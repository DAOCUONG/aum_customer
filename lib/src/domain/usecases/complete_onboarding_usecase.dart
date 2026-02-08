import 'package:fpdart/fpdart.dart';
import '../../core/errors/failures.dart';
import '../repository/preferences_repository_interface.dart';

/// Use case for completing onboarding
class CompleteOnboardingUseCase {
  const CompleteOnboardingUseCase({
    required this.preferencesRepository,
  });

  final PreferencesRepositoryInterface preferencesRepository;

  TaskEither<Failure, Unit> call() {
    return preferencesRepository.completeOnboarding();
  }
}

/// Use case for checking onboarding status
class HasCompletedOnboardingUseCase {
  const HasCompletedOnboardingUseCase({
    required this.preferencesRepository,
  });

  final PreferencesRepositoryInterface preferencesRepository;

  TaskEither<Failure, bool> call() {
    return preferencesRepository.hasCompletedOnboarding();
  }
}
