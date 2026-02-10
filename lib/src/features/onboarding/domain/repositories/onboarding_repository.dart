import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/onboarding_page.dart';

/// Repository interface for onboarding data
///
/// Defines the contract for data access layer
/// All implementations must return TaskEither for error handling
abstract class OnboardingRepository {
  /// Get onboarding page data for the specified index
  TaskEither<Failure, OnboardingPageEntity> getOnboardingPage(int index);

  /// Get total number of onboarding pages
  TaskEither<Failure, int> getTotalPages();

  /// Check if onboarding has been completed
  TaskEither<Failure, bool> isOnboardingCompleted();

  /// Mark onboarding as completed
  TaskEither<Failure, Unit> completeOnboarding();
}
