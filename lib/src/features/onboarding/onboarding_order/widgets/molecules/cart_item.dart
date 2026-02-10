import 'package:flutter/material.dart';
import '../../../../../ui/theme/glass_theme.dart';

/// CartItem - Individual cart item display
class CartItem extends StatelessWidget {
  final String emoji;
  final String name;
  final String? price;
  final String? originalPrice;
  final int quantity;
  final bool isSelected;
  final bool showPromo;

  const CartItem({
    super.key,
    required this.emoji,
    required this.name,
    this.price,
    this.originalPrice,
    this.quantity = 1,
    this.isSelected = false,
    this.showPromo = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isSelected ? GlassTheme.glassSurface.withValues(alpha: 0.6) : Colors.white.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? GlassTheme.primary.withValues(alpha: 0.3) : Colors.white.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(color: _getEmojiBackgroundColor(), borderRadius: BorderRadius.circular(12)),
            child: Center(child: Text(emoji, style: const TextStyle(fontSize: 20))),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: GlassTheme.textPrimary)),
                if (originalPrice != null && showPromo)
                  Row(
                    children: [
                      Text(originalPrice!, style: TextStyle(fontSize: 11, color: GlassTheme.textTertiary, decoration: TextDecoration.lineThrough)),
                      const SizedBox(width: 4),
                      Text(price!, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: GlassTheme.primary)),
                    ],
                  )
                else if (price != null)
                  Text(price!, style: TextStyle(fontSize: 12, color: GlassTheme.textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getEmojiBackgroundColor() {
    if (emoji == '🍔') return const Color(0xFFFFE4CC);
    if (emoji == '🥗') return const Color(0xFFE8F5E9);
    if (emoji == '🍕') return const Color(0xFFFFE4E4);
    return GlassTheme.glassSurface;
  }
}

/// CartSummary - Subtotal and total display
class CartSummary extends StatelessWidget {
  final String subtotal;
  final String? deliveryFee;
  final String total;

  const CartSummary({super.key, required this.subtotal, this.deliveryFee, required this.total});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Subtotal', style: TextStyle(fontSize: 12, color: GlassTheme.textTertiary)),
          Text(subtotal, style: TextStyle(fontSize: 12, color: GlassTheme.textPrimary)),
        ]),
        if (deliveryFee != null) ...[
          const SizedBox(height: 4),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Delivery', style: TextStyle(fontSize: 12, color: GlassTheme.textTertiary)),
            Text(deliveryFee!, style: TextStyle(fontSize: 12, color: GlassTheme.textPrimary)),
          ]),
        ],
        const SizedBox(height: 8),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Total', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: GlassTheme.textPrimary)),
          Text(total, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: GlassTheme.textPrimary)),
        ]),
      ],
    );
  }
}
