import 'package:fpdart/fpdart.dart';
import '../../core/errors/failures.dart';
import '../entities/dietary_preference.dart';
import '../repository/preferences_repository_interface.dart';

/// Use case for getting all available dietary preferences
class GetAvailableDietaryPreferencesUseCase {
  const GetAvailableDietaryPreferencesUseCase({
    required this.preferencesRepository,
  });

  final PreferencesRepositoryInterface preferencesRepository;

  TaskEither<Failure, List<DietaryPreference>> call() {
    return preferencesRepository.getAvailablePreferences();
  }
}

/// Use case for getting saved dietary preferences
class GetSavedDietaryPreferencesUseCase {
  const GetSavedDietaryPreferencesUseCase({
    required this.preferencesRepository,
  });

  final PreferencesRepositoryInterface preferencesRepository;

  TaskEither<Failure, List<DietaryPreference>> call() {
    return preferencesRepository.getSavedPreferences();
  }
}
