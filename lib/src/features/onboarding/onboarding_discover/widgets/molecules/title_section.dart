import 'package:flutter/material.dart';
import '../../../../../ui/theme/glass_theme.dart';

/// TitleSection - A molecule component displaying title and description
///
/// MOLECULE component combining title and description text
/// Used in onboarding screens
class TitleSection extends StatelessWidget {
  final String title;
  final String description;

  const TitleSection({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          _buildTitle(theme),
          const SizedBox(height: 12),
          _buildDescription(theme),
        ],
      ),
    );
  }

  Widget _buildTitle(GlassTheme theme) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.3,
        color: theme.textPrimaryColor,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildDescription(GlassTheme theme) {
    return Text(
      description,
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: theme.textSecondaryColor,
      ),
      textAlign: TextAlign.center,
    );
  }
}
