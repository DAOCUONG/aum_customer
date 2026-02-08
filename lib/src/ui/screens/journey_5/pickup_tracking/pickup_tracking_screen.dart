import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../atoms/glass_button.dart';
import '../../../theme/glass_design_system.dart';

class PickupTrackingScreen extends StatefulWidget {
  const PickupTrackingScreen({super.key});

  @override
  State<PickupTrackingScreen> createState() => _PickupTrackingScreenState();
}

class _PickupTrackingScreenState extends State<PickupTrackingScreen> {
  int _currentStatus = 1;

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
            // Hero background image
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: MediaQuery.of(context).size.height * 0.42,
              child: Container(
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuBA0j22lNKxtfqsXNccc3ZVkbnAtmbb8Sij85QbemFv1OWSpkki-N6mRXvsWTLA9b25KUIVdEuaWaV3zSl7DpTkKd-VYdrIxkXDbRKe9VofT0XeyheVRl7_sFW0Op_j_T07NMr3BBHe3QRuHivcKdY5H7s6oFVod3zC5UEfO9Xkh3fY02sJ_Y22L8ZPxOmFMMgyNyCuymBsdVtYg71nDvcYOI9eDaPi8QAtTA4i3GgO_fffRW7e9fmGmEdhdYZ61RGBXdWVTQyf9SI',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.white.withValues(alpha: 0.3),
                        Colors.white.withValues(alpha: 0.7),
                        Colors.white,
                      ],
                      stops: const [0.0, 0.5, 0.8, 1.0],
                    ),
                  ),
                ),
              ),
            ),
            // Content
            Column(
              children: [
                // Header
                _buildHeader(),
                // Restaurant info
                _buildRestaurantInfo(),
                // Scrollable content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        // Estimated pickup card
                        _buildPickupCard(),
                        const SizedBox(height: 16),
                        // Timeline
                        _buildTimeline(),
                        const SizedBox(height: 16),
                        // Location card
                        _buildLocationCard(),
                        const SizedBox(height: 16),
                        // Order items
                        _buildOrderItems(),
                        const SizedBox(height: 120),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Bottom buttons
            _buildBottomButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 16),
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
              ),
              child: const Text(
                'ORDER #2938',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: textPrimary,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            GlassButton.icon(
              onPressed: () {},
              icon: Icons.more_horiz,
              size: 40,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRestaurantInfo() {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withValues(alpha: 0.6)),
            boxShadow: [glassShadow],
          ),
          child: const Image(
            image: NetworkImage(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuDfv1ebscDLfGocUxoBkQYuuGU6uYXlweuQIOpsOcO4J4qu8RDuday_GRlT30UdnIJrB7lSxUUs2XZkIWLfrg7ofdoXd1MI6A0bLrNFeXPXJ2dErOZIeVkEAauKyUn2S_lR6054ezARAfwSgRnSMw0Lji53dE5RiLRC5NK-6QV_yByKWumaJAxPN-MsdvVY0_Ez7Xv75VGXNfsmCC9Cf4p3bV1AjbYvx851kEPcvuHCuoNZ38q_6k6ZsOONrDC8p-qbrWTUa0xStkg',
            ),
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          "Joe's Diner",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            color: textPrimary,
          ),
        ),
        Text(
          'American • Burgers • Shakes',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildPickupCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.75),
        borderRadius: const BorderRadius.all(Radius.circular(32)),
        border: Border.all(color: Colors.white.withValues(alpha: 0.8)),
        boxShadow: [glassShadow],
      ),
      child: Column(
        children: [
          Text(
            'Estimated Pickup',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: textSecondary,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'Ready in ',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: textPrimary,
                  ),
                ),
                TextSpan(
                  text: '8 min',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '12:45 PM - 12:55 PM',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline() {
    final statusItems = [
      {'icon': Icons.check, 'title': 'Order Confirmed', 'subtitle': '12:28 PM', 'completed': true},
      {'icon': Icons.sync, 'title': 'Preparing Your Food', 'subtitle': 'The kitchen is working on your order right now.', 'completed': true, 'active': true},
      {'icon': Icons.shopping_bag, 'title': 'Ready for Pickup', 'subtitle': 'Est. 12:45 PM', 'completed': false},
    ];

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.5),
        borderRadius: const BorderRadius.all(Radius.circular(32)),
        border: Border.all(color: Colors.white.withValues(alpha: 0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.list_alt, size: 18, color: textSecondary),
              const SizedBox(width: 8),
              const Text(
                'Order Status',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Timeline
          Stack(
            children: [
              // Vertical line
              Positioned(
                left: 15,
                top: 24,
                bottom: 24,
                child: Container(
                  width: 2,
                  color: Colors.black.withValues(alpha: 0.1),
                ),
              ),
              // Progress line
              Positioned(
                left: 15,
                top: 24,
                height: 80,
                child: Container(
                  width: 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [successGreen, primaryColor],
                    ),
                  ),
                ),
              ),
              // Items
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(statusItems.length, (index) {
                  final item = statusItems[index];
                  final isActive = item['active'] == true;
                  final isCompleted = item['completed'] == true;
                  final opacity = isCompleted ? 1.0 : (isActive ? 1.0 : 0.4);

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: isCompleted
                                ? successGreen
                                : (isActive ? primaryColor : Colors.white),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isCompleted
                                  ? successGreen
                                  : (isActive ? primaryColor : Colors.grey.shade300),
                              width: 2,
                            ),
                            boxShadow: isActive
                                ? [
                                    BoxShadow(
                                      color: primaryColor.withValues(alpha: 0.3),
                                      blurRadius: 8,
                                    ),
                                  ]
                                : null,
                          ),
                          child: Icon(
                            item['icon'] as IconData,
                            size: 16,
                            color: (isCompleted || isActive) ? Colors.white : Colors.grey.shade400,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Opacity(
                            opacity: opacity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['title'] as String,
                                  style: TextStyle(
                                    fontSize: isActive ? 17 : 14,
                                    fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
                                    color: textPrimary,
                                  ),
                                ),
                                if (item['subtitle'] != null)
                                  Text(
                                    item['subtitle'] as String,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: textSecondary,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLocationCard() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.5),
          borderRadius: const BorderRadius.all(Radius.circular(24)),
          border: Border.all(color: Colors.white.withValues(alpha: 0.6)),
        ),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
              ),
              child: Icon(
                Icons.location_on,
                size: 24,
                color: primaryColor,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '142 West Street',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: textPrimary,
                    ),
                  ),
                  Text(
                    'New York, NY 10013 • 0.8 mi away',
                    style: TextStyle(
                      fontSize: 12,
                      color: textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        'Get Directions',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: primaryColor,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        size: 14,
                        color: primaryColor,
                      ),
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

  Widget _buildOrderItems() {
    final items = [
      {'name': 'Classic Cheeseburger', 'quantity': 1},
      {'name': 'Sweet Potato Fries', 'quantity': 1},
      {'name': 'Vanilla Milkshake', 'quantity': 1},
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.5),
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        border: Border.all(color: Colors.white.withValues(alpha: 0.6)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order Items (${items.length})',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: textPrimary,
                ),
              ),
              const Text(
                '\$42.50',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...List.generate(items.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
                    ),
                    child: Text(
                      '${items[index]['quantity']}x',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      items[index]['name'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        color: textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 16),
          Divider(color: Colors.black.withValues(alpha: 0.05)),
          const SizedBox(height: 8),
          Center(
            child: TextButton(
              onPressed: () {},
              child: Text(
                'View Receipt',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButtons() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GlassButton.primary(
                onPressed: () {},
                icon: Icons.storefront,
                label: "I'm Here to Pickup",
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildIconButton(Icons.call, 'Call'),
                  const SizedBox(width: 48),
                  _buildIconButton(Icons.help, 'Support'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.white.withValues(alpha: 0.6)),
          ),
          child: Icon(
            icon,
            size: 22,
            color: textSecondary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: textSecondary,
          ),
        ),
      ],
    );
  }
}
