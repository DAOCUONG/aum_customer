import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/cart_entity.dart';
import '../entities/cart_item_entity.dart';
import '../entities/menu_category.dart';
import '../entities/menu_item_entity.dart';

/// Repository interface for cart operations
/// Follows the dependency inversion principle - defined in domain layer
abstract class CartRepositoryInterface {
  /// Get the current cart
  TaskEither<Failure, CartEntity> getCart();

  /// Add an item to the cart
  TaskEither<Failure, CartEntity> addItem({
    required String menuItemId,
    required String name,
    required String description,
    required double price,
    required String imageUrl,
    required int quantity,
    List<CartItemCustomization>? customizations,
    String? notes,
  });

  /// Update the quantity of an item in the cart
  TaskEither<Failure, CartEntity> updateQuantity({
    required String cartItemId,
    required int quantity,
  });

  /// Remove an item from the cart
  TaskEither<Failure, CartEntity> removeItem({required String cartItemId});

  /// Clear all items from the cart
  TaskEither<Failure, CartEntity> clearCart();

  /// Apply a promo code to the cart
  TaskEither<Failure, CartEntity> applyPromoCode({required String promoCode});

  /// Remove the applied promo code
  TaskEither<Failure, CartEntity> removePromoCode();
}

/// Repository interface for menu/restaurant operations
abstract class MenuRepositoryInterface {
  /// Get restaurant details by ID
  TaskEither<Failure, RestaurantEntity> getRestaurant({required String restaurantId});

  /// Get menu items for a restaurant
  TaskEither<Failure, List<MenuItemEntity>> getMenuItems({required String restaurantId});

  /// Get menu items by category
  TaskEither<Failure, List<MenuItemEntity>> getMenuItemsByCategory({
    required String restaurantId,
    required String categoryId,
  });

  /// Get all menu categories for a restaurant
  TaskEither<Failure, List<MenuCategory>> getMenuCategories({required String restaurantId});

  /// Get a specific menu item
  TaskEither<Failure, MenuItemEntity> getMenuItem({required String menuItemId});
}
