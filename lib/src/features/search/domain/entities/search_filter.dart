import 'package:equatable/equatable.dart';

/// Domain entity representing a search filter option
class SearchFilter with EquatableMixin {
  final String id;
  final String label;
  final bool isSelected;
  final FilterType type;

  const SearchFilter({
    required this.id,
    required this.label,
    this.isSelected = false,
    required this.type,
  });

  @override
  List<Object?> get props => [id, label, isSelected, type];
}

enum FilterType {
  sort,
  priceRange,
  dietary,
  deliveryTime,
  specialOffer,
}

/// Domain entity representing combined filter state for search
class FilterState with EquatableMixin {
  final SortOption sortOption;
  final List<int> selectedPriceIndices;
  final List<String> selectedDietary;
  final double maxDeliveryTime;
  final bool specialOffersOnly;

  const FilterState({
    this.sortOption = SortOption.recommended,
    this.selectedPriceIndices = const [],
    this.selectedDietary = const [],
    this.maxDeliveryTime = 45,
    this.specialOffersOnly = false,
  });

  FilterState copyWith({
    SortOption? sortOption,
    List<int>? selectedPriceIndices,
    List<String>? selectedDietary,
    double? maxDeliveryTime,
    bool? specialOffersOnly,
  }) {
    return FilterState(
      sortOption: sortOption ?? this.sortOption,
      selectedPriceIndices: selectedPriceIndices ?? this.selectedPriceIndices,
      selectedDietary: selectedDietary ?? this.selectedDietary,
      maxDeliveryTime: maxDeliveryTime ?? this.maxDeliveryTime,
      specialOffersOnly: specialOffersOnly ?? this.specialOffersOnly,
    );
  }

  @override
  List<Object?> get props => [
        sortOption,
        selectedPriceIndices,
        selectedDietary,
        maxDeliveryTime,
        specialOffersOnly,
      ];

  bool get hasActiveFilters =>
      selectedPriceIndices.isNotEmpty ||
      selectedDietary.isNotEmpty ||
      maxDeliveryTime != 45 ||
      specialOffersOnly ||
      sortOption != SortOption.recommended;

  int get activeFilterCount {
    int count = 0;
    if (selectedPriceIndices.isNotEmpty) count++;
    if (selectedDietary.isNotEmpty) count++;
    if (maxDeliveryTime != 45) count++;
    if (specialOffersOnly) count++;
    if (sortOption != SortOption.recommended) count++;
    return count;
  }
}

enum SortOption {
  recommended,
  fastestDelivery,
  highestRated,
  lowestPrice,
  mostPopular;

  String get label {
    switch (this) {
      case SortOption.recommended:
        return 'Recommended';
      case SortOption.fastestDelivery:
        return 'Fastest Delivery';
      case SortOption.highestRated:
        return 'Highest Rated';
      case SortOption.lowestPrice:
        return 'Lowest Price';
      case SortOption.mostPopular:
        return 'Most Popular';
    }
  }

  String get apiValue {
    switch (this) {
      case SortOption.recommended:
        return 'recommended';
      case SortOption.fastestDelivery:
        return 'delivery_time';
      case SortOption.highestRated:
        return 'rating';
      case SortOption.lowestPrice:
        return 'price';
      case SortOption.mostPopular:
        return 'popularity';
    }
  }
}
