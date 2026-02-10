import 'package:flutter/material.dart';
import '../../../../../ui/theme/glass_theme.dart';
import '../../../../../ui/atoms/glass_button.dart';
import '../atoms/index.dart';

/// PermissionContent - Molecule containing title, description, and action buttons
///
/// Composes:
/// - Title text (Enable Location Access)
/// - Description text (permission rationale)
/// - Primary button (Allow Location Access)
/// - Secondary button (Enter manually)
class PermissionContent extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onAllowLocation;
  final VoidCallback onEnterManually;
  final AnimationController pulseController;
  final AnimationController bounceController;

  const PermissionContent({
    super.key,
    required this.isLoading,
    required this.onAllowLocation,
    required this.onEnterManually,
    required this.pulseController,
    required this.bounceController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 80),

        // Animated location pin
        LocationPin(
          pulseController: pulseController,
          bounceController: bounceController,
        ),

        const SizedBox(height: 32),

        // Title
        const _PermissionTitle(),

        const SizedBox(height: 16),

        // Description
        const _PermissionDescription(),

        const SizedBox(height: 40),

        // Primary action button
        _AllowLocationButton(
          isLoading: isLoading,
          onPressed: onAllowLocation,
        ),

        const SizedBox(height: 16),

        // Secondary action button
        _EnterManuallyButton(
          isLoading: isLoading,
          onPressed: onEnterManually,
        ),

        const SizedBox(height: 40),
      ],
    );
  }
}

/// Permission title - "Enable Location Access"
class _PermissionTitle extends StatelessWidget {
  const _PermissionTitle();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Enable Location Access',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
        color: GlassTheme.textPrimary,
        height: 1.2,
      ),
      textAlign: TextAlign.center,
    );
  }
}

/// Permission description - explains why location is needed
class _PermissionDescription extends StatelessWidget {
  const _PermissionDescription();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        'To find the best restaurants near you and deliver your food accurately, '
        'we need access to your location.',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          height: 1.6,
          color: GlassTheme.textSecondary,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

/// Allow Location Access primary button
class _AllowLocationButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const _AllowLocationButton({
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GlassButton(
      onPressed: isLoading ? null : onPressed,
      label: 'Allow Location Access',
      icon: Icons.near_me,
      height: 56,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      isLoading: isLoading,
    );
  }
}

/// Enter manually secondary button
class _EnterManuallyButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const _EnterManuallyButton({
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          color: GlassTheme.glassSurface.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: GlassTheme.glassBorder.withValues(alpha: 0.4),
          ),
        ),
        child: Center(
          child: Text(
            'Enter manually',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: GlassTheme.primary,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ),
    );
  }
}

/// Compact permission buttons row for smaller screens
class PermissionButtonsRow extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onAllowLocation;
  final VoidCallback onEnterManually;

  const PermissionButtonsRow({
    super.key,
    required this.isLoading,
    required this.onAllowLocation,
    required this.onEnterManually,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GlassButton(
            onPressed: isLoading ? null : onAllowLocation,
            label: 'Allow',
            icon: Icons.near_me,
            height: 48,
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            isLoading: isLoading,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: GestureDetector(
            onTap: isLoading ? null : onEnterManually,
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: GlassTheme.glassSurface.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: GlassTheme.glassBorder.withValues(alpha: 0.4),
                ),
              ),
              child: Center(
                child: Text(
                  'Manual',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: GlassTheme.primary,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
