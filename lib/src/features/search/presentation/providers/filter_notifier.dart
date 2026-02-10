import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/search_filter.dart';
import 'filter_state.dart';

/// Notifier for filter panel state management
class FilterNotifier extends Notifier<FilterPanelState> {
  @override
  FilterPanelState build() {
    return LoadedFilterState(currentFilter: const FilterState());
  }

  /// Update sort option
  void updateSortOption(SortOption option) {
    final currentState = state;
    if (currentState is LoadedFilterState) {
      state = LoadedFilterState(
        currentFilter: currentState.currentFilter.copyWith(sortOption: option),
      );
    }
  }

  /// Toggle price range
  void togglePriceRange(int index) {
    final currentState = state;
    if (currentState is! LoadedFilterState) return;

    final currentIndices = List<int>.from(currentState.currentFilter.selectedPriceIndices);
    if (currentIndices.contains(index)) {
      currentIndices.remove(index);
    } else {
      currentIndices.add(index);
    }

    state = LoadedFilterState(
      currentFilter: currentState.currentFilter.copyWith(
        selectedPriceIndices: currentIndices,
      ),
    );
  }

  /// Toggle dietary option
  void toggleDietary(String dietary) {
    final currentState = state;
    if (currentState is! LoadedFilterState) return;

    final currentDietary = List<String>.from(currentState.currentFilter.selectedDietary);
    if (currentDietary.contains(dietary)) {
      currentDietary.remove(dietary);
    } else {
      currentDietary.add(dietary);
    }

    state = LoadedFilterState(
      currentFilter: currentState.currentFilter.copyWith(
        selectedDietary: currentDietary,
      ),
    );
  }

  /// Update max delivery time
  void updateMaxDeliveryTime(double time) {
    final currentState = state;
    if (currentState is LoadedFilterState) {
      state = LoadedFilterState(
        currentFilter: currentState.currentFilter.copyWith(maxDeliveryTime: time),
      );
    }
  }

  /// Toggle special offers only
  void toggleSpecialOffersOnly() {
    final currentState = state;
    if (currentState is LoadedFilterState) {
      state = LoadedFilterState(
        currentFilter: currentState.currentFilter.copyWith(
          specialOffersOnly: !currentState.currentFilter.specialOffersOnly,
        ),
      );
    }
  }

  /// Reset all filters to default
  void resetFilters() {
    state = LoadedFilterState(currentFilter: const FilterState());
  }

  /// Get current filter state
  FilterState? getCurrentFilter() {
    if (state is LoadedFilterState) {
      return (state as LoadedFilterState).currentFilter;
    }
    return null;
  }
}

/// Provider for filter notifier
final filterNotifierProvider =
    NotifierProvider<FilterNotifier, FilterPanelState>(FilterNotifier.new);
