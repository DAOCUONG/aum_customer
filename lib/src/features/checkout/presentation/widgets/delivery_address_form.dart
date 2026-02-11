import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../ui/theme/glass_theme.dart';
import '../../domain/entities/delivery_address_entity.dart';
import '../providers/checkout_notifier.dart';

/// A glassmorphic card for displaying and editing delivery address
class DeliveryAddressCard extends ConsumerWidget {
  final DeliveryAddressEntity address;
  final VoidCallback onEdit;
  final VoidCallback onChangeAddress;

  const DeliveryAddressCard({
    super.key,
    required this.address,
    required this.onEdit,
    required this.onChangeAddress,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).extension<GlassTheme>()!;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.glassSurfaceColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.glassBorderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: theme.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getIconForLabel(address.label),
                      size: 14,
                      color: theme.primaryColor,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    address.label,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: theme.textSecondaryColor,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: onChangeAddress,
                child: Text(
                  'Change',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: theme.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            address.streetAddress,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: theme.textPrimaryColor,
            ),
          ),
          if (address.apartment != null && address.apartment!.isNotEmpty)
            Text(
              address.apartment!,
              style: TextStyle(
                fontSize: 13,
                color: theme.textSecondaryColor,
              ),
            ),
          Text(
            '${address.city}, ${address.state} ${address.zipCode}',
            style: TextStyle(
              fontSize: 13,
              color: theme.textSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconForLabel(String label) {
    final lowerLabel = label.toLowerCase();
    if (lowerLabel.contains('home')) return Icons.home;
    if (lowerLabel.contains('work') || lowerLabel.contains('office')) return Icons.work;
    if (lowerLabel.contains('friend') || lowerLabel.contains('family')) return Icons.people;
    return Icons.location_on;
  }
}

/// Input form for delivery instructions
class DeliveryInstructionsForm extends ConsumerWidget {
  final TextEditingController controller;

  const DeliveryInstructionsForm({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).extension<GlassTheme>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Delivery Instructions',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: theme.textTertiaryColor,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: theme.glassInputBgColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: theme.glassInputBorderColor),
          ),
          child: TextField(
            controller: controller,
            maxLines: 2,
            decoration: InputDecoration(
              hintText: 'Gate code, drop-off details...',
              hintStyle: TextStyle(color: theme.textSecondaryColor),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(12),
            ),
            style: TextStyle(
              fontSize: 14,
              color: theme.textPrimaryColor,
            ),
            onChanged: (value) =>
                ref.read(checkoutNotifierProvider.notifier).setDeliveryInstructions(value),
          ),
        ),
      ],
    );
  }
}

/// Checkbox row for delivery options
class DeliveryOptionCheckbox extends StatelessWidget {
  final String label;
  final String? subtitle;
  final bool isChecked;
  final ValueChanged<bool?> onChanged;

  const DeliveryOptionCheckbox({
    super.key,
    required this.label,
    this.subtitle,
    required this.isChecked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<GlassTheme>()!;

    return GestureDetector(
      onTap: () => onChanged(!isChecked),
      child: Row(
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: Checkbox(
              value: isChecked,
              onChanged: onChanged,
              activeColor: theme.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: theme.textPrimaryColor,
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: TextStyle(
                      fontSize: 12,
                      color: theme.textSecondaryColor,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
