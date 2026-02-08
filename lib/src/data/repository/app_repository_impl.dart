import 'package:fpdart/fpdart.dart';
import '../../core/errors/failures.dart';
import '../datasource/local/preferences_datasource.dart';
import '../datasource/local/secure_storage_datasource.dart';
import '../../domain/entities/auth_result.dart';
import '../../domain/repository/app_repository_interface.dart';

/// Implementation of AppRepositoryInterface
class AppRepositoryImpl implements AppRepositoryInterface {
  AppRepositoryImpl({
    required PreferencesDatasource preferences,
    required SecureStorageDatasource secureStorage,
  })  : _preferences = preferences,
        _secureStorage = secureStorage;

  final PreferencesDatasource _preferences;
  final SecureStorageDatasource _secureStorage;

  @override
  TaskEither<Failure, InitializationResult> initialize() {
    return TaskEither.tryCatch(
      () async {
        // Check onboarding status
        final hasOnboarding = await _preferences.hasCompletedOnboarding();

        // Check location permission
        final hasLocationPermission = await _preferences.hasLocationPermission();

        // Check dietary preferences
        final hasDietaryPreferences = await _preferences.hasSavedPreferences();

        // Check if first launch
        final isFirstLaunch = !hasOnboarding &&
            !hasLocationPermission &&
            !hasDietaryPreferences;

        return InitializationResult(
          isInitialized: true,
          isFirstLaunch: isFirstLaunch,
          hasOnboardingCompleted: hasOnboarding,
          hasLocationPermission: hasLocationPermission,
          hasDietaryPreferences: hasDietaryPreferences,
        );
      },
      (error, stackTrace) => error is Failure
          ? error
          : UnexpectedFailure(
              message: error.toString(),
              stackTrace: stackTrace,
            ),
    );
  }

  @override
  TaskEither<Failure, bool> isFirstLaunch() {
    return TaskEither.tryCatch(
      () async {
        final hasOnboarding = await _preferences.hasCompletedOnboarding();
        return !hasOnboarding;
      },
      (error, stackTrace) => error is Failure
          ? error
          : UnexpectedFailure(
              message: error.toString(),
              stackTrace: stackTrace,
            ),
    );
  }

  @override
  TaskEither<Failure, String?> getAuthToken() {
    return TaskEither.tryCatch(
      () async {
        return _secureStorage.getAuthToken();
      },
      (error, stackTrace) => error is Failure
          ? error
          : CacheFailure(
              message: error.toString(),
              stackTrace: stackTrace,
            ),
    );
  }

  @override
  TaskEither<Failure, Unit> saveAuthToken({required String token}) {
    return TaskEither.tryCatch(
      () async {
        await _secureStorage.saveAuthToken(token);
        return unit;
      },
      (error, stackTrace) => error is Failure
          ? error
          : CacheFailure(
              message: error.toString(),
              stackTrace: stackTrace,
            ),
    );
  }

  @override
  TaskEither<Failure, Unit> clearAuthToken() {
    return TaskEither.tryCatch(
      () async {
        await _secureStorage.clearAuthData();
        return unit;
      },
      (error, stackTrace) => error is Failure
          ? error
          : CacheFailure(
              message: error.toString(),
              stackTrace: stackTrace,
            ),
    );
  }
}
