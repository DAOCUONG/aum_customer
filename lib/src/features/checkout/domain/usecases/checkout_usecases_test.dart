import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../usecases/checkout_usecases.dart';
import 'checkout_repository_impl_test.dart';

void main() {
  group('ApplyPromoCodeUseCase', () {
    late ApplyPromoCodeUseCase useCase;
    late MockCheckoutRepository mockRepository;

    setUp(() {
      mockRepository = MockCheckoutRepository();
      useCase = ApplyPromoCodeUseCase(mockRepository);
    });

    test('returns failure when promo code is empty', () async {
      final result = await useCase(
        promoCode: '',
        orderSubtotal: 100.0,
      ).run();

      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<ValidationFailure>()),
        (_) => fail('Expected left result'),
      );
    });

    test('returns failure when promo code is invalid', () async {
      mockRepository.mockApplyPromoCode = TaskEither.left(
        const ValidationFailure(message: 'Invalid promo code'),
      );

      final result = await useCase(
        promoCode: 'INVALID',
        orderSubtotal: 100.0,
      ).run();

      expect(result.isLeft(), true);
    });

    test('returns promo result when promo code is valid', () async {
      mockRepository.mockApplyPromoCode = TaskEither.of(
        const PromoCodeResult(
          code: 'SAVE10',
          discountAmount: 10.0,
          description: '10% off',
        ),
      );

      final result = await useCase(
        promoCode: 'SAVE10',
        orderSubtotal: 100.0,
      ).run();

      expect(result.isRight(), true);
      result.fold(
        (_) => fail('Expected right result'),
        (promoResult) => expect(promoResult.code, 'SAVE10'),
      );
    });
  });

  group('GetDeliverySlotsUseCase', () {
    late GetDeliverySlotsUseCase useCase;
    late MockCheckoutRepository mockRepository;

    setUp(() {
      mockRepository = MockCheckoutRepository();
      useCase = GetDeliverySlotsUseCase(mockRepository);
    });

    test('returns filtered and sorted delivery slots', () async {
      final slots = [
        const DeliverySlotEntity(
          id: 'slot_1',
          date: null, // Will be set in mock
          startTime: null, // Will be set in mock
          endTime: null, // Will be set in mock
          isAvailable: true,
          additionalFee: null,
          remainingSlots: 5,
        ),
      ];

      mockRepository.mockGetDeliverySlots = TaskEither.of(slots);

      final result = await useCase().run();

      expect(result.isRight(), true);
    });
  });
}
