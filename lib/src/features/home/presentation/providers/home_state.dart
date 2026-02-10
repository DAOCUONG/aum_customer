import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/category_entity.dart';
import '../../domain/entities/food_entity.dart';
import '../../domain/entities/restaurant_entity.dart';

part 'home_state.freezed.dart';

/// State for the Home screen following Riverpod patterns.
///
/// States represent:
/// - [HomeInitial]: Initial state before loading
/// - [HomeLoading]: Data is being loaded
/// - [HomeLoaded]: Data successfully loaded
/// - [HomeEmpty]: Data loaded but no content available
/// - [HomeError]: An error occurred during loading
@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial() = HomeInitial;

  const factory HomeState.loading() = HomeLoading;

  const factory HomeState.loaded({
    required List<CategoryEntity> categories,
    required List<FoodEntity> recommendedFoods,
    required List<RestaurantEntity> fastDeliveryRestaurants,
  }) = HomeLoaded;

  const factory HomeState.empty({
    required List<CategoryEntity> categories,
    required List<FoodEntity> recommendedFoods,
    required List<RestaurantEntity> fastDeliveryRestaurants,
  }) = HomeEmpty;

  const factory HomeState.error({
    required String message,
  }) = HomeError;

  const HomeState._();

  /// Helper getters for common state checks
  bool get isInitial => this is HomeInitial;
  bool get isLoading => this is HomeLoading;
  bool get isLoaded => this is HomeLoaded;
  bool get isEmpty => this is HomeEmpty;
  bool get isError => this is HomeError;

  /// Returns true if we have data to display (loaded state with content).
  bool get hasData => isLoaded && _hasAnyContent;

  /// Returns true if any data lists are non-empty.
  bool get _hasAnyContent => maybeMap(
        orElse: () => false,
        loaded: (state) =>
            state.categories.isNotEmpty ||
            state.recommendedFoods.isNotEmpty ||
            state.fastDeliveryRestaurants.isNotEmpty,
        empty: (state) =>
            state.categories.isNotEmpty ||
            state.recommendedFoods.isNotEmpty ||
            state.fastDeliveryRestaurants.isNotEmpty,
      );

  /// Get categories (only valid when isLoaded or isEmpty is true)
  List<CategoryEntity>? get categories => maybeMap(
        orElse: () => null,
        loaded: (state) => state.categories,
        empty: (state) => state.categories,
      );

  /// Get recommended foods (only valid when isLoaded or isEmpty is true)
  List<FoodEntity>? get recommendedFoods => maybeMap(
        orElse: () => null,
        loaded: (state) => state.recommendedFoods,
        empty: (state) => state.recommendedFoods,
      );

  /// Get fast delivery restaurants (only valid when isLoaded or isEmpty is true)
  List<RestaurantEntity>? get fastDeliveryRestaurants => maybeMap(
        orElse: () => null,
        loaded: (state) => state.fastDeliveryRestaurants,
        empty: (state) => state.fastDeliveryRestaurants,
      );

  /// Get error message (only valid when isError is true)
  String? get errorMessage => maybeMap(
        orElse: () => null,
        error: (state) => state.message,
      );

  /// Creates an empty state from loaded data.
  ///
  /// Use this when data is loaded but has no content.
  HomeState toEmpty() => maybeMap(
        loaded: (state) => HomeState.empty(
          categories: state.categories,
          recommendedFoods: state.recommendedFoods,
          fastDeliveryRestaurants: state.fastDeliveryRestaurants,
        ),
        orElse: () => this,
      );
}
