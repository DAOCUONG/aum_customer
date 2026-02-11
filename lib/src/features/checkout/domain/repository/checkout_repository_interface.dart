import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/delivery_address_entity.dart';
import '../entities/delivery_slot_entity.dart';
import '../entities/order_entity.dart';
import '../entities/payment_method_entity.dart';

/// Repository interface for checkout operations
///
/// Defines the contract for all checkout-related data operations.
/// Implementations should handle data sources (API, cache, etc.)
/// and map exceptions to appropriate [Failure] types.
abstract class CheckoutRepositoryInterface {
  /// Process checkout and create an order
  ///
  /// Takes the cart items, delivery address, payment method, and other
  /// checkout details to create and process an order.
  ///
  /// Returns [OrderEntity] on success or a [Failure] on error.
  TaskEither<Failure, OrderEntity> processCheckout({
    required DeliveryAddressEntity deliveryAddress,
    required PaymentMethodEntity paymentMethod,
    required List<OrderItemEntity> items,
    required double subtotal,
    required double deliveryFee,
    required double tax,
    required double tip,
    required double discount,
    required String? promoCode,
    required String? deliveryInstructions,
    required DateTime? scheduledDeliveryTime,
  });

  /// Get available delivery slots for scheduling
  ///
  /// Returns a list of available delivery time slots for the next 7 days.
  TaskEither<Failure, List<DeliverySlotEntity>> getDeliverySlots();

  /// Get saved payment methods for the user
  TaskEither<Failure, List<PaymentMethodEntity>> getPaymentMethods();

  /// Get the default or selected payment method
  TaskEither<Failure, PaymentMethodEntity?> getSelectedPaymentMethod();

  /// Get saved delivery addresses
  TaskEither<Failure, List<DeliveryAddressEntity>> getDeliveryAddresses();

  /// Get the default or selected delivery address
  TaskEither<Failure, DeliveryAddressEntity?> getSelectedDeliveryAddress();

  /// Save a new delivery address
  TaskEither<Failure, DeliveryAddressEntity> saveDeliveryAddress({
    required DeliveryAddressEntity address,
  });

  /// Apply a promo code to the order
  ///
  /// Validates and applies the promo code, returning the discount amount.
  TaskEither<Failure, PromoCodeResult> applyPromoCode({
    required String promoCode,
    required double orderSubtotal,
  });

  /// Validate a promo code without applying it
  TaskEither<Failure, PromoCodeValidation> validatePromoCode({
    required String promoCode,
  });
}

/// Result of applying a promo code
class PromoCodeResult {
  final String code;
  final double discountAmount;
  final String? description;

  const PromoCodeResult({
    required this.code,
    required this.discountAmount,
    this.description,
  });
}

/// Validation result for a promo code
class PromoCodeValidation {
  final bool isValid;
  final String? code;
  final double? discountPercent;
  final double? discountAmount;
  final String? errorMessage;

  const PromoCodeValidation({
    required this.isValid,
    this.code,
    this.discountPercent,
    this.discountAmount,
    this.errorMessage,
  });

  factory PromoCodeValidation.invalid(String errorMessage) {
    return PromoCodeValidation(
      isValid: false,
      errorMessage: errorMessage,
    );
  }

  factory PromoCodeValidation.valid({
    required String code,
    required double discountPercent,
    required double discountAmount,
  }) {
    return PromoCodeValidation(
      isValid: true,
      code: code,
      discountPercent: discountPercent,
      discountAmount: discountAmount,
    );
  }
}
