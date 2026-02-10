import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/menu_item_entity.dart';

part 'item_customization_state.freezed.dart';

/// State for item customization screen
@freezed
class ItemCustomizationState with _$ItemCustomizationState {
  const factory ItemCustomizationState({
    @Default(ItemCustomizationStatus.initial) ItemCustomizationStatus status,
    MenuItemEntity? menuItem,
    @Default(1) int quantity,
    @Default([]) List<String> selectedRequiredOptions,
    @Default([]) List<String> selectedOptionalOptions,
    @Default('') String specialInstructions,
    @Default(0.0) double totalPrice,
    @Default('') String errorMessage,
  }) = _ItemCustomizationState;

  const ItemCustomizationState._();
}

/// Status of item customization
enum ItemCustomizationStatus {
  initial,
  loading,
  loaded,
  error,
}

/// Extension for ItemCustomizationState helpers
extension ItemCustomizationStateHelpers on ItemCustomizationState {
  /// Check if customization is loading
  bool get isLoading => status == ItemCustomizationStatus.loading;

  /// Check if customization is loaded
  bool get isLoaded => status == ItemCustomizationStatus.loaded;

  /// Get base price
  double get basePrice => menuItem?.price ?? 0.0;

  /// Get customizations total price
  double get customizationsPrice {
    double total = 0.0;

    // Add required options price
    for (final optionId in selectedRequiredOptions) {
      final option = _findOptionById(optionId);
      if (option != null) {
        total += option.price;
      }
    }

    // Add optional options price
    for (final optionId in selectedOptionalOptions) {
      final option = _findOptionById(optionId);
      if (option != null) {
        total += option.price;
      }
    }

    return total;
  }

  /// Get total price with quantity
  double get total {
    return (basePrice + customizationsPrice) * quantity;
  }

  /// Check if required options are all selected
  bool get isRequiredOptionsComplete {
    if (menuItem?.customizationGroups == null) return true;

    for (final group in menuItem!.customizationGroups!) {
      if (group.isRequired && group.maxSelections == 1) {
        if (!selectedRequiredOptions.contains(group.id)) {
          return false;
        }
      }
    }

    return true;
  }

  MenuItemCustomizationOption? _findOptionById(String optionId) {
    if (menuItem?.customizationGroups == null) return null;

    for (final group in menuItem!.customizationGroups!) {
      for (final option in group.options) {
        if (option.id == optionId) {
          return option;
        }
      }
    }

    return null;
  }

  /// Get formatted total price
  String get formattedTotal => '\$${total.toStringAsFixed(2)}';
}
