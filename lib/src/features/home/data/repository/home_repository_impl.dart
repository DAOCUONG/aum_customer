import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/food_entity.dart';
import '../../domain/entities/restaurant_entity.dart';
import '../../domain/repository/home_repository_interface.dart';
import '../models/category_model.dart';
import '../models/food_model.dart';
import '../models/restaurant_model.dart';

/// Implementation of HomeRepositoryInterface with mock data
/// Replace with actual API calls when backend is available
class HomeRepositoryImpl implements HomeRepositoryInterface {
  @override
  TaskEither<Failure, List<CategoryEntity>> getCategories() {
    return TaskEither.tryCatch(
      () async {
        // Simulate network delay
        await Future<void>.delayed(const Duration(milliseconds: 500));

        final categories = _getMockCategories();
        return categories.map((model) => model.toEntity()).toList();
      },
      (error, stackTrace) => UnexpectedFailure(
        message: 'Failed to fetch categories: $error',
        stackTrace: stackTrace,
      ),
    );
  }

  @override
  TaskEither<Failure, List<FoodEntity>> getRecommendedFoods() {
    return TaskEither.tryCatch(
      () async {
        // Simulate network delay
        await Future<void>.delayed(const Duration(milliseconds: 500));

        final foods = _getMockFoods();
        return foods.map((model) => model.toEntity()).toList();
      },
      (error, stackTrace) => UnexpectedFailure(
        message: 'Failed to fetch recommended foods: $error',
        stackTrace: stackTrace,
      ),
    );
  }

  @override
  TaskEither<Failure, List<RestaurantEntity>> getFastDeliveryRestaurants() {
    return TaskEither.tryCatch(
      () async {
        // Simulate network delay
        await Future<void>.delayed(const Duration(milliseconds: 500));

        final restaurants = _getMockRestaurants();
        return restaurants.map((model) => model.toEntity()).toList();
      },
      (error, stackTrace) => UnexpectedFailure(
        message: 'Failed to fetch restaurants: $error',
        stackTrace: stackTrace,
      ),
    );
  }

  @override
  TaskEither<Failure, HomeData> getHomeData() {
    return TaskEither.tryCatch(
      () async {
        // Simulate network delay for optimized single call
        await Future<void>.delayed(const Duration(milliseconds: 700));

        final categories = _getMockCategories().map((m) => m.toEntity()).toList();
        final foods = _getMockFoods().map((m) => m.toEntity()).toList();
        final restaurants = _getMockRestaurants().map((m) => m.toEntity()).toList();

        return HomeData(
          categories: categories,
          recommendedFoods: foods,
          fastDeliveryRestaurants: restaurants,
        );
      },
      (error, stackTrace) => UnexpectedFailure(
        message: 'Failed to fetch home data: $error',
        stackTrace: stackTrace,
      ),
    );
  }

  // Mock data - Replace with actual API calls
  List<CategoryModel> _getMockCategories() {
    return [
      const CategoryModel(id: '1', name: 'Popular', icon: '🔥', color: '#FF5722'),
      const CategoryModel(id: '2', name: 'Burger', icon: '🍔', color: '#FF9800'),
      const CategoryModel(id: '3', name: 'Pizza', icon: '🍕', color: '#FF5722'),
      const CategoryModel(id: '4', name: 'Sushi', icon: '🍣', color: '#2196F3'),
      const CategoryModel(id: '5', name: 'Mexican', icon: '🌮', color: '#4CAF50'),
      const CategoryModel(id: '6', name: 'Dessert', icon: '🍩', color: '#E91E63'),
    ];
  }

  List<FoodModel> _getMockFoods() {
    return [
      const FoodModel(
        id: 'food_1',
        name: 'Whopper Meal',
        restaurantId: 'rest_1',
        restaurantName: 'Burger King',
        rating: 4.5,
        price: 10.99,
        timeMinutes: 20,
        imageUrl: 'https://picsum.photos/200?random=1',
      ),
      const FoodModel(
        id: 'food_2',
        name: 'Chicken Pizza',
        restaurantId: 'rest_2',
        restaurantName: 'Pizza Hut',
        rating: 4.7,
        price: 15.99,
        timeMinutes: 25,
        imageUrl: 'https://picsum.photos/200?random=2',
      ),
      const FoodModel(
        id: 'food_3',
        name: 'Sushi Platter',
        restaurantId: 'rest_3',
        restaurantName: 'Sushi Master',
        rating: 4.8,
        price: 24.99,
        timeMinutes: 30,
        imageUrl: 'https://picsum.photos/200?random=3',
      ),
      const FoodModel(
        id: 'food_4',
        name: 'Tacos Special',
        restaurantId: 'rest_4',
        restaurantName: 'Taco Bell',
        rating: 4.6,
        price: 12.99,
        timeMinutes: 15,
        imageUrl: 'https://picsum.photos/200?random=4',
      ),
      const FoodModel(
        id: 'food_5',
        name: 'Cheesecake',
        restaurantId: 'rest_5',
        restaurantName: 'Dessert Shop',
        rating: 4.9,
        price: 8.99,
        timeMinutes: 10,
        imageUrl: 'https://picsum.photos/200?random=5',
      ),
    ];
  }

  List<RestaurantModel> _getMockRestaurants() {
    return [
      const RestaurantModel(
        id: 'rest_1',
        name: 'Burger King',
        cuisine: 'American',
        rating: 4.5,
        deliveryTimeMinutes: 20,
        deliveryFee: 'Free',
        imageUrl: 'https://picsum.photos/200?random=10',
      ),
      const RestaurantModel(
        id: 'rest_2',
        name: 'Pizza Hut',
        cuisine: 'Italian',
        rating: 4.3,
        deliveryTimeMinutes: 25,
        deliveryFee: '\$2.99',
        imageUrl: 'https://picsum.photos/200?random=11',
      ),
      const RestaurantModel(
        id: 'rest_3',
        name: "McDonald's",
        cuisine: 'Fast Food',
        rating: 4.4,
        deliveryTimeMinutes: 15,
        deliveryFee: 'Free',
        imageUrl: 'https://picsum.photos/200?random=12',
      ),
      const RestaurantModel(
        id: 'rest_4',
        name: 'KFC',
        cuisine: 'Fast Food',
        rating: 4.2,
        deliveryTimeMinutes: 30,
        deliveryFee: '\$2.99',
        imageUrl: 'https://picsum.photos/200?random=13',
      ),
      const RestaurantModel(
        id: 'rest_5',
        name: 'Subway',
        cuisine: 'Healthy',
        rating: 4.1,
        deliveryTimeMinutes: 18,
        deliveryFee: 'Free',
        imageUrl: 'https://picsum.photos/200?random=14',
      ),
    ];
  }
}
