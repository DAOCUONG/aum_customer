import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/providers/providers.dart';

part 'splash_notifier.dart';
part 'splash_state.dart';

/// Splash screen with Riverpod state management
class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const SplashScreenContent();
  }
}

/// Splash screen content
class SplashScreenContent extends ConsumerStatefulWidget {
  const SplashScreenContent({super.key});

  @override
  ConsumerState<SplashScreenContent> createState() => _SplashScreenContentState();
}

class _SplashScreenContentState extends ConsumerState<SplashScreenContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    );

    // Start initialization
    ref.read(splashNotifierProvider.notifier).initialize();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(splashNotifierProvider);

    // Navigate when navigation event occurs
    if (state.navigationEvent != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _handleNavigation(state.navigationEvent!, context);
        // Clear the navigation event
        ref.read(splashNotifierProvider.notifier).clearNavigationEvent();
      });
    }

    return Scaffold(
      body: _buildBody(context),
    );
  }

  void _handleNavigation(SplashNavigationEvent event, BuildContext context) {
    if (event is _ToOnboarding) {
      context.go('/onboarding');
    } else if (event is _ToSignIn) {
      context.go('/signIn');
    } else if (event is _ToLocationPermission) {
      context.go('/locationPermission');
    } else if (event is _ToDietaryPreferences) {
      context.go('/dietaryPreferences');
    } else if (event is _ToHome) {
      context.go('/home');
    }
  }

  Widget _buildBody(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.height < 700;

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.orange.shade50.withOpacity(0.3),
            Colors.white.withOpacity(0),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Background decorations
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenSize.height * 0.5,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.orange.shade100.withOpacity(0.4),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Top right orange glow
          Positioned(
            top: -80,
            right: -80,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    Colors.orange.shade200.withOpacity(0.3),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Bottom left subtle glow
          Positioned(
            bottom: -80,
            left: -80,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    Colors.orange.shade50.withOpacity(0.4),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Main content
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: isSmallScreen ? 0 : 40),
                  // Logo with pulse animation
                  _buildLogoWithPulse(),
                  const SizedBox(height: 32),
                  // App name
                  _buildAppName(),
                  const SizedBox(height: 12),
                  // Tagline
                  _buildTagline(),
                  const Spacer(),
                  // Loading indicator
                  _buildLoadingIndicator(),
                  const SizedBox(height: 40),
                  // Version text
                  _buildVersionText(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoWithPulse() {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            // Pulse glow
            Transform.scale(
              scale: 1.0 + _pulseAnimation.value * 0.15,
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      Colors.orange.shade200.withOpacity(0.4),
                      Colors.orange.shade50.withOpacity(0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
            ),
            // Logo container
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.9),
                    Colors.white.withOpacity(0.4),
                  ],
                ),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: Colors.white.withOpacity(0.6),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.shade300.withOpacity(0.4),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  '🍔',
                  style: TextStyle(
                    fontSize: 54,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAppName() {
    return Column(
      children: [
        Text(
          'FOODIE',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            letterSpacing: 1,
            height: 1.1,
            color: Colors.grey.shade800,
          ),
        ),
        Text(
          'EXPRESS',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            letterSpacing: 1,
            height: 1.1,
            color: Colors.orange.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildTagline() {
    return Text(
      'Deliciously Fast',
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 3,
        color: Colors.grey.shade500,
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: Column(
        children: [
          // Loading bar background
          Container(
            height: 6,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey.shade300,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: _buildShimmerLoadingBar(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerLoadingBar() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedBuilder(
          animation: _pulseController,
          builder: (context, child) {
            return ShaderMask(
              shaderCallback: (bounds) {
                return LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.orange.shade400,
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ).createShader(bounds);
              },
              child: Container(
                width: constraints.maxWidth / 3,
                height: constraints.maxHeight,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.transparent,
                      Colors.white.withOpacity(0.8),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildVersionText() {
    return Text(
      'VERSION 2.0',
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        letterSpacing: 2,
        color: Colors.grey.shade400,
      ),
    );
  }
}
