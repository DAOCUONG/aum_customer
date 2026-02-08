import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/glass_theme.dart';

/// GlassButton - A glossy primary button with gradient background
///
/// Provides a beautiful primary button with:
/// - Gradient background (orange tones)
/// - Glassmorphism shadow effects
/// - Press animation
/// - Icon support
/// - Loading state
/// - Disabled state
class GlassButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final String? label;
  final Widget? child;
  final IconData? icon;
  final double? iconSize;
  final bool isLoading;
  final bool fullWidth;
  final double height;
  final EdgeInsetsGeometry padding;
  final BorderRadiusGeometry borderRadius;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? shadowColor;
  final double? elevation;
  final List<BoxShadow>? customShadow;
  final MainAxisAlignment mainAxisAlignment;
  final double gap;
  final TextStyle? textStyle;
  final bool autofocus;
  final FocusNode? focusNode;
  final MaterialTapTargetSize? tapTargetSize;

  const GlassButton({
    super.key,
    this.onPressed,
    this.label,
    this.child,
    this.icon,
    this.iconSize = 18,
    this.isLoading = false,
    this.fullWidth = true,
    this.height = 48,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.backgroundColor,
    this.foregroundColor,
    this.shadowColor,
    this.elevation,
    this.customShadow,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.gap = 8,
    this.textStyle,
    this.autofocus = false,
    this.focusNode,
    this.tapTargetSize,
  })  : assert(
          label != null || child != null,
          'Either label or child must be provided',
        ),
        super();

  const GlassButton.primary({
    Key? key,
    required VoidCallback? onPressed,
    String? label,
    Widget? child,
    IconData? icon,
    double? iconSize,
    bool isLoading = false,
    bool fullWidth = true,
    double height = 48,
    EdgeInsetsGeometry? padding,
    BorderRadiusGeometry? borderRadius,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
    double gap = 8,
    TextStyle? textStyle,
    bool autofocus = false,
    FocusNode? focusNode,
    MaterialTapTargetSize? tapTargetSize,
  }) : this(
          key: key,
          onPressed: onPressed,
          label: label,
          child: child,
          icon: icon,
          iconSize: iconSize,
          isLoading: isLoading,
          fullWidth: fullWidth,
          height: height,
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          borderRadius: borderRadius ?? const BorderRadius.all(Radius.circular(16)),
          mainAxisAlignment: mainAxisAlignment,
          gap: gap,
          textStyle: textStyle,
          autofocus: autofocus,
          focusNode: focusNode,
          tapTargetSize: tapTargetSize,
        );

  GlassButton.icon({
    Key? key,
    required VoidCallback? onPressed,
    required IconData icon,
    double size = 48,
    Color? backgroundColor,
    Color? foregroundColor,
    String? tooltip,
    bool autofocus = false,
    FocusNode? focusNode,
    MaterialTapTargetSize? tapTargetSize,
  }) : this(
          key: key,
          onPressed: onPressed,
          height: size,
          padding: EdgeInsets.all((size - 24) / 2),
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          borderRadius: BorderRadius.circular(size / 2),
          child: Icon(icon, size: 24),
          autofocus: autofocus,
          focusNode: focusNode,
          tapTargetSize: tapTargetSize,
        );

  @override
  State<GlassButton> createState() => _GlassButtonState();
}

class _GlassButtonState extends State<GlassButton> {
  bool _isPressed = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
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
    final isDisabled = widget.onPressed == null && !widget.isLoading;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOutCubic,
      width: widget.fullWidth ? double.infinity : null,
      height: widget.height,
      decoration: BoxDecoration(
        gradient: isDisabled
            ? null
            : LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  widget.backgroundColor ?? const Color(0xFFFF7A45),
                  widget.backgroundColor ?? const Color(0xFFFF5E2B),
                ],
              ),
        color: isDisabled ? theme.textTertiaryColor : null,
        borderRadius: widget.borderRadius,
        border: Border.all(
          color: (widget.backgroundColor ?? GlassTheme.primary).withOpacity(0.1),
          width: 0.5,
        ),
        boxShadow: widget.customShadow ??
            [
              if (!isDisabled)
                BoxShadow(
                  color: (widget.shadowColor ?? GlassTheme.primary).withOpacity(0.35),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              BoxShadow(
                color: Colors.white.withOpacity(0.3),
                blurRadius: 1,
                offset: const Offset(0, 1),
                spreadRadius: 0,
              ),
            ],
      ),
      transform: _isPressed ? Matrix4.translationValues(0, 2, 0) : Matrix4.identity(),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.isLoading ? null : widget.onPressed,
          onTapDown: isDisabled || widget.isLoading ? null : _handleTapDown,
          onTapUp: isDisabled || widget.isLoading ? null : _handleTapUp,
          onTapCancel: isDisabled || widget.isLoading ? null : _handleTapCancel,
          borderRadius: widget.borderRadius.resolve(TextDirection.ltr),
          splashColor: Colors.white.withOpacity(0.3),
          highlightColor: Colors.white.withOpacity(0.2),
          autofocus: widget.autofocus,
          focusNode: widget.focusNode,
          child: Container(
            padding: widget.padding,
            decoration: BoxDecoration(
              borderRadius: widget.borderRadius,
              gradient: !isDisabled
                  ? LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withOpacity(0.35),
                        Colors.white.withOpacity(0.1),
                        Colors.white.withOpacity(0.05),
                      ],
                    ) : null,
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: widget.isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: widget.mainAxisAlignment,
                      mainAxisSize: widget.fullWidth ? MainAxisSize.max : MainAxisSize.min,
                      children: [
                        if (widget.icon != null) ...[
                          Icon(
                            widget.icon,
                            size: widget.iconSize,
                            color: widget.foregroundColor ?? Colors.white,
                          ),
                          SizedBox(width: widget.gap),
                        ],
                        if (widget.child != null) widget.child!,
                        if (widget.label != null)
                          Text(
                            widget.label!,
                            style: widget.textStyle ??
                                TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: widget.foregroundColor ?? Colors.white,
                                  letterSpacing: 0.3,
                                ),
                          ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

/// GlassButton variants for different use cases
class GlassButtonVariants {
  /// Secondary glass button (outline style)
  static Widget secondary({
    required BuildContext context,
    required VoidCallback? onPressed,
    required String label,
    IconData? icon,
    double height = 48,
    EdgeInsetsGeometry? padding,
  }) {
    final theme = GlassTheme.of(context);
    return GlassButton(
      onPressed: onPressed,
      label: label,
      icon: icon,
      height: height,
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      backgroundColor: theme.glassSurfaceColor,
      foregroundColor: theme.textPrimaryColor,
      shadowColor: Colors.black,
      customShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  /// Accent button with custom color
  static Widget accent({
    required BuildContext context,
    required VoidCallback? onPressed,
    required String label,
    IconData? icon,
    required Color accentColor,
    double height = 48,
    EdgeInsetsGeometry? padding,
  }) {
    return GlassButton(
      onPressed: onPressed,
      label: label,
      icon: icon,
      height: height,
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      backgroundColor: accentColor,
      shadowColor: accentColor,
    );
  }

  /// Ghost button (transparent background)
  static Widget ghost({
    required BuildContext context,
    required VoidCallback? onPressed,
    required String label,
    IconData? icon,
    double height = 48,
    EdgeInsetsGeometry? padding,
  }) {
    final theme = GlassTheme.of(context);
    return GlassButton(
      onPressed: onPressed,
      label: label,
      icon: icon,
      height: height,
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      backgroundColor: Colors.transparent,
      foregroundColor: theme.primaryColor,
      customShadow: [],
    );
  }
}
