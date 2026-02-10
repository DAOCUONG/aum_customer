import 'dart:ui';

import 'package:flutter/material.dart';
import '../../../../../ui/atoms/glass_button.dart';
import '../../../../../ui/theme/glass_theme.dart';
import '../molecules/index.dart';
import '../../dietary_preferences_state.dart';

/// PreferencesContent - ORGANISM
///
/// Full content composition for the dietary preferences screen.
///
/// Combines:
/// - Sticky header with progress indicator and skip button
/// - Title and description section
/// - Scrollable preferences list
/// - Bottom Continue button with gradient
///
/// This is the main composition widget that organizes all
/// atoms and molecules into the complete screen content.
class PreferencesContent extends StatelessWidget {
  final DietaryPreferencesState state;
  final VoidCallback onTogglePreference;
  final VoidCallback onContinue;
  final VoidCallback onSkip;

  const PreferencesContent({
    super.key,
    required this.state,
    required this.onTogglePreference,
    required this.onContinue,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isDesktop = mediaQuery.size.width > 600;

    return Stack(
      children: [
        // Main content area
        Positioned.fill(
          child: SafeArea(
            child: Column(
              children: [
                // Sticky header
                _buildStickyHeader(context),
                const SizedBox(height: 8),
                // Scrollable content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        // Step indicator dots
                        _buildStepIndicator(),
                        const SizedBox(height: 24),
                        // Title and preferences list
                        PreferencesListWithHeader(
                          preferences: state.preferences,
                          onToggle: (_) => onTogglePreference(),
                        ),
                        const SizedBox(height: 140),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Bottom Continue button
        Positioned(
          bottom: isDesktop ? 24 : 32,
          left: isDesktop ? null : 24,
          right: isDesktop ? null : 24,
          child: _buildContinueButton(context),
        ),
      ],
    );
  }

  Widget _buildStickyHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Progress indicator (1/2)
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.grey.shade200.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.4),
                width: 1,
              ),
            ),
            child: const Center(
              child: Text(
                '1/2',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: GlassTheme.textSecondary,
                ),
              ),
            ),
          ),
          // Skip button
          TextButton(
            onPressed: onSkip,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            ),
            child: Text(
              'Skip',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: GlassTheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildDot(true),
        const SizedBox(width: 8),
        _buildDot(false),
      ],
    );
  }

  Widget _buildDot(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? GlassTheme.primary : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isDesktop = mediaQuery.size.width > 600;
    final maxWidth = isDesktop ? 400.0 : double.infinity;

    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidth),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: GlassButton.primary(
          onPressed: state.isSaving ? null : onContinue,
          label: 'Continue',
          icon: Icons.arrow_forward,
          height: 56,
          isLoading: state.isSaving,
          textStyle: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }
}

/// PreferencesContentDesktop - ORGANISM (Desktop Variant)
///
/// Desktop-optimized version with proper panel styling
/// and responsive layout.
class PreferencesContentDesktop extends StatelessWidget {
  final DietaryPreferencesState state;
  final VoidCallback onTogglePreference;
  final VoidCallback onContinue;
  final VoidCallback onSkip;

  const PreferencesContentDesktop({
    super.key,
    required this.state,
    required this.onTogglePreference,
    required this.onContinue,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.orange.shade50.withValues(alpha: 0.3),
            Colors.white.withValues(alpha: 0),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Mesh gradient background
          _buildMeshBackground(),
          // Main content
          Center(
            child: Container(
              width: 420,
              constraints: const BoxConstraints(maxHeight: 900),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(56),
                border: Border.all(
                  color: GlassTheme.glassBorder.withValues(alpha: 0.6),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 40,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(56),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                  child: Container(
                    color: GlassTheme.glassSurface.withValues(alpha: 0.65),
                    child: PreferencesContent(
                      state: state,
                      onTogglePreference: onTogglePreference,
                      onContinue: onContinue,
                      onSkip: onSkip,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMeshBackground() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topLeft,
            radius: 1.5,
            colors: [
              Colors.orange.shade100.withValues(alpha: 0.8),
              Colors.blue.shade50.withValues(alpha: 0.8),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }
}
