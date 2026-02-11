import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../data/repository/checkout_repository_impl.dart';
import '../../domain/usecases/process_checkout_usecase.dart';
import '../providers/checkout_notifier.dart';
import '../providers/providers.dart';

void main() {
  group('CheckoutNotifier', () {
    late ProviderContainer container;
    late CheckoutRepositoryImpl mockRepository;

    setUp(() {
      mockRepository = CheckoutRepositoryImpl();
      container = ProviderContainer(
        overrides: [
          checkoutRepositoryProvider.overrideWithValue(mockRepository),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('initial state has default values', () {
      final notifier = container.read(checkoutNotifierProvider);

      expect(notifier.status, CheckoutStatus.initial);
      expect(notifier.selectedTipIndex, 0);
      expect(notifier.tipPercentages, [10, 15, 18, 20]);
      expect(notifier.leaveAtDoor, false);
      expect(notifier.priorityDelivery, false);
    });

    test('selectTip updates selected index and tip amount', () async {
      final notifier = container.read(checkoutNotifierProvider.notifier);

      notifier.selectTip(1); // 15%

      final state = container.read(checkoutNotifierProvider);
      expect(state.selectedTipIndex, 1);
      expect(state.tipAmount, closeTo(5.18, 0.01)); // 34.50 * 0.15
    });

    test('setLeaveAtDoor updates state', () async {
      final notifier = container.read(checkoutNotifierProvider.notifier);

      notifier.setLeaveAtDoor(true);

      final state = container.read(checkoutNotifierProvider);
      expect(state.leaveAtDoor, true);
    });

    test('setPriorityDelivery updates state', () async {
      final notifier = container.read(checkoutNotifierProvider.notifier);

      notifier.setPriorityDelivery(true);

      final state = container.read(checkoutNotifierProvider);
      expect(state.priorityDelivery, true);
    });

    test('setDeliveryInstructions updates state', () async {
      final notifier = container.read(checkoutNotifierProvider.notifier);

      notifier.setDeliveryInstructions('Leave at door');

      final state = container.read(checkoutNotifierProvider);
      expect(state.deliveryInstructions, 'Leave at door');
    });

    test('removePromoCode clears promo state', () async {
      final notifier = container.read(checkoutNotifierProvider.notifier);

      // First apply a promo code
      await notifier.applyPromoCode('SAVE10');

      // Then remove it
      notifier.removePromoCode();

      final state = container.read(checkoutNotifierProvider);
      expect(state.promoCode, '');
      expect(state.promoDiscount, 0.0);
    });

    test('clearError clears error message', () async {
      final notifier = container.read(checkoutNotifierProvider.notifier);

      notifier.clearError();

      final state = container.read(checkoutNotifierProvider);
      expect(state.errorMessage, '');
    });

    test('reset returns to initial state', () async {
      final notifier = container.read(checkoutNotifierProvider.notifier);

      // Make some changes
      notifier.setLeaveAtDoor(true);
      notifier.setPriorityDelivery(true);
      notifier.selectTip(2);

      // Reset
      notifier.reset();

      final state = container.read(checkoutNotifierProvider);
      expect(state.status, CheckoutStatus.initial);
      expect(state.leaveAtDoor, false);
      expect(state.priorityDelivery, false);
      expect(state.selectedTipIndex, 0);
    });
  });

  group('CheckoutState computed values', () {
    test('subtotal returns correct value', () {
      const state = CheckoutState(
        deliveryAddress: DeliveryAddressEntity.empty(),
        paymentMethod: PaymentMethodEntity.empty(),
      );

      expect(state.subtotal, 34.50);
    });

    test('deliveryFee returns 2.99 when priority is false', () {
      const state = CheckoutState(
        deliveryAddress: DeliveryAddressEntity.empty(),
        paymentMethod: PaymentMethodEntity.empty(),
        priorityDelivery: false,
      );

      expect(state.deliveryFee, 2.99);
    });

    test('deliveryFee includes priority fee when priority is true', () {
      const state = CheckoutState(
        deliveryAddress: DeliveryAddressEntity.empty(),
        paymentMethod: PaymentMethodEntity.empty(),
        priorityDelivery: true,
        priorityFee: 1.99,
      );

      expect(state.deliveryFee, 4.98); // 2.99 + 1.99
    });

    test('tax calculates correctly at 8%', () {
      const state = CheckoutState(
        deliveryAddress: DeliveryAddressEntity.empty(),
        paymentMethod: PaymentMethodEntity.empty(),
      );

      expect(state.tax, closeTo(2.76, 0.01)); // 34.50 * 0.08
    });

    test('total includes all components', () {
      const state = CheckoutState(
        deliveryAddress: DeliveryAddressEntity.empty(),
        paymentMethod: PaymentMethodEntity.empty(),
        tipAmount: 3.45,
        promoDiscount: 5.0,
      );

      // 34.50 + 2.99 + 2.76 + 3.45 - 5.0 = 38.70
      expect(state.total, closeTo(38.70, 0.01));
    });
  });
}
