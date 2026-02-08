import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../atoms/glass_button.dart';
import '../../../molecules/glass_tracking_components.dart';
import '../../../theme/glass_design_system.dart';

class LiveTrackingScreen extends StatefulWidget {
  const LiveTrackingScreen({super.key});

  @override
  State<LiveTrackingScreen> createState() => _LiveTrackingScreenState();
}

class _LiveTrackingScreenState extends State<LiveTrackingScreen> {
  int _currentStatus = 2; // 0: Confirmed, 1: Preparing, 2: Out for Delivery

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
                // Map
                GlassMapPlaceholder(),
                // Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        // Estimated arrival card
                        _buildEstimatedArrivalCard(),
                        const SizedBox(height: 16),
                        // Order status timeline
                        _buildStatusTimeline(),
                        const SizedBox(height: 16),
                        // Driver card
                        GlassDriverCard(
                          name: 'Sarah M.',
                          rating: '4.9 ★',
                          vehicle: 'Toyota Prius',
                          avatarUrl:
                              'https://lh3.googleusercontent.com/aida-public/AB6AXuDrTAbWkngsaWBd_eCoPqKD3VNe9NgtawbK7ttK39xPAlk5EDLkNcoEU_FzatGZaUokwVy1xh9EoeoeiVmGeGogKF_ns6UhnHsJSBoVyEg3LMbpXOSAXRgl7d1d_QmyjMf0lKw5DJN64xiIxrJNX-8B0bcLj78i8IYQHZEmad9NK9_TG118pFB5g4k1WBesBxGuWMEYfg-fw9v345KOsh_TpXa7YNywnsyOG-FUsIOuIiOQkJ2Sslx_1_ifUSFwXyUWMDGgreWk2Vk',
                          onCallTap: () {},
                          onMessageTap: () {},
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ],
            ),
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
                color: Colors.white.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withValues(alpha: 0.6)),
              ),
              child: const Text(
                'ORDER #2490',
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

  Widget _buildEstimatedArrivalCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.7),
        borderRadius: const BorderRadius.all(Radius.circular(32)),
        border: Border.all(color: Colors.white.withValues(alpha: 0.7)),
        boxShadow: [glassShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Estimated Arrival',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: textSecondary,
                  letterSpacing: 0.5,
                ),
              ),
              Icon(
                Icons.schedule,
                size: 18,
                color: primaryColor,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              const Text(
                '12',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  color: textPrimary,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'min',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Latest arrival by 1:45 PM',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          GlassProgressBar(
            progress: 0.75,
            icons: const [
              Icons.check,
              Icons.restaurant,
              Icons.local_shipping,
              Icons.home,
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusTimeline() {
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
              Icon(
                Icons.list_alt,
                size: 18,
                color: textSecondary,
              ),
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
          const SizedBox(height: 24),
          // Timeline items
          GlassTimelineItem(
            icon: Icons.check,
            title: 'Order Confirmed',
            subtitle: '1:15 PM',
            isCompleted: true,
            isLast: false,
          ),
          const SizedBox(height: 24),
          GlassTimelineItem(
            icon: Icons.soup_kitchen,
            title: 'Preparing',
            subtitle: 'Your food is being prepared',
            isCompleted: false,
            isLast: false,
          ),
          const SizedBox(height: 24),
          GlassTimelineItem(
            icon: Icons.local_shipping,
            title: 'Out for Delivery',
            subtitle: 'Sarah is on the way!',
            isCompleted: false,
            isActive: true,
            isLast: true,
          ),
        ],
      ),
    );
  }
}
