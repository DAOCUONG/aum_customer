import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../atoms/glass_button.dart';
import '../../../molecules/glass_rewards_components.dart';
import '../../../theme/glass_design_system.dart';

class RewardsDashboardScreen extends StatefulWidget {
  const RewardsDashboardScreen({super.key});

  @override
  State<RewardsDashboardScreen> createState() => _RewardsDashboardScreenState();
}

class _RewardsDashboardScreenState extends State<RewardsDashboardScreen> {
  int _selectedIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: meshGradient,
        ),
        child: Stack(
          children: [
            Column(
              children: [
                // Header
                _buildHeader(),
                // Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        // Progress card
                        const GlassProgressCard(
                          currentPoints: '2,450',
                          tierName: 'Silver Member',
                          nextTierName: 'Gold',
                          pointsNeeded: '550',
                          progress: 0.82,
                        ),
                        const SizedBox(height: 24),
                        // Available rewards header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Available Rewards',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: textPrimary,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'See All',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Available rewards list
                        const GlassRewardCard(
                          title: 'Free Classic Burger',
                          subtitle: 'Valid for any classic burger',
                          points: '1,500 pts',
                          emoji: '🍔',
                          emojiGradientStart: Color(0xFFFFE0B2),
                          emojiGradientEnd: Color(0xFFFFF9C4),
                        ),
                        const SizedBox(height: 12),
                        const GlassRewardCard(
                          title: 'Free Delivery',
                          subtitle: 'For your next 3 orders',
                          points: '500 pts',
                          emoji: '🚚',
                          emojiGradientStart: Color(0xFFBBDEFB),
                          emojiGradientEnd: Color(0xFFE3F2FD),
                        ),
                        const SizedBox(height: 12),
                        const GlassRewardCard(
                          title: '\$10 Off Pizza',
                          subtitle: 'Any large pizza order',
                          points: '2,000 pts',
                          emoji: '🍕',
                          emojiGradientStart: Color(0xFFFFCDD2),
                          emojiGradientEnd: Color(0xFFFCE4EC),
                        ),
                        const SizedBox(height: 24),
                        // Unlock soon header
                        const Text(
                          'Unlock Soon',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: textPrimary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Locked rewards
                        const GlassRewardCard(
                          title: 'Premium Sushi Set',
                          subtitle: '',
                          points: '3,500 pts',
                          emoji: '🍱',
                          emojiGradientStart: Colors.grey,
                          emojiGradientEnd: Colors.grey,
                          isLocked: true,
                        ),
                        const SizedBox(height: 12),
                        const GlassRewardCard(
                          title: 'Birthday Special',
                          subtitle: '',
                          points: '5,000 pts',
                          emoji: '🎂',
                          emojiGradientStart: Colors.grey,
                          emojiGradientEnd: Colors.grey,
                          isLocked: true,
                        ),
                        const SizedBox(height: 120),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Bottom navigation
            _buildBottomNavigation(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.6),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GlassButton.icon(
              onPressed: () => context.pop(),
              icon: Icons.arrow_back,
              size: 40,
            ),
            const Text(
              'Rewards',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: textPrimary,
              ),
            ),
            GlassButton.icon(
              onPressed: () {},
              icon: Icons.history,
              size: 40,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white.withValues(alpha: 0.0),
              Colors.white.withValues(alpha: 0.3),
              Colors.white.withValues(alpha: 0.6),
              Colors.white.withValues(alpha: 0.9),
            ],
          ),
        ),
        child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home, 'Home', 0),
              _buildNavItem(Icons.search, 'Browse', 1),
              _buildCenterNavItem(),
              _buildNavItem(Icons.star, 'Rewards', 3, isSelected: true),
              _buildNavItem(Icons.person, 'Profile', 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index, {bool isSelected = false}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 24,
            color: isSelected ? primaryColor : Colors.grey.shade400,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: isSelected ? primaryColor : Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCenterNavItem() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(
          Icons.shopping_bag,
          size: 24,
          color: Colors.white,
        ),
      ),
    );
  }
}
