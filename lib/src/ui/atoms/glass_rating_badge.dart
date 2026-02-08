import 'package:flutter/material.dart';
import '../theme/glass_design_system.dart';

/// Glass Rating Badge - Shows rating with star icon
class GlassRatingBadge extends StatelessWidget {
  final double rating;
  final bool showBackground;
  final double fontSize;
  final EdgeInsetsGeometry padding;

  const GlassRatingBadge({
    super.key,
    required this.rating,
    this.showBackground = true,
    this.fontSize = 10,
    this.padding = const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
  });

  @override
  Widget build(BuildContext context) {
    final bool isHighRating = rating >= 4.5;
    final Color bgColor = isHighRating ? ratingGreen : ratingGray;
    final Color textColor = isHighRating ? ratingGreenText : ratingGrayText;

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: showBackground ? bgColor : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: showBackground ? null : Border.all(color: textColor.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star,
            size: fontSize + 2,
            color: textColor,
          ),
          const SizedBox(width: 2),
          Text(
            rating.toStringAsFixed(1),
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}

/// Glass Promo Badge - For promotional items
class GlassPromoBadge extends StatelessWidget {
  final String text;

  const GlassPromoBadge({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: promoBadgeBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: promoBadgeText.withOpacity(0.2)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: promoBadgeText,
        ),
      ),
    );
  }
}

/// Glass Delivery Badge - Shows delivery info
class GlassDeliveryBadge extends StatelessWidget {
  final String text;
  final bool isFree;
  final IconData? icon;

  const GlassDeliveryBadge({
    super.key,
    required this.text,
    this.isFree = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(
            icon,
            size: 12,
            color: isFree ? successGreen : textSecondary,
          ),
          const SizedBox(width: 2),
        ],
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isFree ? successGreen : textSecondary,
          ),
        ),
      ],
    );
  }
}
