import 'package:fpdart/fpdart.dart';
import '../entities/dietary_preference.dart';
import '../../core/errors/failures.dart';

/// Repository interface for user preferences operations
abstract class PreferencesRepositoryInterface {
  /// Get all available dietary preferences
  TaskEither<Failure, List<DietaryPreference>> getAvailablePreferences();

  /// Get saved dietary preferences for current user
  TaskEither<Failure, List<DietaryPreference>> getSavedPreferences();

  /// Save dietary preferences
  TaskEither<Failure, Unit> savePreferences({
    required List<DietaryPreferenceType> preferences,
  });

  /// Check if preferences have been saved
  TaskEither<Failure, bool> hasSavedPreferences();

  /// Clear all saved preferences
  TaskEither<Failure, Unit> clearPreferences();

  /// Get a specific preference value
  TaskEither<Failure, T> getPreference<T>({
    required String key,
    required T defaultValue,
  });

  /// Save a specific preference value
  TaskEither<Failure, Unit> setPreference<T>({
    required String key,
    required T value,
  });

  /// Remove a specific preference
  TaskEither<Failure, Unit> removePreference({required String key});

  /// Check if onboarding has been completed
  TaskEither<Failure, bool> hasCompletedOnboarding();

  /// Mark onboarding as completed
  TaskEither<Failure, Unit> completeOnboarding();
}
