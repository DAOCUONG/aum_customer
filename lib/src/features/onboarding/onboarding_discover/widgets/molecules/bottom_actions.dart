import 'package:flutter/material.dart';
import '../../../../../ui/atoms/glass_button.dart';
import '../atoms/skip_button.dart';

/// BottomActions - A molecule component for bottom navigation actions
///
/// MOLECULE component combining Next button and Sign In link
/// Used in onboarding screens
class BottomActions extends StatelessWidget {
  final VoidCallback onNextTap;
  final VoidCallback onSignInTap;
  final String nextButtonText;

  const BottomActions({
    super.key,
    required this.onNextTap,
    required this.onSignInTap,
    this.nextButtonText = 'Next',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          _buildNextButton(context),
          const SizedBox(height: 16),
          _buildSignInLink(context),
        ],
      ),
    );
  }

  Widget _buildNextButton(BuildContext context) {
    return GlassButton.primary(
      onPressed: onNextTap,
      height: 56,
      label: nextButtonText,
      icon: Icons.arrow_forward,
      iconSize: 20,
    );
  }

  Widget _buildSignInLink(BuildContext context) {
    return AlreadyHaveAccountText(onSignInTap: onSignInTap);
  }
}

/// SkipHeader - A molecule component for top skip action
///
/// MOLECULE component combining skip button at top of screen
class SkipHeader extends StatelessWidget {
  final VoidCallback onSkipTap;

  const SkipHeader({super.key, required this.onSkipTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        top: 48,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SkipButton(onTap: onSkipTap),
        ],
      ),
    );
  }
}
