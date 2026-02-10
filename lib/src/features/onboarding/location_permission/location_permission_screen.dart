import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../ui/theme/glass_theme.dart';
import '../../../ui/atoms/glass_background.dart';
import '../../../ui/atoms/glass_panel.dart';
import '../../../core/routing/app_router.dart';
import 'location_permission_notifier.dart';
import 'widgets/index.dart';

/// LocationPermissionScreen - Main screen for requesting location access
///
/// Uses atomic design pattern with:
/// - Organisms: PermissionBottomSheet (composes the main sheet)
/// - Molecules: PermissionContent (title, description, buttons)
/// - Atoms: LocationPin (animated pin with pulse effect)
class LocationPermissionScreen extends ConsumerWidget {
  const LocationPermissionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const LocationPermissionScreenContent();
  }
}

/// LocationPermissionScreenContent - Main screen content wrapper
///
/// Handles animation controllers and delegates to atomic components
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
    final screenSize = MediaQuery.of(context).size;
    final isDesktop = screenSize.width > 600;
    final isLargeScreen = screenSize.height > 800;

    return GlassBackground(
      child: Stack(
        children: [
          // Blurred fake UI mock in background
          const _BackgroundMockUI(),

          // Main glass panel
          Positioned.fill(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: isDesktop ? 480 : double.infinity,
                  maxHeight: isLargeScreen ? screenSize.height * 0.95 : double.infinity,
                ),
                child: GlassPanel.screen(
                  borderRadius: isDesktop
                      ? const BorderRadius.all(Radius.circular(56))
                      : BorderRadius.zero,
                  child: Stack(
                    children: [
                      // Close button
                      Positioned(
                        top: 20,
                        right: 20,
                        child: _CloseButton(onPressed: () => context.pop()),
                      ),

                      // Main permission content
                      PermissionBottomSheet(
                        screenSize: screenSize,
                        isLoading: state.isLoading,
                        onAllowLocation: () async {
                          final granted = await ref
                              .read(locationPermissionNotifierProvider.notifier)
                              .requestPermission();

                          if (granted && mounted) {
                            context.go(RouteNames.dietaryPreferences);
                          }
                        },
                        onEnterManually: () {
                          context.go(RouteNames.dietaryPreferences);
                        },
                        pulseController: _pulseController,
                        bounceController: _bounceController,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Background blurred fake UI mock
/// Creates a blurred representation of app UI behind the permission sheet
class _BackgroundMockUI extends StatelessWidget {
  const _BackgroundMockUI();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Header mock
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Hero image mock
              Container(
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              const SizedBox(height: 16),

              // Title line mock
              Container(
                width: 200,
                height: 28,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              const SizedBox(height: 12),

              // Description lines mock
              Container(
                width: double.infinity,
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 180,
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const Spacer(),

              // Grid mock
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 140,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      height: 140,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Close button atom
class _CloseButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _CloseButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(
          Icons.close,
          size: 20,
          color: GlassTheme.textSecondary,
        ),
      ),
    );
  }
}
