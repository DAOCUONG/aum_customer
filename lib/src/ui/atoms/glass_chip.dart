import 'package:flutter/material.dart';
import '../theme/glass_theme.dart';

/// GlassChip - A selection chip with glassmorphism effect
///
/// Provides beautiful chips for selection and filtering:
/// - Selectable state
/// - Disabled state
/// - Icon support
/// - Close button option
/// - Animated selection
class GlassChip extends StatefulWidget {
  final String label;
  final bool isSelected;
  final bool isEnabled;
  final VoidCallback? onTap;
  final VoidCallback? onClose;
  final IconData? icon;
  final Widget? leading;
  final Widget? trailing;
  final GlassChipVariant variant;
  final GlassChipSize size;
  final Color? selectedBackgroundColor;
  final Color? selectedTextColor;
  final Color? unselectedBackgroundColor;
  final Color? unselectedTextColor;
  final Color? selectedBorderColor;
  final Color? unselectedBorderColor;
  final BorderRadiusGeometry? borderRadius;
  final TextStyle? textStyle;

  const GlassChip({
    super.key,
    required this.label,
    this.isSelected = false,
    this.isEnabled = true,
    this.onTap,
    this.onClose,
    this.icon,
    this.leading,
    this.trailing,
    this.variant = GlassChipVariant.glass,
    this.size = GlassChipSize.medium,
    this.selectedBackgroundColor,
    this.selectedTextColor,
    this.unselectedBackgroundColor,
    this.unselectedTextColor,
    this.selectedBorderColor,
    this.unselectedBorderColor,
    this.borderRadius,
    this.textStyle,
  });

  const GlassChip.selectable({
    super.key,
    required this.label,
    required this.isSelected,
    this.isEnabled = true,
    required this.onTap,
    this.icon,
    this.leading,
    this.variant = GlassChipVariant.glass,
    this.size = GlassChipSize.medium,
    this.selectedBackgroundColor,
    this.selectedTextColor,
    this.unselectedBackgroundColor,
    this.unselectedTextColor,
    this.selectedBorderColor,
    this.unselectedBorderColor,
    this.borderRadius,
    this.textStyle,
  })  : onClose = null,
        trailing = null;

  const GlassChip.removable({
    super.key,
    required this.label,
    this.isSelected = false,
    this.isEnabled = true,
    required this.onTap,
    required this.onClose,
    this.icon,
    this.leading,
    this.variant = GlassChipVariant.glass,
    this.size = GlassChipSize.medium,
    this.selectedBackgroundColor,
    this.selectedTextColor,
    this.unselectedBackgroundColor,
    this.unselectedTextColor,
    this.selectedBorderColor,
    this.unselectedBorderColor,
    this.borderRadius,
    this.textStyle,
  }) : trailing = null;

  const GlassChip.icon({
    super.key,
    required this.label,
    required this.icon,
    this.isSelected = false,
    this.isEnabled = true,
    this.onTap,
    this.variant = GlassChipVariant.glass,
    this.size = GlassChipSize.medium,
    this.selectedBackgroundColor,
    this.selectedTextColor,
    this.unselectedBackgroundColor,
    this.unselectedTextColor,
    this.selectedBorderColor,
    this.unselectedBorderColor,
    this.borderRadius,
    this.textStyle,
  })  : leading = null,
        trailing = null,
        onClose = null;

  @override
  State<GlassChip> createState() => _GlassChipState();
}

class _GlassChipState extends State<GlassChip> {
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
    final effectiveBorderRadius = widget.borderRadius ?? _getBorderRadius();
    final selectedColor = widget.selectedBackgroundColor ??
        theme.glassSurface.withOpacity(0.7);
    final unselectedColor = widget.unselectedBackgroundColor ??
        theme.glassSurface.withOpacity(0.4);
    final selectedTextColor = widget.selectedTextColor ?? theme.primaryColor;
    final unselectedTextColor = widget.unselectedTextColor ?? theme.textSecondary;
    final selectedBorderColor =
        widget.selectedBorderColor ?? theme.primaryColor.withOpacity(0.3);
    final unselectedBorderColor =
        widget.unselectedBorderColor ?? theme.glassBorder;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      padding: _getPadding(),
      decoration: BoxDecoration(
        color: widget.isSelected ? selectedColor : unselectedColor,
        borderRadius: effectiveBorderRadius,
        border: Border.all(
          color: widget.isSelected ? selectedBorderColor : unselectedBorderColor,
          width: widget.isSelected ? 2 : 1,
        ),
        boxShadow: widget.isSelected
            ? [
                BoxShadow(
                  color: theme.primaryColor.withOpacity(0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      transform: _isPressed && widget.isEnabled
          ? Matrix4.translationValues(0, 1, 0)
          : Matrix4.identity(),
      child: GestureDetector(
        onTap: widget.isEnabled ? widget.onTap : null,
        onTapDown: widget.isEnabled ? _handleTapDown : null,
        onTapUp: widget.isEnabled ? _handleTapUp : null,
        onTapCancel: widget.isEnabled ? _handleTapCancel : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (widget.leading != null) ...[
              widget.leading!,
              const SizedBox(width: 6),
            ],
            if (widget.icon != null) ...[
              Icon(
                widget.icon,
                size: _getIconSize(),
                color: widget.isSelected ? selectedTextColor : unselectedTextColor,
              ),
              const SizedBox(width: 6),
            ],
            Flexible(
              child: Text(
                widget.label,
                style: widget.textStyle ??
                    TextStyle(
                      fontSize: _getFontSize(),
                      fontWeight: widget.isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: widget.isSelected ? selectedTextColor : unselectedTextColor,
                      height: 1.3,
                    ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (widget.trailing != null) ...[
              const SizedBox(width: 6),
              widget.trailing!,
            ],
            if (widget.onClose != null) ...[
              const SizedBox(width: 4),
              GestureDetector(
                onTap: widget.onClose,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: (widget.isSelected
                            ? selectedTextColor
                            : unselectedTextColor)
                        .withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    size: 12,
                    color: widget.isSelected
                        ? selectedTextColor
                        : unselectedTextColor,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  double _getFontSize() {
    switch (widget.size) {
      case GlassChipSize.small:
        return 11.0;
      case GlassChipSize.medium:
        return 13.0;
      case GlassChipSize.large:
        return 15.0;
    }
  }

  double _getIconSize() {
    switch (widget.size) {
      case GlassChipSize.small:
        return 14.0;
      case GlassChipSize.medium:
        return 16.0;
      case GlassChipSize.large:
        return 18.0;
    }
  }

  EdgeInsetsGeometry _getPadding() {
    switch (widget.size) {
      case GlassChipSize.small:
        return const EdgeInsets.symmetric(horizontal: 10, vertical: 5);
      case GlassChipSize.medium:
        return const EdgeInsets.symmetric(horizontal: 14, vertical: 7);
      case GlassChipSize.large:
        return const EdgeInsets.symmetric(horizontal: 18, vertical: 9);
    }
  }

  BorderRadiusGeometry _getBorderRadius() {
    return const BorderRadius.all(Radius.circular(999));
  }
}

enum GlassChipVariant {
  glass,
  outlined,
  filled,
}

enum GlassChipSize {
  small,
  medium,
  large,
}

/// Chip group for multiple selection
class GlassChipGroup extends StatelessWidget {
  final List<String> labels;
  final List<bool> selectedStates;
  final Function(int index) onTap;
  final GlassChipSize size;
  final bool multiSelect;
  final WrapAlignment alignment;
  final double spacing;
  final double runSpacing;

  const GlassChipGroup({
    super.key,
    required this.labels,
    required this.selectedStates,
    required this.onTap,
    this.size = GlassChipSize.medium,
    this.multiSelect = false,
    this.alignment = WrapAlignment.start,
    this.spacing = 8,
    this.runSpacing = 8,
  }) : assert(labels.length == selectedStates.length);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: alignment,
      spacing: spacing,
      runSpacing: runSpacing,
      children: List.generate(
        labels.length,
        (index) => GlassChip(
          label: labels[index],
          isSelected: selectedStates[index],
          isEnabled: true,
          onTap: () => onTap(index),
          size: size,
        ),
      ),
    );
  }
}

/// Category chip with icon
class GlassCategoryChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final bool isActive;
  final VoidCallback? onTap;
  final GlassChipSize size;
  final Color? iconColor;

  const GlassCategoryChip({
    super.key,
    required this.label,
    required this.icon,
    this.isSelected = false,
    this.isActive = true,
    this.onTap,
    this.size = GlassChipSize.medium,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);
    final effectiveIconColor = iconColor ?? (isSelected ? GlassTheme.primary : theme.textSecondary);

    return GlassChip(
      label: label,
      icon: icon,
      isSelected: isSelected,
      isEnabled: isActive,
      onTap: onTap,
      size: size,
      selectedBackgroundColor: GlassTheme.primary.withOpacity(0.1),
      selectedTextColor: GlassTheme.primary,
      selectedBorderColor: GlassTheme.primary.withOpacity(0.3),
      unselectedBackgroundColor: theme.glassSurface.withOpacity(0.5),
      unselectedTextColor: theme.textSecondary,
      unselectedBorderColor: theme.glassBorder,
    );
  }
}
