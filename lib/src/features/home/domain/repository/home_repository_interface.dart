import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/category_entity.dart';
import '../entities/food_entity.dart';
import '../entities/restaurant_entity.dart';

/// Repository interface for home screen data operations.
///
/// Implementations should handle:
/// - Fetching categories
/// - Fetching recommended food items
/// - Fetching fast delivery restaurants
/// - Providing an optimized single call for all data
abstract class HomeRepositoryInterface {
  /// Get all categories
  TaskEither<Failure, List<CategoryEntity>> getCategories();

  /// Get recommended food items
  TaskEither<Failure, List<FoodEntity>> getRecommendedFoods();

  /// Get fast delivery restaurants
  TaskEither<Failure, List<RestaurantEntity>> getFastDeliveryRestaurants();

  /// Get all home data at once (optimized single call)
  ///
  /// This method is preferred over calling individual methods
  /// as it reduces network overhead.
  TaskEither<Failure, HomeData> getHomeData();
}

/// Container for all home data returned together.
///
/// This class is immutable and thread-safe.
class HomeData {
  final List<CategoryEntity> categories;
  final List<FoodEntity> recommendedFoods;
  final List<RestaurantEntity> fastDeliveryRestaurants;

  /// Creates a new [HomeData] instance.
  const HomeData({
    required this.categories,
    required this.recommendedFoods,
    required this.fastDeliveryRestaurants,
  });

  /// Returns true if all lists are empty.
  bool get isEmpty =>
      categories.isEmpty &&
      recommendedFoods.isEmpty &&
      fastDeliveryRestaurants.isEmpty;

  /// Returns true if at least one list has items.
  bool get isNotEmpty => !isEmpty;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is HomeData &&
        other.categories == categories &&
        other.recommendedFoods == recommendedFoods &&
        other.fastDeliveryRestaurants == fastDeliveryRestaurants;
  }

  @override
  int get hashCode =>
      categories.hashCode ^
      recommendedFoods.hashCode ^
      fastDeliveryRestaurants.hashCode;

  /// Creates a copy with optionally modified values.
  HomeData copyWith({
    List<CategoryEntity>? categories,
    List<FoodEntity>? recommendedFoods,
    List<RestaurantEntity>? fastDeliveryRestaurants,
  }) {
    return HomeData(
      categories: categories ?? this.categories,
      recommendedFoods: recommendedFoods ?? this.recommendedFoods,
      fastDeliveryRestaurants:
          fastDeliveryRestaurants ?? this.fastDeliveryRestaurants,
    );
  }
}
