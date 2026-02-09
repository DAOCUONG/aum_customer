import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../ui/theme/glass_theme.dart';
import '../../../ui/atoms/glass_button.dart';
import '../../../ui/atoms/glass_card.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/providers/providers.dart';
import '../../../core/routing/app_router.dart';
import 'onboarding_notifier.dart';
import 'onboarding_state.dart';

part 'widgets/page_indicator.dart';

/// Onboarding screen with 3 slides
class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const OnboardingScreenContent();
  }
}

/// Onboarding screen content
class OnboardingScreenContent extends ConsumerStatefulWidget {
  const OnboardingScreenContent({super.key});

  @override
  ConsumerState<OnboardingScreenContent> createState() =>
      _OnboardingScreenContentState();
}

class _OnboardingScreenContentState
    extends ConsumerState<OnboardingScreenContent> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingNotifierProvider);

    return Scaffold(
      body: _buildBody(context, state),
    );
  }

  Widget _buildBody(BuildContext context, OnboardingState state) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white.withValues(alpha: 0),
            Colors.orange.shade50.withValues(alpha: 0.3),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Mesh gradient background
          _buildMeshBackground(),
          // Main content
          SafeArea(
            child: Column(
              children: [
                // Top row with indicators and skip
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Page indicators
                      PageIndicator(
                        currentPage: state.currentPage,
                        totalPages: AppConstants.onboardingPageCount,
                      ),
                      // Skip button
                      TextButton(
                        onPressed: () async {
                          await ref
                              .read(onboardingNotifierProvider.notifier)
                              .completeOnboarding();
                          if (mounted) {
                            _navigateToSignIn(context);
                          }
                        },
                        child: Text(
                          'Skip',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                        ),
                      ),
                    ],
                  ),
                ),
                // Page view with slides
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (page) {
                      ref
                          .read(onboardingNotifierProvider.notifier)
                          .goToPage(page);
                    },
                    children: [
                      _buildDiscoverSlide(),
                      _buildOrderSlide(),
                      _buildTrackSlide(),
                    ],
                  ),
                ),
                // Bottom button
                _buildBottomButton(context, state),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToSignIn(BuildContext context) {
    context.go(RouteNames.signIn);
  }

  Widget _buildMeshBackground() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topLeft,
            radius: 1.5,
            colors: [
              Colors.orange.shade100.withValues(alpha: 0.6),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomButton(BuildContext context, OnboardingState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: GlassButton(
        onPressed: state.isLoading
            ? null
            : () async {
                if (state.isLastPage) {
                  await ref
                      .read(onboardingNotifierProvider.notifier)
                      .completeOnboarding();
                  if (mounted) {
                    _navigateToSignIn(context);
                  }
                } else {
                  ref.read(onboardingNotifierProvider.notifier).nextPage();
                }
              },
        label: state.isLastPage ? 'Get Started' : 'Continue',
        icon: state.isLastPage ? null : Icons.arrow_forward,
        height: 56,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        isLoading: state.isLoading,
      ),
    );
  }

  // Slide 1: Discover Amazing Food
  Widget _buildDiscoverSlide() {
    return Column(
      children: [
        const Spacer(),
        // Food grid illustration
        _buildFoodGridIllustration(),
        const SizedBox(height: 32),
        // Text content
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const Text(
                'Discover Amazing Food',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                  height: 1.2,
                  color: GlassTheme.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Find the best local restaurants and dishes delivered straight to your doorstep in minutes.',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const Spacer(),
      ],
    );
  }

  Widget _buildFoodGridIllustration() {
    return Center(
      child: SizedBox(
        width: 320,
        height: 320,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background glow
            Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    Colors.orange.shade200.withValues(alpha: 0.2),
                    Colors.transparent,
                  ],
                ),
                borderRadius: BorderRadius.circular(40),
              ),
            ),
            // Glass container with food grid
            GlassCard(
              borderRadius: const BorderRadius.all(Radius.circular(28)),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Top row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildFoodItem('130', '130'),
                      _buildFoodItem('130', '130'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Middle row (offset)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(width: 50),
                      _buildFoodItem('130', '130'),
                      const SizedBox(width: 50),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Bottom row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildFoodItem('130', '130'),
                      _buildFoodItem('130', '130'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodItem(String width, String height) {
    return Container(
      width: double.tryParse(width) ?? 130,
      height: double.tryParse(height) ?? 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          color: Colors.orange.shade100,
          child: const Center(
            child: Text(
              '🍔',
              style: TextStyle(fontSize: 40),
            ),
          ),
        ),
      ),
    );
  }

  // Slide 2: Order in Seconds
  Widget _buildOrderSlide() {
    return Column(
      children: [
        const Spacer(),
        // Phone illustration
        _buildPhoneIllustration(),
        const SizedBox(height: 32),
        // Text content
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'Order in\n',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                    color: GlassTheme.textPrimary,
                  ),
                ),
                TextSpan(
                  text: 'Seconds',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                    color: GlassTheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Browse menus, customize your meal, and checkout instantly with our streamlined cart.',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            height: 1.5,
            color: Colors.grey.shade600,
          ),
          textAlign: TextAlign.center,
        ),
        const Spacer(),
      ],
    );
  }

  Widget _buildPhoneIllustration() {
    return Center(
      child: SizedBox(
        width: 280,
        height: 380,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background glows
            Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    Colors.orange.shade200.withValues(alpha: 0.15),
                    Colors.transparent,
                  ],
                ),
                borderRadius: BorderRadius.circular(120),
              ),
            ),
            // Phone frame
            Container(
              width: 220,
              height: 400,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withValues(alpha: 0.7),
                    Colors.white.withValues(alpha: 0.4),
                  ],
                ),
                borderRadius: BorderRadius.circular(40),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.8),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.shade200.withValues(alpha: 0.3),
                    blurRadius: 30,
                    offset: const Offset(0, 15),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Status bar
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black.withValues(alpha: 0.05),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Container(
                          width: 60,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: Colors.orange.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.shopping_bag_outlined,
                            size: 16,
                            color: Colors.orange.shade600,
                          ),
                        ),
                      ],
                      ),
                    ),
                  ),
                  // Cart items
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          // Item 1
                          _buildCartItem('🍔', 'Burger', '\$8.99', false),
                          const SizedBox(height: 12),
                          // Item 2
                          _buildCartItem('🥗', 'Salad', '\$6.49', false),
                          const SizedBox(height: 12),
                          // Item 3 (selected)
                          _buildCartItem('🍕', 'Pizza', '\$12.99', true),
                          const Spacer(),
                          // Total
                          _buildCartTotal(),
                        ],
                      ),
                    ),
                  ),
                  // Bottom bar
                  Container(
                    height: 50,
                    margin: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade600,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(
                      child: Text(
                        'Checkout',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Floating elements
            Positioned(
              top: 60,
              right: 20,
              child: _buildFloatingIcon('🥤', 45),
            ),
            Positioned(
              bottom: 100,
              left: 10,
              child: _buildFloatingIcon('🍩', 45),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItem(
      String emoji, String name, String price, bool isSelected) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isSelected
            ? Colors.white.withValues(alpha: 0.6)
            : Colors.white.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected
              ? Colors.orange.shade300
              : Colors.white.withValues(alpha: 0.5),
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: Colors.orange.shade200.withValues(alpha: 0.2),
                  blurRadius: 8,
                ),
              ]
            : null,
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.orange.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                emoji,
                style: const TextStyle(fontSize: 22),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                price,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
          const Spacer(),
          if (!isSelected)
            Row(
              children: [
                _buildQuantityButton('-'),
                const SizedBox(width: 8),
                const Text(
                  '1',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
                _buildQuantityButton('+'),
              ],
            )
          else
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.orange.shade600,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.check,
                size: 14,
                color: Colors.white,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildQuantityButton(String text) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
          ),
        ],
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildCartTotal() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Subtotal',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade500,
              ),
            ),
            Text(
              '\$28.47',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Delivery',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '\$2.99',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFloatingIcon(String emoji, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.6),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
          ),
        ],
      ),
      child: Center(
        child: Text(
          emoji,
          style: TextStyle(fontSize: size * 0.45),
        ),
      ),
    );
  }

  // Slide 3: Track Every Step
  Widget _buildTrackSlide() {
    return Column(
      children: [
        const Spacer(),
        // Map illustration
        _buildMapIllustration(),
        const SizedBox(height: 24),
        // Text content
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'Track Every\n',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                    color: GlassTheme.textPrimary,
                  ),
                ),
                TextSpan(
                  text: 'Step',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                    color: GlassTheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Watch your food travel from the kitchen to your doorstep in real-time with live GPS tracking.',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            height: 1.5,
            color: Colors.grey.shade600,
          ),
          textAlign: TextAlign.center,
        ),
        const Spacer(),
      ],
    );
  }

  Widget _buildMapIllustration() {
    return Center(
      child: SizedBox(
        width: 300,
        height: 300,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Map container
            Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(32),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.5),
                ),
              ),
              child: CustomPaint(
                size: const Size(280, 280),
                painter: MapPathPainter(),
              ),
            ),
            // Driver marker
            Positioned(
              top: 80,
              right: 60,
              child: _buildDriverMarker(),
            ),
            // Restaurant marker
            Positioned(
              bottom: 50,
              left: 60,
              child: _buildRestaurantMarker(),
            ),
            // Driver status badge
            Positioned(
              bottom: 70,
              left: 80,
              child: _buildDriverStatusBadge(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDriverStatusBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 6),
          const Text(
            'Driver nearby',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDriverMarker() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.orange.shade200.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Text(
            '🛵',
            style: TextStyle(fontSize: 32),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
          ),
          child: const Text(
            '5m',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRestaurantMarker() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 2,
        ),
      ),
      child: Icon(
        Icons.location_on,
        color: Colors.orange.shade600,
        size: 24,
      ),
    );
  }
}

/// Custom painter for map path
class MapPathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Background path
    final bgPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.3)
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..moveTo(size.width * 0.2, size.height * 0.75)
      ..quadraticBezierTo(
        size.width * 0.3,
        size.height * 0.55,
        size.width * 0.5,
        size.height * 0.55,
      )
      ..quadraticBezierTo(
        size.width * 0.65,
        size.height * 0.55,
        size.width * 0.78,
        size.height * 0.25,
      );

    canvas.drawPath(path, bgPaint);

    // Dashed path on top
    final dashedPaint = Paint()
      ..color = Colors.orange.shade600!
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, dashedPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
