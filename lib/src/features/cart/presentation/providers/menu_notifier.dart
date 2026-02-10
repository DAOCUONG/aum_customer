import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/menu_category.dart';
import '../../domain/entities/menu_item_entity.dart';
import '../../domain/usecases/menu_usecases.dart';
import 'menu_state.dart';
import 'providers.dart';

/// Notifier for menu state management
class MenuNotifier extends StateNotifier<MenuState> {
  final GetRestaurantUseCase _getRestaurantUseCase;
  final GetMenuItemsUseCase _getMenuItemsUseCase;
  final GetMenuCategoriesUseCase _getMenuCategoriesUseCase;

  MenuNotifier({
    required GetRestaurantUseCase getRestaurantUseCase,
    required GetMenuItemsUseCase getMenuItemsUseCase,
    required GetMenuCategoriesUseCase getMenuCategoriesUseCase,
  })  : _getRestaurantUseCase = getRestaurantUseCase,
        _getMenuItemsUseCase = getMenuItemsUseCase,
        _getMenuCategoriesUseCase = getMenuCategoriesUseCase,
        super(const MenuState());

  /// Load restaurant and menu data
  Future<void> loadRestaurant({required String restaurantId}) async {
    state = state.copyWith(
      status: MenuStatus.loading,
      restaurantId: restaurantId,
      errorMessage: '',
    );

    // Load restaurant details
    final restaurantResult = await _getRestaurantUseCase(
      restaurantId: restaurantId,
    ).run();

    // Load menu categories
    final categoriesResult = await _getMenuCategoriesUseCase(
      restaurantId: restaurantId,
    ).run();

    // Load menu items
    final menuItemsResult = await _getMenuItemsUseCase(
      restaurantId: restaurantId,
    ).run();

    // Combine results
    final failure = restaurantResult.fold(
      (l) => l,
      (_) => categoriesResult.fold(
        (l) => l,
        (_) => menuItemsResult.fold(
          (l) => l,
          (_) => null,
        ),
      ),
    );

    if (failure != null) {
      state = state.copyWith(
        status: MenuStatus.error,
        errorMessage: failure.message,
      );
      return;
    }

    // Extract successful results
    final restaurant = restaurantResult.fold(
      (l) => null,
      (r) => r,
    );

    final categories = categoriesResult.fold(
      (l) => <MenuCategory>[],
      (r) => r,
    );

    final menuItems = menuItemsResult.fold(
      (l) => <MenuItemEntity>[],
      (r) => r,
    );

    // Select first category by default
    final selectedCategoryId = categories.isNotEmpty ? categories.first.id : '';

    state = state.copyWith(
      status: MenuStatus.loaded,
      restaurant: restaurant,
      menuItems: menuItems,
      categories: categories,
      selectedCategoryId: selectedCategoryId,
    );
  }

  /// Select a category
  void selectCategory({required String categoryId}) {
    state = state.copyWith(selectedCategoryId: categoryId);
  }

  /// Clear error message
  void clearError() {
    state = state.copyWith(errorMessage: '');
  }
}

/// Provider for MenuNotifier
final menuNotifierProvider =
    StateNotifierProvider<MenuNotifier, MenuState>((ref) {
  final menuRepo = ref.watch(menuRepositoryProvider);

  return MenuNotifier(
    getRestaurantUseCase: GetRestaurantUseCase(menuRepo),
    getMenuItemsUseCase: GetMenuItemsUseCase(menuRepo),
    getMenuCategoriesUseCase: GetMenuCategoriesUseCase(menuRepo),
  );
});
