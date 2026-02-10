import 'package:flutter/material.dart';
import '../theme/glass_theme.dart';

/// GlassDivider - A divider with various styles
///
/// Provides beautiful dividers for layout separation:
/// - Solid line
/// - Dashed line
/// - Dotted line
/// - With label option
/// - Glass effect
class GlassDivider extends StatelessWidget {
  final GlassDividerVariant variant;
  final double thickness;
  final double indent;
  final double endIndent;
  final Color? color;
  final Color? glassColor;
  final double? height;
  final String? label;
  final TextStyle? labelStyle;
  final MainAxisAlignment? labelAlignment;

  const GlassDivider({
    super.key,
    this.variant = GlassDividerVariant.solid,
    this.thickness = 1,
    this.indent = 0,
    this.endIndent = 0,
    this.color,
    this.glassColor,
    this.height,
    this.label,
    this.labelStyle,
    this.labelAlignment,
  });

  const GlassDivider.solid({
    super.key,
    this.thickness = 1,
    this.indent = 0,
    this.endIndent = 0,
    this.color,
    this.height,
    this.label,
    this.labelStyle,
    this.labelAlignment,
  }) : variant = GlassDividerVariant.solid,
       glassColor = null;

  const GlassDivider.dashed({
    super.key,
    this.thickness = 1,
    this.indent = 0,
    this.endIndent = 0,
    this.color,
    this.glassColor,
    this.height,
    this.label,
    this.labelStyle,
    this.labelAlignment,
  }) : variant = GlassDividerVariant.dashed;

  const GlassDivider.dotted({
    super.key,
    this.thickness = 2,
    this.indent = 0,
    this.endIndent = 0,
    this.color,
    this.glassColor,
    this.height,
    this.label,
    this.labelStyle,
    this.labelAlignment,
  }) : variant = GlassDividerVariant.dotted;

  const GlassDivider.glass({
    super.key,
    this.thickness = 1,
    this.indent = 0,
    this.endIndent = 0,
    this.glassColor,
    this.height,
    this.label,
    this.labelStyle,
    this.labelAlignment,
  }) : variant = GlassDividerVariant.glass,
       color = null;

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    if (label != null) {
      return Row(
        children: [
          Expanded(
            child: _buildLine(context, indent: indent),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              label!,
              style: labelStyle ??
                  TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: theme.textTertiaryColor,
                    letterSpacing: 0.5,
                  ),
            ),
          ),
          Expanded(
            child: _buildLine(context, indent: endIndent),
          ),
        ],
      );
    }

    return _buildLine(context);
  }

  Widget _buildLine(BuildContext context, {double indent = 0}) {
    final theme = GlassTheme.of(context);
    final effectiveColor = color ?? theme.dividerColor;
    final effectiveGlassColor = glassColor ?? theme.glassBorderColor;
    final effectiveHeight = height ?? (variant == GlassDividerVariant.dotted ? 4 : 10);

    switch (variant) {
      case GlassDividerVariant.solid:
        return Divider(
          thickness: thickness,
          indent: indent,
          color: effectiveColor,
          height: effectiveHeight,
        );

      case GlassDividerVariant.dashed:
        return CustomPaint(
          size: Size.fromHeight(effectiveHeight),
          painter: _DashedDividerPainter(
            color: effectiveColor,
            strokeWidth: thickness,
            dashWidth: 6,
            dashSpacing: 4,
          ),
        );

      case GlassDividerVariant.dotted:
        return CustomPaint(
          size: Size.fromHeight(effectiveHeight),
          painter: _DottedDividerPainter(
            color: effectiveColor,
            radius: thickness / 2,
          ),
        );

      case GlassDividerVariant.glass:
        return CustomPaint(
          size: Size.fromHeight(effectiveHeight),
          painter: _GlassDividerPainter(
            glassColor: effectiveGlassColor,
            strokeWidth: thickness,
          ),
        );
    }
  }
}

enum GlassDividerVariant {
  solid,
  dashed,
  dotted,
  glass,
}

/// Custom painter for dashed line
class _DashedDividerPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpacing;

  _DashedDividerPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashWidth,
    required this.dashSpacing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, size.height / 2),
        Offset(startX + dashWidth, size.height / 2),
        paint,
      );
      startX += dashWidth + dashSpacing;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Custom painter for dotted line
class _DottedDividerPainter extends CustomPainter {
  final Color color;
  final double radius;

  _DottedDividerPainter({
    required this.color,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final spacing = radius * 3;
    double startX = radius;
    while (startX < size.width) {
      canvas.drawCircle(
        Offset(startX, size.height / 2),
        radius,
        paint,
      );
      startX += spacing;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Custom painter for glass gradient divider
class _GlassDividerPainter extends CustomPainter {
  final Color glassColor;
  final double strokeWidth;

  _GlassDividerPainter({
    required this.glassColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromPoints(
      Offset(0, size.height / 2 - strokeWidth / 2),
      Offset(size.width, size.height / 2 + strokeWidth / 2),
    );

    final gradient = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Colors.transparent,
        glassColor,
        glassColor,
        Colors.transparent,
      ],
      stops: const [0.0, 0.2, 0.8, 1.0],
    );

    canvas.drawRect(
      rect,
      Paint()
        ..shader = gradient.createShader(rect)
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Vertical divider
class GlassVerticalDivider extends StatelessWidget {
  final GlassDividerVariant variant;
  final double thickness;
  final double indent;
  final double endIndent;
  final Color? color;
  final double? height;

  const GlassVerticalDivider({
    super.key,
    this.variant = GlassDividerVariant.solid,
    this.thickness = 1,
    this.indent = 0,
    this.endIndent = 0,
    this.color,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);
    final effectiveColor = color ?? theme.dividerColor;

    return SizedBox(
      height: height ?? 24,
      child: VerticalDivider(
        thickness: thickness,
        indent: indent,
        endIndent: endIndent,
        color: effectiveColor,
      ),
    );
  }
}

/// Spacing divider with label option
class SectionDivider extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final VoidCallback? onActionTap;
  final String? actionText;
  final bool showDivider;
  final Color? iconColor;
  final TextStyle? titleStyle;
  final EdgeInsetsGeometry? padding;

  const SectionDivider({
    super.key,
    this.title,
    this.icon,
    this.onActionTap,
    this.actionText,
    this.showDivider = true,
    this.iconColor,
    this.titleStyle,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 18,
              color: iconColor ?? theme.textTertiaryColor,
            ),
            const SizedBox(width: 8),
          ],
          if (title != null)
            Expanded(
              child: Text(
                title!,
                style: titleStyle ??
                    TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: theme.textTertiaryColor,
                      letterSpacing: 0.5,
                    ),
              ),
            ),
          if (actionText != null && onActionTap != null)
            GestureDetector(
              onTap: onActionTap,
              child: Text(
                actionText!,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: theme.primaryColor,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
