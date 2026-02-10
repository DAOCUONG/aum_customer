import 'dart:ui';

import 'package:flutter/material.dart';
import '../theme/glass_theme.dart';

/// GlassAtom - Small glass elements with blur(30px)
///
/// Compact glassmorphism components for small UI elements like:
/// - Icons
/// - Badges
/// - Small indicators
/// - Floating elements
///
/// Usage:
/// ```dart
/// GlassAtom(
///   child: Icon(Icons.star),
/// )
/// ```
class GlassAtom extends StatefulWidget {
  final Widget? child;
  final GlassAtomVariant variant;
  final GlassAtomShape shape;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final List<BoxShadow>? boxShadow;
  final Clip clipBehavior;
  final double blurRadius;
  final double backgroundOpacity;
  final double borderOpacity;
  final VoidCallback? onTap;
  final bool isPressed;

  const GlassAtom({
    super.key,
    this.child,
    this.variant = GlassAtomVariant.defaultVariant,
    this.shape = GlassAtomShape.roundedRectangle,
    this.padding,
    this.margin,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.boxShadow,
    this.clipBehavior = Clip.antiAlias,
    this.blurRadius = 30,
    this.backgroundOpacity = 0.5,
    this.borderOpacity = 0.6,
    this.onTap,
    this.isPressed = false,
  });

  const GlassAtom.icon({
    super.key,
    this.child,
    this.variant = GlassAtomVariant.defaultVariant,
    this.shape = GlassAtomShape.circle,
    this.padding = const EdgeInsets.all(12),
    this.margin,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.boxShadow,
    this.clipBehavior = Clip.antiAlias,
    this.blurRadius = 30,
    this.backgroundOpacity = 0.5,
    this.borderOpacity = 0.6,
    this.onTap,
    this.isPressed = false,
  });

  const GlassAtom.badge({
    super.key,
    this.child,
    this.variant = GlassAtomVariant.defaultVariant,
    this.shape = GlassAtomShape.roundedRectangle,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    this.margin,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.boxShadow,
    this.clipBehavior = Clip.antiAlias,
    this.blurRadius = 30,
    this.backgroundOpacity = 0.5,
    this.borderOpacity = 0.6,
    this.onTap,
    this.isPressed = false,
  });

  const GlassAtom.floating({
    super.key,
    this.child,
    this.variant = GlassAtomVariant.floating,
    this.shape = GlassAtomShape.roundedRectangle,
    this.padding,
    this.margin,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.boxShadow,
    this.clipBehavior = Clip.antiAlias,
    this.blurRadius = 30,
    this.backgroundOpacity = 0.5,
    this.borderOpacity = 0.6,
    this.onTap,
    this.isPressed = false,
  });

  @override
  State<GlassAtom> createState() => _GlassAtomState();
}

class _GlassAtomState extends State<GlassAtom> {
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
    final effectiveBorderRadius = widget.borderRadius ?? _getDefaultRadius();
    final effectiveBorderColor = widget.borderColor ?? theme.glassBorderColor;
    final effectiveBorderWidth = widget.borderWidth ?? 1.0;
    final isInteractive = widget.onTap != null;

    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: isInteractive ? _handleTapDown : null,
      onTapUp: isInteractive ? _handleTapUp : null,
      onTapCancel: isInteractive ? _handleTapCancel : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOutQuad,
        margin: widget.margin,
        clipBehavior: widget.clipBehavior,
        transform: (_isPressed || widget.isPressed) && isInteractive
            ? Matrix4.translationValues(0, 1, 0)
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: _getBackgroundColor(theme),
          borderRadius: effectiveBorderRadius,
          border: Border.all(
            color: effectiveBorderColor.withValues(alpha:widget.borderOpacity),
            width: effectiveBorderWidth,
          ),
          boxShadow: widget.boxShadow ?? _getShadows(theme),
          gradient: widget.variant == GlassAtomVariant.glossy
              ? LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withValues(alpha:0.4),
                    Colors.white.withValues(alpha:0.1),
                  ],
                )
              : null,
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: widget.blurRadius,
            sigmaY: widget.blurRadius,
          ),
          child: Padding(
            padding: widget.padding ?? _getDefaultPadding(),
            child: widget.child,
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor(GlassTheme theme) {
    switch (widget.variant) {
      case GlassAtomVariant.defaultVariant:
        return theme.glassSurfaceColor.withValues(alpha:widget.backgroundOpacity);
      case GlassAtomVariant.glossy:
        return theme.glassSurfaceColor.withValues(alpha:widget.backgroundOpacity + 0.1);
      case GlassAtomVariant.floating:
        return theme.glassSurfaceColor.withValues(alpha:widget.backgroundOpacity);
      case GlassAtomVariant.subtle:
        return theme.glassSurfaceColor.withValues(alpha:widget.backgroundOpacity - 0.1);
    }
  }

  List<BoxShadow> _getShadows(GlassTheme theme) {
    switch (widget.variant) {
      case GlassAtomVariant.defaultVariant:
        return [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ];
      case GlassAtomVariant.glossy:
        return [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ];
      case GlassAtomVariant.floating:
        return [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.white.withValues(alpha:0.2),
            blurRadius: 4,
            offset: const Offset(0, -1),
          ),
        ];
      case GlassAtomVariant.subtle:
        return [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.02),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ];
    }
  }

  BorderRadiusGeometry _getDefaultRadius() {
    switch (widget.shape) {
      case GlassAtomShape.circle:
        return BorderRadius.circular(9999);
      case GlassAtomShape.roundedRectangle:
        return BorderRadius.circular(16);
      case GlassAtomShape.rounded:
        return BorderRadius.circular(12);
      case GlassAtomShape.pill:
        return BorderRadius.circular(9999);
    }
  }

  EdgeInsetsGeometry _getDefaultPadding() {
    switch (widget.shape) {
      case GlassAtomShape.circle:
        return const EdgeInsets.all(8);
      case GlassAtomShape.roundedRectangle:
        return const EdgeInsets.all(12);
      case GlassAtomShape.rounded:
        return const EdgeInsets.all(10);
      case GlassAtomShape.pill:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
    }
  }
}

enum GlassAtomVariant {
  defaultVariant,
  glossy,
  floating,
  subtle,
}

enum GlassAtomShape {
  circle,
  roundedRectangle,
  rounded,
  pill,
}

/// GlassIconButton - Icon button with glass effect
class GlassIconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget icon;
  final double size;
  final Color? backgroundColor;
  final Color? iconColor;
  final EdgeInsetsGeometry? padding;
  final List<BoxShadow>? boxShadow;
  final double blurRadius;

  const GlassIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.size = 44,
    this.backgroundColor,
    this.iconColor,
    this.padding,
    this.boxShadow,
    this.blurRadius = 30,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOutQuad,
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor ?? theme.glassSurfaceColor.withValues(alpha:0.5),
          borderRadius: BorderRadius.circular(size / 2.5),
          border: Border.all(
            color: theme.glassBorderColor.withValues(alpha:0.6),
          ),
          boxShadow: boxShadow ?? [
            BoxShadow(
              color: Colors.black.withValues(alpha:0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurRadius, sigmaY: blurRadius),
          child: Padding(
            padding: padding ?? EdgeInsets.all((size - 24) / 2),
            child: IconTheme(
              data: IconThemeData(
                color: iconColor ?? theme.textPrimaryColor,
                size: 24,
              ),
              child: icon,
            ),
          ),
        ),
      ),
    );
  }
}

/// GlassBadge - Small badge with glass effect
class GlassBadge extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final Color? borderColor;
  final BorderRadiusGeometry? borderRadius;
  final List<BoxShadow>? boxShadow;

  const GlassBadge({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    this.margin,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.glassSurfaceColor.withValues(alpha:0.5),
        borderRadius: borderRadius,
        border: Border.all(
          color: (borderColor ?? theme.glassBorderColor).withValues(alpha:0.6),
        ),
        boxShadow: boxShadow,
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
        child: Padding(
          padding: padding!,
          child: child,
        ),
      ),
    );
  }
}

/// GlassFloatingElement - Floating decorative glass element
///
/// Used for decorative floating elements like:
/// - Food icons floating in background
/// - Decorative shapes
/// - Emoji badges
class GlassFloatingElement extends StatelessWidget {
  final Widget child;
  final double size;
  final double rotation;
  final EdgeInsetsGeometry? margin;
  final List<BoxShadow>? boxShadow;
  final double blurRadius;

  const GlassFloatingElement({
    super.key,
    required this.child,
    this.size = 48,
    this.rotation = 0,
    this.margin,
    this.boxShadow,
    this.blurRadius = 30,
  });

  const GlassFloatingElement.rotated({
    super.key,
    required this.child,
    this.size = 48,
    this.rotation = 12,
    this.margin,
    this.boxShadow,
    this.blurRadius = 30,
  });

  const GlassFloatingElement.inverted({
    super.key,
    required this.child,
    this.size = 48,
    this.rotation = -12,
    this.margin,
    this.boxShadow,
    this.blurRadius = 30,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return Transform.rotate(
      angle: rotation * (3.14159 / 180),
      child: Container(
        width: size,
        height: size,
        margin: margin,
        decoration: BoxDecoration(
          color: theme.glassSurfaceColor.withValues(alpha:0.5),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: theme.glassBorderColor.withValues(alpha:0.6),
          ),
          boxShadow: boxShadow ?? [
            BoxShadow(
              color: Colors.black.withValues(alpha:0.03),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurRadius, sigmaY: blurRadius),
          child: Center(child: child),
        ),
      ),
    );
  }
}

/// GlassIndicator - Small indicator with glass effect
class GlassIndicator extends StatelessWidget {
  final bool isActive;
  final double size;
  final Color? activeColor;
  final Color? inactiveColor;

  const GlassIndicator({
    super.key,
    this.isActive = false,
    this.size = 8,
    this.activeColor,
    this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      width: isActive ? 24 : size,
      height: size,
      decoration: BoxDecoration(
        color: (isActive ? activeColor : inactiveColor ?? theme.textPrimaryColor.withValues(alpha:0.2)),
        borderRadius: BorderRadius.circular(size / 2),
        border: isActive
            ? null
            : Border.all(
                color: theme.glassBorderColor.withValues(alpha:0.3),
              ),
      ),
    );
  }
}
