import 'package:flutter/material.dart';
import '../theme/glass_design_system.dart';

/// Glass Quantity Stepper - For increment/decrement
class GlassQuantityStepper extends StatefulWidget {
  final int quantity;
  final Function(int) onQuantityChanged;
  final double size;

  const GlassQuantityStepper({
    super.key,
    required this.quantity,
    required this.onQuantityChanged,
    this.size = 36,
  });

  @override
  State<GlassQuantityStepper> createState() => _GlassQuantityStepperState();
}

class _GlassQuantityStepperState extends State<GlassQuantityStepper> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.size,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(widget.size / 2),
        border: Border.all(color: Colors.white.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildMinusButton(),
          SizedBox(
            width: widget.size - 8,
            child: Center(
              child: Text(
                '${widget.quantity}',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: textPrimary,
                ),
              ),
            ),
          ),
          _buildPlusButton(),
        ],
      ),
    );
  }

  Widget _buildMinusButton() {
    return GestureDetector(
      onTap: widget.quantity > 1
          ? () => widget.onQuantityChanged(widget.quantity - 1)
          : null,
      child: Container(
        width: widget.size - 8,
        height: widget.size - 8,
        decoration: BoxDecoration(
          color: widget.quantity > 1 ? Colors.white : Colors.white.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.remove,
          size: 16,
          color: widget.quantity > 1 ? textPrimary : textSecondary,
        ),
      ),
    );
  }

  Widget _buildPlusButton() {
    return GestureDetector(
      onTap: () => widget.onQuantityChanged(widget.quantity + 1),
      child: Container(
        width: widget.size - 8,
        height: widget.size - 8,
        decoration: const BoxDecoration(
          color: primaryColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: primaryColor,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: const Icon(
          Icons.add,
          size: 16,
          color: Colors.white,
        ),
      ),
    );
  }
}

/// Glass Promo Input - For promo codes
class GlassPromoInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onApply;

  const GlassPromoInput({
    super.key,
    required this.controller,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: buttonRadius,
        border: Border.all(color: Colors.white.withOpacity(0.5)),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Enter promo code',
          hintStyle: TextStyle(color: textSecondary),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: Icon(
              Icons.local_offer,
              size: 20,
              color: textSecondary,
            ),
          ),
          suffixIcon: GestureDetector(
            onTap: onApply,
            child: Container(
              margin: const EdgeInsets.all(4),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Apply',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }
}

/// Glass Divider with gradient
class GlassGradientDivider extends StatelessWidget {
  final double height;
  final List<Color> colors;

  const GlassGradientDivider({
    super.key,
    this.height = 1,
    this.colors = const [
      Colors.transparent,
      Colors.black,
      Colors.black,
      Colors.transparent,
    ],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.transparent,
            Colors.black.withOpacity(0.08),
            Colors.black.withOpacity(0.08),
            Colors.transparent,
          ],
        ),
      ),
    );
  }
}
