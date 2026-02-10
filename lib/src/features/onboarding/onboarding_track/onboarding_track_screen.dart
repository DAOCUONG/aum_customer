import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/routing/app_router.dart';
import '../../../ui/atoms/glass_background.dart';
import '../../../ui/theme/glass_theme.dart';
import 'widgets/index.dart';

/// OnboardingTrackScreen - Third slide of onboarding flow
///
/// THIN WIDGET - Main screen delegates to composed components
/// Uses atomic design system with proper glassmorphism effects
///
/// Features:
/// - Glass-styled map visualization with delivery route
/// - Live GPS tracking visualization
/// - Pulsing destination marker
/// - Driver nearby indicator
/// - Glassmorphism panel effects
class OnboardingTrackScreen extends StatelessWidget {
  const OnboardingTrackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GlassBackground(
        child: OnboardingTrackContent(
          onSkip: () => _navigateToSignIn(context),
          onGetStarted: () => _navigateToSignIn(context),
        ),
      ),
    );
  }

  void _navigateToSignIn(BuildContext context) {
    context.go(RouteNames.signIn);
  }
}

/// OnboardingTrackContent - Main content widget
///
/// COMPOSITION WIDGET - Combines all atoms, molecules, and organisms
/// Handles the full content composition for the track screen
class OnboardingTrackContent extends StatelessWidget {
  final VoidCallback onSkip;
  final VoidCallback onGetStarted;

  const OnboardingTrackContent({
    super.key,
    required this.onSkip,
    required this.onGetStarted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: GlassTheme.backgroundLight,
      child: Stack(
        children: [
          // Main glass panel with backdrop blur effect
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
              blendMode: BlendMode.srcOver,
              child: Container(
                color: GlassTheme.glassSurface.withValues(alpha: 0.65),
              ),
            ),
          ),

          // Panel border
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: GlassTheme.glassBorder.withValues(alpha: 0.6),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(56),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 40,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
            ),
          ),

          // Track content organism
          Positioned.fill(
            child: TrackContent(
              onSkip: onSkip,
              onGetStarted: onGetStarted,
            ),
          ),
        ],
      ),
    );
  }
}
