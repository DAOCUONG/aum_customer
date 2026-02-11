import 'package:freezed_annotation/freezed_annotation.dart';

import 'delivery_address_entity.dart';
import 'payment_method_entity.dart';

part 'order_entity.freezed.dart';

/// Entity representing a completed order
@freezed
class OrderEntity with _$OrderEntity {
  const factory OrderEntity({
    required String id,
    required String orderNumber,
    required DateTime createdAt,
    required OrderStatus status,
    required DeliveryAddressEntity deliveryAddress,
    required PaymentMethodEntity paymentMethod,
    required List<OrderItemEntity> items,
    required double subtotal,
    required double deliveryFee,
    required double tax,
    required double tip,
    required double discount,
    required double total,
    required DateTime? scheduledDeliveryTime,
    required String? promoCode,
    required String? deliveryInstructions,
    required int estimatedDeliveryMinutes,
  }) = _OrderEntity;

  const OrderEntity._();

  /// Generate a human-readable order number
  factory OrderEntity.generateOrderNumber() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = (timestamp % 10000).toString().padLeft(4, '0');
    return OrderEntity(
      id: 'order_$timestamp',
      orderNumber: 'ORD-$random',
      createdAt: DateTime.now(),
      status: OrderStatus.pending,
      deliveryAddress: DeliveryAddressEntity.empty(),
      paymentMethod: PaymentMethodEntity.empty(),
      items: const [],
      subtotal: 0,
      deliveryFee: 0,
      tax: 0,
      tip: 0,
      discount: 0,
      total: 0,
      scheduledDeliveryTime: null,
      promoCode: null,
      deliveryInstructions: null,
      estimatedDeliveryMinutes: 30,
    );
  }
}

/// Order status enum
enum OrderStatus {
  pending,
  confirmed,
  preparing,
  ready,
  outForDelivery,
  delivered,
  cancelled,
}

/// Entity representing an item in an order
@freezed
class OrderItemEntity with _$OrderItemEntity {
  const factory OrderItemEntity({
    required String id,
    required String menuItemId,
    required String name,
    required String description,
    required double price,
    required int quantity,
    required String imageUrl,
    List<OrderItemCustomization>? customizations,
    String? notes,
  }) = _OrderItemEntity;

  const OrderItemEntity._();

  double get totalPrice {
    final customizationsTotal = customizations?.fold<double>(
          0.0,
          (sum, item) => sum + item.price,
        ) ??
        0.0;
    return (price + customizationsTotal) * quantity;
  }
}

/// Entity representing customization options for an order item
@freezed
class OrderItemCustomization with _$OrderItemCustomization {
  const factory OrderItemCustomization({
    required String id,
    required String name,
    required double price,
  }) = _OrderItemCustomization;
}
