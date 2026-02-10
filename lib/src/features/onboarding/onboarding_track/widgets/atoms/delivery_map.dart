import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import '../../../../../ui/theme/glass_theme.dart';

/// DeliveryMap - Glass-styled map container with route visualization
///
/// ATOM component displaying a stylized delivery route with:
/// - Glass map container with blur effect
/// - Curved SVG path from bottom-left to top-right
/// - Pulsing destination marker
/// - Delivery scooter with ETA badge
/// - Driver nearby indicator
class DeliveryMap extends StatefulWidget {
  final double width;
  final double height;
  final double rotation;

  const DeliveryMap({
    super.key,
    this.width = 280,
    this.height = 280,
    this.rotation = 3,
  });

  @override
  State<DeliveryMap> createState() => _DeliveryMapState();
}

class _DeliveryMapState extends State<DeliveryMap> with TickerProviderStateMixin {
  late AnimationController _routeController;
  late Animation<double> _routeAnimation;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _routeController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _routeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _routeController, curve: Curves.easeInOutCubic),
    );
    _routeController.forward();

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _routeController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: widget.rotation * (math.pi / 180),
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.5),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.3),
              blurRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              color: Colors.white.withValues(alpha: 0.3),
              child: Stack(
                children: [
                  // Grid pattern overlay
                  _buildGridPattern(),
                  // Route visualization
                  _buildRoute(),
                  // Start point
                  _buildStartPoint(),
                  // Destination marker with pulse
                  _buildDestinationMarker(),
                  // Delivery scooter
                  _buildDeliveryScooter(),
                  // Driver nearby indicator
                  _buildDriverIndicator(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGridPattern() {
    return Positioned.fill(
      child: CustomPaint(
        painter: GridPatternPainter(),
      ),
    );
  }

  Widget _buildRoute() {
    return AnimatedBuilder(
      animation: _routeController,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.width, widget.height),
          painter: RoutePainter(
            progress: _routeAnimation.value,
          ),
        );
      },
    );
  }

  Widget _buildStartPoint() {
    return Positioned(
      left: 40,
      bottom: 40,
      child: Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: Colors.grey.shade300,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDestinationMarker() {
    return Positioned(
      top: 50,
      right: 30,
      child: Column(
        children: [
          // Pulsing ring
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Container(
                width: 24 + (_pulseController.value * 16),
                height: 24 + (_pulseController.value * 16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: GlassTheme.primary.withValues(
                    alpha: 0.2 * (1 - _pulseController.value),
                  ),
                ),
              );
            },
          ),
          // Main marker
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: GlassTheme.primary,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: GlassTheme.primary.withValues(alpha: 0.4),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryScooter() {
    return AnimatedBuilder(
      animation: _routeAnimation,
      builder: (context, child) {
        // Calculate position along the route
        final t = _routeAnimation.value;
        // Cubic bezier interpolation
        final start = Offset(40, widget.height - 40);
        final end = Offset(widget.width - 30, 50);
        final cp1 = Offset(80, widget.height - 80);
        final cp2 = Offset(200, widget.height - 120);

        final x = _cubicBezier(t, start.dx, cp1.dx, cp2.dx, end.dx);
        final y = _cubicBezier(t, start.dy, cp1.dy, cp2.dy, end.dy);

        return Positioned(
          left: x - 24,
          top: y - 24,
          child: child!,
        );
      },
      child: _ScooterBadge(),
    );
  }

  Widget _buildDriverIndicator() {
    return Positioned(
      bottom: 40,
      left: 60,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.5),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedBuilder(
              animation: _pulseController,
              builder: (context, child) {
                return Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: GlassTheme.success,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: GlassTheme.success.withValues(alpha: 0.6),
                        blurRadius: 6,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(width: 6),
            Text(
              'Driver nearby',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: GlassTheme.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _cubicBezier(double t, double p0, double p1, double p2, double p3) {
    final mt = 1 - t;
    return mt * mt * mt * p0 +
        3 * mt * mt * t * p1 +
        3 * mt * t * t * p2 +
        t * t * t * p3;
  }
}

/// Grid pattern for map background
class GridPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withValues(alpha: 0.05)
      ..strokeWidth = 1;

    const gridSize = 40.0;

    // Vertical lines
    for (double x = 0; x < size.width; x += gridSize) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }

    // Horizontal lines
    for (double y = 0; y < size.height; y += gridSize) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Route path painter with animated dash
class RoutePainter extends CustomPainter {
  final double progress;

  RoutePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(52, size.height - 52);
    path.cubicTo(
      52, size.height - 52,
      92, size.height - 92,
      152, size.height - 92,
    );
    path.cubicTo(
      212, size.height - 92,
      192, size.height - 172,
      252, size.height - 212,
    );

    // Draw white base path
    final basePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.8)
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 2);

    canvas.drawPath(path, basePaint);

    // Draw dashed orange path
    final dashPaint = Paint()
      ..color = GlassTheme.primary
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // Create dashed path
    final dashPath = _createDashedPath(path, dashLength: 10, gapLength: 10);

    // Clip path to show only portion based on progress
    final clipPath = Path();
    final metrics = path.computeMetrics().first;
    final clipLength = metrics.length * progress;
    clipPath.addPath(metrics.extractPath(0, clipLength), Offset.zero);

    canvas.save();
    canvas.clipPath(clipPath);
    canvas.drawPath(dashPath, dashPaint);
    canvas.restore();
  }

  Path _createDashedPath(Path original, {required double dashLength, required double gapLength}) {
    final dashedPath = Path();
    final metrics = original.computeMetrics().first;

    for (double distance = 0; distance < metrics.length;) {
      final remaining = metrics.length - distance;
      final segmentLength = math.min(dashLength, remaining);

      final start = metrics.getTangentForOffset(distance)!;

      dashedPath.addArc(
        Rect.fromCenter(
          center: start.position,
          width: segmentLength,
          height: segmentLength,
        ),
        0,
        2 * math.pi,
      );

      distance += segmentLength + gapLength;
    }

    return dashedPath;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      oldDelegate is RoutePainter && oldDelegate.progress != progress;
}

/// Scooter badge with ETA
class _ScooterBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.6),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '🛵',
            style: TextStyle(
              fontSize: 24,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}

/// Pulsing delivery marker
class PulsingDeliveryMarker extends StatelessWidget {
  final String emoji;
  final String eta;
  final Color? ringColor;

  const PulsingDeliveryMarker({
    super.key,
    this.emoji = '🛵',
    this.eta = '5m',
    this.ringColor,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AlwaysStoppedAnimation(0.5)..addListener(() {}),
      builder: (context, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.6),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                emoji,
                style: const TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
            // ETA badge
            Positioned(
              bottom: -4,
              right: -4,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                  color: GlassTheme.success,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.white,
                    width: 1,
                  ),
                ),
                child: Text(
                  eta,
                  style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
