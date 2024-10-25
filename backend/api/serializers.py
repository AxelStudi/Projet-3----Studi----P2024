# api/serializers.py

from rest_framework import serializers
from django.contrib.auth.models import User
from .models import Offer, Order, OrderItem, Ticket


class UserSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True, required=True, style={'input_type': 'password'})

    class Meta:
        model = User
        fields = ('id', 'username', 'email', 'password')

    def create(self, validated_data):
        user = User.objects.create_user(
            username=validated_data['username'],
            email=validated_data.get('email'),
            password=validated_data['password']
        )
        return user


class OfferSerializer(serializers.ModelSerializer):
    class Meta:
        model = Offer
        fields = ['id', 'title', 'description', 'price', 'created_at']


class OrderSerializer(serializers.ModelSerializer):
    customer = serializers.StringRelatedField(read_only=True)
    items = serializers.StringRelatedField(many=True, read_only=True)
    tickets = serializers.StringRelatedField(many=True, read_only=True)

    class Meta:
        model = Order
        fields = '__all__'


class OrderItemSerializer(serializers.ModelSerializer):
    offer = serializers.StringRelatedField(read_only=True)
    order = serializers.StringRelatedField(read_only=True)

    class Meta:
        model = OrderItem
        fields = '__all__'


class TicketSerializer(serializers.ModelSerializer):
    order_item = serializers.StringRelatedField(read_only=True)
    qr_code = serializers.ImageField(read_only=True)

    class Meta:
        model = Ticket
        fields = '__all__'
