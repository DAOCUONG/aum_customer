import 'package:flutter/material.dart';
import '../../../../../ui/theme/glass_theme.dart';
import '../../../../../domain/entities/dietary_preference.dart';
import '../atoms/index.dart';

/// PreferencesList - MOLECULE
///
/// A list of dietary preference options with proper spacing.
///
/// Combines multiple DietaryOption atoms into a scrollable list
/// with consistent spacing and animations.
///
/// Usage:
/// ```dart
/// PreferencesList(
///   preferences: state.preferences,
///   onToggle: (index) => notifier.toggleSelection(index),
/// )
/// ```
class PreferencesList extends StatelessWidget {
  final List<DietaryPreference> preferences;
  final ValueChanged<int> onToggle;

  const PreferencesList({
    super.key,
    required this.preferences,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        preferences.length,
        (index) => DietaryOption(
          emoji: preferences[index].emoji,
          title: preferences[index].title,
          description: preferences[index].description,
          isSelected: preferences[index].isSelected,
          onTap: () => onToggle(index),
        ),
      ),
    );
  }
}

/// PreferencesListWithHeader - ENHANCED MOLECULE
///
/// Preferences list with title section included.
///
/// Combines title, description, and the preferences list
/// for a complete dietary preferences section.
class PreferencesListWithHeader extends StatelessWidget {
  final List<DietaryPreference> preferences;
  final ValueChanged<int> onToggle;

  const PreferencesListWithHeader({
    super.key,
    required this.preferences,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleSection(),
        const SizedBox(height: 24),
        PreferencesList(
          preferences: preferences,
          onToggle: onToggle,
        ),
      ],
    );
  }

  Widget _buildTitleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Help us personalize',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            letterSpacing: -1,
            height: 1.1,
            color: GlassTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'your feed',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            letterSpacing: -1,
            height: 1.1,
            color: GlassTheme.primary,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Select any dietary preferences or allergies so we can curate the best food options for you.',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            height: 1.5,
            color: GlassTheme.textSecondary,
          ),
        ),
      ],
    );
  }
}
