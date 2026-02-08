import 'package:flutter/material.dart';
import '../theme/glass_theme.dart';

/// GlassBadge - A small badge/label with glassmorphism effect
///
/// Provides beautiful badges for various use cases:
/// - Status indicators
/// - Category labels
/// - Promotional tags
/// - Notification badges
class GlassBadge extends StatelessWidget {
  final String text;
  final GlassBadgeVariant variant;
  final GlassBadgeSize size;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double? borderWidth;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;

  const GlassBadge({
    super.key,
    required this.text,
    this.variant = GlassBadgeVariant.primary,
    this.size = GlassBadgeSize.medium,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.padding,
    this.textStyle,
  });

  const GlassBadge.success({
    super.key,
    required this.text,
    this.size = GlassBadgeSize.medium,
    this.icon,
    this.padding,
    this.textStyle,
  })  : variant = GlassBadgeVariant.success,
        backgroundColor = null,
        textColor = null,
        borderColor = null,
        borderWidth = null,
        borderRadius = null;

  const GlassBadge.warning({
    super.key,
    required this.text,
    this.size = GlassBadgeSize.medium,
    this.icon,
    this.padding,
    this.textStyle,
  })  : variant = GlassBadgeVariant.warning,
        backgroundColor = null,
        textColor = null,
        borderColor = null,
        borderWidth = null,
        borderRadius = null;

  const GlassBadge.error({
    super.key,
    required this.text,
    this.size = GlassBadgeSize.medium,
    this.icon,
    this.padding,
    this.textStyle,
  })  : variant = GlassBadgeVariant.error,
        backgroundColor = null,
        textColor = null,
        borderColor = null,
        borderWidth = null,
        borderRadius = null;

  const GlassBadge.info({
    super.key,
    required this.text,
    this.size = GlassBadgeSize.medium,
    this.icon,
    this.padding,
    this.textStyle,
  })  : variant = GlassBadgeVariant.info,
        backgroundColor = null,
        textColor = null,
        borderColor = null,
        borderWidth = null,
        borderRadius = null;

  const GlassBadge.outlined({
    super.key,
    required this.text,
    this.size = GlassBadgeSize.medium,
    this.icon,
    this.padding,
    this.textStyle,
  })  : variant = GlassBadgeVariant.outlined,
        backgroundColor = null,
        textColor = null,
        borderColor = null,
        borderWidth = null,
        borderRadius = null;

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);
    final (bgColor, txtColor, bdColor) = _getColors(theme);

    final effectivePadding = padding ?? _getPadding();
    final effectiveBorderRadius = borderRadius ?? _getBorderRadius();
    final effectiveBorderWidth = borderWidth ?? (variant == GlassBadgeVariant.outlined ? 1.0 : 0.0);

    return Container(
      padding: effectivePadding,
      decoration: BoxDecoration(
        color: variant == GlassBadgeVariant.outlined ? Colors.transparent : bgColor,
        borderRadius: effectiveBorderRadius,
        border: variant == GlassBadgeVariant.outlined || variant == GlassBadgeVariant.glass
            ? Border.all(
                color: bdColor ?? theme.glassBorderColor,
                width: effectiveBorderWidth,
              )
            : null,
        boxShadow: variant == GlassBadgeVariant.glass
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ]
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: _getIconSize(),
              color: txtColor,
            ),
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: textStyle ??
                TextStyle(
                  fontSize: _getFontSize(),
                  fontWeight: FontWeight.w600,
                  color: txtColor,
                  height: 1.2,
                  letterSpacing: _getLetterSpacing(),
                ),
          ),
        ],
      ),
    );
  }

  (Color backgroundColor, Color textColor, Color borderColor) _getColors(
      GlassTheme theme) {
    switch (variant) {
      case GlassBadgeVariant.primary:
        return (
          theme.primaryColor.withOpacity(0.15),
          theme.primaryColor,
          theme.primaryColor.withOpacity(0.2)
        );
      case GlassBadgeVariant.success:
        return (
          const Color(0xFF34C759).withOpacity(0.15),
          const Color(0xFF34C759),
          const Color(0xFF34C759).withOpacity(0.2)
        );
      case GlassBadgeVariant.warning:
        return (
          const Color(0xFFFF9500).withOpacity(0.15),
          const Color(0xFFFF9500),
          const Color(0xFFFF9500).withOpacity(0.2)
        );
      case GlassBadgeVariant.error:
        return (
          const Color(0xFFFF3B30).withOpacity(0.15),
          const Color(0xFFFF3B30),
          const Color(0xFFFF3B30).withOpacity(0.2)
        );
      case GlassBadgeVariant.info:
        return (
          const Color(0xFF007AFF).withOpacity(0.15),
          const Color(0xFF007AFF),
          const Color(0xFF007AFF).withOpacity(0.2)
        );
      case GlassBadgeVariant.outlined:
        return (
          Colors.transparent,
          theme.textSecondaryColor,
          theme.glassBorderColor
        );
      case GlassBadgeVariant.glass:
        return (
          theme.glassSurfaceColor.withOpacity(0.5),
          theme.textPrimaryColor,
          theme.glassBorderColor.withOpacity(0.6)
        );
      case GlassBadgeVariant.rating:
        return (
          const Color(0xFF34C759).withOpacity(0.15),
          const Color(0xFF34C759),
          const Color(0xFF34C759).withOpacity(0.2)
        );
    }
  }

  double _getFontSize() {
    switch (size) {
      case GlassBadgeSize.small:
        return 10.0;
      case GlassBadgeSize.medium:
        return 11.0;
      case GlassBadgeSize.large:
        return 13.0;
    }
  }

  double _getIconSize() {
    switch (size) {
      case GlassBadgeSize.small:
        return 12.0;
      case GlassBadgeSize.medium:
        return 14.0;
      case GlassBadgeSize.large:
        return 16.0;
    }
  }

  double _getLetterSpacing() {
    switch (size) {
      case GlassBadgeSize.small:
        return 0.5;
      case GlassBadgeSize.medium:
        return 0.3;
      case GlassBadgeSize.large:
        return 0.0;
    }
  }

  EdgeInsetsGeometry _getPadding() {
    switch (size) {
      case GlassBadgeSize.small:
        return const EdgeInsets.symmetric(horizontal: 8, vertical: 3);
      case GlassBadgeSize.medium:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 4);
      case GlassBadgeSize.large:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 6);
    }
  }

  BorderRadiusGeometry _getBorderRadius() {
    switch (size) {
      case GlassBadgeSize.small:
        return BorderRadius.circular(8);
      case GlassBadgeSize.medium:
        return BorderRadius.circular(10);
      case GlassBadgeSize.large:
        return BorderRadius.circular(12);
    }
  }
}

enum GlassBadgeVariant {
  primary,
  success,
  warning,
  error,
  info,
  outlined,
  glass,
  rating,
}

enum GlassBadgeSize {
  small,
  medium,
  large,
}

/// Pill badge with rounded ends
class GlassPillBadge extends GlassBadge {
  const GlassPillBadge({
    super.key,
    required super.text,
    super.variant,
    super.size,
    super.icon,
    super.backgroundColor,
    super.textColor,
    super.borderColor,
    super.borderWidth,
    super.padding,
    super.textStyle,
  }) : super(
          borderRadius: const BorderRadius.all(Radius.circular(999)),
        );
}

/// Rating badge with star icon
class GlassRatingBadge extends StatelessWidget {
  final double rating;
  final int? reviewCount;
  final GlassBadgeSize size;
  final bool showStar;
  final Color? starColor;

  const GlassRatingBadge({
    super.key,
    required this.rating,
    this.reviewCount,
    this.size = GlassBadgeSize.medium,
    this.showStar = true,
    this.starColor,
  });

  @override
  Widget build(BuildContext context) {
    final formattedRating = rating.toStringAsFixed(rating.truncateToDouble() == rating ? 0 : 1);
    return GlassBadge(
      text: formattedRating,
      variant: GlassBadgeVariant.rating,
      size: size,
      icon: showStar ? Icons.star : null,
    );
  }
}

/// Delivery badge
class GlassDeliveryBadge extends StatelessWidget {
  final bool isFree;
  final GlassBadgeSize size;

  const GlassDeliveryBadge({
    super.key,
    this.isFree = true,
    this.size = GlassBadgeSize.small,
  });

  @override
  Widget build(BuildContext context) {
    return GlassBadge(
      text: isFree ? 'Free Delivery' : 'Delivery',
      variant: GlassBadgeVariant.glass,
      size: size,
    );
  }
}

/// Discount badge with percentage
class GlassDiscountBadge extends StatelessWidget {
  final int percentage;
  final GlassBadgeSize size;
  final bool showPercentSign;

  const GlassDiscountBadge({
    super.key,
    required this.percentage,
    this.size = GlassBadgeSize.small,
    this.showPercentSign = true,
  });

  @override
  Widget build(BuildContext context) {
    return GlassBadge(
      text: '${showPercentSign ? '' : '-'}$percentage${showPercentSign ? '%' : ''} OFF',
      variant: GlassBadgeVariant.primary,
      size: size,
    );
  }
}
