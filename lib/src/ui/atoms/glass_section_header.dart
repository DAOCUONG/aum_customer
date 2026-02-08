import 'package:flutter/material.dart';
import '../theme/glass_design_system.dart';

/// Glass Section Header with Number Badge
class GlassSectionHeader extends StatelessWidget {
  final int number;
  final String title;
  final bool hasAction;
  final VoidCallback? onActionTap;

  const GlassSectionHeader({
    super.key,
    required this.number,
    required this.title,
    this.hasAction = false,
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Number Badge
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Text(
              '$number',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Title
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: textPrimary,
          ),
        ),
        const Spacer(),
        if (hasAction && onActionTap != null)
          GestureDetector(
            onTap: onActionTap,
            child: Text(
              'Edit',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: primaryColor,
              ),
            ),
          ),
      ],
    );
  }
}

/// Glass Delivery Address Card
class GlassDeliveryCard extends StatelessWidget {
  final String addressType;
  final String address;
  final VoidCallback? onTap;

  const GlassDeliveryCard({
    super.key,
    required this.addressType,
    required this.address,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.4),
          borderRadius: cardRadius,
          border: Border.all(color: Colors.white.withOpacity(0.5)),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.home,
                size: 24,
                color: textSecondary,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  addressType,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: textTertiary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  address,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: textPrimary,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Icon(
              Icons.chevron_right,
              size: 20,
              color: textTertiary,
            ),
          ],
        ),
      ),
    );
  }
}

/// Glass Text Area for delivery instructions
class GlassTextArea extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final int maxLines;

  const GlassTextArea({
    super.key,
    this.hintText = 'Add delivery instructions...',
    this.controller,
    this.maxLines = 3,
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
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: textSecondary),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(12),
        ),
        style: const TextStyle(
          fontSize: 14,
          color: textPrimary,
        ),
      ),
    );
  }
}

/// Glass Payment Card
class GlassPaymentCard extends StatelessWidget {
  final String method;
  final String lastFour;
  final bool isSelected;
  final VoidCallback? onTap;

  const GlassPaymentCard({
    super.key,
    required this.method,
    required this.lastFour,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.4),
          borderRadius: cardRadius,
          border: Border.all(
            color: isSelected
                ? primaryColor.withOpacity(0.3)
                : Colors.white.withOpacity(0.5),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  method.substring(0, 1).toUpperCase(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    method,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '**** $lastFour',
                    style: TextStyle(
                      fontSize: 13,
                      color: textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  size: 14,
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Glass Tip Selector
class GlassTipSelector extends StatelessWidget {
  final List<double> tipPercentages;
  final List<double> tipAmounts;
  final int selectedIndex;
  final Function(int) onSelect;
  final VoidCallback? onCustomTap;

  const GlassTipSelector({
    super.key,
    required this.tipPercentages,
    required this.tipAmounts,
    required this.selectedIndex,
    required this.onSelect,
    this.onCustomTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tip option chips
        Row(
          children: List.generate(tipPercentages.length, (index) {
            return Expanded(
              child: GestureDetector(
                onTap: () => onSelect(index),
                child: Container(
                  margin: EdgeInsets.only(right: index < tipPercentages.length - 1 ? 8 : 0),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: selectedIndex == index
                        ? primaryColor.withOpacity(0.1)
                        : Colors.white.withOpacity(0.4),
                    borderRadius: buttonRadius,
                    border: Border.all(
                      color: selectedIndex == index
                          ? primaryColor.withOpacity(0.3)
                          : Colors.white.withOpacity(0.5),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '${tipPercentages[index].toInt()}%',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: selectedIndex == index ? primaryColor : textPrimary,
                        ),
                      ),
                      Text(
                        '\$${tipAmounts[index].toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 11,
                          color: textTertiary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
        // Custom tip link
        if (onCustomTap != null)
          GestureDetector(
            onTap: onCustomTap,
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                'Or enter custom amount',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: primaryColor,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// Glass Price Breakdown Row
class GlassPriceRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  final bool isTotal;
  final Color? valueColor;

  const GlassPriceRow({
    super.key,
    required this.label,
    required this.value,
    this.isBold = false,
    this.isTotal = false,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isBold || isTotal ? FontWeight.w600 : FontWeight.w500,
            color: isTotal ? textPrimary : textSecondary,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 18 : 14,
            fontWeight: isBold || isTotal ? FontWeight.w700 : FontWeight.w500,
            color: valueColor ?? (isTotal ? textPrimary : textSecondary),
          ),
        ),
      ],
    );
  }
}

/// Glass Checkbox Row
class GlassCheckboxRow extends StatelessWidget {
  final String label;
  final String? subtitle;
  final String? price;
  final bool isChecked;
  final Function(bool) onChanged;

  const GlassCheckboxRow({
    super.key,
    required this.label,
    this.subtitle,
    this.price,
    required this.isChecked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!isChecked),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.4),
          borderRadius: buttonRadius,
          border: Border.all(color: Colors.white.withOpacity(0.5)),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isChecked ? primaryColor : Colors.transparent,
                border: Border.all(
                  color: isChecked ? primaryColor : textTertiary,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: isChecked
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: textPrimary,
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: TextStyle(
                        fontSize: 12,
                        color: textTertiary,
                      ),
                    ),
                ],
              ),
            ),
            if (price != null)
              Text(
                '+$price',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
