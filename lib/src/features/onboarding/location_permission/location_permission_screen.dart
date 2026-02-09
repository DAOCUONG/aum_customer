import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../ui/theme/glass_theme.dart';
import '../../../ui/atoms/glass_button.dart';
import '../../../core/providers/providers.dart';
import '../../../core/routing/app_router.dart';
import 'location_permission_notifier.dart';
import 'location_permission_state.dart';

/// Location Permission Screen - Modal for requesting location access
class LocationPermissionScreen extends ConsumerWidget {
  const LocationPermissionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const LocationPermissionScreenContent();
  }
}

/// Location permission screen content
class LocationPermissionScreenContent extends ConsumerStatefulWidget {
  const LocationPermissionScreenContent({super.key});

  @override
  ConsumerState<LocationPermissionScreenContent> createState() =>
      _LocationPermissionScreenContentState();
}

class _LocationPermissionScreenContentState
    extends ConsumerState<LocationPermissionScreenContent> with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _bounceController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(locationPermissionNotifierProvider);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(24),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: Colors.white.withOpacity(0.7),
          border: Border.all(
            color: Colors.white.withOpacity(0.6),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.orange.shade200.withOpacity(0.2),
              blurRadius: 40,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Close button
            Positioned(
              top: 20,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.close,
                    size: 20,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ),
            // Main content
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildBottomContent(context, state),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomContent(BuildContext context, LocationPermissionState state) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white.withOpacity(0.9),
            Colors.white.withOpacity(0.7),
          ],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 80),
          // Location icon with pulse animation
          _buildLocationIcon(),
          const SizedBox(height: 32),
          // Title
          const Text(
            'Enable Location Access',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
              color: GlassTheme.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          // Description
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'To find the best restaurants near you and deliver your food accurately, we need access to your location.',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                height: 1.6,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 40),
          // Allow button
          GlassButton(
            onPressed: state.isLoading
                ? null
                : () async {
                    final granted = await ref
                        .read(locationPermissionNotifierProvider.notifier)
                        .requestPermission();

                    if (granted && mounted) {
                      context.go(RouteNames.dietaryPreferences);
                    }
                  },
            label: 'Allow Location Access',
            icon: Icons.near_me,
            height: 56,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            isLoading: state.isLoading,
          ),
          const SizedBox(height: 16),
          // Enter manually button
          GestureDetector(
            onTap: state.isLoading
                ? null
                : () {
                    context.go(RouteNames.dietaryPreferences);
                  },
            child: Container(
              height: 52,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withOpacity(0.4),
                ),
              ),
              child: Center(
                child: Text(
                  'Enter manually',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: GlassTheme.primary,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildLocationIcon() {
    return SizedBox(
      width: 180,
      height: 180,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Pulse rings
          _buildPulseRing(60, 3),
          _buildPulseRing(60, 2),
          _buildPulseRing(60, 1),
          // Main icon container
          AnimatedBuilder(
            animation: _bounceController,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, -10 + _bounceController.value * 10),
                child: child,
              );
            },
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.9),
                    Colors.white.withOpacity(0.4),
                  ],
                ),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: Colors.white.withOpacity(0.6),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.shade300.withOpacity(0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Center(
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        GlassTheme.primary,
                        const Color(0xFFFF7A45),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.location_on,
                    size: 28,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPulseRing(double size, int index) {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        return Container(
          width: size + (_pulseController.value * 220),
          height: size + (_pulseController.value * 220),
          decoration: BoxDecoration(
            border: Border.all(
              color: GlassTheme.primary.withOpacity(0.3 - (index * 0.08)),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(size / 2 + (_pulseController.value * 110)),
          ),
        );
      },
    );
  }
}
