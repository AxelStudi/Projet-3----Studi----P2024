# api/admin.py

from django.contrib import admin
from .models import Offer, Order, OrderItem, Ticket

@admin.register(Offer)
class OfferAdmin(admin.ModelAdmin):
    """
    Admin interface configuration for the Offer model.
    """
    list_display = ('title', 'price', 'created_at')
    search_fields = ('title', 'description')
    list_filter = ('created_at',)
    ordering = ('-created_at',)
    readonly_fields = ('created_at', 'updated_at')

    fieldsets = (
        (None, {
            'fields': ('title', 'description', 'price')
        }),
        ('Dates', {
            'fields': ('created_at', 'updated_at'),
            'classes': ('collapse',),
        }),
    )

class OrderItemInline(admin.TabularInline):
    model = OrderItem
    extra = 1
    readonly_fields = ('price',)
    can_delete = False

@admin.register(Order)
class OrderAdmin(admin.ModelAdmin):
    """
    Admin interface configuration for the Order model.
    """
    list_display = ('id', 'customer', 'total_price', 'status', 'created_at')
    search_fields = ('customer__username', 'customer__email')
    list_filter = ('status', 'created_at')
    ordering = ('-created_at',)
    readonly_fields = ('created_at', 'updated_at', 'total_price')

    fieldsets = (
        (None, {
            'fields': ('customer', 'status')
        }),
        ('Financials', {
            'fields': ('total_price',),
            'classes': ('collapse',),
        }),
        ('Dates', {
            'fields': ('created_at', 'updated_at'),
            'classes': ('collapse',),
        }),
    )

    inlines = [OrderItemInline]

@admin.register(OrderItem)
class OrderItemAdmin(admin.ModelAdmin):
    """
    Admin interface configuration for the OrderItem model.
    """
    list_display = ('order', 'offer', 'quantity', 'price')
    search_fields = ('order__customer__username', 'offer__title')
    list_filter = ('order', 'offer')
    ordering = ('order',)
    readonly_fields = ('price',)

    fieldsets = (
        (None, {
            'fields': ('order', 'offer', 'quantity')
        }),
        ('Pricing', {
            'fields': ('price',),
            'classes': ('collapse',),
        }),
    )

@admin.register(Ticket)
class TicketAdmin(admin.ModelAdmin):
    """
    Admin interface configuration for the Ticket model.
    """
    list_display = ('id', 'order_item', 'event_name', 'ticket_number', 'issued_at')
    search_fields = ('order_item__order__customer__username', 'event_name', 'ticket_number')
    list_filter = ('event_name', 'issued_at')
    ordering = ('-issued_at',)
    readonly_fields = ('issued_at',)

    fieldsets = (
        (None, {
            'fields': ('order_item', 'event_name', 'ticket_number')
        }),
        ('Issued At', {
            'fields': ('issued_at',),
            'classes': ('collapse',),
        }),
    )
