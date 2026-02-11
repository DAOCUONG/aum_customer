import '../../domain/entities/order_entity.dart';
import '../../domain/entities/delivery_address_entity.dart';
import '../../domain/entities/payment_method_entity.dart';

/// Data model for orders
class OrderModel {
  final String id;
  final String orderNumber;
  final String createdAt;
  final String status;
  final Map<String, dynamic> deliveryAddress;
  final Map<String, dynamic> paymentMethod;
  final List<Map<String, dynamic>> items;
  final double subtotal;
  final double deliveryFee;
  final double tax;
  final double tip;
  final double discount;
  final double total;
  final String? scheduledDeliveryTime;
  final String? promoCode;
  final String? deliveryInstructions;
  final int estimatedDeliveryMinutes;

  const OrderModel({
    required this.id,
    required this.orderNumber,
    required this.createdAt,
    required this.status,
    required this.deliveryAddress,
    required this.paymentMethod,
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.tax,
    required this.tip,
    required this.discount,
    required this.total,
    this.scheduledDeliveryTime,
    this.promoCode,
    this.deliveryInstructions,
    required this.estimatedDeliveryMinutes,
  });

  /// Convert to domain entity
  OrderEntity toEntity() {
    return OrderEntity(
      id: id,
      orderNumber: orderNumber,
      createdAt: DateTime.parse(createdAt),
      status: _parseOrderStatus(status),
      deliveryAddress: _parseDeliveryAddress(deliveryAddress),
      paymentMethod: _parsePaymentMethod(paymentMethod),
      items: items.map(_parseOrderItem).toList(),
      subtotal: subtotal,
      deliveryFee: deliveryFee,
      tax: tax,
      tip: tip,
      discount: discount,
      total: total,
      scheduledDeliveryTime: scheduledDeliveryTime != null
          ? DateTime.parse(scheduledDeliveryTime!)
          : null,
      promoCode: promoCode,
      deliveryInstructions: deliveryInstructions,
      estimatedDeliveryMinutes: estimatedDeliveryMinutes,
    );
  }

  OrderStatus _parseOrderStatus(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return OrderStatus.pending;
      case 'confirmed':
        return OrderStatus.confirmed;
      case 'preparing':
        return OrderStatus.preparing;
      case 'ready':
        return OrderStatus.ready;
      case 'out_for_delivery':
        return OrderStatus.outForDelivery;
      case 'delivered':
        return OrderStatus.delivered;
      case 'cancelled':
        return OrderStatus.cancelled;
      default:
        return OrderStatus.pending;
    }
  }

  DeliveryAddressEntity _parseDeliveryAddress(Map<String, dynamic> address) {
    return DeliveryAddressEntity(
      id: address['id'] ?? '',
      label: address['label'] ?? '',
      streetAddress: address['streetAddress'] ?? '',
      apartment: address['apartment'],
      city: address['city'] ?? '',
      state: address['state'] ?? '',
      zipCode: address['zipCode'] ?? '',
      country: address['country'] ?? 'USA',
      latitude: (address['latitude'] ?? 0).toDouble(),
      longitude: (address['longitude'] ?? 0).toDouble(),
      isDefault: address['isDefault'] ?? false,
      deliveryInstructions: address['deliveryInstructions'],
    );
  }

  PaymentMethodEntity _parsePaymentMethod(Map<String, dynamic> payment) {
    return PaymentMethodEntity(
      id: payment['id'] ?? '',
      type: _parsePaymentMethodType(payment['type']),
      lastFourDigits: payment['lastFourDigits'] ?? '',
      cardBrand: payment['cardBrand'],
      cardholderName: payment['cardholderName'],
      expiryMonth: payment['expiryMonth'],
      expiryYear: payment['expiryYear'],
      isDefault: payment['isDefault'] ?? false,
      iconName: payment['iconName'],
    );
  }

  PaymentMethodType _parsePaymentMethodType(String type) {
    switch (type.toLowerCase()) {
      case 'credit_card':
        return PaymentMethodType.creditCard;
      case 'debit_card':
        return PaymentMethodType.debitCard;
      case 'apple_pay':
        return PaymentMethodType.applePay;
      case 'google_pay':
        return PaymentMethodType.googlePay;
      case 'cash':
        return PaymentMethodType.cash;
      default:
        return PaymentMethodType.creditCard;
    }
  }

  OrderItemEntity _parseOrderItem(Map<String, dynamic> item) {
    return OrderItemEntity(
      id: item['id'] ?? '',
      menuItemId: item['menuItemId'] ?? '',
      name: item['name'] ?? '',
      description: item['description'] ?? '',
      price: (item['price'] ?? 0).toDouble(),
      quantity: item['quantity'] ?? 1,
      imageUrl: item['imageUrl'] ?? '',
      customizations: item['customizations'] != null
          ? List<Map<String, dynamic>>.from(item['customizations'])
              .map((c) => OrderItemCustomization(
                    id: c['id'] ?? '',
                    name: c['name'] ?? '',
                    price: (c['price'] ?? 0).toDouble(),
                  ))
              .toList()
          : null,
      notes: item['notes'],
    );
  }
}
