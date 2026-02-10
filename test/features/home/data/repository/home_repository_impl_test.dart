import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../../lib/src/core/errors/failures.dart';
import '../../../../../lib/src/features/home/data/repository/home_repository_impl.dart';
import '../../../../../lib/src/features/home/domain/entities/category_entity.dart';
import '../../../../../lib/src/features/home/domain/entities/food_entity.dart';
import '../../../../../lib/src/features/home/domain/entities/restaurant_entity.dart';
import '../../../../../lib/src/features/home/domain/repository/home_repository_interface.dart';

void main() {
  group('HomeRepositoryImpl', () {
    late HomeRepositoryImpl repository;

    setUp(() {
      repository = HomeRepositoryImpl();
    });

    group('getCategories', () {
      test(
          'returns list of categories on success',
          () async {
        // Act
        final result = await repository.getCategories().run();

        // Assert
        expect(result.isRight(), true);
        result.fold(
          (_) => fail('Should not return left'),
          (categories) {
            expect(categories, isNotEmpty);
            expect(categories.length, equals(6));
            expect(categories.first.id, equals('1'));
            expect(categories.first.name, equals('Popular'));
            expect(categories.first.icon, equals('🔥'));
          },
        );
      });

      test(
          'returns non-empty list with expected data',
          () async {
        // Act
        final result = await repository.getCategories().run();

        // Assert
        result.fold(
          (failure) => fail('Should not fail: $failure'),
          (categories) {
            expect(categories[0].name, equals('Popular'));
            expect(categories[1].name, equals('Burger'));
            expect(categories[2].name, equals('Pizza'));
            expect(categories[3].name, equals('Sushi'));
            expect(categories[4].name, equals('Mexican'));
            expect(categories[5].name, equals('Dessert'));
          },
        );
      });
    });

    group('getRecommendedFoods', () {
      test(
          'returns list of recommended foods on success',
          () async {
        // Act
        final result = await repository.getRecommendedFoods().run();

        // Assert
        expect(result.isRight(), true);
        result.fold(
          (_) => fail('Should not return left'),
          (foods) {
            expect(foods, isNotEmpty);
            expect(foods.length, equals(5));
            expect(foods.first.id, equals('food_1'));
            expect(foods.first.name, equals('Whopper Meal'));
            expect(foods.first.restaurantName, equals('Burger King'));
          },
        );
      });

      test(
          'all foods have valid ratings and prices',
          () async {
        // Act
        final result = await repository.getRecommendedFoods().run();

        // Assert
        result.fold(
          (_) => fail('Should not return left'),
          (foods) {
            for (final food in foods) {
              expect(food.rating, greaterThan(0));
              expect(food.rating, lessThanOrEqualTo(5));
              expect(food.price, greaterThan(0));
              expect(food.timeMinutes, greaterThan(0));
              expect(food.imageUrl, isNotEmpty);
            }
          },
        );
      });
    });

    group('getFastDeliveryRestaurants', () {
      test(
          'returns list of restaurants on success',
          () async {
        // Act
        final result = await repository.getFastDeliveryRestaurants().run();

        // Assert
        expect(result.isRight(), true);
        result.fold(
          (_) => fail('Should not return left'),
          (restaurants) {
            expect(restaurants, isNotEmpty);
            expect(restaurants.length, equals(5));
            expect(restaurants.first.id, equals('rest_1'));
            expect(restaurants.first.name, equals('Burger King'));
          },
        );
      });

      test(
          'all restaurants have valid delivery times',
          () async {
        // Act
        final result = await repository.getFastDeliveryRestaurants().run();

        // Assert
        result.fold(
          (_) => fail('Should not return left'),
          (restaurants) {
            for (final restaurant in restaurants) {
              expect(restaurant.deliveryTimeMinutes, greaterThan(0));
              expect(restaurant.deliveryTimeMinutes, lessThanOrEqualTo(60));
              expect(restaurant.rating, greaterThan(0));
              expect(restaurant.rating, lessThanOrEqualTo(5));
            }
          },
        );
      });
    });

    group('getHomeData', () {
      test(
          'returns HomeData with all three lists on success',
          () async {
        // Act
        final result = await repository.getHomeData().run();

        // Assert
        expect(result.isRight(), true);
        result.fold(
          (_) => fail('Should not return left'),
          (homeData) {
            expect(homeData.categories, isNotEmpty);
            expect(homeData.recommendedFoods, isNotEmpty);
            expect(homeData.fastDeliveryRestaurants, isNotEmpty);
          },
        );
      });

      test(
          'returns HomeData with correct item counts',
          () async {
        // Act
        final result = await repository.getHomeData().run();

        // Assert
        result.fold(
          (_) => fail('Should not return left'),
          (homeData) {
            expect(homeData.categories.length, equals(6));
            expect(homeData.recommendedFoods.length, equals(5));
            expect(homeData.fastDeliveryRestaurants.length, equals(5));
          },
        );
      });

      test(
          'returns HomeData with isNotEmpty true when data exists',
          () async {
        // Act
        final result = await repository.getHomeData().run();

        // Assert
        result.fold(
          (_) => fail('Should not return left'),
          (homeData) {
            expect(homeData.isNotEmpty, isTrue);
            expect(homeData.isEmpty, isFalse);
          },
        );
      });

      test(
          'categories in HomeData match standalone getCategories',
          () async {
        // Arrange
        final categoriesResult = await repository.getCategories().run();
        final homeDataResult = await repository.getHomeData().run();

        // Assert
        categoriesResult.fold(
          (failure) => fail('Categories should not fail: $failure'),
          (categories) {
            homeDataResult.fold(
              (failure) => fail('HomeData should not fail: $failure'),
              (homeData) {
                expect(homeData.categories.length, equals(categories.length));
                for (var i = 0; i < categories.length; i++) {
                  expect(
                    homeData.categories[i].id,
                    equals(categories[i].id),
                  );
                  expect(
                    homeData.categories[i].name,
                    equals(categories[i].name),
                  );
                }
              },
            );
          },
        );
      });

      test(
          'foods in HomeData match standalone getRecommendedFoods',
          () async {
        // Arrange
        final foodsResult = await repository.getRecommendedFoods().run();
        final homeDataResult = await repository.getHomeData().run();

        // Assert
        foodsResult.fold(
          (failure) => fail('Foods should not fail: $failure'),
          (foods) {
            homeDataResult.fold(
              (failure) => fail('HomeData should not fail: $failure'),
              (homeData) {
                expect(
                  homeData.recommendedFoods.length,
                  equals(foods.length),
                );
                for (var i = 0; i < foods.length; i++) {
                  expect(
                    homeData.recommendedFoods[i].id,
                    equals(foods[i].id),
                  );
                  expect(
                    homeData.recommendedFoods[i].name,
                    equals(foods[i].name),
                  );
                }
              },
            );
          },
        );
      });

      test(
          'restaurants in HomeData match standalone getFastDeliveryRestaurants',
          () async {
        // Arrange
        final restaurantsResult =
            await repository.getFastDeliveryRestaurants().run();
        final homeDataResult = await repository.getHomeData().run();

        // Assert
        restaurantsResult.fold(
          (failure) => fail('Restaurants should not fail: $failure'),
          (restaurants) {
            homeDataResult.fold(
              (failure) => fail('HomeData should not fail: $failure'),
              (homeData) {
                expect(
                  homeData.fastDeliveryRestaurants.length,
                  equals(restaurants.length),
                );
                for (var i = 0; i < restaurants.length; i++) {
                  expect(
                    homeData.fastDeliveryRestaurants[i].id,
                    equals(restaurants[i].id),
                  );
                  expect(
                    homeData.fastDeliveryRestaurants[i].name,
                    equals(restaurants[i].name),
                  );
                }
              },
            );
          },
        );
      });
    });

    group('HomeData copyWith', () {
      test(
          'creates copy with modified categories',
          () async {
        // Arrange
        final result = await repository.getHomeData().run();
        final List<CategoryEntity> newCategories = [
          const CategoryEntity(id: 'new', name: 'New', icon: 'new', color: '#000'),
        ];

        // Act
        result.fold(
          (failure) => fail('Should not fail'),
          (homeData) {
            final updated = homeData.copyWith(categories: newCategories);

            // Assert
            expect(updated.categories, equals(newCategories));
            expect(updated.recommendedFoods, equals(homeData.recommendedFoods));
            expect(
              updated.fastDeliveryRestaurants,
              equals(homeData.fastDeliveryRestaurants),
            );
          },
        );
      });

      test(
          'creates copy with modified foods',
          () async {
        // Arrange
        final result = await repository.getHomeData().run();
        final List<FoodEntity> newFoods = <FoodEntity>[];

        // Act
        result.fold(
          (failure) => fail('Should not fail'),
          (homeData) {
            final updated = homeData.copyWith(recommendedFoods: newFoods);

            // Assert
            expect(updated.recommendedFoods, isEmpty);
            expect(updated.categories, equals(homeData.categories));
          },
        );
      });
    });

    group('HomeData equality', () {
      test(
          'two HomeData instances have same content',
          () async {
        // Arrange
        final result1 = await repository.getHomeData().run();
        final result2 = await repository.getHomeData().run();

        // Assert - compare lists since entities are created fresh each time
        result1.fold(
          (failure) => fail('Should not fail'),
          (data1) {
            result2.fold(
              (failure) => fail('Should not fail'),
              (data2) {
                expect(data1.categories.length, equals(data2.categories.length));
                expect(
                  data1.recommendedFoods.length,
                  equals(data2.recommendedFoods.length),
                );
                expect(
                  data1.fastDeliveryRestaurants.length,
                  equals(data2.fastDeliveryRestaurants.length),
                );
              },
            );
          },
        );
      });

      test(
          'HomeData instances with different data have different content',
          () async {
        // Arrange
        final result = await repository.getHomeData().run();

        // Act
        result.fold(
          (failure) => fail('Should not fail'),
          (homeData) {
            final modified = HomeData(
              categories: const [],
              recommendedFoods: homeData.recommendedFoods,
              fastDeliveryRestaurants: homeData.fastDeliveryRestaurants,
            );

            // Assert
            expect(modified.categories, isEmpty);
            expect(homeData.categories, isNotEmpty);
          },
        );
      });
    });
  });
}
