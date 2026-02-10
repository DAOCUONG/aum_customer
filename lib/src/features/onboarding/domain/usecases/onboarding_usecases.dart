import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/onboarding_page.dart';
import '../repositories/onboarding_repository.dart';

/// Use case for getting onboarding page data
///
/// Single responsibility: Retrieve onboarding page by index
/// Follows Clean Architecture dependency inversion principle
class GetOnboardingPage {
  final OnboardingRepository _repository;

  const GetOnboardingPage({required OnboardingRepository repository})
      : _repository = repository;

  /// Execute the use case with page index
  ///
  /// Returns [OnboardingPageEntity] on success
  /// Returns [Failure] on error
  TaskEither<Failure, OnboardingPageEntity> call(int index) {
    return _repository.getOnboardingPage(index);
  }
}

/// Use case for completing onboarding flow
///
/// Handles marking onboarding as completed
class CompleteOnboarding {
  final OnboardingRepository _repository;

  const CompleteOnboarding({required OnboardingRepository repository})
      : _repository = repository;

  /// Execute the use case
  ///
  /// Returns [Unit] on success
  /// Returns [Failure] on error
  TaskEither<Failure, Unit> call() {
    return _repository.completeOnboarding();
  }
}

/// Use case for checking onboarding completion status
class CheckOnboardingStatus {
  final OnboardingRepository _repository;

  const CheckOnboardingStatus({required OnboardingRepository repository})
      : _repository = repository;

  TaskEither<Failure, bool> call() {
    return _repository.isOnboardingCompleted();
  }
}
