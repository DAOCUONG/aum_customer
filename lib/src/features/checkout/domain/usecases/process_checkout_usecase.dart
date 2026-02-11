import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/delivery_address_entity.dart';
import '../entities/order_entity.dart';
import '../entities/payment_method_entity.dart';
import '../repository/checkout_repository_interface.dart';

/// Use case for processing checkout and creating an order
class ProcessCheckoutUseCase {
  final CheckoutRepositoryInterface _repository;

  const ProcessCheckoutUseCase(this._repository);

  /// Execute the checkout process
  ///
  /// Takes all necessary order details and processes the checkout
  /// to create a new order.
  ///
  /// Returns [OrderEntity] on success or a [Failure] on error.
  TaskEither<Failure, OrderEntity> call({
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
  }) {
    // Validate inputs
    final validationFailure = _validateInputs(
      deliveryAddress: deliveryAddress,
      paymentMethod: paymentMethod,
      items: items,
    );

    if (validationFailure != null) {
      return TaskEither.left(validationFailure);
    }

    // Calculate total
    final total = subtotal + deliveryFee + tax + tip - discount;

    // Calculate estimated delivery time
    final estimatedMinutes = _calculateEstimatedDeliveryTime(
      scheduledDeliveryTime: scheduledDeliveryTime,
      isScheduled: scheduledDeliveryTime != null,
    );

    // Process checkout
    return _repository.processCheckout(
      deliveryAddress: deliveryAddress,
      paymentMethod: paymentMethod,
      items: items,
      subtotal: subtotal,
      deliveryFee: deliveryFee,
      tax: tax,
      tip: tip,
      discount: discount,
      promoCode: promoCode,
      deliveryInstructions: deliveryInstructions,
      scheduledDeliveryTime: scheduledDeliveryTime,
    ).map((order) => order.copyWith(
      estimatedDeliveryMinutes: estimatedMinutes,
      total: total,
    ));
  }

  /// Validate checkout inputs
  Failure? _validateInputs({
    required DeliveryAddressEntity deliveryAddress,
    required PaymentMethodEntity paymentMethod,
    required List<OrderItemEntity> items,
  }) {
    if (items.isEmpty) {
      return const ValidationFailure(
        message: 'Cart is empty',
        field: 'items',
      );
    }

    if (!deliveryAddress.isValid) {
      return const ValidationFailure(
        message: 'Invalid delivery address',
        field: 'deliveryAddress',
      );
    }

    if (!paymentMethod.isValid) {
      return const ValidationFailure(
        message: 'Invalid payment method',
        field: 'paymentMethod',
      );
    }

    return null;
  }

  /// Calculate estimated delivery time in minutes
  int _calculateEstimatedDeliveryTime({
    required DateTime? scheduledDeliveryTime,
    required bool isScheduled,
  }) {
    if (isScheduled && scheduledDeliveryTime != null) {
      final now = DateTime.now();
      final diff = scheduledDeliveryTime.difference(now);
      return diff.inMinutes.clamp(30, 120);
    }

    // Default delivery time based on current time
    final now = DateTime.now();
    final hour = now.hour;

    // Rush hour adjustment
    if ((hour >= 11 && hour <= 14) || (hour >= 18 && hour <= 21)) {
      return 45;
    }

    return 30;
  }
}
