import 'package:equatable/equatable.dart';

import '../../domain/entities/search_filter.dart';

/// Base state class for filter panel feature
sealed class FilterPanelState with EquatableMixin {
  const FilterPanelState();
}

/// Initial state
class InitialFilterState extends FilterPanelState {
  const InitialFilterState();

  @override
  List<Object?> get props => [];
}

/// Loading state
class LoadingFilterState extends FilterPanelState {
  const LoadingFilterState();

  @override
  List<Object?> get props => [];
}

/// Loaded state with filter options
class LoadedFilterState extends FilterPanelState {
  final FilterState currentFilter;

  const LoadedFilterState({required this.currentFilter});

  @override
  List<Object?> get props => [currentFilter];

  bool get hasActiveFilters => currentFilter.hasActiveFilters;
  int get activeFilterCount => currentFilter.activeFilterCount;
}

/// Error state
class ErrorFilterState extends FilterPanelState {
  final String message;

  const ErrorFilterState({required this.message});

  @override
  List<Object?> get props => [message];
}
