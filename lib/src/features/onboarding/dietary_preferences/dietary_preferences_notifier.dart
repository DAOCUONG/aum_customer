import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dietary_preferences_state.dart';
import '../../../domain/entities/dietary_preference.dart';
import '../../../domain/entities/dietary_preference.dart' as domain;
import '../../../core/providers/providers.dart';

/// Dietary preferences screen notifier
class DietaryPreferencesNotifier extends AutoDisposeNotifier<DietaryPreferencesState> {
  @override
  DietaryPreferencesState build() {
    return const DietaryPreferencesState();
  }

    /// Load available preferences
  Future<void> loadPreferences() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final useCase = ref.read(getAvailableDietaryPreferencesUseCaseProvider);

    final result = await useCase().run();

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          hasError: true,
          errorMessage: failure.message,
        );
      },
      (preferences) {
        state = state.copyWith(
          isLoading: false,
          preferences: preferences,
        );
      },
    );
  }

  /// Toggle selection of a preference
  void toggleSelection(int index) {
    if (index < 0 || index >= state.preferences.length) return;

    final updatedPreferences = List<DietaryPreference>.from(state.preferences);
    updatedPreferences[index] = updatedPreferences[index].toggleSelected();

    state = state.copyWith(preferences: updatedPreferences);
  }

  /// Save selected preferences
  Future<bool> savePreferences() async {
    final selectedPreferences = state.selectedPreferences;

    if (selectedPreferences.isEmpty) {
      // Allow empty selection - just navigate to home
      return true;
    }

    state = state.copyWith(isSaving: true, errorMessage: null);

    final useCase = ref.read(saveDietaryPreferencesUseCaseProvider);

    final preferenceTypes = selectedPreferences
        .map((pref) => domain.DietaryPreferenceType.fromId(pref.id))
        .whereType<domain.DietaryPreferenceType>()
        .toList();

    final result = await useCase(preferences: preferenceTypes).run();

    result.fold(
      (failure) {
        state = state.copyWith(
          isSaving: false,
          hasError: true,
          errorMessage: failure.message,
        );
        return false;
      },
      (_) {
        state = state.copyWith(isSaving: false);
        return true;
      },
    );

    return true;  }

  /// Clear selections
  void clearSelections() {
    final updatedPreferences = state.preferences.map((preference) {
      return preference.copyWith(isSelected: false);
    }).toList();

    state = state.copyWith(preferences: updatedPreferences);
  }
}

/// Provider for dietary preferences notifier
final dietaryPreferencesNotifierProvider =
    AutoDisposeNotifierProvider<DietaryPreferencesNotifier, DietaryPreferencesState>(
  DietaryPreferencesNotifier.new,
);
