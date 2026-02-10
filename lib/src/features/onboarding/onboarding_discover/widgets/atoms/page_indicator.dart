import 'package:flutter/material.dart';
import '../../../../../ui/theme/glass_theme.dart';

/// PageIndicator - A dot indicator for onboarding pages
///
/// ATOM component representing page navigation dots
/// with active/inactive states and glow effects
class PageIndicator extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Color? activeColor;
  final Color? inactiveColor;
  final double size;
  final double spacing;

  const PageIndicator({
    super.key,
    required this.currentPage,
    required this.totalPages,
    this.activeColor,
    this.inactiveColor,
    this.size = 8,
    this.spacing = 8,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);
    final effectiveActiveColor = activeColor ?? theme.primaryColor;
    final effectiveInactiveColor = inactiveColor ?? theme.textTertiaryColor;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalPages,
        (index) => _buildIndicator(
          context,
          index: index,
          isActive: index == currentPage,
          activeColor: effectiveActiveColor,
          inactiveColor: effectiveInactiveColor,
        ),
      ),
    );
  }

  Widget _buildIndicator(
    BuildContext context, {
    required int index,
    required bool isActive,
    required Color activeColor,
    required Color inactiveColor,
  }) {
    if (isActive) {
      return _ActiveIndicator(
        color: activeColor,
        size: size,
      );
    }
    return _InactiveIndicator(
      color: inactiveColor,
      size: size,
    );
  }
}

class _ActiveIndicator extends StatelessWidget {
  final Color color;
  final double size;

  const _ActiveIndicator({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(size / 2),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.25),
            blurRadius: 10,
          ),
        ],
      ),
    );
  }
}

class _InactiveIndicator extends StatelessWidget {
  final Color color;
  final double size;

  const _InactiveIndicator({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(size / 2),
        border: Border.all(
          color: theme.glassBorderColor,
          width: 0.5,
        ),
      ),
    );
  }
}
