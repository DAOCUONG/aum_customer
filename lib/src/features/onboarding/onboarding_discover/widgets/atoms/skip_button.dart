import 'package:flutter/material.dart';
import '../../../../../ui/theme/glass_theme.dart';

/// SkipButton - A skip button for onboarding flow
///
/// ATOM component for skipping onboarding pages
class SkipButton extends StatelessWidget {
  final VoidCallback onTap;

  const SkipButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: theme.glassSurfaceColor.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: theme.glassBorderColor,
            width: 0.5,
          ),
        ),
        child: Text(
          'Skip',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: theme.textSecondaryColor,
          ),
        ),
      ),
    );
  }
}

/// SignInTextLink - A "Sign In" text link for existing users
class SignInTextLink extends StatelessWidget {
  final VoidCallback onTap;

  const SignInTextLink({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Text(
        'Sign In',
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: theme.primaryColor,
        ),
      ),
    );
  }
}

/// AlreadyHaveAccountText - Helper text with sign-in link
class AlreadyHaveAccountText extends StatelessWidget {
  final VoidCallback onSignInTap;

  const AlreadyHaveAccountText({super.key, required this.onSignInTap});

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account?',
          style: TextStyle(
            fontSize: 13,
            color: theme.textSecondaryColor,
          ),
        ),
        const SizedBox(width: 4),
        SignInTextLink(onTap: onSignInTap),
      ],
    );
  }
}
