import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/glass_theme.dart';

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
    this.size = 44,
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

  /// Surface variant - glass background
  const GlassIconButton.surface({
    super.key,
    required this.onPressed,
    required this.icon,
    this.size = 44,
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
  }) : variant = GlassIconButtonVariant.surface;

  /// Primary variant - primary color background
  const GlassIconButton.primary({
    super.key,
    required this.onPressed,
    required this.icon,
    this.size = 44,
    this.backgroundColor,
    this.foregroundColor = Colors.white,
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
  }) : variant = GlassIconButtonVariant.primary;

  /// Transparent variant - no background
  const GlassIconButton.transparent({
    super.key,
    required this.onPressed,
    required this.icon,
    this.size = 44,
    this.backgroundColor = Colors.transparent,
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
  }) : variant = GlassIconButtonVariant.transparent;

  /// Outlined variant - transparent with border
  const GlassIconButton.outlined({
    super.key,
    required this.onPressed,
    required this.icon,
    this.size = 44,
    this.backgroundColor = Colors.transparent,
    this.foregroundColor,
    this.borderColor,
    this.badgeText,
    this.badgeColor,
    this.badgeTextColor,
    this.isLoading = false,
    this.padding,
    this.borderRadius,
    this.borderWidth = 1,
    this.customShadow,
    this.iconConstraints,
    this.tooltip,
  }) : variant = GlassIconButtonVariant.outlined;

  @override
  State<GlassIconButton> createState() => _GlassIconButtonState();
}

enum GlassIconButtonVariant {
  surface,
  primary,
  transparent,
  outlined,
}

class _GlassIconButtonState extends State<GlassIconButton> {
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

  BoxDecoration _getDecoration(BuildContext context) {
    final theme = GlassTheme.of(context);
    final isDisabled = widget.onPressed == null && !widget.isLoading;

    Color? bgColor = widget.backgroundColor;
    Color? borderColor = widget.borderColor;

    switch (widget.variant) {
      case GlassIconButtonVariant.surface:
        bgColor ??= theme.glassSurface.withOpacity(0.7);
        borderColor ??= theme.glassBorder;
        break;
      case GlassIconButtonVariant.primary:
        bgColor ??= theme.primaryColor;
        borderColor ??= theme.primaryColor.withOpacity(0.1);
        break;
      case GlassIconButtonVariant.transparent:
        bgColor ??= Colors.transparent;
        break;
      case GlassIconButtonVariant.outlined:
        bgColor ??= Colors.transparent;
        borderColor ??= theme.glassBorder;
        break;
    }

    return BoxDecoration(
      color: isDisabled ? theme.textTertiary.withOpacity(0.3) : bgColor,
      borderRadius: widget.borderRadius ?? BorderRadius.circular(widget.size / 2),
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
                color: theme.primaryColor.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ]
          : widget.customShadow ??
              (widget.variant == GlassIconButtonVariant.surface
                  ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ]
                  : null),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);
    final isDisabled = widget.onPressed == null && !widget.isLoading;

    return Tooltip(
      message: widget.tooltip ?? '',
      child: GestureDetector(
        onTap: widget.isLoading ? null : widget.onPressed,
        onTapDown: isDisabled || widget.isLoading ? null : _handleTapDown,
        onTapUp: isDisabled || widget.isLoading ? null : _handleTapUp,
        onTapCancel: isDisabled || widget.isLoading ? null : _handleTapCancel,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOutCubic,
          width: widget.size,
          height: widget.size,
          decoration: _getDecoration(context),
          transform: _isPressed ? Matrix4.translationValues(0, 2, 0) : Matrix4.identity(),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.isLoading ? null : widget.onPressed,
              borderRadius: widget.borderRadius ??
                  BorderRadius.circular(widget.size / 2),
              splashColor: (widget.foregroundColor ?? theme.textPrimary)
                  .withOpacity(0.2),
              highlightColor: (widget.foregroundColor ?? theme.textPrimary)
                  .withOpacity(0.1),
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
                            border: Border.all(
                              color: theme.glassSurface,
                              width: 2,
                            ),
                          ),
                          child: Text(
                            widget.badgeText!,
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              color: widget.badgeTextColor ?? Colors.white,
                              height: 1,
                            ),
                            textAlign: TextAlign.center,
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
      ),
    );
  }
}

/// Back button with glass effect
class GlassBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final double size;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const GlassBackButton({
    super.key,
    this.onPressed,
    this.size = 40,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return GlassIconButton.surface(
      onPressed: onPressed ?? () => context.maybePop(),
      icon: Icon(
        Icons.arrow_back_ios_new,
        size: 20,
        color: foregroundColor,
      ),
      size: size,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
    );
  }
}

/// Notification bell with badge
class GlassNotificationButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final int notificationCount;
  final double size;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const GlassNotificationButton({
    super.key,
    this.onPressed,
    this.notificationCount = 0,
    this.size = 40,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return GlassIconButton.surface(
      onPressed: onPressed,
      icon: Icon(
        Icons.notifications,
        size: 22,
        color: foregroundColor,
      ),
      size: size,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      badgeText: notificationCount > 0 ? (notificationCount > 99 ? '99+' : notificationCount.toString()) : null,
      badgeColor: GlassTheme.primary,
      badgeTextColor: Colors.white,
    );
  }
}

/// Favorite/heart button
class GlassFavoriteButton extends StatefulWidget {
  final bool isFavorite;
  final VoidCallback? onPressed;
  final double size;
  final Color? activeColor;
  final Color? inactiveColor;

  const GlassFavoriteButton({
    super.key,
    this.isFavorite = false,
    this.onPressed,
    this.size = 40,
    this.activeColor,
    this.inactiveColor,
  });

  @override
  State<GlassFavoriteButton> createState() => _GlassFavoriteButtonState();
}

class _GlassFavoriteButtonState extends State<GlassFavoriteButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 1.3).chain(CurveTween(curve: Curves.easeOut)),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.3, end: 1.0).chain(CurveTween(curve: Curves.easeIn)),
        weight: 20,
      ),
    ]).animate(_controller);

    _colorAnimation = ColorTween(
      begin: widget.inactiveColor ?? const Color(0xFF636366),
      end: widget.activeColor ?? GlassTheme.error,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void didUpdateWidget(GlassFavoriteButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isFavorite != widget.isFavorite) {
      if (widget.isFavorite) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return GlassIconButton.surface(
          onPressed: widget.onPressed,
          icon: Icon(
            _controller.value >= 0.5 ? Icons.favorite : Icons.favorite_border,
            size: 20,
            color: _colorAnimation.value,
          ),
          size: widget.size,
          backgroundColor: theme.glassSurface.withOpacity(0.6),
          foregroundColor: _colorAnimation.value,
        );
      },
    );
  }
}
