import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/delivery_address_entity.dart';
import '../../domain/entities/delivery_slot_entity.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/entities/payment_method_entity.dart';
import '../../domain/repository/checkout_repository_interface.dart';
import '../models/delivery_address_model.dart';
import '../models/delivery_slot_model.dart';
import '../models/order_model.dart';
import '../models/payment_method_model.dart';

/// Implementation of CheckoutRepositoryInterface with mock data
///
/// This implementation provides realistic mock data for development
/// and testing purposes. In production, this would be replaced
/// with actual API calls.
class CheckoutRepositoryImpl implements CheckoutRepositoryInterface {
  OrderModel? _lastOrder;
  String? _appliedPromoCode;

  CheckoutRepositoryImpl();

  @override
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
  }) {
    return TaskEither.tryCatch(
      () async {
        // Simulate network delay
        await Future.delayed(const Duration(milliseconds: 800));

        // Generate order number
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final random = (timestamp % 10000).toString().padLeft(4, '0');
        final orderNumber = 'ORD-$random';

        // Create order model
        final orderModel = OrderModel(
          id: 'order_$timestamp',
          orderNumber: orderNumber,
          createdAt: DateTime.now().toIso8601String(),
          status: 'confirmed',
          deliveryAddress: {
            'id': deliveryAddress.id,
            'label': deliveryAddress.label,
            'streetAddress': deliveryAddress.streetAddress,
            'apartment': deliveryAddress.apartment,
            'city': deliveryAddress.city,
            'state': deliveryAddress.state,
            'zipCode': deliveryAddress.zipCode,
            'country': deliveryAddress.country,
            'latitude': deliveryAddress.latitude,
            'longitude': deliveryAddress.longitude,
            'isDefault': deliveryAddress.isDefault,
            'deliveryInstructions': deliveryAddress.deliveryInstructions,
          },
          paymentMethod: {
            'id': paymentMethod.id,
            'type': paymentMethod.type.name,
            'lastFourDigits': paymentMethod.lastFourDigits,
            'cardBrand': paymentMethod.cardBrand,
            'cardholderName': paymentMethod.cardholderName,
            'expiryMonth': paymentMethod.expiryMonth,
            'expiryYear': paymentMethod.expiryYear,
            'isDefault': paymentMethod.isDefault,
            'iconName': paymentMethod.iconName,
          },
          items: items.map((item) => {
                'id': item.id,
                'menuItemId': item.menuItemId,
                'name': item.name,
                'description': item.description,
                'price': item.price,
                'quantity': item.quantity,
                'imageUrl': item.imageUrl,
                'customizations': item.customizations
                    ?.map((c) => {
                          'id': c.id,
                          'name': c.name,
                          'price': c.price,
                        })
                    .toList(),
                'notes': item.notes,
              }).toList(),
          subtotal: subtotal,
          deliveryFee: deliveryFee,
          tax: tax,
          tip: tip,
          discount: discount,
          total: subtotal + deliveryFee + tax + tip - discount,
          scheduledDeliveryTime: scheduledDeliveryTime?.toIso8601String(),
          promoCode: promoCode,
          deliveryInstructions: deliveryInstructions,
          estimatedDeliveryMinutes: 30,
        );

        _lastOrder = orderModel;
        _appliedPromoCode = promoCode;

        return orderModel.toEntity();
      },
      (error, stack) => ServerFailure(message: 'Failed to process checkout: $error'),
    );
  }

  @override
  TaskEither<Failure, List<DeliverySlotEntity>> getDeliverySlots() {
    return TaskEither.tryCatch(
      () async {
        await Future.delayed(const Duration(milliseconds: 200));

        // Generate mock delivery slots for next 7 days
        final slots = _generateMockDeliverySlots();
        return slots.map((model) => model.toEntity()).toList();
      },
      (error, stack) => ServerFailure(message: 'Failed to get delivery slots: $error'),
    );
  }

  @override
  TaskEither<Failure, List<PaymentMethodEntity>> getPaymentMethods() {
    return TaskEither.tryCatch(
      () async {
        await Future.delayed(const Duration(milliseconds: 100));

        final methods = _getMockPaymentMethods();
        return methods.map((model) => model.toEntity()).toList();
      },
      (error, stack) => ServerFailure(message: 'Failed to get payment methods: $error'),
    );
  }

  @override
  TaskEither<Failure, PaymentMethodEntity?> getSelectedPaymentMethod() {
    return TaskEither.tryCatch(
      () async {
        await Future.delayed(const Duration(milliseconds: 50));

        // Return the default payment method (Apple Pay in mock)
        final methods = _getMockPaymentMethods();
        final defaultMethod = methods.firstWhere(
          (m) => m.isDefault,
          orElse: () => methods.first,
        );
        return defaultMethod.toEntity();
      },
      (error, stack) =>
          ServerFailure(message: 'Failed to get selected payment method: $error'),
    );
  }

  @override
  TaskEither<Failure, List<DeliveryAddressEntity>> getDeliveryAddresses() {
    return TaskEither.tryCatch(
      () async {
        await Future.delayed(const Duration(milliseconds: 100));

        final addresses = _getMockDeliveryAddresses();
        return addresses.map((model) => model.toEntity()).toList();
      },
      (error, stack) => ServerFailure(message: 'Failed to get delivery addresses: $error'),
    );
  }

  @override
  TaskEither<Failure, DeliveryAddressEntity?> getSelectedDeliveryAddress() {
    return TaskEither.tryCatch(
      () async {
        await Future.delayed(const Duration(milliseconds: 50));

        // Return the default delivery address
        final addresses = _getMockDeliveryAddresses();
        final defaultAddress = addresses.firstWhere(
          (a) => a.isDefault,
          orElse: () => addresses.first,
        );
        return defaultAddress.toEntity();
      },
      (error, stack) =>
          ServerFailure(message: 'Failed to get selected delivery address: $error'),
    );
  }

  @override
  TaskEither<Failure, DeliveryAddressEntity> saveDeliveryAddress({
    required DeliveryAddressEntity address,
  }) {
    return TaskEither.tryCatch(
      () async {
        await Future.delayed(const Duration(milliseconds: 200));
        return address;
      },
      (error, stack) => ServerFailure(message: 'Failed to save delivery address: $error'),
    );
  }

  @override
  TaskEither<Failure, PromoCodeResult> applyPromoCode({
    required String promoCode,
    required double orderSubtotal,
  }) {
    return TaskEither.tryCatch(
      () async {
        await Future.delayed(const Duration(milliseconds: 300));

        // Valid promo codes for testing
        final validPromos = {
          'SAVE10': _PromoConfig(discountPercent: 0.10, description: '10% off'),
          'SAVE20': _PromoConfig(discountPercent: 0.20, description: '20% off'),
          'FIRST5': _PromoConfig(discountAmount: 5.0, description: '\$5 off'),
          'FREEDELIVERY': _PromoConfig(
            discountAmount: 2.99,
            description: 'Free delivery',
          ),
        };

        final code = promoCode.toUpperCase();
        final promo = validPromos[code];

        if (promo == null) {
          throw ValidationFailure(message: 'Invalid promo code');
        }

        final discountAmount = promo.discountAmount ??
            (orderSubtotal * promo.discountPercent!);

        return PromoCodeResult(
          code: code,
          discountAmount: discountAmount,
          description: promo.description,
        );
      },
      (error, stack) =>
          ServerFailure(message: 'Failed to apply promo code: $error'),
    );
  }

  @override
  TaskEither<Failure, PromoCodeValidation> validatePromoCode({
    required String promoCode,
  }) {
    return TaskEither.tryCatch(
      () async {
        await Future.delayed(const Duration(milliseconds: 200));

        final validPromos = {
          'SAVE10': _PromoConfig(discountPercent: 0.10),
          'SAVE20': _PromoConfig(discountPercent: 0.20),
          'FIRST5': _PromoConfig(discountAmount: 5.0),
          'FREEDELIVERY': _PromoConfig(discountAmount: 2.99),
        };

        final code = promoCode.toUpperCase();
        final promo = validPromos[code];

        if (promo == null) {
          return PromoCodeValidation.invalid('Invalid promo code');
        }

        if (promo.discountPercent != null) {
          return PromoCodeValidation.valid(
            code: code,
            discountPercent: promo.discountPercent!,
            discountAmount: promo.discountPercent! * 100,
          );
        }

        return PromoCodeValidation.valid(
          code: code,
          discountPercent: 0,
          discountAmount: promo.discountAmount!,
        );
      },
      (error, stack) =>
          ServerFailure(message: 'Failed to validate promo code: $error'),
    );
  }

  /// Get the last created order (for testing)
  OrderEntity? getLastOrder() {
    return _lastOrder?.toEntity();
  }

  /// Get mock payment methods
  List<PaymentMethodModel> _getMockPaymentMethods() {
    return [
      const PaymentMethodModel(
        id: 'pm_apple_pay',
        type: 'apple_pay',
        lastFourDigits: '4242',
        cardBrand: 'Apple Pay',
        isDefault: true,
      ),
      const PaymentMethodModel(
        id: 'pm_visa',
        type: 'credit_card',
        lastFourDigits: '4532',
        cardBrand: 'Visa',
        cardholderName: 'John Doe',
        expiryMonth: '12',
        expiryYear: '26',
        isDefault: false,
      ),
      const PaymentMethodModel(
        id: 'pm_mastercard',
        type: 'credit_card',
        lastFourDigits: '8888',
        cardBrand: 'Mastercard',
        cardholderName: 'John Doe',
        expiryMonth: '06',
        expiryYear: '25',
        isDefault: false,
      ),
    ];
  }

  /// Get mock delivery addresses
  List<DeliveryAddressModel> _getMockDeliveryAddresses() {
    return [
      const DeliveryAddressModel(
        id: 'addr_home',
        label: 'Home',
        streetAddress: '245 Highland Ave',
        apartment: 'Apt 4B',
        city: 'San Francisco',
        state: 'CA',
        zipCode: '94110',
        country: 'USA',
        latitude: 37.7749,
        longitude: -122.4194,
        isDefault: true,
        deliveryInstructions: 'Gate code: 1234',
      ),
      const DeliveryAddressModel(
        id: 'addr_work',
        label: 'Work',
        streetAddress: '100 Market Street',
        apartment: 'Suite 500',
        city: 'San Francisco',
        state: 'CA',
        zipCode: '94105',
        country: 'USA',
        latitude: 37.7937,
        longitude: -122.3951,
        isDefault: false,
      ),
    ];
  }

  /// Generate mock delivery slots for next 7 days
  List<DeliverySlotModel> _generateMockDeliverySlots() {
    final slots = <DeliverySlotModel>[];
    final now = DateTime.now();
    int slotId = 0;

    // Generate slots for the next 7 days
    for (int day = 0; day < 7; day++) {
      final date = now.add(Duration(days: day));

      // Skip past time slots for today
      final startHour = day == 0 ? now.hour + 1 : 10;
      final endHour = 22;

      // Morning slot (10:00 - 12:00)
      if (startHour <= 10) {
        slots.add(DeliverySlotModel(
          id: 'slot_${slotId++}',
          date: '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}',
          startTime: '10:00',
          endTime: '12:00',
          isAvailable: true,
          additionalFee: null,
          remainingSlots: 5,
        ));
      }

      // Afternoon slot (12:00 - 14:00)
      if (startHour <= 12) {
        slots.add(DeliverySlotModel(
          id: 'slot_${slotId++}',
          date: '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}',
          startTime: '12:00',
          endTime: '14:00',
          isAvailable: true,
          additionalFee: day == 0 ? 1.99 : null,
          remainingSlots: 3,
        ));
      }

      // Evening slot (18:00 - 20:00)
      if (startHour <= 18) {
        slots.add(DeliverySlotModel(
          id: 'slot_${slotId++}',
          date: '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}',
          startTime: '18:00',
          endTime: '20:00',
          isAvailable: true,
          additionalFee: null,
          remainingSlots: 7,
        ));
      }

      // Late night slot (20:00 - 22:00)
      if (startHour <= 20) {
        slots.add(DeliverySlotModel(
          id: 'slot_${slotId++}',
          date: '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}',
          startTime: '20:00',
          endTime: '22:00',
          isAvailable: day < 6, // Not available for the last day
          additionalFee: 2.99,
          remainingSlots: day < 6 ? 2 : 0,
        ));
      }
    }

    return slots;
  }
}

/// Configuration for promo codes
class _PromoConfig {
  final double? discountPercent;
  final double? discountAmount;
  final String? description;

  const _PromoConfig({
    this.discountPercent,
    this.discountAmount,
    this.description,
  });
}
