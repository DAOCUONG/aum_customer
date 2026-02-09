import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/routing/app_router.dart';
import '../../../ui/theme/glass_design_system.dart';

/// Onboarding Discover Screen - First slide of onboarding flow
///
/// UI matches onboarding_discover.html design with:
/// - Mesh gradient background
/// - Glassmorphism card with food grid
/// - Skip and navigation buttons
class OnboardingDiscoverScreen extends ConsumerWidget {
  const OnboardingDiscoverScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: OnboardingDiscoverContent(),
    );
  }
}

class OnboardingDiscoverContent extends StatelessWidget {
  const OnboardingDiscoverContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF2F2F7),
            Color(0xFFF8F0E8),
            Color(0xFFF0F8FF),
            Color(0xFFF2F2F7),
          ],
        ),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            // Mesh gradient overlays
            _buildMeshGradients(),

            // Main content column
            Column(
              children: [
                // Skip button
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => _navigateToSignIn(context),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          backgroundColor: Colors.white.withOpacity(0.3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          'Skip',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Page indicators
                _buildPageIndicators(),

                const SizedBox(height: 24),

                // Food grid illustration
                Expanded(
                  child: Center(
                    child: _buildFoodGridIllustration(),
                  ),
                ),

                // Title and description
                _buildTitleAndDescription(),

                const SizedBox(height: 32),

                // Bottom buttons
                _buildBottomButton(context),
                const SizedBox(height: 40),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMeshGradients() {
    return Positioned.fill(
      child: Stack(
        children: [
          // Top left orange gradient
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 400,
              height: 300,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0.5, 0.5),
                  colors: [
                    const Color(0xFFFFE0CC).withValues(alpha: 0.6),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Top right blue gradient
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 400,
              height: 300,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0.5, 0.5),
                  colors: [
                    const Color(0xFFCCE0FF).withValues(alpha: 0.6),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Bottom left blue gradient
          Positioned(
            bottom: -100,
            left: -100,
            child: Container(
              width: 400,
              height: 300,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0.5, 0.5),
                  colors: [
                    const Color(0xFFCCE0FF).withValues(alpha: 0.6),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Bottom right pink gradient
          Positioned(
            bottom: -100,
            right: -100,
            child: Container(
              width: 400,
              height: 300,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0.5, 0.5),
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

  Widget _buildPageIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildIndicator(isActive: true),
        const SizedBox(width: 8),
        _buildIndicator(isActive: false),
        const SizedBox(width: 8),
        _buildIndicator(isActive: false),
      ],
    );
  }

  Widget _buildIndicator({required bool isActive}) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? primaryColor : Colors.black.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: primaryColor.withValues(alpha: 0.25),
                  blurRadius: 10,
                ),
              ]
            : null,
        border: isActive
            ? null
            : Border.all(
                color: Colors.white.withValues(alpha: 0.4),
                width: 0.5,
              ),
      ),
    );
  }

  Widget _buildFoodGridIllustration() {
    return SizedBox(
      width: 280,
      height: 280,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Gradient background glow
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.orange.shade100.withValues(alpha: 0.3),
                  Colors.blue.shade100.withValues(alpha: 0.2),
                  Colors.transparent,
                ],
              ),
              borderRadius: BorderRadius.circular(32),
            ),
          ),

          // Rotating gradient overlay
          Transform.rotate(
            angle: 0.05,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.orange.shade200.withValues(alpha: 0.2),
                    Colors.blue.shade200.withValues(alpha: 0.2),
                  ],
                ),
                borderRadius: BorderRadius.circular(48),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.shade100.withValues(alpha: 0.3),
                    blurRadius: 30,
                    spreadRadius: -10,
                  ),
                ],
              ),
            ),
          ),

          // Glass card with food grid
          Container(
            width: 220,
            height: 220,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.6),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: _buildFoodGrid(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodGrid() {
    // HTML uses flex flex-wrap with 4 items
    // Order: Food1, Food2, Food3, Food4
    // Row 1: Food1, Food2 (Food2 has mt-8)
    // Row 2: Food3 (-mt-8), Food4
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Row 1
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildFoodImage('assets/images/onboarding/food_1.jpg'),
            const SizedBox(width: 6),
            Transform.translate(
              offset: const Offset(0, 20),
              child: _buildFoodImage('assets/images/onboarding/food_2.jpg'),
            ),
          ],
        ),
        const SizedBox(height: 6),
        // Row 2
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Transform.translate(
              offset: const Offset(0, -20),
              child: _buildFoodImage('assets/images/onboarding/food_3.jpg'),
            ),
            const SizedBox(width: 6),
            _buildFoodImage('assets/images/onboarding/food_4.jpg'),
          ],
        ),
      ],
    );
  }

  Widget _buildFoodImage(String assetPath) {
    final fileName = assetPath.split('/').last;
    return SizedBox(
      width: 95,
      height: 95,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              assetPath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                print('❌ ERROR loading: $assetPath - $error');
                return Container(
                  color: Colors.red.shade200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error, color: Colors.red),
                      Text(
                        fileName,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            // Show file name on top for debugging
            Positioned(
              bottom: 2,
              left: 4,
              child: Text(
                fileName.replaceAll('.jpg', ''),
                style: const TextStyle(
                  fontSize: 8,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.3),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleAndDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          const Text(
            'Discover Amazing Food',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.3,
              height: 1.2,
              color: Color(0xFF1C1C1E),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            'Find the best local restaurants and dishes delivered straight to your doorstep in minutes.',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              height: 1.5,
              color: Colors.grey.shade500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          // Next button
          GestureDetector(
            onTap: () => _navigateToNext(context),
            child: Container(
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.5),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1C1C1E),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.arrow_forward,
                    size: 20,
                    color: Colors.grey.shade700,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Sign in link
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an account?',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade500,
                ),
              ),
              const SizedBox(width: 4),
              GestureDetector(
                onTap: () => _navigateToSignIn(context),
                child: const Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _navigateToSignIn(BuildContext context) {
    context.go(RouteNames.signIn);
  }

  void _navigateToNext(BuildContext context) {
    context.go(RouteNames.onboarding);
  }
}
