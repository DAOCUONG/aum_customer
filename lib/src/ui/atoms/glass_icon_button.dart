import 'package:flutter/material.dart';
import '../theme/glass_theme.dart';

/// GlassIconButtonVariant - Different styles for the icon button
enum GlassIconButtonVariant {
  surface,
  primary,
  transparent,
  outlined,
}

/// GlassIconButton - A circular icon button with glassmorphism effect
///
/// Provides a beautiful icon button with:
/// - Glass background effect
/// - Multiple variants (surface, primary, transparent)
/// - Press animation
/// - Badge support
/// - Loading state
class GlassIconButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget icon;
  final double size;
  final GlassIconButtonVariant variant;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final String? badgeText;
  final Color? badgeColor;
  final Color? badgeTextColor;
  final bool isLoading;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final double? borderWidth;
  final List<BoxShadow>? customShadow;
  final BoxConstraints? iconConstraints;
  final String? tooltip;

  const GlassIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.size = 48,
    this.variant = GlassIconButtonVariant.surface,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.badgeText,
    this.badgeColor,
    this.badgeTextColor,
    this.isLoading = false,
    this.padding,
    this.borderRadius,
    this.borderWidth,
    this.customShadow,
    this.iconConstraints,
    this.tooltip,
  });

  const GlassIconButton.transparent({
    super.key,
    required this.onPressed,
    required this.icon,
    this.size = 40,
    this.variant = GlassIconButtonVariant.transparent,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.badgeText,
    this.badgeColor,
    this.badgeTextColor,
    this.isLoading = false,
    this.padding,
    this.borderRadius,
    this.borderWidth,
    this.customShadow,
    this.iconConstraints,
    this.tooltip,
  });

  @override
  State<GlassIconButton> createState() => _GlassIconButtonState();
}

class _GlassIconButtonState extends State<GlassIconButton> {
  bool _isPressed = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);
    final isDisabled = widget.onPressed == null && !widget.isLoading;

    Color? bgColor = widget.backgroundColor;
    Color? borderColor = widget.borderColor;

    switch (widget.variant) {
      case GlassIconButtonVariant.surface:
        bgColor ??= theme.glassSurfaceColor.withValues(alpha: 0.7);
        borderColor ??= theme.glassBorderColor;
        break;
      case GlassIconButtonVariant.primary:
        bgColor ??= theme.primaryColor;
        borderColor ??= theme.primaryColor.withValues(alpha: 0.1);
        break;
      case GlassIconButtonVariant.transparent:
        bgColor ??= Colors.transparent;
        break;
      case GlassIconButtonVariant.outlined:
        bgColor ??= Colors.transparent;
        borderColor ??= theme.glassBorderColor;
        break;
    }

    return GestureDetector(
      onTapDown: isDisabled ? null : _handleTapDown,
      onTapUp: isDisabled ? null : _handleTapUp,
      onTapCancel: isDisabled ? null : _handleTapCancel,
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: widget.size,
        height: widget.size,
        decoration: _getDecoration(context),
        transform:
            _isPressed ? Matrix4.translationValues(0, 2, 0) : Matrix4.identity(),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.isLoading ? null : widget.onPressed,
            borderRadius: widget.borderRadius != null
                ? BorderRadius.circular(widget.size / 2)
                : null,
            splashColor: (widget.foregroundColor ?? theme.textPrimaryColor)
                .withValues(alpha: 0.2),
            highlightColor: (widget.foregroundColor ?? theme.textPrimaryColor)
                .withValues(alpha: 0.1),
            child: Container(
              padding: widget.padding ??
                  EdgeInsets.all((widget.size - 24) / 2),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  widget.icon,
                  if (widget.badgeText != null) ...[
                    Positioned(
                      top: -4,
                      right: -4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: widget.badgeColor ?? GlassTheme.error,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          widget.badgeText!,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: widget.badgeTextColor ?? Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _getDecoration(BuildContext context) {
    final theme = GlassTheme.of(context);
    final isDisabled = widget.onPressed == null && !widget.isLoading;

    Color? bgColor = widget.backgroundColor;
    Color? borderColor = widget.borderColor;

    switch (widget.variant) {
      case GlassIconButtonVariant.surface:
        bgColor ??= theme.glassSurfaceColor.withValues(alpha: 0.7);
        borderColor ??= theme.glassBorderColor;
        break;
      case GlassIconButtonVariant.primary:
        bgColor ??= theme.primaryColor;
        borderColor ??= theme.primaryColor.withValues(alpha: 0.1);
        break;
      case GlassIconButtonVariant.transparent:
        bgColor ??= Colors.transparent;
        break;
      case GlassIconButtonVariant.outlined:
        bgColor ??= Colors.transparent;
        borderColor ??= theme.glassBorderColor;
        break;
    }

    return BoxDecoration(
      color: isDisabled
          ? theme.textTertiaryColor.withValues(alpha: 0.3)
          : bgColor,
      borderRadius: widget.borderRadius != null
          ? widget.borderRadius!
          : BorderRadius.circular(widget.size / 2),
      border: widget.variant == GlassIconButtonVariant.outlined ||
              widget.variant == GlassIconButtonVariant.primary
          ? Border.all(
              color: isDisabled ? Colors.transparent : borderColor!,
              width: widget.borderWidth ?? 1,
            )
          : null,
      boxShadow: widget.variant == GlassIconButtonVariant.primary
          ? [
              BoxShadow(
                color: theme.primaryColor.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ]
          : widget.customShadow ??
              (widget.variant == GlassIconButtonVariant.surface
                  ? [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ]
                  : null),
    );
  }
}
