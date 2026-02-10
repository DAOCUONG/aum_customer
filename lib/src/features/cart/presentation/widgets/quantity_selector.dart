import 'package:flutter/material.dart';

import '../../../../ui/theme/glass_theme.dart';

/// Size options for quantity selector
enum QuantitySelectorSize {
  small,
  medium,
  large,
}

/// Glassmorphism quantity selector widget
class QuantitySelector extends StatelessWidget {
  final int quantity;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
  final QuantitySelectorSize size;
  final bool Function()? onQuantityChanged;

  const QuantitySelector({
    super.key,
    required this.quantity,
    this.onIncrement,
    this.onDecrement,
    this.size = QuantitySelectorSize.medium,
    this.onQuantityChanged,
  });

  double get _iconSize {
    switch (size) {
      case QuantitySelectorSize.small:
        return 20;
      case QuantitySelectorSize.medium:
        return 24;
      case QuantitySelectorSize.large:
        return 28;
    }
  }

  double get _buttonSize {
    switch (size) {
      case QuantitySelectorSize.small:
        return 28;
      case QuantitySelectorSize.medium:
        return 36;
      case QuantitySelectorSize.large:
        return 44;
    }
  }

  double get _fontSize {
    switch (size) {
      case QuantitySelectorSize.small:
        return 14;
      case QuantitySelectorSize.medium:
        return 16;
      case QuantitySelectorSize.large:
        return 18;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.glassSurfaceColor,
        borderRadius: BorderRadius.circular(_buttonSize / 2),
        border: Border.all(
          color: theme.glassBorderColor.withOpacity(0.5),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Minus button
          _buildButton(
            context,
            icon: Icons.remove,
            onTap: onDecrement,
            isEnabled: quantity > 1,
          ),
          // Quantity text
          SizedBox(
            width: _buttonSize,
            child: Text(
              quantity.toString(),
              style: GlassTextStyles.titleMedium(context).copyWith(
                fontSize: _fontSize,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // Plus button
          _buildButton(
            context,
            icon: Icons.add,
            onTap: onIncrement,
            isEnabled: quantity < 99,
          ),
        ],
      ),
    );
  }

  Widget _buildButton(
    BuildContext context, {
    required IconData icon,
    required VoidCallback? onTap,
    required bool isEnabled,
  }) {
    final theme = GlassTheme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isEnabled ? onTap : null,
        borderRadius: BorderRadius.circular(_buttonSize / 2),
        child: SizedBox(
          width: _buttonSize,
          height: _buttonSize,
          child: Icon(
            icon,
            size: _iconSize,
            color: isEnabled
                ? theme.primaryColor
                : theme.textTertiaryColor.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
