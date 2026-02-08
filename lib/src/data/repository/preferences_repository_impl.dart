import 'package:fpdart/fpdart.dart';
import '../../core/errors/failures.dart';
import '../datasource/local/preferences_datasource.dart';
import '../models/dietary_preference_model.dart';
import '../../domain/entities/dietary_preference.dart';
import '../../domain/repository/preferences_repository_interface.dart';

/// Implementation of PreferencesRepositoryInterface
class PreferencesRepositoryImpl implements PreferencesRepositoryInterface {
  PreferencesRepositoryImpl({required PreferencesDatasource preferences})
      : _preferences = preferences;

  final PreferencesDatasource _preferences;

  @override
  TaskEither<Failure, List<DietaryPreference>> getAvailablePreferences() {
    return TaskEither.tryCatch(
      () async {
        // Get all available preferences from enum
        final preferences = DietaryPreferenceType.values
            .map((type) => type.toEntity())
            .toList();

        // Mark saved preferences as selected
        final savedIds = await _preferences.getDietaryPreferences();
        return preferences.map((pref) {
          if (savedIds.contains(pref.id)) {
            return pref.copyWith(isSelected: true);
          }
          return pref;
        }).toList();
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
  TaskEither<Failure, List<DietaryPreference>> getSavedPreferences() {
    return TaskEither.tryCatch(
      () async {
        final savedIds = await _preferences.getDietaryPreferences();

        if (savedIds.isEmpty) {
          return <DietaryPreference>[];
        }

        final preferences = DietaryPreferenceType.values
            .where((type) => savedIds.contains(type.id))
            .map((type) => type.toEntity(isSelected: true))
            .toList();

        return preferences;
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
  TaskEither<Failure, Unit> savePreferences({
    required List<DietaryPreferenceType> preferences,
  }) {
    return TaskEither.tryCatch(
      () async {
        final preferenceIds = preferences.map((p) => p.id).toList();
        await _preferences.saveDietaryPreferences(preferenceIds);
        await _preferences.setPreferencesSaved();
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
  TaskEither<Failure, bool> hasSavedPreferences() {
    return TaskEither.tryCatch(
      () async {
        return _preferences.hasSavedPreferences();
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
  TaskEither<Failure, Unit> clearPreferences() {
    return TaskEither.tryCatch(
      () async {
        await _preferences.clearDietaryPreferences();
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
  TaskEither<Failure, T> getPreference<T>({
    required String key,
    required T defaultValue,
  }) {
    return TaskEither.tryCatch(
      () async {
        final prefs = await _preferences.getPrefs();

        if (defaultValue is String) {
          return (prefs.getString(key) ?? defaultValue) as T;
        }
        if (defaultValue is bool) {
          return (prefs.getBool(key) ?? defaultValue) as T;
        }
        if (defaultValue is int) {
          return (prefs.getInt(key) ?? defaultValue) as T;
        }
        if (defaultValue is double) {
          return (prefs.getDouble(key) ?? defaultValue) as T;
        }
        if (defaultValue is List<String>) {
          return (prefs.getStringList(key) ?? defaultValue) as T;
        }

        return defaultValue;
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
  TaskEither<Failure, Unit> setPreference<T>({
    required String key,
    required T value,
  }) {
    return TaskEither.tryCatch(
      () async {
        if (value is String) {
          await _preferences.setString(key: key, value: value);
        } else if (value is bool) {
          await _preferences.setBool(key: key, value: value);
        } else {
          throw ArgumentError('Unsupported type: $T');
        }
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
  TaskEither<Failure, Unit> removePreference({required String key}) {
    return TaskEither.tryCatch(
      () async {
        final prefs = await _preferences.getPrefs();
        await prefs.remove(key);
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
  TaskEither<Failure, bool> hasCompletedOnboarding() {
    return TaskEither.tryCatch(
      () async {
        return _preferences.hasCompletedOnboarding();
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
  TaskEither<Failure, Unit> completeOnboarding() {
    return TaskEither.tryCatch(
      () async {
        await _preferences.setOnboardingCompleted();
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
