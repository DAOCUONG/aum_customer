import 'package:flutter/material.dart';
import '../../../../../ui/theme/glass_theme.dart';
import '../molecules/index.dart';

/// PermissionBottomSheet - Organism composing the bottom permission sheet
///
/// Combines:
/// - Gradient background overlay
/// - Glassmorphism container
/// - PermissionContent molecule
/// - Decorative glow elements
class PermissionBottomSheet extends StatelessWidget {
  final Size screenSize;
  final bool isLoading;
  final VoidCallback onAllowLocation;
  final VoidCallback onEnterManually;
  final AnimationController pulseController;
  final AnimationController bounceController;

  const PermissionBottomSheet({
    super.key,
    required this.screenSize,
    required this.isLoading,
    required this.onAllowLocation,
    required this.onEnterManually,
    required this.pulseController,
    required this.bounceController,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: _SheetContainer(
        child: Stack(
          children: [
            // Permission content
            Padding(
              padding: const EdgeInsets.all(32),
              child: PermissionContent(
                isLoading: isLoading,
                onAllowLocation: onAllowLocation,
                onEnterManually: onEnterManually,
                pulseController: pulseController,
                bounceController: bounceController,
              ),
            ),

            // Decorative glow elements
            const _DecorativeGlow(),
          ],
        ),
      ),
    );
  }
}

/// Sheet container with glassmorphism and gradient overlay
class _SheetContainer extends StatelessWidget {
  final Widget child;

  const _SheetContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white.withValues(alpha: 0.95),
            Colors.white.withValues(alpha: 0.85),
            Colors.white.withValues(alpha: 0.7),
          ],
        ),
      ),
      child: child,
    );
  }
}

/// Decorative glow elements - adds ambient light effects
class _DecorativeGlow extends StatelessWidget {
  const _DecorativeGlow();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Primary glow (bottom-right)
        Positioned(
          bottom: -80,
          right: -80,
          child: Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  GlassTheme.primary.withValues(alpha: 0.15),
                  GlassTheme.primary.withValues(alpha: 0),
                ],
              ),
            ),
          ),
        ),

        // Secondary glow (top-left)
        Positioned(
          top: -80,
          left: -80,
          child: Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  const Color(0xFF87CEEB).withValues(alpha: 0.15),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Extended permission bottom sheet with additional features
class PermissionBottomSheetExtended extends StatelessWidget {
  final Size screenSize;
  final bool isLoading;
  final VoidCallback onAllowLocation;
  final VoidCallback onEnterManually;
  final AnimationController pulseController;
  final AnimationController bounceController;
  final Widget? additionalContent;
  final VoidCallback? onClose;

  const PermissionBottomSheetExtended({
    super.key,
    required this.screenSize,
    required this.isLoading,
    required this.onAllowLocation,
    required this.onEnterManually,
    required this.pulseController,
    required this.bounceController,
    this.additionalContent,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Main sheet
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: _SheetContainer(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Drag handle
                const _DragHandle(),
                const SizedBox(height: 16),

                // Content
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: PermissionContent(
                    isLoading: isLoading,
                    onAllowLocation: onAllowLocation,
                    onEnterManually: onEnterManually,
                    pulseController: pulseController,
                    bounceController: bounceController,
                  ),
                ),

                // Additional content if provided
                if (additionalContent != null) ...[
                  additionalContent!,
                  const SizedBox(height: 24),
                ],
              ],
            ),
          ),
        ),

        // Close button overlay
        if (onClose != null)
          Positioned(
            top: 16,
            right: 16,
            child: GestureDetector(
              onTap: onClose,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.close,
                  size: 18,
                  color: GlassTheme.textSecondary,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// Drag handle for sheet
class _DragHandle extends StatelessWidget {
  const _DragHandle();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: GlassTheme.glassBorder.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}
