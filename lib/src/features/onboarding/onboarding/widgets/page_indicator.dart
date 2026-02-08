part of '../onboarding_screen.dart';

/// Page Indicator dots for onboarding slides
class PageIndicator extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback? onSkip;

  const PageIndicator({
    super.key,
    required this.currentPage,
    required this.totalPages,
    this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Page indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            totalPages,
            (index) => _buildDot(index),
          ),
        ),
        // Skip button
        if (onSkip != null)
          TextButton(
            onPressed: onSkip,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: Text(
              'Skip',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: GlassTheme.textTertiary,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildDot(int index) {
    final isActive = index == currentPage;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive
            ? GlassTheme.primary
            : GlassTheme.textTertiary.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(4),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: GlassTheme.primary.withValues(alpha: 0.4),
                  blurRadius: 8,
                  offset: Offset(0, 0),
                ),
              ]
            : null,
      ),
    );
  }
}

/// Compact page indicator for slides
class CompactPageIndicator extends StatelessWidget {
  final int currentPage;
  final int totalPages;

  const CompactPageIndicator({
    super.key,
    required this.currentPage,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalPages,
        (index) => _buildDot(index),
      ),
    );
  }

  Widget _buildDot(int index) {
    final isActive = index == currentPage;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? GlassTheme.primary : Colors.black.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
        border: isActive
            ? null
            : Border.all(
                color: Colors.white.withValues(alpha: 0.2),
                width: 1,
              ),
      ),
    );
  }
}
