# backend/backend/urls.py

from django.contrib import admin
from django.urls import path, include
from rest_framework import routers
from api.views import (
    OfferViewSet,
    AdminOrderViewSet,
    AdminTicketViewSet,
    RegisterView,
    CheckoutView,
    TicketListView,
    OrderListView,
    MyTokenObtainPairView,
    MyTokenRefreshView,
)

router = routers.DefaultRouter()
router.register(r'offers', OfferViewSet, basename='offer')
router.register(r'admin/orders', AdminOrderViewSet, basename='admin-order')
router.register(r'admin/tickets', AdminTicketViewSet, basename='admin-ticket')

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/register/', RegisterView.as_view(), name='register'),
    path('api/checkout/', CheckoutView.as_view(), name='checkout'),
    path('api/tickets/', TicketListView.as_view(), name='ticket-list'),
    path('api/orders/', OrderListView.as_view(), name='order-list'),
    # Ajouter les routes JWT ici
    path('api/token/', MyTokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('api/token/refresh/', MyTokenRefreshView.as_view(), name='token_refresh'),
    path('api/', include(router.urls)),  # Inclure les autres routes de l'API
]
