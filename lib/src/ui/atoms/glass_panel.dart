import 'dart:ui';

import 'package:flutter/material.dart';
import '../theme/glass_theme.dart';

/// GlassPanel - Main glass panel with blur(50px), saturate(180%)
///
/// A high-quality glassmorphism panel for main containers, modals, and screens.
/// Features:
/// - Backdrop blur: 50px
/// - Saturation: 180%
/// - Semi-transparent white background (65%)
/// - Subtle border and shadow
///
/// Usage:
/// ```dart
/// GlassPanel(
///   child: Column(
///     children: [YourContent()],
///   ),
/// )
/// ```
class GlassPanel extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final List<BoxShadow>? boxShadow;
  final Clip clipBehavior;
  final bool showOverlay;
  final double blurRadius;
  final double saturationAmount;
  final double borderOpacity;
  final double backgroundOpacity;

  const GlassPanel({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.boxShadow,
    this.clipBehavior = Clip.antiAlias,
    this.showOverlay = false,
    this.blurRadius = 50,
    this.saturationAmount = 180,
    this.borderOpacity = 0.6,
    this.backgroundOpacity = 0.65,
  });

  /// Default panel radius for full-screen panels
  static const BorderRadius _defaultScreenRadius = BorderRadius.all(Radius.circular(0));

  /// Panel radius for modal/sheet style
  static const BorderRadius _defaultModalRadius = BorderRadius.all(Radius.circular(32));

  /// Large panel radius for card style
  static const BorderRadius _defaultCardRadius = BorderRadius.all(Radius.circular(24));

  /// Full-screen glass panel for onboarding screens
  const GlassPanel.screen({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius = _defaultScreenRadius,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.boxShadow,
    this.clipBehavior = Clip.antiAlias,
    this.showOverlay = false,
    this.blurRadius = 50,
    this.saturationAmount = 180,
    this.borderOpacity = 0.6,
    this.backgroundOpacity = 0.65,
  });

  /// Modal-style glass panel
  const GlassPanel.modal({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius = _defaultModalRadius,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.boxShadow,
    this.clipBehavior = Clip.antiAlias,
    this.showOverlay = true,
    this.blurRadius = 50,
    this.saturationAmount = 180,
    this.borderOpacity = 0.6,
    this.backgroundOpacity = 0.65,
  });

  /// Card-style glass panel
  const GlassPanel.card({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius = _defaultCardRadius,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.boxShadow,
    this.clipBehavior = Clip.antiAlias,
    this.showOverlay = false,
    this.blurRadius = 40,
    this.saturationAmount = 180,
    this.borderOpacity = 0.6,
    this.backgroundOpacity = 0.65,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);
    final effectiveBorderRadius = borderRadius ?? _defaultCardRadius;
    final effectiveBorderColor = borderColor ?? theme.glassBorderColor;
    final effectiveBorderWidth = borderWidth ?? 1.0;

    return Container(
      margin: margin,
      clipBehavior: clipBehavior,
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.glassSurfaceColor.withValues(alpha: backgroundOpacity),
        borderRadius: effectiveBorderRadius,
        border: Border.all(
          color: effectiveBorderColor.withValues(alpha: borderOpacity),
          width: effectiveBorderWidth,
        ),
        boxShadow: boxShadow ?? _defaultShadows(theme),
        gradient: showOverlay
            ? LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withValues(alpha: 0.3),
                  Colors.white.withValues(alpha: 0.05),
                ],
              )
            : null,
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blurRadius,
          sigmaY: blurRadius,
        ),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(20),
          child: child,
        ),
      ),
    );
  }

  List<BoxShadow> _defaultShadows(GlassTheme theme) {
    return [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.08),
        blurRadius: 16,
        offset: const Offset(0, 4),
      ),
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.04),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ];
  }
}

/// GlassContainer - Flexible glass container with configurable blur
///
/// Provides a more flexible glass container that can be customized
/// for various use cases beyond standard panels.
class GlassContainer extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final List<BoxShadow>? boxShadow;
  final Clip clipBehavior;
  final double blur;
  final double saturation;
  final double backgroundOpacity;
  final double borderOpacity;
  final Alignment? alignment;
  final BoxConstraints? constraints;

  const GlassContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.boxShadow,
    this.clipBehavior = Clip.antiAlias,
    this.blur = 50,
    this.saturation = 180,
    this.backgroundOpacity = 0.65,
    this.borderOpacity = 0.6,
    this.alignment,
    this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return Container(
      width: width,
      height: height,
      margin: margin,
      alignment: alignment,
      constraints: constraints,
      clipBehavior: clipBehavior,
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.glassSurfaceColor.withValues(alpha: backgroundOpacity),
        borderRadius: borderRadius ?? BorderRadius.circular(24),
        border: Border.all(
          color: (borderColor ?? theme.glassBorderColor).withValues(alpha: borderOpacity),
          width: borderWidth ?? 1.0,
        ),
        boxShadow: boxShadow,
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blur,
          sigmaY: blur,
        ),
        child: Padding(
          padding: padding ?? EdgeInsets.zero,
          child: child,
        ),
      ),
    );
  }
}

/// Compact glass panel for smaller containers
class GlassPanelCompact extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry? borderRadius;

  const GlassPanelCompact({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      padding: padding ?? const EdgeInsets.all(16),
      margin: margin,
      borderRadius: borderRadius ?? BorderRadius.circular(16),
      blurRadius: 40,
      backgroundOpacity: 0.55,
      child: child,
    );
  }
}

/// Glass sheet for bottom sheets and slide-up panels
class GlassSheet extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final List<BoxShadow>? shadows;

  const GlassSheet({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = const BorderRadius.only(
      topLeft: Radius.circular(28),
      topRight: Radius.circular(28),
    ),
    this.shadows,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: theme.glassSurfaceColor.withValues(alpha: 0.75),
        borderRadius: borderRadius,
        border: Border.all(
          color: theme.glassBorderColor.withValues(alpha: 0.5),
        ),
        boxShadow: shadows ?? [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(24),
          child: child,
        ),
      ),
    );
  }
}
