import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../ui/atoms/glass_icon_button.dart';
import '../../ui/theme/glass_design_system.dart';
import '../../core/routing/app_router.dart';

/// Empty Cart Screen
class EmptyCartScreen extends StatefulWidget {
  const EmptyCartScreen({super.key});

  @override
  State<EmptyCartScreen> createState() => _EmptyCartScreenState();
}

class _EmptyCartScreenState extends State<EmptyCartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundLight,
      body: Stack(
        children: [
          // Mesh Background with animated blobs
          _buildMeshBackground(),
          // Main Content
          SafeArea(
            child: Column(
              children: [
                // Header
                _buildHeader(),
                // Content
                Expanded(
                  child: Center(
                    child: _buildEmptyContent(),
                  ),
                ),
                // Bottom Button
                _buildExploreButton(),
              ],
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
              Colors.orange.shade100.withOpacity(0.6),
              backgroundLight,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          GlassIconButton.transparent(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back_ios_new, size: 20),
            size: 40,
          ),
          const Spacer(),
          GlassIconButton.transparent(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz, size: 24),
            size: 40,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Animated Cart Icon
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 1000),
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, -20 * (1 - value)),
              child: Opacity(
                opacity: value,
                child: child,
              ),
            );
          },
          child: Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Colors.white.withOpacity(0.9),
                  Colors.white.withOpacity(0.6),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 40,
                  offset: const Offset(0, 20),
                ),
                BoxShadow(
                  color: primaryColor.withOpacity(0.2),
                  blurRadius: 60,
                  offset: const Offset(0, -20),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Shopping cart icon
                Icon(
                  Icons.shopping_cart,
                  size: 80,
                  color: primaryColor.withValues(alpha: 0.3),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 32),
        // Text
        const Text(
          'Your cart is empty',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Looks like you haven\'t added\nanything yet...',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: textSecondary,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildExploreButton() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: GestureDetector(
        onTap: () => context.push(RouteNames.home),
        child: Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [primaryLight, primaryColor],
            ),
            borderRadius: buttonRadius,
            boxShadow: [
              BoxShadow(
                color: primaryColor.withOpacity(0.4),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Explore Restaurants',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_forward,
                size: 20,
                color: Colors.white.withOpacity(0.8),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
