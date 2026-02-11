import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/delivery_address_entity.dart';
import '../entities/delivery_slot_entity.dart';
import '../entities/payment_method_entity.dart';
import '../repository/checkout_repository_interface.dart';

/// Use case for getting available delivery slots
class GetDeliverySlotsUseCase {
  final CheckoutRepositoryInterface _repository;

  const GetDeliverySlotsUseCase(this._repository);

  /// Execute to get available delivery slots
  ///
  /// Returns a list of available delivery time slots for the next 7 days.
  /// Filters out unavailable and past slots.
  TaskEither<Failure, List<DeliverySlotEntity>> call() {
    return _repository.getDeliverySlots().map((slots) {
      // Filter available slots and sort by date/time
      return slots
          .where((slot) => slot.isAvailable && !slot.isPast)
          .toList()
        ..sort((a, b) {
          final dateCompare = a.date.compareTo(b.date);
          if (dateCompare != 0) return dateCompare;
          final aMinutes = a.startTime.hour * 60 + a.startTime.minute;
          final bMinutes = b.startTime.hour * 60 + b.startTime.minute;
          return aMinutes.compareTo(bMinutes);
        });
    });
  }
}

/// Use case for applying a promo code
class ApplyPromoCodeUseCase {
  final CheckoutRepositoryInterface _repository;

  const ApplyPromoCodeUseCase(this._repository);

  /// Execute to apply a promo code
  TaskEither<Failure, PromoCodeResult> call({
    required String promoCode,
    required double orderSubtotal,
  }) {
    if (promoCode.trim().isEmpty) {
      return TaskEither.left(
        const ValidationFailure(
          message: 'Promo code cannot be empty',
          field: 'promoCode',
        ),
      );
    }

    return _repository.applyPromoCode(
      promoCode: promoCode.trim().toUpperCase(),
      orderSubtotal: orderSubtotal,
    );
  }
}

/// Use case for getting saved payment methods
class GetPaymentMethodsUseCase {
  final CheckoutRepositoryInterface _repository;

  const GetPaymentMethodsUseCase(this._repository);

  TaskEither<Failure, List<PaymentMethodEntity>> call() {
    return _repository.getPaymentMethods();
  }
}

/// Use case for getting saved delivery addresses
class GetDeliveryAddressesUseCase {
  final CheckoutRepositoryInterface _repository;

  const GetDeliveryAddressesUseCase(this._repository);

  TaskEither<Failure, List<DeliveryAddressEntity>> call() {
    return _repository.getDeliveryAddresses();
  }
}
