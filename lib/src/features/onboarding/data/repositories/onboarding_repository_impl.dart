import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/onboarding_page.dart';
import '../../domain/repositories/onboarding_repository.dart';

/// Implementation of OnboardingRepository with dummy data
///
/// Currently uses hardcoded data for development
/// In production, this would fetch from local storage or API
class OnboardingRepositoryImpl implements OnboardingRepository {
  /// Dummy onboarding pages data
  static const _dummyPages = [
    OnboardingPageEntity(
      id: 'discover',
      title: 'Discover Amazing Food',
      description:
          'Find the best local restaurants and dishes delivered straight to your doorstep in minutes.',
      foodImagePaths: [
        'assets/images/onboarding/food_1.jpg',
        'assets/images/onboarding/food_2.jpg',
        'assets/images/onboarding/food_3.jpg',
        'assets/images/onboarding/food_4.jpg',
      ],
      totalPages: 3,
      currentPageIndex: 0,
    ),
    OnboardingPageEntity(
      id: 'order',
      title: 'Easy Ordering',
      description:
          'Browse menus, customize your orders, and track delivery in real-time with our seamless ordering system.',
      foodImagePaths: [
        'assets/images/onboarding/food_2.jpg',
        'assets/images/onboarding/food_3.jpg',
        'assets/images/onboarding/food_4.jpg',
        'assets/images/onboarding/food_1.jpg',
      ],
      totalPages: 3,
      currentPageIndex: 1,
    ),
    OnboardingPageEntity(
      id: 'enjoy',
      title: 'Enjoy Fast Delivery',
      description:
          'Get your favorite meals delivered hot and fresh. Track your order every step of the way.',
      foodImagePaths: [
        'assets/images/onboarding/food_3.jpg',
        'assets/images/onboarding/food_1.jpg',
        'assets/images/onboarding/food_2.jpg',
        'assets/images/onboarding/food_4.jpg',
      ],
      totalPages: 3,
      currentPageIndex: 2,
    ),
  ];

  @override
  TaskEither<Failure, OnboardingPageEntity> getOnboardingPage(int index) {
    return TaskEither.tryCatch(
      () async {
        if (index < 0 || index >= _dummyPages.length) {
          throw ArgumentError('Invalid page index: $index');
        }
        return _dummyPages[index];
      },
      (error, stack) => _mapToFailure(error, stack),
    );
  }

  @override
  TaskEither<Failure, int> getTotalPages() {
    return TaskEither.right(_dummyPages.length);
  }

  @override
  TaskEither<Failure, bool> isOnboardingCompleted() {
    return TaskEither.right(false); // Dummy: always returns false
  }

  @override
  TaskEither<Failure, Unit> completeOnboarding() {
    return TaskEither.right(unit);
  }

  Failure _mapToFailure(Object error, StackTrace stack) {
    if (error is ArgumentError) {
      return ValidationFailure(
        message: error.message ?? 'Invalid page index',
        code: 'INVALID_PAGE_INDEX',
        stackTrace: stack,
      );
    }
    return UnexpectedFailure(
      message: error.toString(),
      stackTrace: stack,
    );
  }
}
