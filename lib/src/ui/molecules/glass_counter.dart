import 'package:flutter/material.dart';
import '../theme/glass_theme.dart';
import '../atoms/glass_icon_button.dart';

/// GlassCounter - Quantity counter with increment/decrement buttons
///
/// Shows quantity with +/- buttons for selection
class GlassCounter extends StatefulWidget {
  final int initialQuantity;
  final int minQuantity;
  final int maxQuantity;
  final Function(int quantity) onQuantityChanged;
  final GlassCounterSize size;
  final bool enabled;
  final Color? buttonColor;
  final Color? iconColor;

  const GlassCounter({
    super.key,
    this.initialQuantity = 1,
    this.minQuantity = 1,
    this.maxQuantity = 99,
    required this.onQuantityChanged,
    this.size = GlassCounterSize.medium,
    this.enabled = true,
    this.buttonColor,
    this.iconColor,
  });

  @override
  State<GlassCounter> createState() => _GlassCounterState();
}

class _GlassCounterState extends State<GlassCounter> {
  late int _quantity;

  @override
  void initState() {
    super.initState();
    _quantity = widget.initialQuantity;
  }

  void _increment() {
    if (_quantity < widget.maxQuantity) {
      setState(() => _quantity++);
      widget.onQuantityChanged(_quantity);
    }
  }

  void _decrement() {
    if (_quantity > widget.minQuantity) {
      setState(() => _quantity--);
      widget.onQuantityChanged(_quantity);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);
    final effectiveButtonColor =
        widget.buttonColor ?? theme.glassSurface.withOpacity(0.7);
    final effectiveIconColor =
        widget.iconColor ?? theme.textPrimary;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_getHeight() * 0.5),
        color: theme.glassSurface.withOpacity(0.5),
        border: Border.all(
          color: theme.glassBorder,
          width: 1,
        ),
      ),
      height: _getHeight(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildButton(
            icon: Icons.remove,
            onTap: widget.enabled ? _decrement : null,
            color: effectiveButtonColor,
            iconColor: effectiveIconColor,
            isDisabled: _quantity <= widget.minQuantity,
          ),
          SizedBox(
            width: _getWidth(),
            child: Text(
              '$_quantity',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: _getFontSize(),
                fontWeight: FontWeight.w600,
                color: effectiveIconColor,
              ),
            ),
          ),
          _buildButton(
            icon: Icons.add,
            onTap: widget.enabled ? _increment : null,
            color: effectiveButtonColor,
            iconColor: effectiveIconColor,
            isDisabled: _quantity >= widget.maxQuantity,
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required IconData icon,
    required VoidCallback? onTap,
    required Color color,
    required Color iconColor,
    required bool isDisabled,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(miseconds: 150),
        width: _getHeight(),
        height: _getHeight(),
        decoration: BoxDecoration(
          color: isDisabled ? Colors.transparent : color,
          borderRadius: onTap != null
              ? BorderRadius.horizontal(
                  left: icon == Icons.remove
                      ? Radius.circular(_getHeight() * 0.5)
                      : Radius.zero,
                  right: icon == Icons.add
                      ? Radius.circular(_getHeight() * 0.5)
                      : Radius.zero,
                )
              : null,
        ),
        child: Icon(
          icon,
          size: _getIconSize(),
          color: isDisabled
              ? theme?.textTertiary.withOpacity(0.5)
              : iconColor,
        ),
      ),
    );
  }

  double _getHeight() {
    switch (widget.size) {
      case GlassCounterSize.small:
        return 32.0;
      case GlassCounterSize.medium:
        return 40.0;
      case GlassCounterSize.large:
        return 48.0;
    }
  }

  double _getWidth() {
    switch (widget.size) {
      case GlassCounterSize.small:
        return 28.0;
      case GlassCounterSize.medium:
        return 36.0;
      case GlassCounterSize.large:
        return 44.0;
    }
  }

  double _getFontSize() {
    switch (widget.size) {
      case GlassCounterSize.small:
        return 12.0;
      case GlassCounterSize.medium:
        return 15.0;
      case GlassCounterSize.large:
        return 18.0;
    }
  }

  double _getIconSize() {
    switch (widget.size) {
      case GlassCounterSize.small:
        return 14.0;
      case GlassCounterSize.medium:
        return 18.0;
      case GlassCounterSize.large:
        return 22.0;
    }
  }

  ThemeData? get theme => Theme.of(context, nullOk: true);
}

enum GlassCounterSize {
  small,
  medium,
  large,
}

/// Stepper indicator for onboarding
class GlassStepper extends StatefulWidget {
  final int stepCount;
  final int currentStep;
  final Function(int)? onStepTapped;
  final double height;
  final Color? activeColor;
  final Color? inactiveColor;

  const GlassStepper({
    super.key,
    required this.stepCount,
    this.currentStep = 0,
    this.onStepTapped,
    this.height = 4,
    this.activeColor,
    this.inactiveColor,
  });

  @override
  State<GlassStepper> createState() => _GlassStepperState();
}

class _GlassStepperState extends State<GlassStepper> {
  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);
    final activeColor = widget.activeColor ?? GlassTheme.primary;
    final inactiveColor =
        widget.inactiveColor ?? theme.glassBorder.withOpacity(0.5);

    return Row(
      children: List.generate(widget.stepCount, (index) {
        final isActive = index <= widget.currentStep;
        final isCurrent = index == widget.currentStep;

        return Expanded(
          child: GestureDetector(
            onTap: widget.onStepTapped != null
                ? () => widget.onStepTapped!(index)
                : null,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: EdgeInsets.only(
                right: index < widget.stepCount - 1 ? 4 : 0,
              ),
              height: widget.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.height / 2),
                color: isActive ? activeColor : inactiveColor,
              ),
            ),
          ),
        );
      }),
    );
  }
}

/// Pagination controls
class GlassPagination extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Function(int) onPageChanged;
  final bool showFirstLast;
  final GlassPaginationSize size;

  const GlassPagination({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
    this.showFirstLast = true,
    this.size = GlassPaginationSize.medium,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showFirstLast)
          GlassIconButton.transparent(
            onPressed: currentPage > 0 ? () => onPageChanged(0) : null,
            icon: const Icon(Icons.first_page, size: 20),
            size: _getSize(),
          ),
        GlassIconButton.surface(
          onPressed: currentPage > 0 ? () => onPageChanged(currentPage - 1) : null,
          icon: const Icon(Icons.chevron_left, size: 20),
          size: _getSize(),
        ),
        const SizedBox(width: 8),
        Text(
          '${currentPage + 1} / $totalPages',
          style: TextStyle(
            fontSize: _getFontSize(),
            fontWeight: FontWeight.w600,
            color: theme.textPrimary,
          ),
        ),
        const SizedBox(width: 8),
        GlassIconButton.surface(
          onPressed: currentPage < totalPages - 1
              ? () => onPageChanged(currentPage + 1)
              : null,
          icon: const Icon(Icons.chevron_right, size: 20),
          size: _getSize(),
        ),
        if (showFirstLast)
          GlassIconButton.transparent(
            onPressed: currentPage < totalPages - 1
                ? () => onPageChanged(totalPages - 1)
                : null,
            icon: const Icon(Icons.last_page, size: 20),
            size: _getSize(),
          ),
      ],
    );
  }

  double _getSize() {
    switch (size) {
      case GlassPaginationSize.small:
        return 32.0;
      case GlassPaginationSize.medium:
        return 40.0;
      case GlassPaginationSize.large:
        return 48.0;
    }
  }

  double _getFontSize() {
    switch (size) {
      case GlassPaginationSize.small:
        return 11.0;
      case GlassPaginationSize.medium:
        return 13.0;
      case GlassPaginationSize.large:
        return 15.0;
    }
  }
}

enum GlassPaginationSize {
  small,
  medium,
  large,
}
