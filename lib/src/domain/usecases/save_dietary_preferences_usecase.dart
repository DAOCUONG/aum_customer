import 'package:fpdart/fpdart.dart';
import '../../core/errors/failures.dart';
import '../entities/dietary_preference.dart';
import '../repository/preferences_repository_interface.dart';

/// Use case for saving dietary preferences
class SaveDietaryPreferencesUseCase {
  const SaveDietaryPreferencesUseCase({
    required this.preferencesRepository,
  });

  final PreferencesRepositoryInterface preferencesRepository;

  TaskEither<Failure, Unit> call({
    required List<DietaryPreferenceType> preferences,
  }) {
    return preferencesRepository.savePreferences(preferences: preferences);
  }
}
