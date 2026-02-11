import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../repository/checkout_repository_impl.dart';

void main() {
  group('CheckoutRepositoryImpl', () {
    late CheckoutRepositoryImpl repository;

    setUp(() {
      repository = CheckoutRepositoryImpl();
    });

    group('getDeliverySlots', () {
      test('returns list of delivery slots', () async {
        final result = await repository.getDeliverySlots().run();

        expect(result.isRight(), true);
        result.fold(
          (_) => fail('Expected right result'),
          (slots) => expect(slots, isNotEmpty),
        );
      });
    });

    group('getPaymentMethods', () {
      test('returns list of payment methods', () async {
        final result = await repository.getPaymentMethods().run();

        expect(result.isRight(), true);
        result.fold(
          (_) => fail('Expected right result'),
          (methods) => expect(methods, isNotEmpty),
        );
      });

      test('returns default payment method selected', () async {
        final result = await repository.getSelectedPaymentMethod().run();

        expect(result.isRight(), true);
        result.fold(
          (_) => fail('Expected right result'),
          (method) => expect(method?.isDefault, true),
        );
      });
    });

    group('getDeliveryAddresses', () {
      test('returns list of delivery addresses', () async {
        final result = await repository.getDeliveryAddresses().run();

        expect(result.isRight(), true);
        result.fold(
          (_) => fail('Expected right result'),
          (addresses) => expect(addresses, isNotEmpty),
        );
      });

      test('returns default address selected', () async {
        final result = await repository.getSelectedDeliveryAddress().run();

        expect(result.isRight(), true);
        result.fold(
          (_) => fail('Expected right result'),
          (address) => expect(address?.isDefault, true),
        );
      });
    });

    group('applyPromoCode', () {
      test('returns failure for invalid promo code', () async {
        final result = await repository
            .applyPromoCode(promoCode: 'INVALID', orderSubtotal: 100.0)
            .run();

        expect(result.isLeft(), true);
      });

      test('returns promo result for valid promo code SAVE10', () async {
        final result = await repository
            .applyPromoCode(promoCode: 'SAVE10', orderSubtotal: 100.0)
            .run();

        expect(result.isRight(), true);
        result.fold(
          (_) => fail('Expected right result'),
          (promoResult) {
            expect(promoResult.code, 'SAVE10');
            expect(promoResult.discountAmount, 10.0);
          },
        );
      });

      test('returns promo result for valid promo code SAVE20', () async {
        final result = await repository
            .applyPromoCode(promoCode: 'SAVE20', orderSubtotal: 100.0)
            .run();

        expect(result.isRight(), true);
        result.fold(
          (_) => fail('Expected right result'),
          (promoResult) {
            expect(promoResult.code, 'SAVE20');
            expect(promoResult.discountAmount, 20.0);
          },
        );
      });

      test('returns promo result for valid promo code FIRST5', () async {
        final result = await repository
            .applyPromoCode(promoCode: 'FIRST5', orderSubtotal: 100.0)
            .run();

        expect(result.isRight(), true);
        result.fold(
          (_) => fail('Expected right result'),
          (promoResult) {
            expect(promoResult.code, 'FIRST5');
            expect(promoResult.discountAmount, 5.0);
          },
        );
      });
    });

    group('processCheckout', () {
      test('returns order on successful checkout', () async {
        final result = await repository
            .processCheckout(
              deliveryAddress: const DeliveryAddressEntity(
                id: 'addr_1',
                label: 'Home',
                streetAddress: '123 Main St',
                apartment: null,
                city: 'San Francisco',
                state: 'CA',
                zipCode: '94110',
                country: 'USA',
                latitude: 37.7749,
                longitude: -122.4194,
                isDefault: true,
                deliveryInstructions: null,
              ),
              paymentMethod: const PaymentMethodEntity(
                id: 'pm_1',
                type: PaymentMethodType.creditCard,
                lastFourDigits: '4242',
                cardBrand: 'Visa',
                cardholderName: 'Test',
                expiryMonth: '12',
                expiryYear: '25',
                isDefault: true,
                iconName: 'credit_card',
              ),
              items: [
                const OrderItemEntity(
                  id: 'item_1',
                  menuItemId: 'menu_001',
                  name: 'Test Item',
                  description: 'Test',
                  price: 10.0,
                  quantity: 1,
                  imageUrl: 'http://test.com/image.jpg',
                ),
              ],
              subtotal: 10.0,
              deliveryFee: 2.99,
              tax: 0.8,
              tip: 1.5,
              discount: 0,
              promoCode: null,
              deliveryInstructions: null,
              scheduledDeliveryTime: null,
            )
            .run();

        expect(result.isRight(), true);
        result.fold(
          (_) => fail('Expected right result'),
          (order) {
            expect(order.id, isNotEmpty);
            expect(order.orderNumber, startsWith('ORD-'));
            expect(order.status, OrderStatus.confirmed);
          },
        );
      });
    });
  });
}
