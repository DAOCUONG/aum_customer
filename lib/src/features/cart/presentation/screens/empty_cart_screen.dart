import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/app_router.dart';
import '../../../../ui/theme/glass_theme.dart';

/// Empty cart screen with glassmorphism design
/// Displays when the shopping cart is empty with a call to action
class EmptyCartScreen extends ConsumerWidget {
  const EmptyCartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: GlassGradients.meshGradient,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                // Empty cart illustration
                _buildIllustration(context),
                const SizedBox(height: 40),
                // Message
                _buildMessage(context),
                const SizedBox(height: 16),
                // Subtitle
                _buildSubtitle(context),
                const Spacer(),
                // CTA Button
                _buildBrowseButton(context),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIllustration(BuildContext context) {
    final theme = GlassTheme.of(context);

    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        color: theme.glassSurfaceColor,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: theme.glassBorderColor,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.primaryColor.withOpacity(0.1),
            blurRadius: 60,
            spreadRadius: 10,
          ),
        ],
      ),
      child: Icon(
        Icons.shopping_cart_outlined,
        size: 80,
        color: theme.primaryColor.withOpacity(0.7),
      ),
    );
  }

  Widget _buildMessage(BuildContext context) {
    final theme = GlassTheme.of(context);

    return Text(
      'Your cart is empty',
      style: GlassTextStyles.headlineLarge(context).copyWith(
        color: theme.textPrimaryColor,
        fontWeight: FontWeight.w700,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSubtitle(BuildContext context) {
    final theme = GlassTheme.of(context);

    return Text(
      'Looks like you haven\'t added\nanything to your cart yet.',
      style: GlassTextStyles.bodyLarge(context).copyWith(
        color: theme.textSecondaryColor,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildBrowseButton(BuildContext context) {
    final theme = GlassTheme.of(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: GlassGradients.primaryButton,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: theme.primaryColor.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Navigate to home/restaurants
            context.go(RouteNames.home);
          },
          borderRadius: BorderRadius.circular(28),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 18, horizontal: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.restaurant_menu,
                  color: Colors.white,
                  size: 24,
                ),
                SizedBox(width: 12),
                Text(
                  'Browse Restaurants',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
