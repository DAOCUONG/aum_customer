import 'dart:ui';

import 'package:flutter/material.dart';
import '../../../../../ui/theme/glass_theme.dart';
import '../atoms/glass_phone.dart';
import '../molecules/cart_item.dart';

/// OrderVisual - Main visual area showing phone with cart items
class OrderVisual extends StatelessWidget {
  const OrderVisual({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GlassPhone(
          child: Column(
            children: [
              const PhoneHeader(),
              PhoneContent(
                child: Column(
                  children: const [
                    CartItem(emoji: '🍔', name: 'Classic Burger', price: '\$12', quantity: 1, isSelected: true),
                    SizedBox(height: 12),
                    CartItem(emoji: '🥗', name: 'Fresh Salad', price: '\$8', quantity: 0, isSelected: true),
                    SizedBox(height: 12),
                    CartItem(emoji: '🍕', name: 'Pepperoni Pizza', originalPrice: '\$18', price: '\$15', quantity: 1, isSelected: true, showPromo: true),
                  ],
                ),
              ),
              PhoneFooter(
                height: 70,
                child: Padding(padding: const EdgeInsets.all(16), child: const CartSummary(subtotal: '\$35', deliveryFee: '\$3', total: '\$38')),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// DecorativeFloatingElement - Floating emoji decoration
class DecorativeFloatingElement extends StatelessWidget {
  final String emoji;
  final double top;
  final double right;
  final double bottom;
  final double left;
  final double rotation;
  final double size;

  const DecorativeFloatingElement({
    super.key,
    required this.emoji,
    this.top = 0, this.right = 0, this.bottom = 0, this.left = 0,
    this.rotation = 12, this.size = 48,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top, right: right, bottom: bottom, left: left,
      child: Transform.rotate(
        angle: rotation * (3.14159 / 180),
        child: Container(
          width: size, height: size,
          decoration: BoxDecoration(
            color: GlassTheme.glassSurface.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withValues(alpha: 0.6), width: 1),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
            child: Center(child: Text(emoji, style: const TextStyle(fontSize: 24))),
          ),
        ),
      ),
    );
  }
}

/// DecorativeAddButton - Floating add button decoration
class DecorativeAddButton extends StatelessWidget {
  final double top;
  final double left;
  final double size;

  const DecorativeAddButton({super.key, this.top = 0, this.left = 0, this.size = 32});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top, left: left,
      child: Container(
        width: size, height: size,
        decoration: BoxDecoration(
          color: GlassTheme.glassSurface.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(size / 2),
          border: Border.all(color: Colors.white.withValues(alpha: 0.6), width: 1),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: const Icon(Icons.add, size: 16, color: GlassTheme.success),
        ),
      ),
    );
  }
}
