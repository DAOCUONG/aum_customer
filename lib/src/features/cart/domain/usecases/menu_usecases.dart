import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/menu_category.dart';
import '../entities/menu_item_entity.dart';
import '../repository/cart_repository_interface.dart';

/// Use case for getting restaurant details
class GetRestaurantUseCase {
  final MenuRepositoryInterface _repository;

  GetRestaurantUseCase(this._repository);

  TaskEither<Failure, RestaurantEntity> call({required String restaurantId}) {
    if (restaurantId.isEmpty) {
      return TaskEither.left(
        ValidationFailure(message: 'Restaurant ID cannot be empty'),
      );
    }

    return _repository.getRestaurant(restaurantId: restaurantId);
  }
}

/// Use case for getting all menu items for a restaurant
class GetMenuItemsUseCase {
  final MenuRepositoryInterface _repository;

  GetMenuItemsUseCase(this._repository);

  TaskEither<Failure, List<MenuItemEntity>> call({required String restaurantId}) {
    if (restaurantId.isEmpty) {
      return TaskEither.left(
        ValidationFailure(message: 'Restaurant ID cannot be empty'),
      );
    }

    return _repository.getMenuItems(restaurantId: restaurantId);
  }
}

/// Use case for getting menu categories
class GetMenuCategoriesUseCase {
  final MenuRepositoryInterface _repository;

  GetMenuCategoriesUseCase(this._repository);

  TaskEither<Failure, List<MenuCategory>> call({required String restaurantId}) {
    if (restaurantId.isEmpty) {
      return TaskEither.left(
        ValidationFailure(message: 'Restaurant ID cannot be empty'),
      );
    }

    return _repository.getMenuCategories(restaurantId: restaurantId);
  }
}

/// Use case for getting a specific menu item
class GetMenuItemUseCase {
  final MenuRepositoryInterface _repository;

  GetMenuItemUseCase(this._repository);

  TaskEither<Failure, MenuItemEntity> call({required String menuItemId}) {
    if (menuItemId.isEmpty) {
      return TaskEither.left(
        ValidationFailure(message: 'Menu item ID cannot be empty'),
      );
    }

    return _repository.getMenuItem(menuItemId: menuItemId);
  }
}

/// Use case for getting items by category
class GetItemsByCategoryUseCase {
  final MenuRepositoryInterface _repository;

  GetItemsByCategoryUseCase(this._repository);

  TaskEither<Failure, List<MenuItemEntity>> call({
    required String restaurantId,
    required String categoryId,
  }) {
    if (restaurantId.isEmpty || categoryId.isEmpty) {
      return TaskEither.left(
        ValidationFailure(message: 'Invalid restaurant or category ID'),
      );
    }

    return _repository.getMenuItemsByCategory(
      restaurantId: restaurantId,
      categoryId: categoryId,
    );
  }
}
