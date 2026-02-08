import 'package:flutter/material.dart';
import '../theme/glass_theme.dart';

/// PrimaryIcon - An icon widget with primary color styling
///
/// Provides consistent primary color icons:
/// - Multiple sizes
/// - Filled and outlined variants
/// - Custom color support
/// - Glass background option
class PrimaryIcon extends StatelessWidget {
  final IconData icon;
  final PrimaryIconSize size;
  final PrimaryIconVariant variant;
  final Color? color;
  final Color? backgroundColor;
  final bool useGlassBackground;
  final VoidCallback? onTap;
  final double? customSize;

  const PrimaryIcon({
    super.key,
    required this.icon,
    this.size = PrimaryIconSize.medium,
    this.variant = PrimaryIconVariant.filled,
    this.color,
    this.backgroundColor,
    this.useGlassBackground = false,
    this.onTap,
    this.customSize,
  });

  const PrimaryIcon.small({
    super.key,
    required this.icon,
    this.size = PrimaryIconSize.small,
    this.variant = PrimaryIconVariant.filled,
    this.color,
    this.backgroundColor,
    this.useGlassBackground = false,
    this.onTap,
    this.customSize,
  });

  const PrimaryIcon.medium({
    super.key,
    required this.icon,
    this.size = PrimaryIconSize.medium,
    this.variant = PrimaryIconVariant.filled,
    this.color,
    this.backgroundColor,
    this.useGlassBackground = false,
    this.onTap,
    this.customSize,
  });

  const PrimaryIcon.large({
    super.key,
    required this.icon,
    this.size = PrimaryIconSize.large,
    this.variant = PrimaryIconVariant.filled,
    this.color,
    this.backgroundColor,
    this.useGlassBackground = false,
    this.onTap,
    this.customSize,
  });

  const PrimaryIcon.extraLarge({
    super.key,
    required this.icon,
    this.size = PrimaryIconSize.extraLarge,
    this.variant = PrimaryIconVariant.filled,
    this.color,
    this.backgroundColor,
    this.useGlassBackground = false,
    this.onTap,
    this.customSize,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);
    final effectiveColor = color ?? theme.primaryColor;
    final effectiveSize = customSize ?? _getSize();

    Widget iconWidget = Icon(
      icon,
      size: effectiveSize,
      color: variant == PrimaryIconVariant.filled
          ? effectiveColor
          : effectiveColor,
    );

    if (useGlassBackground) {
      final effectiveBackgroundColor =
          backgroundColor ?? theme.glassSurface.withOpacity(0.6);
      final containerSize = effectiveSize * 1.8;

      return Container(
        width: containerSize,
        height: containerSize,
        decoration: BoxDecoration(
          color: effectiveBackgroundColor,
          borderRadius: BorderRadius.circular(containerSize / 2),
          border: Border.all(
            color: theme.glassBorder,
            width: 1,
          ),
        ),
        child: iconWidget,
      );
    }

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: iconWidget,
      );
    }

    return iconWidget;
  }

  double _getSize() {
    switch (size) {
      case PrimaryIconSize.small:
        return 16.0;
      case PrimaryIconSize.medium:
        return 20.0;
      case PrimaryIconSize.large:
        return 24.0;
      case PrimaryIconSize.extraLarge:
        return 28.0;
    }
  }
}

enum PrimaryIconSize {
  small,
  medium,
  large,
  extraLarge,
}

enum PrimaryIconVariant {
  filled,
  outlined,
}

/// Category icon with colored background
class CategoryIcon extends StatelessWidget {
  final IconData icon;
  final String? emoji;
  final bool isSelected;
  final bool showBackground;
  final double size;
  final Color? iconColor;
  final Color? backgroundColor;
  final Color? selectedBackgroundColor;
  final VoidCallback? onTap;
  final bool hasShadow;

  const CategoryIcon({
    super.key,
    required this.icon,
    this.emoji,
    this.isSelected = false,
    this.showBackground = true,
    this.size = 64,
    this.iconColor,
    this.backgroundColor,
    this.selectedBackgroundColor,
    this.onTap,
    this.hasShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);
    final effectiveBackgroundColor = isSelected
        ? (selectedBackgroundColor ?? GlassTheme.primary.withOpacity(0.1))
        : (backgroundColor ?? theme.glassSurface.withOpacity(0.5));
    final effectiveIconColor = iconColor ?? (isSelected ? GlassTheme.primary : theme.textSecondary);

    Widget content;
    if (emoji != null) {
      content = Text(
        emoji!,
        style: TextStyle(fontSize: size * 0.45),
      );
    } else {
      content = Icon(
        icon,
        size: size * 0.4,
        color: effectiveIconColor,
      );
    }

    final child = Container(
      width: size,
      height: size,
      decoration: showBackground
          ? BoxDecoration(
              color: effectiveBackgroundColor,
              borderRadius: BorderRadius.circular(size * 0.3),
              border: isSelected
                  ? Border.all(
                      color: GlassTheme.primary.withOpacity(0.2),
                      width: 2,
                    )
                  : Border.all(
                      color: theme.glassBorder,
                      width: 1,
                    ),
              boxShadow: hasShadow && isSelected
                  ? [
                      BoxShadow(
                        color: GlassTheme.primary.withOpacity(0.15),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
              gradient: !isSelected
                  ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.5),
                        Colors.white.withOpacity(0.2),
                      ],
                    )
                  : null,
            )
          : null,
      child: Center(child: content),
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: AnimatedScale(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOutCubic,
          scale: isSelected ? 0.95 : 1.0,
          child: child,
        ),
      );
    }

    return AnimatedScale(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOutCubic,
      scale: isSelected ? 0.95 : 1.0,
      child: child,
    );
  }
}

/// Glass icon button with primary color icon
class PrimaryIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final double size;
  final Color? backgroundColor;
  final Color? iconColor;
  final String? tooltip;

  const PrimaryIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.size = 40,
    this.backgroundColor,
    this.iconColor,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return Tooltip(
      message: tooltip ?? '',
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: backgroundColor ?? theme.glassSurface.withOpacity(0.6),
            borderRadius: BorderRadius.circular(size / 2),
            border: Border.all(
              color: theme.glassBorder,
              width: 1,
            ),
          ),
          child: Icon(
            icon,
            size: size * 0.5,
            color: iconColor ?? theme.textSecondary,
          ),
        ),
      ),
    );
  }
}
