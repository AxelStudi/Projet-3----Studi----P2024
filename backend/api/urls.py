from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    RegisterView,
    OfferViewSet,
    CheckoutView,
    TicketListView,
    AdminOrderViewSet,
    AdminTicketViewSet,
    MyTokenObtainPairView,  # Nouvelle vue pour login avec email suite à un bug
)
from rest_framework_simplejwt.views import TokenRefreshView

router = DefaultRouter()
router.register(r'offers', OfferViewSet, basename='offer')
router.register(r'admin/orders', AdminOrderViewSet, basename='admin-orders')
router.register(r'admin/tickets', AdminTicketViewSet, basename='admin-tickets')

urlpatterns = [
    path('', include(router.urls)),
    path('register/', RegisterView.as_view(), name='register'),
    path('checkout/', CheckoutView.as_view(), name='checkout'),
    path('tickets/', TicketListView.as_view(), name='tickets'),
    # JWT Auth Endpoints
    path('token/', MyTokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
]
