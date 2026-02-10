import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/cart_item_entity.dart';
import '../../domain/usecases/cart_usecases.dart';
import 'cart_state.dart';
import 'providers.dart';

/// Notifier for cart state management
class CartNotifier extends StateNotifier<CartState> {
  final GetCartUseCase _getCartUseCase;
  final AddToCartUseCase _addToCartUseCase;
  final UpdateCartItemQuantityUseCase _updateQuantityUseCase;
  final RemoveFromCartUseCase _removeFromCartUseCase;
  final ClearCartUseCase _clearCartUseCase;
  final ApplyPromoCodeUseCase _applyPromoCodeUseCase;
  final RemovePromoCodeUseCase _removePromoCodeUseCase;

  CartNotifier({
    required GetCartUseCase getCartUseCase,
    required AddToCartUseCase addToCartUseCase,
    required UpdateCartItemQuantityUseCase updateQuantityUseCase,
    required RemoveFromCartUseCase removeFromCartUseCase,
    required ClearCartUseCase clearCartUseCase,
    required ApplyPromoCodeUseCase applyPromoCodeUseCase,
    required RemovePromoCodeUseCase removePromoCodeUseCase,
  })  : _getCartUseCase = getCartUseCase,
        _addToCartUseCase = addToCartUseCase,
        _updateQuantityUseCase = updateQuantityUseCase,
        _removeFromCartUseCase = removeFromCartUseCase,
        _clearCartUseCase = clearCartUseCase,
        _applyPromoCodeUseCase = applyPromoCodeUseCase,
        _removePromoCodeUseCase = removePromoCodeUseCase,
        super(const CartState.initial());

  Future<void> loadCart() async {
    state = state.copyWith(status: CartStatus.loading, errorMessage: '');

    final result = await _getCartUseCase().run();

    result.fold(
      (failure) {
        state = state.copyWith(
          status: CartStatus.error,
          errorMessage: failure.message,
        );
      },
      (cart) {
        state = state.copyWith(
          status: cart.isEmpty ? CartStatus.empty : CartStatus.loaded,
          cart: cart,
        );
      },
    );
  }

  Future<void> addItem({
    required String menuItemId,
    required String name,
    required String description,
    required double price,
    required String imageUrl,
    required int quantity,
    List<CartItemCustomization>? customizations,
    String? notes,
  }) async {
    state = state.copyWith(status: CartStatus.loading);

    final result = await _addToCartUseCase(
      menuItemId: menuItemId,
      name: name,
      description: description,
      price: price,
      imageUrl: imageUrl,
      quantity: quantity,
      customizations: customizations,
      notes: notes,
    ).run();

    result.fold(
      (failure) {
        state = state.copyWith(
          status: state.cart?.isEmpty == true ? CartStatus.empty : CartStatus.loaded,
          errorMessage: failure.message,
        );
      },
      (cart) {
        state = state.copyWith(
          status: cart.isEmpty ? CartStatus.empty : CartStatus.loaded,
          cart: cart,
        );
      },
    );
  }

  Future<void> updateQuantity({
    required String cartItemId,
    required int quantity,
  }) async {
    final result = await _updateQuantityUseCase(
      cartItemId: cartItemId,
      quantity: quantity,
    ).run();

    result.fold(
      (failure) {
        state = state.copyWith(errorMessage: failure.message);
      },
      (cart) {
        state = state.copyWith(
          status: cart.isEmpty ? CartStatus.empty : CartStatus.loaded,
          cart: cart,
        );
      },
    );
  }

  Future<void> removeItem({required String cartItemId}) async {
    final result = await _removeFromCartUseCase(cartItemId: cartItemId).run();

    result.fold(
      (failure) {
        state = state.copyWith(errorMessage: failure.message);
      },
      (cart) {
        state = state.copyWith(
          status: cart.isEmpty ? CartStatus.empty : CartStatus.loaded,
          cart: cart,
        );
      },
    );
  }

  Future<void> clearCart() async {
    final result = await _clearCartUseCase().run();

    result.fold(
      (failure) {
        state = state.copyWith(errorMessage: failure.message);
      },
      (cart) {
        state = state.copyWith(
          status: CartStatus.empty,
          cart: cart,
        );
      },
    );
  }

  Future<void> applyPromoCode({required String promoCode}) async {
    state = state.copyWith(isApplyingPromo: true);

    final result = await _applyPromoCodeUseCase(promoCode: promoCode).run();

    result.fold(
      (failure) {
        state = state.copyWith(
          isApplyingPromo: false,
          errorMessage: failure.message,
        );
      },
      (cart) {
        state = state.copyWith(
          isApplyingPromo: false,
          cart: cart,
        );
      },
    );
  }

  Future<void> removePromoCode() async {
    final result = await _removePromoCodeUseCase().run();

    result.fold(
      (failure) {
        state = state.copyWith(errorMessage: failure.message);
      },
      (cart) {
        state = state.copyWith(cart: cart);
      },
    );
  }

  Future<void> incrementQuantity(String cartItemId) async {
    final currentQuantity = state.cart?.items
        .firstWhere((item) => item.id == cartItemId)
        .quantity;

    if (currentQuantity != null) {
      await updateQuantity(
        cartItemId: cartItemId,
        quantity: currentQuantity + 1,
      );
    }
  }

  Future<void> decrementQuantity(String cartItemId) async {
    final currentQuantity = state.cart?.items
        .firstWhere((item) => item.id == cartItemId)
        .quantity;

    if (currentQuantity != null && currentQuantity > 1) {
      await updateQuantity(
        cartItemId: cartItemId,
        quantity: currentQuantity - 1,
      );
    }
  }

  void clearError() {
    state = state.copyWith(errorMessage: '');
  }
}

/// Provider for CartNotifier
final cartNotifierProvider =
    StateNotifierProvider<CartNotifier, CartState>((ref) {
  final cartRepo = ref.watch(cartRepositoryProvider);

  return CartNotifier(
    getCartUseCase: GetCartUseCase(cartRepo),
    addToCartUseCase: AddToCartUseCase(cartRepo),
    updateQuantityUseCase: UpdateCartItemQuantityUseCase(cartRepo),
    removeFromCartUseCase: RemoveFromCartUseCase(cartRepo),
    clearCartUseCase: ClearCartUseCase(cartRepo),
    applyPromoCodeUseCase: ApplyPromoCodeUseCase(cartRepo),
    removePromoCodeUseCase: RemovePromoCodeUseCase(cartRepo),
  );
});
