import 'dart:ui';

import 'package:flutter/material.dart';
import '../theme/glass_theme.dart';
import 'glass_button.dart';

/// GlassCard - A card container with glassmorphism effect
///
/// Provides beautiful cards for various use cases:
/// - Product cards
/// - Feature cards
/// - Content containers
/// - Interactive cards with tap
class GlassCard extends StatefulWidget {
  final Widget? child;
  final Widget? header;
  final Widget? footer;
  final GlassCardVariant variant;
  final GlassCardSize size;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final List<BoxShadow>? shadows;
  final Clip clipBehavior;
  final bool showOverlay;
  final bool isPressed;

  const GlassCard({
    super.key,
    this.child,
    this.header,
    this.footer,
    this.variant = GlassCardVariant.panel,
    this.size = GlassCardSize.medium,
    this.onTap,
    this.padding,
    this.margin,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.shadows,
    this.clipBehavior = Clip.antiAlias,
    this.showOverlay = false,
    this.isPressed = false,
  });

  const GlassCard.panel({
    super.key,
    this.child,
    this.header,
    this.footer,
    this.size = GlassCardSize.medium,
    this.onTap,
    this.padding,
    this.margin,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.shadows,
    this.clipBehavior = Clip.antiAlias,
    this.showOverlay = false,
    this.isPressed = false,
  }) : variant = GlassCardVariant.panel;

  const GlassCard.atom({
    super.key,
    this.child,
    this.header,
    this.footer,
    this.size = GlassCardSize.medium,
    this.onTap,
    this.padding,
    this.margin,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.shadows,
    this.clipBehavior = Clip.antiAlias,
    this.showOverlay = false,
    this.isPressed = false,
  }) : variant = GlassCardVariant.atom;

  const GlassCard.elevated({
    super.key,
    this.child,
    this.header,
    this.footer,
    this.size = GlassCardSize.medium,
    this.onTap,
    this.padding,
    this.margin,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.shadows,
    this.clipBehavior = Clip.antiAlias,
    this.showOverlay = false,
    this.isPressed = false,
  }) : variant = GlassCardVariant.elevated;

  const GlassCard.outlined({
    super.key,
    this.child,
    this.header,
    this.footer,
    this.size = GlassCardSize.medium,
    this.onTap,
    this.padding,
    this.margin,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.shadows,
    this.clipBehavior = Clip.antiAlias,
    this.showOverlay = false,
    this.isPressed = false,
  }) : variant = GlassCardVariant.outlined;

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard> {
  bool _isPressed = false;

  void _handleTapDown(TapDownDetails details) {
    if (widget.onTap != null) {
      setState(() => _isPressed = true);
    }
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);
    final effectiveBorderRadius = widget.borderRadius ?? _getBorderRadius();
    final effectivePadding = widget.padding ?? _getPadding();
    final effectiveBorderColor = widget.borderColor ?? theme.glassBorderColor;
    final effectiveBorderWidth = widget.borderWidth ?? 1.0;
    final isInteractive = widget.onTap != null;

    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: isInteractive ? _handleTapDown : null,
      onTapUp: isInteractive ? _handleTapUp : null,
      onTapCancel: isInteractive ? _handleTapCancel : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        margin: widget.margin,
        clipBehavior: widget.clipBehavior,
        decoration: BoxDecoration(
          color: _getBackgroundColor(theme),
          borderRadius: effectiveBorderRadius,
          border: Border.all(
            color: effectiveBorderColor.withOpacity(
                widget.variant == GlassCardVariant.outlined ? 1.0 : 0.6),
            width: effectiveBorderWidth,
          ),
          boxShadow: widget.shadows ?? _getShadows(theme),
          gradient: widget.showOverlay
              ? LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.4),
                    Colors.white.withOpacity(0.1),
                  ],
                )
              : null,
        ),
        transform: (_isPressed || widget.isPressed) && isInteractive
            ? Matrix4.translationValues(0, 2, 0)
            : Matrix4.identity(),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.header != null)
                Padding(
                  padding: effectivePadding,
                  child: widget.header,
                ),
              if (widget.header != null && widget.child != null)
                const SizedBox(height: 8),
              if (widget.child != null)
                Padding(
                  padding: effectivePadding,
                  child: widget.child,
                ),
              if (widget.footer != null && widget.child != null)
                const SizedBox(height: 12),
              if (widget.footer != null)
                Padding(
                  padding: effectivePadding,
                  child: widget.footer,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor(GlassTheme theme) {
    switch (widget.variant) {
      case GlassCardVariant.panel:
        return theme.glassSurfaceColor.withOpacity(0.65);
      case GlassCardVariant.atom:
        return theme.glassSurfaceColor.withOpacity(0.5);
      case GlassCardVariant.elevated:
        return theme.glassSurfaceColor;
      case GlassCardVariant.outlined:
        return widget.backgroundColor ?? Colors.transparent;
    }
  }

  List<BoxShadow>? _getShadows(GlassTheme theme) {
    switch (widget.variant) {
      case GlassCardVariant.panel:
        return [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ];
      case GlassCardVariant.atom:
        return [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ];
      case GlassCardVariant.elevated:
        return [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ];
      case GlassCardVariant.outlined:
        return null;
    }
  }

  BorderRadiusGeometry _getBorderRadius() {
    switch (widget.size) {
      case GlassCardSize.small:
        return BorderRadius.circular(12);
      case GlassCardSize.medium:
        return BorderRadius.circular(20);
      case GlassCardSize.large:
        return BorderRadius.circular(28);
      case GlassCardSize.extraLarge:
        return BorderRadius.circular(32);
    }
  }

  EdgeInsetsGeometry _getPadding() {
    switch (widget.size) {
      case GlassCardSize.small:
        return const EdgeInsets.all(12);
      case GlassCardSize.medium:
        return const EdgeInsets.all(20);
      case GlassCardSize.large:
        return const EdgeInsets.all(28);
      case GlassCardSize.extraLarge:
        return const EdgeInsets.all(32);
    }
  }
}

enum GlassCardVariant {
  panel,
  atom,
  elevated,
  outlined,
}

enum GlassCardSize {
  small,
  medium,
  large,
  extraLarge,
}

/// Interactive product card with image area
class GlassProductCard extends StatelessWidget {
  final Widget image;
  final String title;
  final String? subtitle;
  final String? price;
  final String? originalPrice;
  final Widget? badge;
  final VoidCallback? onFavoriteTap;
  final bool isFavorite;
  final VoidCallback? onAddTap;
  final Widget? footer;
  final GlassCardSize size;

  const GlassProductCard({
    super.key,
    required this.image,
    required this.title,
    this.subtitle,
    this.price,
    this.originalPrice,
    this.badge,
    this.onFavoriteTap,
    this.isFavorite = false,
    this.onAddTap,
    this.footer,
    this.size = GlassCardSize.medium,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return GlassCard(
      variant: GlassCardVariant.atom,
      size: GlassCardSize.small,
      padding: EdgeInsets.zero,
      showOverlay: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: image,
              ),
              if (badge != null)
                Positioned(
                  top: 12,
                  left: 12,
                  child: badge!,
                ),
              if (onFavoriteTap != null)
                Positioned(
                  top: 12,
                  right: 12,
                  child: GestureDetector(
                    onTap: onFavoriteTap,
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.5),
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        size: 18,
                        color: isFavorite
                            ? GlassTheme.error
                            : theme.textSecondaryColor,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: theme.textPrimaryColor,
                    height: 1.2,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle!,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: theme.textTertiaryColor,
                      height: 1.4,
                    ),
                  ),
                ],
                if (price != null) ...[
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            price!,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: theme.textPrimaryColor,
                              height: 1.1,
                            ),
                          ),
                          if (originalPrice != null) ...[
                            const SizedBox(width: 8),
                            Text(
                              originalPrice!,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: theme.textTertiaryColor,
                                height: 1.1,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ],
                      ),
                      if (onAddTap != null)
                        GlassButton(
                          onPressed: onAddTap,
                          label: 'Add',
                          icon: Icons.add,
                          height: 36,
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                        ),
                    ],
                  ),
                ],
                if (footer != null) ...[
                  const SizedBox(height: 12),
                  footer!,
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Blur utility class for consistent blur effects
class BlurUtils {
  static const BlurConfiguration small = BlurConfiguration(10);
  static const BlurConfiguration medium = BlurConfiguration(20);
  static const BlurConfiguration large = BlurConfiguration(40);
  static const BlurConfiguration extraLarge = BlurConfiguration(60);

  static Widget blurMedium({required Widget child}) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
      child: child,
    );
  }
}

class BlurConfiguration {
  final double sigmaX;
  final double sigmaY;

  const BlurConfiguration(this.sigmaX, {this.sigmaY = -1});

  ImageFilter get filter {
    return ImageFilter.blur(
      sigmaX: sigmaX,
      sigmaY: sigmaY < 0 ? sigmaX : sigmaY,
    );
  }
}
