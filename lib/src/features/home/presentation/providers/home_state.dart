import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/category_entity.dart';
import '../../domain/entities/food_entity.dart';
import '../../domain/entities/restaurant_entity.dart';

part 'home_state.freezed.dart';

/// State for the Home screen following Riverpod patterns
@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial() = HomeInitial;

  const factory HomeState.loading() = HomeLoading;

  const factory HomeState.loaded({
    required List<CategoryEntity> categories,
    required List<FoodEntity> recommendedFoods,
    required List<RestaurantEntity> fastDeliveryRestaurants,
  }) = HomeLoaded;

  const factory HomeState.error({
    required String message,
  }) = HomeError;

  const HomeState._();

  /// Helper getters for common checks
  bool get isInitial => this is HomeInitial;
  bool get isLoading => this is HomeLoading;
  bool get isLoaded => this is HomeLoaded;
  bool get isError => this is HomeError;

  /// Get data helpers (only valid when isLoaded is true)
  List<CategoryEntity>? get categories => maybeMap(
        orElse: () => null,
        loaded: (state) => state.categories,
      );

  List<FoodEntity>? get recommendedFoods => maybeMap(
        orElse: () => null,
        loaded: (state) => state.recommendedFoods,
      );

  List<RestaurantEntity>? get fastDeliveryRestaurants => maybeMap(
        orElse: () => null,
        loaded: (state) => state.fastDeliveryRestaurants,
      );

  /// Get error message (only valid when isError is true)
  String? get errorMessage => maybeMap(
        orElse: () => null,
        error: (state) => state.message,
      );
}
