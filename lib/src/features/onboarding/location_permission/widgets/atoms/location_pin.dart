import 'package:flutter/material.dart';
import '../../../../../ui/theme/glass_theme.dart';

/// LocationPin - Animated location pin atom
///
/// Features:
/// - Pulsing rings animation around the pin
/// - Bouncing animation for the pin itself
/// - Gradient background for the inner icon
/// - Glassmorphism outer container
class LocationPin extends StatefulWidget {
  final AnimationController pulseController;
  final AnimationController bounceController;

  const LocationPin({
    super.key,
    required this.pulseController,
    required this.bounceController,
  });

  @override
  State<LocationPin> createState() => _LocationPinState();
}

class _LocationPinState extends State<LocationPin> {
  static const double _pinSize = 90;
  static const double _iconSize = 56;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 180,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Pulse rings - positioned at center
          _PulseRing(
            baseSize: 60,
            index: 2,
            animation: widget.pulseController,
            maxExpansion: 220,
          ),
          _PulseRing(
            baseSize: 60,
            index: 1,
            animation: widget.pulseController,
            maxExpansion: 220,
          ),
          _PulseRing(
            baseSize: 60,
            index: 0,
            animation: widget.pulseController,
            maxExpansion: 220,
          ),

          // Main pin container with bounce animation
          AnimatedBuilder(
            animation: widget.bounceController,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, -10 + widget.bounceController.value * 10),
                child: child,
              );
            },
            child: _PinContent(size: _pinSize, iconSize: _iconSize),
          ),
        ],
      ),
    );
  }
}

/// Pulse ring widget - creates expanding ring animation
class _PulseRing extends StatelessWidget {
  final double baseSize;
  final int index;
  final AnimationController animation;
  final double maxExpansion;

  const _PulseRing({
    required this.baseSize,
    required this.index,
    required this.animation,
    this.maxExpansion = 220,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final expansion = animation.value * maxExpansion;
        final currentSize = baseSize + expansion;
        final opacity = 0.8 - (index * 0.15) - (animation.value * 0.5);

        return Center(
          child: Container(
            width: currentSize,
            height: currentSize,
            decoration: BoxDecoration(
              border: Border.all(
                color: GlassTheme.primary.withValues(alpha: opacity > 0 ? opacity : 0),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(currentSize / 2),
              boxShadow: [
                BoxShadow(
                  color: GlassTheme.primary.withValues(alpha: 0.1),
                  blurRadius: 20,
                  spreadRadius: 0,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Pin content - the glass container with the location icon
class _PinContent extends StatelessWidget {
  final double size;
  final double iconSize;

  const _PinContent({required this.size, required this.iconSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: 0.9),
            Colors.white.withValues(alpha: 0.4),
          ],
        ),
        borderRadius: BorderRadius.circular(size * 0.33),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.6),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: GlassTheme.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Center(
        child: _LocationIcon(size: iconSize),
      ),
    );
  }
}

/// Location icon - the orange gradient icon inside the pin
class _LocationIcon extends StatelessWidget {
  final double size;

  const _LocationIcon({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            GlassTheme.primary,
            Color(0xFFFF7A45),
          ],
        ),
        borderRadius: BorderRadius.circular(size * 0.285),
        boxShadow: [
          BoxShadow(
            color: GlassTheme.primary.withValues(alpha: 0.4),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Icon(
        Icons.location_on,
        size: 28,
        color: Colors.white,
      ),
    );
  }
}

/// Simplified location pin for compact usage
class LocationPinCompact extends StatelessWidget {
  final double size;
  final VoidCallback? onTap;

  const LocationPinCompact({
    super.key,
    this.size = 48,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              GlassTheme.primary,
              Color(0xFFFF7A45),
            ],
          ),
          borderRadius: BorderRadius.circular(size * 0.33),
          boxShadow: [
            BoxShadow(
              color: GlassTheme.primary.withValues(alpha: 0.4),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(
          Icons.location_on,
          size: size * 0.5,
          color: Colors.white,
        ),
      ),
    );
  }
}
