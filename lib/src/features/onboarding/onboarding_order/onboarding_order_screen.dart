import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/routing/app_router.dart';
import '../../../ui/atoms/glass_background.dart';
import '../../../ui/theme/glass_theme.dart';
import 'widgets/index.dart';

/// OnboardingOrderScreen - Second onboarding screen showing order flow
///
/// THIN WIDGET - Handles navigation callbacks and delegates to composed content
class OnboardingOrderScreen extends StatefulWidget {
  const OnboardingOrderScreen({super.key});

  @override
  State<OnboardingOrderScreen> createState() => _OnboardingOrderScreenState();
}

class _OnboardingOrderScreenState extends State<OnboardingOrderScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 800), vsync: this);
    _slideAnimation = Tween<double>(begin: 30, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToNext() {
    if (!mounted) return;
    context.go(RouteNames.onboardingTrack);
  }

  void _navigateToSkip() {
    if (!mounted) return;
    context.go(RouteNames.signIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GlassBackground(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _slideAnimation.value),
              child: Opacity(opacity: _fadeAnimation.value, child: child),
            );
          },
          child: Stack(
            children: [
              // Floating elements
              Positioned.fill(
                child: IgnorePointer(
                  child: Stack(
                    children: [
                      DecorativeFloatingElement(
                        emoji: '🍩', top: 0.12 * MediaQuery.of(context).size.height,
                        right: MediaQuery.of(context).size.width * 0.08, rotation: 12,
                      ),
                      DecorativeFloatingElement(
                        emoji: '🥤', bottom: 0.20 * MediaQuery.of(context).size.height,
                        left: MediaQuery.of(context).size.width * 0.03, rotation: -12,
                      ),
                      DecorativeAddButton(
                        top: 0.30 * MediaQuery.of(context).size.height,
                        left: -MediaQuery.of(context).size.width * 0.03,
                      ),
                    ],
                  ),
                ),
              ),
              // Main content
              Column(
                children: [
                  Padding(padding: const EdgeInsets.fromLTRB(24, 48, 24, 0), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    const SizedBox(width: 40),
                    _buildProgressIndicator(),
                    TextButton(onPressed: _navigateToSkip, child: const Text('Skip', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: GlassTheme.textSecondary))),
                  ])),
                  const Spacer(),
                  const OrderVisual(),
                  const Spacer(),
                  _buildTitleSection(),
                  const SizedBox(height: 24),
                  _buildContinueButton(),
                  const SizedBox(height: 40),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        final isActive = index == 1;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: isActive ? 24 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: isActive ? GlassTheme.textPrimary : GlassTheme.textPrimary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(4),
              border: isActive ? null : Border.all(color: GlassTheme.glassBorder.withValues(alpha: 0.3)),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildTitleSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              children: [
                TextSpan(text: 'Order in\n', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: GlassTheme.textPrimary, height: 1.2)),
                TextSpan(text: 'Seconds', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: GlassTheme.primary, height: 1.2)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Browse menus, customize your meal, and checkout instantly with our streamlined cart.',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: GlassTheme.textSecondary, height: 1.5),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: GestureDetector(
        onTap: _navigateToNext,
        child: Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            gradient: const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFFFF7A45), Color(0xFFFF5E2B)]),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: GlassTheme.primary.withValues(alpha: 0.1), width: 0.5),
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
            Text('Continue', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.white)),
            SizedBox(width: 8),
            Icon(Icons.arrow_forward, size: 20, color: Colors.white),
          ]),
        ),
      ),
    );
  }
}
