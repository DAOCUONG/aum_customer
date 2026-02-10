import 'dart:ui';

import 'package:flutter/material.dart';
import '../../../../../ui/theme/glass_theme.dart';

/// GlassPhone - Glass-styled phone mockup for showcasing cart
class GlassPhone extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  final double rotation;

  const GlassPhone({
    super.key,
    required this.child,
    this.width = 240,
    this.height = 420,
    this.rotation = -6,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation * (3.14159 / 180),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white.withValues(alpha: 0.7),
              Colors.white.withValues(alpha: 0.4),
            ],
          ),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.8),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(36),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(36),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// PhoneHeader - Status bar area for phone mockup
class PhoneHeader extends StatelessWidget {
  const PhoneHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(width: 48, height: 12, decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(6))),
          Container(
            width: 32, height: 32,
            decoration: BoxDecoration(color: GlassTheme.primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
            child: const Icon(Icons.shopping_bag, size: 16, color: GlassTheme.primary),
          ),
        ],
      ),
    );
  }
}

/// PhoneContent - Main content area inside phone
class PhoneContent extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const PhoneContent({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Padding(padding: padding ?? const EdgeInsets.all(16), child: child));
  }
}

/// PhoneFooter - Bottom action area for phone
class PhoneFooter extends StatelessWidget {
  final Widget child;
  final double height;

  const PhoneFooter({super.key, required this.child, this.height = 80});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.8),
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(36), bottomRight: Radius.circular(36)),
      ),
      child: child,
    );
  }
}
