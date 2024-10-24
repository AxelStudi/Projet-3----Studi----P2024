# api/tests.py

from django.test import TestCase
from django.contrib.auth.models import User
from .models import Offer


class OfferModelTest(TestCase):
    def setUp(self):
        self.offer = Offer.objects.create(
            name='Solo',
            description='Accès individuel aux événements avec flexibilité maximale.',
            price=50.00,
            type='solo'
        )

    def test_offer_creation(self):
        self.assertEqual(self.offer.name, 'Solo')
        self.assertEqual(self.offer.price, 50.00)
        self.assertEqual(self.offer.type, 'solo')
