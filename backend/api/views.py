from rest_framework import generics, viewsets, permissions, status
from rest_framework.views import APIView
from rest_framework.response import Response
from django.contrib.auth.models import User
from .models import Offer, Order, OrderItem, Ticket
from .serializers import (
    UserSerializer,
    OfferSerializer,
    OrderSerializer,
    OrderItemSerializer,
    TicketSerializer,
)
from rest_framework.permissions import IsAuthenticated, IsAdminUser, AllowAny
from rest_framework.decorators import action
import uuid
import qrcode
from io import BytesIO
from django.core.files import File
from django.shortcuts import get_object_or_404
from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer
from rest_framework import serializers

# Custom Permissions
class IsAdminOrReadOnly(permissions.BasePermission):
    def has_permission(self, request, view):
        if request.method in permissions.SAFE_METHODS:
            return True
        return request.user and request.user.is_staff

# Vues pour l'Authentification et l'Inscription
class RegisterView(generics.CreateAPIView):
    queryset = User.objects.all()
    permission_classes = (AllowAny,)
    serializer_class = UserSerializer

# Vues pour les Offres
class OfferViewSet(viewsets.ModelViewSet):
    queryset = Offer.objects.all()
    serializer_class = OfferSerializer
    permission_classes = [AllowAny]

# Vues pour le Checkout (Commande)
class CheckoutView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        user = request.user
        items = request.data.get('items', [])
        if not items:
            return Response({"error": "Aucun article fourni pour la commande."}, status=status.HTTP_400_BAD_REQUEST)

        order = Order.objects.create(customer=user, status='pending')  # Initialisation du statut 'pending'
        total = 0

        for item in items:
            offer_id = item.get('id')
            quantity = item.get('quantity', 1)
            try:
                offer = Offer.objects.get(id=offer_id)
            except Offer.DoesNotExist:
                return Response({"error": f"L'offre avec l'ID {offer_id} n'existe pas."}, status=status.HTTP_400_BAD_REQUEST)

            order_item = OrderItem.objects.create(
                order=order,
                offer=offer,
                quantity=quantity,
                price=offer.price * quantity
            )
            total += order_item.price

            # Générer le QR code
            ticket_number = str(uuid.uuid4())
            qr = qrcode.QRCode(
                version=1,
                error_correction=qrcode.constants.ERROR_CORRECT_L,
                box_size=10,
                border=4,
            )
            qr.add_data(ticket_number)
            qr.make(fit=True)

            img = qr.make_image(fill_color="black", back_color="white")
            buffer = BytesIO()
            img.save(buffer, format='PNG')
            buffer.seek(0)

            ticket = Ticket.objects.create(
                order_item=order_item,
                ticket_number=ticket_number,
                event_name="Event Placeholder"
            )
            ticket.qr_code.save(f"{ticket_number}.png", File(buffer), save=True)

        order.total_price = total
        order.status = 'completed'  # Mise à jour du statut à 'completed'
        order.save()

        serializer = OrderSerializer(order)
        return Response({
            "order": serializer.data,
            "ticket_key": ticket_number  # Renvoie la clé du billet au frontend
        }, status=status.HTTP_201_CREATED)

# Vues pour les Tickets
class TicketListView(generics.ListAPIView):
    serializer_class = TicketSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        user = self.request.user
        return Ticket.objects.filter(order_item__order__customer=user).order_by('-order_item__order__created_at')

# Vues pour les Commandes
class OrderListView(generics.ListAPIView):
    serializer_class = OrderSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        user = self.request.user
        return Order.objects.filter(customer=user).order_by('-created_at')

# Vues pour les Administrateurs (Gestion des Commandes et Tickets)
class AdminOrderViewSet(viewsets.ModelViewSet):
    queryset = Order.objects.all()
    serializer_class = OrderSerializer
    permission_classes = [IsAdminUser]

    @action(detail=True, methods=['post'], permission_classes=[IsAdminUser])
    def mark_as_completed(self, request, pk=None):
        order = self.get_object()
        order.status = 'completed'
        order.save()
        return Response({'status': 'Commande marquée comme terminée.'}, status=status.HTTP_200_OK)

class AdminTicketViewSet(viewsets.ModelViewSet):
    queryset = Ticket.objects.all()
    serializer_class = TicketSerializer
    permission_classes = [IsAdminUser]

# Vues pour l'authentification JWT avec email
class MyTokenObtainPairSerializer(TokenObtainPairSerializer):
    @classmethod
    def get_token(cls, user):
        token = super().get_token(user)
        return token

    def validate(self, attrs):
        try:
            # Trouver l'utilisateur par email au lieu du username
            user = User.objects.get(email=attrs['username'])
            attrs['username'] = user.username
        except User.DoesNotExist:
            raise serializers.ValidationError('Aucun utilisateur trouvé avec cet email.')
        return super().validate(attrs)

class MyTokenObtainPairView(TokenObtainPairView):
    serializer_class = MyTokenObtainPairSerializer
    permission_classes = (AllowAny,)

class MyTokenRefreshView(TokenRefreshView):
    permission_classes = (AllowAny,)
