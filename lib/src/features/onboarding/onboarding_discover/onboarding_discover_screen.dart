import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/routing/app_router.dart';

/// Onboarding Discover Screen - First slide of onboarding flow
class OnboardingDiscoverScreen extends StatelessWidget {
  const OnboardingDiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background mesh gradients
          _buildBackground(context),

          // Glass panel container
          _buildGlassPanel(context),
        ],
      ),
    );
  }

  Widget _buildBackground(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: const Alignment(0.15, 0.5),
          radius: 1.0,
          colors: [
            const Color(0xFFFFDCC8).withValues(alpha: 0.6),
            Colors.transparent,
          ],
        ),
      ),
      child: Stack(
        children: [
          // Blue gradient
          Positioned(
            right: 0,
            top: 0,
            width: size.width,
            height: size.height * 0.5,
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0.85, 0.3),
                  radius: 1.0,
                  colors: [
                    const Color(0xFFC8E6FF).withValues(alpha: 0.6),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Pink gradient
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: size.height * 0.5,
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0.15, 0.85),
                  radius: 1.0,
                  colors: [
                    const Color(0xFFFFCCE0).withValues(alpha: 0.6),
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

  Widget _buildGlassPanel(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.65),
        borderRadius: BorderRadius.zero,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.6),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.zero,
        child: _buildContent(),
      ),
    );
  }

  Widget _buildFoodGrid() {
    final foodImages = [
      'assets/images/onboarding/food_1.jpg',
      'assets/images/onboarding/food_2.jpg',
      'assets/images/onboarding/food_3.jpg',
      'assets/images/onboarding/food_4.jpg',
    ];

    return SizedBox(
      width: 220,
      height: 220,
      child: Stack(
        children: [
          // Background gradient
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFFFFE4CC).withValues(alpha: 0.5),
                    const Color(0xFFCCE0FF).withValues(alpha: 0.5),
                  ],
                ),
                borderRadius: BorderRadius.circular(32),
              ),
            ),
          ),
          // Image grid
          Positioned.fill(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  // Left column
                  Expanded(
                    child: Column(
                      children: [
                        _buildFoodImage(foodImages[0], -12),
                        const Spacer(),
                        _buildFoodImage(foodImages[2], -6),
                      ],
                    ),
                  ),
                  const SizedBox(width: 6),
                  // Right column
                  Expanded(
                    child: Column(
                      children: [
                        _buildFoodImage(foodImages[1], 6),
                        const Spacer(),
                        _buildFoodImage(foodImages[3], 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodImage(String assetPath, double offset) {
    return Transform.translate(
      offset: Offset(0, offset),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          assetPath,
          width: 85,
          height: 85,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 85,
              height: 85,
              color: const Color(0xFFFFE4CC),
              child: const Icon(
                Icons.fastfood,
                size: 30,
                color: Color(0xFFFF7A45),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Builder(
      builder: (context) {
        return Column(
          children: [
            // Skip button
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 48),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => context.go(RouteNames.onboardingOrder),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
                      ),
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF636366),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Page indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: index == 0 ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: index == 0
                        ? const Color(0xFF1C1C1E)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(4),
                    border: index == 0
                        ? null
                        : Border.all(color: Colors.white.withValues(alpha: 0.4)),
                  ),
                );
              }),
            ),

            const SizedBox(height: 24),

            // Food grid images
            SizedBox(
              width: 220,
              height: 220,
              child: _buildFoodGrid(),
            ),

            // Title
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                'Discover Amazing Food',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1C1C1E),
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 12),

            // Description
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                'Find the best local restaurants and dishes delivered straight to your doorstep in minutes.',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF636366),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const Spacer(),

            // Next button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: GestureDetector(
                onTap: () => context.go(RouteNames.onboardingOrder),
                child: Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFFFF7A45), Color(0xFFFF5E2B)],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFFF5E2B).withValues(alpha: 0.1),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Next',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.arrow_forward,
                        size: 20,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Sign in link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account?',
                  style: TextStyle(fontSize: 13, color: Color(0xFF636366)),
                ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: () => context.go(RouteNames.signIn),
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFFF5E2B),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),
          ],
        );
      },
    );
  }
}
