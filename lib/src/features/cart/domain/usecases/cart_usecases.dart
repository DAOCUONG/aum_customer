import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/cart_entity.dart';
import '../entities/cart_item_entity.dart';
import '../repository/cart_repository_interface.dart';

/// Use case for getting the current cart
class GetCartUseCase {
  final CartRepositoryInterface _repository;

  GetCartUseCase(this._repository);

  TaskEither<Failure, CartEntity> call() {
    return _repository.getCart();
  }
}

/// Use case for adding an item to the cart
class AddToCartUseCase {
  final CartRepositoryInterface _repository;

  AddToCartUseCase(this._repository);

  TaskEither<Failure, CartEntity> call({
    required String menuItemId,
    required String name,
    required String description,
    required double price,
    required String imageUrl,
    required int quantity,
    List<CartItemCustomization>? customizations,
    String? notes,
  }) {
    // Validate quantity
    if (quantity < 1) {
      return TaskEither.left(
        ValidationFailure(message: 'Quantity must be at least 1'),
      );
    }

    return _repository.addItem(
      menuItemId: menuItemId,
      name: name,
      description: description,
      price: price,
      imageUrl: imageUrl,
      quantity: quantity,
      customizations: customizations,
      notes: notes,
    );
  }
}

/// Use case for updating item quantity in cart
class UpdateCartItemQuantityUseCase {
  final CartRepositoryInterface _repository;

  UpdateCartItemQuantityUseCase(this._repository);

  TaskEither<Failure, CartEntity> call({
    required String cartItemId,
    required int quantity,
  }) {
    // Validate quantity
    if (quantity < 1) {
      return TaskEither.left(
        ValidationFailure(message: 'Quantity must be at least 1'),
      );
    }

    return _repository.updateQuantity(
      cartItemId: cartItemId,
      quantity: quantity,
    );
  }
}

/// Use case for removing an item from the cart
class RemoveFromCartUseCase {
  final CartRepositoryInterface _repository;

  RemoveFromCartUseCase(this._repository);

  TaskEither<Failure, CartEntity> call({required String cartItemId}) {
    if (cartItemId.isEmpty) {
      return TaskEither.left(
        ValidationFailure(message: 'Invalid cart item ID'),
      );
    }

    return _repository.removeItem(cartItemId: cartItemId);
  }
}

/// Use case for clearing the entire cart
class ClearCartUseCase {
  final CartRepositoryInterface _repository;

  ClearCartUseCase(this._repository);

  TaskEither<Failure, CartEntity> call() {
    return _repository.clearCart();
  }
}

/// Use case for applying a promo code
class ApplyPromoCodeUseCase {
  final CartRepositoryInterface _repository;

  ApplyPromoCodeUseCase(this._repository);

  TaskEither<Failure, CartEntity> call({required String promoCode}) {
    if (promoCode.isEmpty) {
      return TaskEither.left(
        ValidationFailure(message: 'Promo code cannot be empty'),
      );
    }

    return _repository.applyPromoCode(promoCode: promoCode);
  }
}

/// Use case for removing a promo code
class RemovePromoCodeUseCase {
  final CartRepositoryInterface _repository;

  RemovePromoCodeUseCase(this._repository);

  TaskEither<Failure, CartEntity> call() {
    return _repository.removePromoCode();
  }
}
