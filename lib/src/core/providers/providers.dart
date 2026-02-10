import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/datasource/local/secure_storage_datasource.dart';
import '../../data/datasource/local/preferences_datasource.dart';
import '../../data/repository/auth_repository_impl.dart';
import '../../data/repository/preferences_repository_impl.dart';
import '../../data/repository/location_repository_impl.dart';
import '../../data/repository/app_repository_impl.dart';
import '../../domain/repository/auth_repository_interface.dart';
import '../../domain/repository/preferences_repository_interface.dart';
import '../../domain/repository/location_repository_interface.dart';
import '../../domain/repository/app_repository_interface.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../../domain/usecases/sign_up_usecase.dart';
import '../../domain/usecases/initialize_app_usecase.dart';
import '../../domain/usecases/get_dietary_preferences_usecase.dart';
import '../../domain/usecases/save_dietary_preferences_usecase.dart';
import '../../domain/usecases/request_location_permission_usecase.dart';
import '../../domain/usecases/complete_onboarding_usecase.dart';
import '../../features/home/data/repository/home_repository_impl.dart';
import '../../features/home/domain/repository/home_repository_interface.dart';
import '../../features/home/domain/usecases/get_home_data_usecase.dart';

part 'providers.g.dart';

/// Secure storage datasource provider
@riverpod
SecureStorageDatasource secureStorageDatasource(SecureStorageDatasourceRef ref) {
  return SecureStorageDatasource();
}

/// Preferences datasource provider
@riverpod
PreferencesDatasource preferencesDatasource(PreferencesDatasourceRef ref) {
  return PreferencesDatasource();
}

/// Auth repository provider
@riverpod
AuthRepositoryInterface authRepository(AuthRepositoryRef ref) {
  return AuthRepositoryImpl(
    secureStorage: ref.read(secureStorageDatasourceProvider),
    preferences: ref.read(preferencesDatasourceProvider),
  );
}

/// Preferences repository provider
@riverpod
PreferencesRepositoryInterface preferencesRepository(PreferencesRepositoryRef ref) {
  return PreferencesRepositoryImpl(
    preferences: ref.read(preferencesDatasourceProvider),
  );
}

/// Location repository provider
@riverpod
LocationRepositoryInterface locationRepository(LocationRepositoryRef ref) {
  return LocationRepositoryImpl(
    preferences: ref.read(preferencesDatasourceProvider),
  );
}

/// App repository provider
@riverpod
AppRepositoryInterface appRepository(AppRepositoryRef ref) {
  return AppRepositoryImpl(
    preferences: ref.read(preferencesDatasourceProvider),
    secureStorage: ref.read(secureStorageDatasourceProvider),
  );
}

/// Home repository provider
@riverpod
HomeRepositoryInterface homeRepository(HomeRepositoryRef ref) {
  return HomeRepositoryImpl();
}

/// Sign in use case provider
@riverpod
SignInUseCase signInUseCase(SignInUseCaseRef ref) {
  return SignInUseCase(
    authRepository: ref.read(authRepositoryProvider),
  );
}

/// Sign up use case provider
@riverpod
SignUpUseCase signUpUseCase(SignUpUseCaseRef ref) {
  return SignUpUseCase(
    authRepository: ref.read(authRepositoryProvider),
  );
}

/// Initialize app use case provider
@riverpod
InitializeAppUseCase initializeAppUseCase(InitializeAppUseCaseRef ref) {
  return InitializeAppUseCase(
    appRepository: ref.read(appRepositoryProvider),
    preferencesRepository: ref.read(preferencesRepositoryProvider),
  );
}

/// Determine splash navigation use case provider
@riverpod
DetermineSplashNavigationUseCase determineSplashNavigationUseCase(
    DetermineSplashNavigationUseCaseRef ref) {
  return DetermineSplashNavigationUseCase(
    appRepository: ref.read(appRepositoryProvider),
    preferencesRepository: ref.read(preferencesRepositoryProvider),
  );
}

/// Get available dietary preferences use case provider
@riverpod
GetAvailableDietaryPreferencesUseCase getAvailableDietaryPreferencesUseCase(
    GetAvailableDietaryPreferencesUseCaseRef ref) {
  return GetAvailableDietaryPreferencesUseCase(
    preferencesRepository: ref.read(preferencesRepositoryProvider),
  );
}

/// Get saved dietary preferences use case provider
@riverpod
GetSavedDietaryPreferencesUseCase getSavedDietaryPreferencesUseCase(
    GetSavedDietaryPreferencesUseCaseRef ref) {
  return GetSavedDietaryPreferencesUseCase(
    preferencesRepository: ref.read(preferencesRepositoryProvider),
  );
}

/// Save dietary preferences use case provider
@riverpod
SaveDietaryPreferencesUseCase saveDietaryPreferencesUseCase(
    SaveDietaryPreferencesUseCaseRef ref) {
  return SaveDietaryPreferencesUseCase(
    preferencesRepository: ref.read(preferencesRepositoryProvider),
  );
}

/// Request location permission use case provider
@riverpod
RequestLocationPermissionUseCase requestLocationPermissionUseCase(
    RequestLocationPermissionUseCaseRef ref) {
  return RequestLocationPermissionUseCase(
    locationRepository: ref.read(locationRepositoryProvider),
  );
}

/// Complete onboarding use case provider
@riverpod
CompleteOnboardingUseCase completeOnboardingUseCase(
    CompleteOnboardingUseCaseRef ref) {
  return CompleteOnboardingUseCase(
    preferencesRepository: ref.read(preferencesRepositoryProvider),
  );
}

/// Get home data use case provider
@riverpod
GetHomeDataUseCase getHomeDataUseCase(GetHomeDataUseCaseRef ref) {
  return GetHomeDataUseCase(
    repository: ref.read(homeRepositoryProvider),
  );
}
