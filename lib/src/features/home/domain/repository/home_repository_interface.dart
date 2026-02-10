import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../entities/category_entity.dart';
import '../entities/food_entity.dart';
import '../entities/restaurant_entity.dart';

/// Repository interface for home screen data operations
abstract class HomeRepositoryInterface {
  /// Get all categories
  TaskEither<Failure, List<CategoryEntity>> getCategories();

  /// Get recommended food items
  TaskEither<Failure, List<FoodEntity>> getRecommendedFoods();

  /// Get fast delivery restaurants
  TaskEither<Failure, List<RestaurantEntity>> getFastDeliveryRestaurants();

  /// Get all home data at once (optimized single call)
  TaskEither<Failure, HomeData> getHomeData();
}

/// Container for all home data returned together
class HomeData {
  final List<CategoryEntity> categories;
  final List<FoodEntity> recommendedFoods;
  final List<RestaurantEntity> fastDeliveryRestaurants;

  HomeData({
    required this.categories,
    required this.recommendedFoods,
    required this.fastDeliveryRestaurants,
  });
}
