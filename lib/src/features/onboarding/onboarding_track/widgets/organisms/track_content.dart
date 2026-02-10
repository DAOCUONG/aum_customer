import 'package:flutter/material.dart';
import '../../../../../ui/atoms/glass_button.dart';
import '../../../../../ui/theme/glass_theme.dart';
import '../atoms/index.dart';
import '../molecules/index.dart';

/// TrackContent - An organism component for the onboarding track screen
///
/// ORGANISM component composing:
/// - Skip button header
/// - Delivery map visualization
/// - Track info (title, description, progress)
/// - Get Started button
class TrackContent extends StatefulWidget {
  final VoidCallback onSkip;
  final VoidCallback onGetStarted;

  const TrackContent({
    super.key,
    required this.onSkip,
    required this.onGetStarted,
  });

  @override
  State<TrackContent> createState() => _TrackContentState();
}

class _TrackContentState extends State<TrackContent>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideAnimation = Tween<double>(begin: 30, end: 0).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
    );
    _slideController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _slideController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _slideAnimation.value),
          child: Opacity(opacity: _fadeAnimation.value, child: child),
        );
      },
      child: Stack(
        children: [
          // Decorative floating elements
          Positioned.fill(
            child: IgnorePointer(
              child: Stack(
                children: [
                  Positioned(
                    top: 0.08 * MediaQuery.of(context).size.height,
                    right: MediaQuery.of(context).size.width * 0.05,
                    child: _buildDecorativeElement(emoji: '📍', rotation: 15),
                  ),
                  Positioned(
                    bottom: 0.15 * MediaQuery.of(context).size.height,
                    left: MediaQuery.of(context).size.width * 0.02,
                    child: _buildDecorativeElement(emoji: '🚗', rotation: -10),
                  ),
                  Positioned(
                    top: 0.25 * MediaQuery.of(context).size.height,
                    left: MediaQuery.of(context).size.width * 0.02,
                    child: _buildDecorativeElement(emoji: '📦', rotation: 8),
                  ),
                ],
              ),
            ),
          ),
          // Main content
          Column(
            children: [
              // Skip button
              _buildSkipButton(),
              const Spacer(),
              // Delivery map
              _buildDeliveryMap(),
              const Spacer(),
              // Track info
              const TrackInfo(
                currentPage: 2,
                totalPages: 3,
              ),
              const Spacer(),
              // Get Started button
              _buildGetStartedButton(),
              const SizedBox(height: 40),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkipButton() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        top: 48,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: widget.onSkip,
            child: Text(
              'Skip',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: GlassTheme.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryMap() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          width: 320,
          height: 320,
          child: DeliveryMap(
            width: 320,
            height: 320,
            rotation: 3,
          ),
        ),
      ),
    );
  }

  Widget _buildGetStartedButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          GlassButton.primary(
            onPressed: widget.onGetStarted,
            label: 'Get Started',
            height: 56,
            textStyle: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDecorativeElement({
    required String emoji,
    required double rotation,
  }) {
    return Transform.rotate(
      angle: rotation * (3.14159 / 180),
      child: Opacity(
        opacity: 0.7,
        child: Text(emoji, style: const TextStyle(fontSize: 40)),
      ),
    );
  }
}
