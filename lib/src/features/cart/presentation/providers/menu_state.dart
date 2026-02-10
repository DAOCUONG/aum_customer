import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/menu_category.dart';
import '../../domain/entities/menu_item_entity.dart';

part 'menu_state.freezed.dart';

/// State for the menu/restaurant detail screen
@freezed
class MenuState with _$MenuState {
  const factory MenuState({
    @Default(MenuStatus.initial) MenuStatus status,
    @Default('') String restaurantId,
    RestaurantEntity? restaurant,
    @Default([]) List<MenuItemEntity> menuItems,
    @Default([]) List<MenuCategory> categories,
    @Default('') String selectedCategoryId,
    @Default('') String errorMessage,
  }) = _MenuState;

  const MenuState._();
}

/// Status of the menu
enum MenuStatus {
  initial,
  loading,
  loaded,
  error,
}

/// Extension for MenuState helpers
extension MenuStateHelpers on MenuState {
  /// Check if menu is loading
  bool get isLoading => status == MenuStatus.loading;

  /// Check if menu is loaded
  bool get isLoaded => status == MenuStatus.loaded;

  /// Get items for selected category
  List<MenuItemEntity> get itemsForSelectedCategory {
    if (selectedCategoryId.isEmpty) return menuItems;
    return menuItems.where((item) => item.categoryId == selectedCategoryId).toList();
  }

  /// Get selected category name
  String? get selectedCategoryName {
    try {
      return categories.firstWhere((c) => c.id == selectedCategoryId).name;
    } catch (e) {
      return null;
    }
  }
}
