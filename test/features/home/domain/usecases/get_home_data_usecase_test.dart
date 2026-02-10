import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../lib/src/core/errors/failures.dart';
import '../../../../../lib/src/features/home/domain/entities/category_entity.dart';
import '../../../../../lib/src/features/home/domain/entities/food_entity.dart';
import '../../../../../lib/src/features/home/domain/entities/restaurant_entity.dart';
import '../../../../../lib/src/features/home/domain/repository/home_repository_interface.dart';
import '../../../../../lib/src/features/home/domain/usecases/get_home_data_usecase.dart';

/// Mock repository for testing
class MockHomeRepository extends Mock implements HomeRepositoryInterface {}

void main() {
  group('GetHomeDataUseCase', () {
    late MockHomeRepository mockRepository;
    late GetHomeDataUseCase useCase;

    setUp(() {
      mockRepository = MockHomeRepository();
      useCase = GetHomeDataUseCase(repository: mockRepository);
    });

    tearDown(() {
      reset(mockRepository);
    });

    group('execute', () {
      test(
          'returns HomeData when repository succeeds',
          () async {
        // Arrange
        final categories = [
          const CategoryEntity(id: '1', name: 'Test', icon: 'test', color: '#000'),
        ];
        final foods = [
          const FoodEntity(
            id: 'food_1',
            name: 'Test Food',
            restaurantId: 'rest_1',
            restaurantName: 'Test Restaurant',
            rating: 4.5,
            price: 10.99,
            timeMinutes: 20,
            imageUrl: 'https://example.com/image.jpg',
          ),
        ];
        final restaurants = [
          const RestaurantEntity(
            id: 'rest_1',
            name: 'Test Restaurant',
            cuisine: 'Test Cuisine',
            rating: 4.5,
            deliveryTimeMinutes: 20,
            deliveryFee: 'Free',
            imageUrl: 'https://example.com/restaurant.jpg',
          ),
        ];

        final homeData = HomeData(
          categories: categories,
          recommendedFoods: foods,
          fastDeliveryRestaurants: restaurants,
        );

        when(() => mockRepository.getHomeData())
            .thenReturn(TaskEither.right(homeData));

        // Act
        final result = await useCase().run();

        // Assert
        expect(result.isRight(), true);
        result.fold(
          (_) => fail('Should not return left'),
          (data) {
            expect(data.categories, equals(categories));
            expect(data.recommendedFoods, equals(foods));
            expect(data.fastDeliveryRestaurants, equals(restaurants));
          },
        );

        verify(() => mockRepository.getHomeData()).called(1);
      });

      test(
          'returns Failure when repository fails with network error',
          () async {
        // Arrange
        const errorMessage = 'Network error';
        when(() => mockRepository.getHomeData())
            .thenReturn(TaskEither.left(NetworkFailure(message: errorMessage)));

        // Act
        final result = await useCase().run();

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<NetworkFailure>());
            expect((failure as NetworkFailure).message, equals(errorMessage));
          },
          (_) => fail('Should not return right'),
        );

        verify(() => mockRepository.getHomeData()).called(1);
      });

      test(
          'returns Failure when repository fails with server error',
          () async {
        // Arrange
        const errorMessage = 'Server error';
        when(() => mockRepository.getHomeData())
            .thenReturn(TaskEither.left(ServerFailure(message: errorMessage)));

        // Act
        final result = await useCase().run();

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<ServerFailure>());
            expect((failure as ServerFailure).message, equals(errorMessage));
          },
          (_) => fail('Should not return right'),
        );

        verify(() => mockRepository.getHomeData()).called(1);
      });

      test(
          'returns Failure when repository fails with unexpected error',
          () async {
        // Arrange
        const errorMessage = 'Unexpected error';
        when(() => mockRepository.getHomeData())
            .thenReturn(TaskEither.left(UnexpectedFailure(message: errorMessage)));

        // Act
        final result = await useCase().run();

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<UnexpectedFailure>());
            expect((failure as UnexpectedFailure).message, equals(errorMessage));
          },
          (_) => fail('Should not return right'),
        );

        verify(() => mockRepository.getHomeData()).called(1);
      });

      test(
          'returns empty HomeData when all lists are empty',
          () async {
        // Arrange
        final homeData = HomeData(
          categories: [],
          recommendedFoods: [],
          fastDeliveryRestaurants: [],
        );

        when(() => mockRepository.getHomeData())
            .thenReturn(TaskEither.right(homeData));

        // Act
        final result = await useCase().run();

        // Assert
        expect(result.isRight(), true);
        result.fold(
          (_) => fail('Should not return left'),
          (data) {
            expect(data.categories, isEmpty);
            expect(data.recommendedFoods, isEmpty);
            expect(data.fastDeliveryRestaurants, isEmpty);
            expect(data.isEmpty, isTrue);
          },
        );

        verify(() => mockRepository.getHomeData()).called(1);
      });

      test(
          'HomeData isNotEmpty returns false when all lists are empty',
          () async {
        // Arrange
        final emptyData = HomeData(
          categories: [],
          recommendedFoods: [],
          fastDeliveryRestaurants: [],
        );

        // Assert
        expect(emptyData.isEmpty, isTrue);
        expect(emptyData.isNotEmpty, isFalse);
      });

      test(
          'HomeData isNotEmpty returns true when at least one list has items',
          () async {
        // Arrange
        final partialData = HomeData(
          categories: [
            const CategoryEntity(id: '1', name: 'Test', icon: 'test', color: '#000'),
          ],
          recommendedFoods: [],
          fastDeliveryRestaurants: [],
        );

        // Assert
        expect(partialData.isEmpty, isFalse);
        expect(partialData.isNotEmpty, isTrue);
      });
    });
  });
}
