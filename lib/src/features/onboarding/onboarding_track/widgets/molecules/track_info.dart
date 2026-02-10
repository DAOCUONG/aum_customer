import 'package:flutter/material.dart';
import '../../../../../ui/theme/glass_theme.dart';

/// TrackInfo - A molecule component displaying title, description, and progress
///
/// MOLECULE component combining:
/// - Gradient title with highlighted text
/// - Description text
/// - Page progress indicator (3 dots)
class TrackInfo extends StatelessWidget {
  final int currentPage;
  final int totalPages;

  const TrackInfo({
    super.key,
    this.currentPage = 2,
    this.totalPages = 3,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return Column(
      children: [
        _buildTitle(theme),
        const SizedBox(height: 16),
        _buildDescription(theme),
        const SizedBox(height: 32),
        _buildProgressIndicator(),
      ],
    );
  }

  Widget _buildTitle(GlassTheme theme) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          const TextSpan(
            text: 'Track Every\n',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: GlassTheme.textPrimary,
              height: 1.2,
              letterSpacing: -0.5,
            ),
          ),
          TextSpan(
            text: 'Step',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: GlassTheme.primary,
              height: 1.2,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription(GlassTheme theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        'Watch your food travel from the kitchen to your doorstep in real-time with live GPS tracking.',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          height: 1.5,
          color: GlassTheme.textSecondary,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalPages, (index) {
        final isActive = index == currentPage;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive
                ? GlassTheme.primary
                : GlassTheme.textPrimary.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(isActive ? 4 : 4),
            border: isActive
                ? null
                : Border.all(
                    color: GlassTheme.glassBorder.withValues(alpha: 0.3),
                  ),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: GlassTheme.primary.withValues(alpha: 0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
        );
      }),
    );
  }
}
