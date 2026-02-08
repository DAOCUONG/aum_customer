import 'package:fpdart/fpdart.dart';
import '../../core/errors/failures.dart';
import '../entities/auth_result.dart';
import '../repository/app_repository_interface.dart';
import '../repository/preferences_repository_interface.dart';

/// Use case for initializing the application
class InitializeAppUseCase {
  const InitializeAppUseCase({
    required this.appRepository,
    required this.preferencesRepository,
  });

  final AppRepositoryInterface appRepository;
  final PreferencesRepositoryInterface preferencesRepository;

  TaskEither<Failure, InitializationResult> call() {
    return appRepository.initialize();
  }
}

/// Result of navigation decision after splash
enum SplashNavigationResult {
  onboarding,
  signIn,
  locationPermission,
  dietaryPreferences,
  home,
}

/// Use case to determine where to navigate after splash
class DetermineSplashNavigationUseCase {
  const DetermineSplashNavigationUseCase({
    required this.appRepository,
    required this.preferencesRepository,
  });

  final AppRepositoryInterface appRepository;
  final PreferencesRepositoryInterface preferencesRepository;

  TaskEither<Failure, SplashNavigationResult> call() {
    return appRepository.initialize().flatMap(
      (result) {
        // Priority: onboarding -> location -> dietary -> home
        if (result.needsOnboarding) {
          return TaskEither.right(SplashNavigationResult.onboarding);
        }
        if (result.needsLocationPermission) {
          return TaskEither.right(SplashNavigationResult.locationPermission);
        }
        if (result.needsDietaryPreferences) {
          return TaskEither.right(SplashNavigationResult.dietaryPreferences);
        }
        return TaskEither.right(SplashNavigationResult.home);
      },
    );
  }
}
