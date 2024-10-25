from django.test import TestCase
from rest_framework.test import APIClient
from rest_framework import status
from django.urls import reverse
from .models import Offer, Order, OrderItem, Ticket
from django.contrib.auth.models import User
import json

class OfferTests(TestCase):
    def setUp(self):
        self.client = APIClient()
        self.offer_data = {'title': 'Solo', 'description': 'Accès individuel', 'price': 50.00}
        self.url = reverse('offer-list')

    def test_create_offer(self):
        response = self.client.post(self.url, self.offer_data, format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

    def test_get_offer_list(self):
        response = self.client.get(self.url, format='json')
        self.assertEqual(response.status_code, status.HTTP_200_OK)

class OrderTests(TestCase):
    def setUp(self):
        self.client = APIClient()
        self.user = User.objects.create_user(username='testuser', password='12345')
        self.client.force_authenticate(user=self.user)
        self.offer = Offer.objects.create(title='Solo', description='Accès individuel', price=50.00)
        self.order_data = {'items': [{'id': self.offer.id, 'quantity': 1}]}
        self.url = reverse('checkout')

    def test_create_order(self):
        response = self.client.post(self.url, json.dumps(self.order_data), content_type='application/json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

    def test_get_order_list(self):
        response = self.client.get(reverse('order-list'))
        self.assertEqual(response.status_code, status.HTTP_200_OK)

class TicketTests(TestCase):
    def setUp(self):
        self.client = APIClient()
        self.user = User.objects.create_user(username='testuser', password='12345')
        self.client.force_authenticate(user=self.user)
        self.offer = Offer.objects.create(title='Solo', description='Accès individuel', price=50.00)
        self.order = Order.objects.create(customer=self.user, total_price=50.00)
        self.order_item = OrderItem.objects.create(order=self.order, offer=self.offer, quantity=1, price=50.00)
        self.ticket = Ticket.objects.create(order_item=self.order_item, event_name='Event', ticket_number='1234')
        self.url = reverse('ticket-list')

    def test_get_ticket_list(self):
        response = self.client.get(self.url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
