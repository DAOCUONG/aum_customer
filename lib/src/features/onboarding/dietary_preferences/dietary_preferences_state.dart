import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/dietary_preference.dart';

part 'dietary_preferences_state.freezed.dart';

/// Dietary preferences screen state
@freezed
class DietaryPreferencesState with _$DietaryPreferencesState {
  const factory DietaryPreferencesState({
    @Default([]) List<DietaryPreference> preferences,
    @Default(false) bool isLoading,
    @Default(false) bool isSaving,
    @Default(false) bool hasError,
    String? errorMessage,
  }) = _DietaryPreferencesState;
}

/// Extension methods
extension DietaryPreferencesStateX on DietaryPreferencesState {
  /// Get selected preferences
  List<DietaryPreference> get selectedPreferences =>
      preferences.where((p) => p.isSelected).toList();

  /// Get selected count
  int get selectedCount => selectedPreferences.length;

  /// Check if any preference is selected
  bool get hasSelection => selectedCount > 0;

  /// Check if has error
  bool get isInErrorState => hasError || errorMessage != null;
}
