import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/delivery_address_entity.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/entities/payment_method_entity.dart';
import '../../domain/usecases/checkout_usecases.dart';
import '../../domain/usecases/process_checkout_usecase.dart';
import 'checkout_state.dart';
import 'providers.dart';

/// Notifier for checkout state management
class CheckoutNotifier extends StateNotifier<CheckoutState> {
  final ProcessCheckoutUseCase _processCheckoutUseCase;
  final GetPaymentMethodsUseCase _getPaymentMethodsUseCase;
  final GetDeliveryAddressesUseCase _getDeliveryAddressesUseCase;
  final ApplyPromoCodeUseCase _applyPromoCodeUseCase;

  CheckoutNotifier({
    required ProcessCheckoutUseCase processCheckoutUseCase,
    required GetPaymentMethodsUseCase getPaymentMethodsUseCase,
    required GetDeliveryAddressesUseCase getDeliveryAddressesUseCase,
    required ApplyPromoCodeUseCase applyPromoCodeUseCase,
  })  : _processCheckoutUseCase = processCheckoutUseCase,
        _getPaymentMethodsUseCase = getPaymentMethodsUseCase,
        _getDeliveryAddressesUseCase = getDeliveryAddressesUseCase,
        _applyPromoCodeUseCase = applyPromoCodeUseCase,
        super(const CheckoutState());

  /// Initialize checkout state with saved data
  Future<void> initialize() async {
    state = state.copyWith(status: CheckoutStatus.loading);

    // Load payment methods and delivery address in parallel
    final paymentMethodsResult = await _getPaymentMethodsUseCase().run();
    final addressesResult = await _getDeliveryAddressesUseCase().run();

    paymentMethodsResult.fold(
      (failure) {},
      (methods) {
        if (methods.isNotEmpty) {
          state = state.copyWith(
            paymentMethods: methods,
            paymentMethod: methods.firstWhere(
              (m) => m.isDefault,
              orElse: () => methods.first,
            ),
          );
        }
      },
    );

    addressesResult.fold(
      (failure) {},
      (addresses) {
        if (addresses.isNotEmpty) {
          state = state.copyWith(
            savedAddresses: addresses,
            deliveryAddress: addresses.firstWhere(
              (a) => a.isDefault,
              orElse: () => addresses.first,
            ),
          );
        }
      },
    );

    state = state.copyWith(status: CheckoutStatus.initial);
  }

  /// Update selected payment method
  void selectPaymentMethod(PaymentMethodEntity method) {
    state = state.copyWith(paymentMethod: method);
  }

  /// Update delivery address
  void updateDeliveryAddress(DeliveryAddressEntity address) {
    state = state.copyWith(deliveryAddress: address);
  }

  /// Select tip percentage
  void selectTip(int index) {
    final percentages = state.tipPercentages;
    final subtotal = state.subtotal;
    final tipPercentage = percentages[index] / 100;
    final tipAmount = subtotal * tipPercentage;

    state = state.copyWith(
      selectedTipIndex: index,
      tipAmount: tipAmount,
    );
  }

  /// Set custom tip amount
  void setCustomTip(double amount) {
    state = state.copyWith(
      tipAmount: amount,
      selectedTipIndex: -1,
    );
  }

  /// Apply promo code
  Future<void> applyPromoCode(String code) async {
    if (code.trim().isEmpty) return;

    state = state.copyWith(isApplyingPromo: true, promoErrorMessage: '');

    final result = await _applyPromoCodeUseCase(
      promoCode: code,
      orderSubtotal: state.subtotal,
    ).run();

    result.fold(
      (failure) {
        state = state.copyWith(
          isApplyingPromo: false,
          promoErrorMessage: failure.message,
        );
      },
      (promoResult) {
        state = state.copyWith(
          isApplyingPromo: false,
          promoCode: promoResult.code,
          promoDiscount: promoResult.discountAmount,
          promoErrorMessage: '',
        );
      },
    );
  }

  /// Remove applied promo code
  void removePromoCode() {
    state = state.copyWith(
      promoCode: '',
      promoDiscount: 0,
      promoErrorMessage: '',
    );
  }

  /// Toggle leave at door option
  void setLeaveAtDoor(bool value) {
    state = state.copyWith(leaveAtDoor: value);
  }

  /// Toggle priority delivery option
  void setPriorityDelivery(bool value) {
    state = state.copyWith(priorityDelivery: value);
  }

  /// Update delivery instructions
  void setDeliveryInstructions(String instructions) {
    state = state.copyWith(deliveryInstructions: instructions);
  }

  /// Process checkout and create order
  Future<bool> processCheckout() async {
    final deliveryAddress = state.effectiveDeliveryAddress;
    final paymentMethod = state.effectivePaymentMethod;

    if (!deliveryAddress.isValid) {
      state = state.copyWith(
        status: CheckoutStatus.error,
        errorMessage: 'Please select a delivery address',
      );
      return false;
    }

    if (!paymentMethod.isValid) {
      state = state.copyWith(
        status: CheckoutStatus.error,
        errorMessage: 'Please select a payment method',
      );
      return false;
    }

    state = state.copyWith(status: CheckoutStatus.processing);

    // Mock order items (in real app, would come from cart)
    final items = [
      const OrderItemEntity(
        id: 'item_1',
        menuItemId: 'menu_001',
        name: 'Margherita Pizza',
        description: 'Classic tomato sauce, fresh mozzarella, basil',
        price: 14.99,
        quantity: 1,
        imageUrl: 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=400',
      ),
      const OrderItemEntity(
        id: 'item_2',
        menuItemId: 'menu_003',
        name: 'Caesar Salad',
        description: 'Romaine lettuce, croutons, parmesan',
        price: 10.99,
        quantity: 1,
        imageUrl: 'https://images.unsplash.com/photo-1550304943-4f24f54ddde9?w=400',
      ),
      const OrderItemEntity(
        id: 'item_3',
        menuItemId: 'menu_004',
        name: 'Tiramisu',
        description: 'Classic Italian dessert',
        price: 8.99,
        quantity: 1,
        imageUrl: 'https://images.unsplash.com/photo-1571877227200-a0d98ea607e9?w=400',
      ),
    ];

    final result = await _processCheckoutUseCase(
      deliveryAddress: deliveryAddress,
      paymentMethod: paymentMethod,
      items: items,
      subtotal: state.subtotal,
      deliveryFee: state.deliveryFee,
      tax: state.tax,
      tip: state.tipAmount,
      discount: state.promoDiscount,
      promoCode: state.promoCode.isNotEmpty ? state.promoCode : null,
      deliveryInstructions: state.deliveryInstructions.isNotEmpty
          ? state.deliveryInstructions
          : null,
      scheduledDeliveryTime: null,
    ).run();

    result.fold(
      (failure) {
        state = state.copyWith(
          status: CheckoutStatus.error,
          errorMessage: failure.message,
        );
        return false;
      },
      (order) {
        state = state.copyWith(
          status: CheckoutStatus.success,
          order: order,
        );
        return true;
      },
    );

    return state.status == CheckoutStatus.success;
  }

  /// Clear error message
  void clearError() {
    state = state.copyWith(errorMessage: '');
  }

  /// Reset checkout state
  void reset() {
    state = const CheckoutState();
  }
}

/// Provider for CheckoutNotifier
final checkoutNotifierProvider =
    StateNotifierProvider<CheckoutNotifier, CheckoutState>((ref) {
  final repository = ref.watch(checkoutRepositoryProvider);

  return CheckoutNotifier(
    processCheckoutUseCase: ProcessCheckoutUseCase(repository),
    getPaymentMethodsUseCase: GetPaymentMethodsUseCase(repository),
    getDeliveryAddressesUseCase: GetDeliveryAddressesUseCase(repository),
    applyPromoCodeUseCase: ApplyPromoCodeUseCase(repository),
  );
});

/// Derived provider for tip amounts
final tipAmountsProvider = Provider<List<double>>((ref) {
  final state = ref.watch(checkoutNotifierProvider);
  final percentages = state.tipPercentages;
  final subtotal = state.subtotal;

  return percentages.map((p) => subtotal * (p / 100)).toList();
});
