import 'package:flutter/material.dart';
import '../theme/glass_theme.dart';
import '../atoms/glass_badge.dart';

/// GlassPriceTag - Price display component
///
/// Shows current price with optional original price and discount
class GlassPriceTag extends StatelessWidget {
  final String currentPrice;
  final String? originalPrice;
  final String? currencySymbol;
  final GlassPriceTagSize size;
  final bool showDiscount;
  final int? discountPercentage;

  const GlassPriceTag({
    super.key,
    required this.currentPrice,
    this.originalPrice,
    this.currencySymbol = '\$',
    this.size = GlassPriceTagSize.medium,
    this.showDiscount = false,
    this.discountPercentage,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          currencySymbol!,
          style: TextStyle(
            fontSize: _getPriceFontSize() * 0.6,
            fontWeight: FontWeight.w600,
            color: theme.textSecondary,
          ),
        ),
        const SizedBox(width: 2),
        Text(
          currentPrice,
          style: TextStyle(
            fontSize: _getPriceFontSize(),
            fontWeight: FontWeight.w700,
            color: theme.textPrimary,
            height: 1,
          ),
        ),
        if (originalPrice != null) ...[
          const SizedBox(width: 8),
          Text(
            originalPrice!,
            style: TextStyle(
              fontSize: _getPriceFontSize() * 0.7,
              fontWeight: FontWeight.w500,
              color: theme.textTertiary,
              decoration: TextDecoration.lineThrough,
              height: 1,
            ),
          ),
        ],
        if (showDiscount && discountPercentage != null) ...[
          const SizedBox(width: 8),
          GlassBadge(
            text: '$discountPercentage% OFF',
            variant: GlassBadgeVariant.primary,
            size: GlassBadgeSize.small,
          ),
        ],
      ],
    );
  }

  double _getPriceFontSize() {
    switch (size) {
      case GlassPriceTagSize.small:
        return 16.0;
      case GlassPriceTagSize.medium:
        return 20.0;
      case GlassPriceTagSize.large:
        return 24.0;
      case GlassPriceTagSize.extraLarge:
        return 32.0;
    }
  }
}

enum GlassPriceTagSize {
  small,
  medium,
  large,
  extraLarge,
}

/// Price row with label
class GlassPriceRow extends StatelessWidget {
  final String label;
  final String price;
  final String? currencySymbol;
  final GlassPriceTagSize size;
  final Color? labelColor;
  final FontWeight? labelWeight;
  final bool showDiscount;

  const GlassPriceRow({
    super.key,
    required this.label,
    required this.price,
    this.currencySymbol = '\$',
    this.size = GlassPriceTagSize.medium,
    this.labelColor,
    this.labelWeight,
    this.showDiscount = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: _getFontSize(),
            fontWeight: labelWeight ?? FontWeight.w500,
            color: labelColor ?? theme.textSecondary,
          ),
        ),
        Text(
          '$currencySymbol$price',
          style: TextStyle(
            fontSize: _getFontSize(),
            fontWeight: FontWeight.w600,
            color: theme.textPrimary,
          ),
        ),
      ],
    );
  }

  double _getFontSize() {
    switch (size) {
      case GlassPriceTagSize.small:
        return 12.0;
      case GlassPriceTagSize.medium:
        return 14.0;
      case GlassPriceTagSize.large:
        return 15.0;
      case GlassPriceTagSize.extraLarge:
        return 16.0;
    }
  }
}

/// Total price display
class GlassTotalPrice extends StatelessWidget {
  final String label;
  final String price;
  final String? currencySymbol;
  final GlassPriceTagSize size;
  final bool emphasizePrice;

  const GlassTotalPrice({
    super.key,
    required this.label,
    required this.price,
    this.currencySymbol = '\$',
    this.size = GlassPriceTagSize.large,
    this.emphasizePrice = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: theme.textSecondary,
          ),
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: currencySymbol,
                style: TextStyle(
                  fontSize: _getPriceFontSize() * 0.6,
                  fontWeight: FontWeight.w700,
                  color: theme.textPrimary,
                ),
              ),
              TextSpan(
                text: price,
                style: TextStyle(
                  fontSize: _getPriceFontSize(),
                  fontWeight: FontWeight.w700,
                  color: theme.textPrimary,
                  height: 1,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  double _getPriceFontSize() {
    switch (size) {
      case GlassPriceTagSize.small:
        return 18.0;
      case GlassPriceTagSize.medium:
        return 22.0;
      case GlassPriceTagSize.large:
        return 26.0;
      case GlassPriceTagSize.extraLarge:
        return 34.0;
    }
  }
}

/// Price per unit display
class GlassPricePerUnit extends StatelessWidget {
  final String price;
  final String unit;
  final String? currencySymbol;
  final GlassPriceTagSize size;

  const GlassPricePerUnit({
    super.key,
    required this.price,
    required this.unit,
    this.currencySymbol = '\$',
    this.size = GlassPriceTagSize.small,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          '$currencySymbol$price',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: theme.primaryColor,
          ),
        ),
        Text(
          '/$unit',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: theme.textTertiary,
          ),
        ),
      ],
    );
  }
}
