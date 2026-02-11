import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/entities/payment_method_entity.dart';
import '../../domain/repository/checkout_repository_interface.dart';
import '../usecases/process_checkout_usecase.dart';

void main() {
  group('ProcessCheckoutUseCase', () {
    late ProcessCheckoutUseCase useCase;
    late MockCheckoutRepository mockRepository;

    setUp(() {
      mockRepository = MockCheckoutRepository();
      useCase = ProcessCheckoutUseCase(mockRepository);
    });

    test('returns failure when items are empty', () async {
      final result = await useCase(
        deliveryAddress: DeliveryAddressEntity.empty(),
        paymentMethod: PaymentMethodEntity.empty(),
        items: [],
        subtotal: 0,
        deliveryFee: 2.99,
        tax: 0,
        tip: 0,
        discount: 0,
        promoCode: null,
        deliveryInstructions: null,
        scheduledDeliveryTime: null,
      ).run();

      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<ValidationFailure>()),
        (_) => fail('Expected left result'),
      );
    });

    test('returns failure when delivery address is invalid', () async {
      final result = await useCase(
        deliveryAddress: DeliveryAddressEntity.empty(),
        paymentMethod: PaymentMethodEntity.empty(),
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
        tip: 0,
        discount: 0,
        promoCode: null,
        deliveryInstructions: null,
        scheduledDeliveryTime: null,
      ).run();

      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<ValidationFailure>()),
        (_) => fail('Expected left result'),
      );
    });

    test('returns order on successful checkout', () async {
      final validAddress = DeliveryAddressEntity(
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
      );

      final validPayment = PaymentMethodEntity(
        id: 'pm_1',
        type: PaymentMethodType.creditCard,
        lastFourDigits: '4242',
        cardBrand: 'Visa',
        cardholderName: 'Test User',
        expiryMonth: '12',
        expiryYear: '25',
        isDefault: true,
        iconName: 'credit_card',
      );

      final items = [
        const OrderItemEntity(
          id: 'item_1',
          menuItemId: 'menu_001',
          name: 'Test Item',
          description: 'Test',
          price: 10.0,
          quantity: 1,
          imageUrl: 'http://test.com/image.jpg',
        ),
      ];

      mockRepository.mockProcessCheckout = TaskEither.of(OrderEntity.generateOrderNumber());

      final result = await useCase(
        deliveryAddress: validAddress,
        paymentMethod: validPayment,
        items: items,
        subtotal: 10.0,
        deliveryFee: 2.99,
        tax: 0.8,
        tip: 1.5,
        discount: 0,
        promoCode: null,
        deliveryInstructions: null,
        scheduledDeliveryTime: null,
      ).run();

      expect(result.isRight(), true);
      result.fold(
        (_) => fail('Expected right result'),
        (order) => expect(order.id, isNotEmpty),
      );
    });
  });
}

class MockCheckoutRepository implements CheckoutRepositoryInterface {
  TaskEither<Failure, OrderEntity> mockProcessCheckout = TaskEither.left(
    const ServerFailure(message: 'Not implemented'),
  );

  @override
  TaskEither<Failure, OrderEntity> processCheckout({
    required dynamic deliveryAddress,
    required dynamic paymentMethod,
    required dynamic items,
    required double subtotal,
    required double deliveryFee,
    required double tax,
    required double tip,
    required double discount,
    required String? promoCode,
    required String? deliveryInstructions,
    required DateTime? scheduledDeliveryTime,
  }) {
    return mockProcessCheckout;
  }

  @override
  TaskEither<Failure, List<dynamic>> getDeliverySlots() {
    return TaskEither.of([]);
  }

  @override
  TaskEither<Failure, List<PaymentMethodEntity>> getPaymentMethods() {
    return TaskEither.of([]);
  }

  @override
  TaskEither<Failure, PaymentMethodEntity?> getSelectedPaymentMethod() {
    return TaskEither.of(null);
  }

  @override
  TaskEither<Failure, List<dynamic>> getDeliveryAddresses() {
    return TaskEither.of([]);
  }

  @override
  TaskEither<Failure, dynamic?> getSelectedDeliveryAddress() {
    return TaskEither.of(null);
  }

  @override
  TaskEither<Failure, dynamic> saveDeliveryAddress({required dynamic address}) {
    return TaskEither.of(address);
  }

  @override
  TaskEither<Failure, PromoCodeResult> applyPromoCode({
    required String promoCode,
    required double orderSubtotal,
  }) {
    return TaskEither.of(
      PromoCodeResult(
        code: promoCode,
        discountAmount: orderSubtotal * 0.1,
      ),
    );
  }

  @override
  TaskEither<Failure, PromoCodeValidation> validatePromoCode({
    required String promoCode,
  }) {
    return TaskEither.of(
      PromoCodeValidation.valid(
        code: promoCode,
        discountPercent: 0.1,
        discountAmount: 10.0,
      ),
    );
  }
}
