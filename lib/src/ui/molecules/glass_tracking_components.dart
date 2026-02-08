import 'package:flutter/material.dart';
import '../atoms/glass_button.dart';
import '../theme/glass_design_system.dart';

/// Glass Timeline Status Item for order tracking
class GlassTimelineItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final bool isCompleted;
  final bool isActive;
  final bool isLast;

  const GlassTimelineItem({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.isCompleted = false,
    this.isActive = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            // Timeline connector
            if (!isLast)
              Container(
                width: 2,
                height: 24,
                margin: const EdgeInsets.only(bottom: 4),
                decoration: BoxDecoration(
                  gradient: isCompleted
                      ? const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [successGreen, primaryColor],
                        )
                      : null,
                  color: isCompleted ? null : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            // Status icon
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: _getBackgroundColor(),
                border: Border.all(color: _getBorderColor(), width: 2),
                borderRadius: BorderRadius.circular(16),
                boxShadow: isActive
                    ? [
                        BoxShadow(
                          color: primaryColor.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: Icon(
                icon,
                size: 16,
                color: _getIconColor(),
              ),
            ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
                    color: isActive ? primaryColor : textPrimary,
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle!,
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
    );
  }

  Color _getBackgroundColor() {
    if (isCompleted) return successGreen;
    if (isActive) return primaryColor;
    return Colors.white;
  }

  Color _getBorderColor() {
    if (isCompleted) return successGreen;
    if (isActive) return primaryColor;
    return Colors.grey.shade300;
  }

  Color _getIconColor() {
    if (isCompleted || isActive) return Colors.white;
    return Colors.grey.shade400;
  }
}

/// Glass Map Placeholder for tracking screens
class GlassMapPlaceholder extends StatelessWidget {
  final VoidCallback? onLocationTap;

  const GlassMapPlaceholder({super.key, this.onLocationTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onLocationTap,
      child: Container(
        height: 220,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          image: const DecorationImage(
            image: NetworkImage(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuAkFHy5xAdt3Zs7V4v0eOHRdFPA89NkeOd7OT3XhqTddNm2zBxnu0-Q65QPePUkeUkm1n2lo4F2O80fjXjCxZ50Egb4C_CPWos8-TFj50oBAC5_q5-l30HHWusT6udvFzVdF21TzHZE26VrHCPBe-P_wQTEwD-2Z_7pBMkQHmZTAzOH1IXNrIF-TzhB70zG_rus4nb-tXhg3XhnHtaJNfO6TuTpftX4pQis6ieiRIgwv1lkxei9y8kiSoqvD5pQo8dCxugW_p3dwmQ',
            ),
            fit: BoxFit.cover,
          ),
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(24),
          ),
        ),
        child: Stack(
          children: [
            // Grid overlay effect
            Positioned.fill(
              child: CustomPaint(
                painter: GridOverlayPainter(),
              ),
            ),
            // Restaurant marker
            Positioned(
              top: 60,
              left: 60,
              child: _buildMarker(
                icon: Icons.restaurant,
                label: 'Foodie Express',
              ),
            ),
            // Driver marker with pulse
            Positioned(
              top: 120,
              left: 160,
              child: _buildDriverMarker(),
            ),
            // Home marker
            Positioned(
              bottom: 60,
              right: 80,
              child: _buildMarker(
                icon: Icons.location_on,
                label: 'Home',
              ),
            ),
            // Gradient overlay at bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 60,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withValues(alpha: 0.3),
                      Colors.white.withValues(alpha: 0.6),
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

  Widget _buildMarker({required IconData icon, required String label}) {
    return Column(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            icon,
            size: 18,
            color: primaryColor,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w600,
              color: textPrimary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDriverMarker() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // Pulse effect
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: primaryColor.withValues(alpha: 0.2),
              ),
            ),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withValues(alpha: 0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(14)),
                child: Image(
                  image: NetworkImage(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuDrTAbWkngsaWBd_eCoPqKD3VNe9NgtawbK7ttK39xPAlk5EDLkNcoEU_FzatGZaUokwVy1xh9EoeoeiVmGeGogKF_ns6UhnHsJSBoVyEg3LMbpXOSAXRgl7d1d_QmyjMf0lKw5DJN64xiIxrJNX-8B0bcLj78i8IYQHZEmad9NK9_TG118pFB5g4k1WBesBxGuWMEYfg-fw9v345KOsh_TpXa7YNywnsyOG-FUsIOuIiOQkJ2Sslx_1_ifUSFwXyUWMDGgreWk2Vk',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.black87.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Text(
            'Sarah M.',
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
}

/// Grid overlay painter for map effect
class GridOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withValues(alpha: 0.03)
      ..strokeWidth = 1;

    const gridSize = 40.0;

    // Vertical lines
    for (double x = 0; x <= size.width; x += gridSize) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }

    // Horizontal lines
    for (double y = 0; y <= size.height; y += gridSize) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

/// Glass Progress Bar for delivery tracking
class GlassProgressBar extends StatelessWidget {
  final double progress;
  final List<IconData> icons;

  const GlassProgressBar({
    super.key,
    required this.progress,
    required this.icons,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Background line
        Container(
          height: 4,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        // Progress line
        Container(
          height: 4,
          width: MediaQuery.of(context).size.width * progress,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange.shade400, primaryColor],
            ),
            borderRadius: BorderRadius.circular(2),
            boxShadow: [
              BoxShadow(
                color: primaryColor.withValues(alpha: 0.5),
                blurRadius: 8,
                offset: const Offset(0, 1),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Glass Driver Card for delivery info
class GlassDriverCard extends StatelessWidget {
  final String name;
  final String rating;
  final String vehicle;
  final String avatarUrl;
  final VoidCallback? onCallTap;
  final VoidCallback? onMessageTap;

  const GlassDriverCard({
    super.key,
    required this.name,
    required this.rating,
    required this.vehicle,
    required this.avatarUrl,
    this.onCallTap,
    this.onMessageTap,
  });

  @override
  Widget build(BuildContext context) {
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
            children: [
              // Avatar with online indicator
              Stack(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(26),
                      child: Image(
                        image: NetworkImage(avatarUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: successGreen,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 12,
                          color: Colors.amber.shade600,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          rating,
                          style: TextStyle(
                            fontSize: 12,
                            color: textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '•',
                          style: TextStyle(
                            color: Colors.grey.shade400,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          vehicle,
                          style: TextStyle(
                            fontSize: 12,
                            color: textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Action buttons
          Row(
            children: [
              Expanded(
                child: GlassButton(
                  onPressed: onCallTap ?? () {},
                  label: 'Call',
                  icon: Icons.call,
                  backgroundColor: Colors.white,
                  foregroundColor: textPrimary,
                  customShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GlassButton.primary(
                  onPressed: onMessageTap ?? () {},
                  label: 'Message',
                  icon: Icons.chat_bubble,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
