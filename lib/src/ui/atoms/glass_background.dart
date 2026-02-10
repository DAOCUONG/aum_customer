import 'package:flutter/material.dart';
import '../theme/glass_theme.dart';

/// GlassBackground - Base mesh gradient background with radial gradients
///
/// Creates a beautiful mesh gradient background with multiple radial gradients
/// positioned at different points to create depth and visual interest.
///
/// Usage:
/// ```dart
/// GlassBackground(
///   child: YourContentWidget(),
/// )
/// ```
class GlassBackground extends StatelessWidget {
  final Widget child;
  final bool enableMesh;
  final double meshOpacity;

  const GlassBackground({
    super.key,
    required this.child,
    this.enableMesh = true,
    this.meshOpacity = 0.6,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return Container(
      color: theme.background,
      child: Stack(
        children: [
          if (enableMesh)
            _MeshGradientLayer(opacity: meshOpacity),
          child,
        ],
      ),
    );
  }
}

/// Internal mesh gradient layer with customizable colors
class _MeshGradientLayer extends StatelessWidget {
  final double opacity;

  const _MeshGradientLayer({this.opacity = 0.6});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        children: [
          // Warm gradient at 15% 50% (peach tone)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(-0.7, 0.0),
                  radius: 0.8,
                  colors: [
                    const Color(0xFFFFDCC8).withValues(alpha: opacity),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Cool gradient at 85% 30% (blue tone)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0.7, -0.4),
                  radius: 0.8,
                  colors: [
                    const Color(0xFFC8E6FF).withValues(alpha: opacity),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Pink gradient at bottom left
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(-0.3, 0.85),
                  radius: 0.7,
                  colors: [
                    const Color(0xFFFFCCE0).withValues(alpha: opacity * 0.6),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Blue gradient at bottom right
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0.7, 0.85),
                  radius: 0.7,
                  colors: [
                    const Color(0xFFC8E6FF).withValues(alpha: opacity * 0.6),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Simplified mesh background for quick usage
class MeshGradientBackground extends StatelessWidget {
  final Widget child;

  const MeshGradientBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GlassBackground(child: child);
  }
}

/// Background with specific radial gradient spots (matches HTML spec)
///
/// CSS equivalent:
/// ```css
/// background:
///     radial-gradient(circle at 15% 50%, rgba(255, 220, 200, 0.6), transparent 40%),
///     radial-gradient(circle at 85% 30%, rgba(200, 230, 255, 0.6), transparent 40%);
/// ```
class RadialMeshBackground extends StatelessWidget {
  final Widget child;
  final Color warmSpotColor;
  final Color coolSpotColor;
  final double warmSpotOpacity;
  final double coolSpotOpacity;

  const RadialMeshBackground({
    super.key,
    required this.child,
    this.warmSpotColor = const Color(0xFFFFDCC8),
    this.coolSpotColor = const Color(0xFFC8E6FF),
    this.warmSpotOpacity = 0.6,
    this.coolSpotOpacity = 0.6,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Warm gradient at 15% 50%
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(-0.7, 0.0),
                radius: 0.5,
                colors: [
                  warmSpotColor.withValues(alpha: warmSpotOpacity),
                  warmSpotColor.withValues(alpha: 0),
                ],
              ),
            ),
          ),
        ),
        // Cool gradient at 85% 30%
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(0.7, -0.4),
                radius: 0.5,
                colors: [
                  coolSpotColor.withValues(alpha: coolSpotOpacity),
                  coolSpotColor.withValues(alpha: 0),
                ],
              ),
            ),
          ),
        ),
        child,
      ],
    );
  }
}
