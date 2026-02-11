import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/delivery_address_entity.dart';
import '../../domain/entities/delivery_slot_entity.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/entities/payment_method_entity.dart';

part 'checkout_state.freezed.dart';

/// State for the checkout flow
@freezed
class CheckoutState with _$CheckoutState {
  const factory CheckoutState({
    @Default(CheckoutStatus.initial) CheckoutStatus status,
    DeliveryAddressEntity? deliveryAddress,
    PaymentMethodEntity? paymentMethod,
    @Default([]) List<PaymentMethodEntity> paymentMethods,
    @Default([]) List<DeliveryAddressEntity> savedAddresses,
    @Default('') String promoCode,
    @Default(0.0) double promoDiscount,
    @Default('') String promoErrorMessage,
    @Default(false) bool isApplyingPromo,
    @Default(0) int selectedTipIndex,
    @Default([10, 15, 18, 20]) List<int> tipPercentages,
    @Default(false) bool leaveAtDoor,
    @Default(false) bool priorityDelivery,
    @Default('') String deliveryInstructions,
    @Default(0.0) double priorityFee,
    @Default(0.0) double tipAmount,
    OrderEntity? order,
    String? errorMessage,
  }) = _CheckoutState;

  const CheckoutState._();

  /// Factory constructor for initial state
  factory CheckoutState.initial() {
    return const CheckoutState();
  }

  /// Get effective delivery address (fallback to first saved address if null)
  DeliveryAddressEntity get effectiveDeliveryAddress {
    return deliveryAddress ??
        (savedAddresses.isNotEmpty ? savedAddresses.first : DeliveryAddressEntity.empty());
  }

  /// Get effective payment method (fallback to first saved payment method if null)
  PaymentMethodEntity get effectivePaymentMethod {
    return paymentMethod ??
        (paymentMethods.isNotEmpty ? paymentMethods.first : PaymentMethodEntity.empty());
  }

  /// Calculate subtotal from cart items
  double get subtotal {
    // In a real app, this would come from the cart
    return 34.50;
  }

  /// Calculate delivery fee
  double get deliveryFee {
    return priorityDelivery ? 2.99 + priorityFee : 2.99;
  }

  /// Calculate tax (8%)
  double get tax => subtotal * 0.08;

  /// Calculate total
  double get total {
    return subtotal + deliveryFee + tax + tipAmount - promoDiscount;
  }
}

/// Checkout status enum
enum CheckoutStatus {
  initial,
  loading,
  processing,
  success,
  error,
}

/// State for delivery slot selection
@freezed
class DeliverySlotState with _$DeliverySlotState {
  const factory DeliverySlotState({
    @Default(DeliverySlotStatus.initial) DeliverySlotStatus status,
    @Default([]) List<DeliverySlotEntity> slots,
    DeliverySlotEntity? selectedSlot,
    @Default('') String deliveryInstructions,
    String? errorMessage,
  }) = _DeliverySlotState;

  const DeliverySlotState._();

  /// Factory constructor for initial state
  factory DeliverySlotState.initial() {
    return const DeliverySlotState();
  }
}

/// Delivery slot status enum
enum DeliverySlotStatus {
  initial,
  loading,
  loaded,
  selected,
  error,
}

/// State for order confirmation
@freezed
class OrderConfirmationState with _$OrderConfirmationState {
  const factory OrderConfirmationState({
    @Default(OrderStatusEnum.initial) OrderStatusEnum status,
    OrderEntity? order,
    String? errorMessage,
  }) = _OrderConfirmationState;

  const OrderConfirmationState._();

  /// Factory constructor for initial state
  factory OrderConfirmationState.initial() {
    return const OrderConfirmationState();
  }
}

/// Order status for confirmation screen
enum OrderStatusEnum {
  initial,
  loading,
  success,
  error,
}
