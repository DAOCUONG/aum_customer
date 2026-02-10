import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/cart_item_entity.dart';
import '../../domain/entities/menu_item_entity.dart';
import '../../domain/usecases/menu_usecases.dart';
import 'item_customization_state.dart';
import 'providers.dart';

/// Notifier for item customization state management
class ItemCustomizationNotifier
    extends StateNotifier<ItemCustomizationState> {
  final GetMenuItemUseCase _getMenuItemUseCase;

  ItemCustomizationNotifier({
    required GetMenuItemUseCase getMenuItemUseCase,
  })  : _getMenuItemUseCase = getMenuItemUseCase,
        super(const ItemCustomizationState());

  /// Load menu item for customization
  Future<void> loadMenuItem({required String menuItemId}) async {
    state = state.copyWith(
      status: ItemCustomizationStatus.loading,
      errorMessage: '',
    );

    final result = await _getMenuItemUseCase(menuItemId: menuItemId).run();

    result.fold(
      (failure) {
        state = state.copyWith(
          status: ItemCustomizationStatus.error,
          errorMessage: failure.message,
        );
      },
      (menuItem) {
        state = state.copyWith(
          status: ItemCustomizationStatus.loaded,
          menuItem: menuItem,
          quantity: 1,
          selectedRequiredOptions: [],
          selectedOptionalOptions: [],
          specialInstructions: '',
          totalPrice: menuItem.price,
        );
      },
    );
  }

  /// Set the menu item directly (from restaurant detail screen)
  void setMenuItem(MenuItemEntity menuItem) {
    state = state.copyWith(
      status: ItemCustomizationStatus.loaded,
      menuItem: menuItem,
      quantity: 1,
      selectedRequiredOptions: [],
      selectedOptionalOptions: [],
      specialInstructions: '',
      totalPrice: menuItem.price,
    );
  }

  /// Increment quantity
  void incrementQuantity() {
    if (state.quantity < 99) {
      state = state.copyWith(quantity: state.quantity + 1);
    }
  }

  /// Decrement quantity
  void decrementQuantity() {
    if (state.quantity > 1) {
      state = state.copyWith(quantity: state.quantity - 1);
    }
  }

  /// Set quantity directly
  void setQuantity(int quantity) {
    if (quantity >= 1 && quantity <= 99) {
      state = state.copyWith(quantity: quantity);
    }
  }

  /// Toggle a required option
  void toggleRequiredOption(String optionId) {
    final current = List<String>.from(state.selectedRequiredOptions);
    if (current.contains(optionId)) {
      current.remove(optionId);
    } else {
      // Find the group and enforce max selections
      final group = _findGroupForOption(optionId);
      if (group != null) {
        // Remove previous selection if single selection
        if (group.maxSelections == 1) {
          current.clear();
        }
        current.add(optionId);
      }
    }
    state = state.copyWith(selectedRequiredOptions: current);
  }

  /// Toggle an optional option
  void toggleOptionalOption(String optionId) {
    final current = List<String>.from(state.selectedOptionalOptions);
    if (current.contains(optionId)) {
      current.remove(optionId);
    } else {
      // Check max selections
      final group = _findGroupForOption(optionId);
      if (group != null && current.length < group.maxSelections) {
        current.add(optionId);
      }
    }
    state = state.copyWith(selectedOptionalOptions: current);
  }

  /// Set special instructions
  void setSpecialInstructions(String instructions) {
    state = state.copyWith(specialInstructions: instructions);
  }

  /// Get selected customization objects
  List<CartItemCustomization> getSelectedCustomizations() {
    final List<CartItemCustomization> customizations = [];

    // Add required options
    for (final optionId in state.selectedRequiredOptions) {
      final option = _findOptionById(optionId);
      if (option != null) {
        customizations.add(
          CartItemCustomization(
            id: option.id,
            name: option.name,
            price: option.price,
          ),
        );
      }
    }

    // Add optional options
    for (final optionId in state.selectedOptionalOptions) {
      final option = _findOptionById(optionId);
      if (option != null) {
        customizations.add(
          CartItemCustomization(
            id: option.id,
            name: option.name,
            price: option.price,
          ),
        );
      }
    }

    return customizations;
  }

  MenuItemCustomizationGroup? _findGroupForOption(String optionId) {
    if (state.menuItem?.customizationGroups == null) return null;

    for (final group in state.menuItem!.customizationGroups!) {
      for (final option in group.options) {
        if (option.id == optionId) {
          return group;
        }
      }
    }

    return null;
  }

  MenuItemCustomizationOption? _findOptionById(String optionId) {
    if (state.menuItem?.customizationGroups == null) return null;

    for (final group in state.menuItem!.customizationGroups!) {
      for (final option in group.options) {
        if (option.id == optionId) {
          return option;
        }
      }
    }

    return null;
  }

  /// Reset state
  void reset() {
    state = const ItemCustomizationState();
  }
}

/// Provider for ItemCustomizationNotifier
final itemCustomizationNotifierProvider =
    StateNotifierProvider<ItemCustomizationNotifier, ItemCustomizationState>(
        (ref) {
  final menuRepo = ref.watch(menuRepositoryProvider);

  return ItemCustomizationNotifier(
    getMenuItemUseCase: GetMenuItemUseCase(menuRepo),
  );
});
