import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../ui/theme/glass_theme.dart';
import '../../domain/entities/delivery_slot_entity.dart';
import '../providers/checkout_state.dart';
import '../providers/delivery_slots_notifier.dart';

/// A glassmorphic card for displaying a delivery time slot
class DeliverySlotCard extends ConsumerWidget {
  final DeliverySlotEntity slot;
  final bool isSelected;
  final VoidCallback onTap;

  const DeliverySlotCard({
    super.key,
    required this.slot,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).extension<GlassTheme>()!;

    return GestureDetector(
      onTap: slot.isAvailable && !slot.isPast ? onTap : null,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _getBackgroundColor(theme),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _getBorderColor(theme),
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: theme.primaryColor.withOpacity(0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
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
                Text(
                  slot.formattedDate,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: _getTextColor(theme),
                  ),
                ),
                if (slot.additionalFee != null && slot.additionalFee! > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: theme.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '+\$${slot.additionalFee!.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: theme.primaryColor,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    slot.timeRange,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: _getTextColor(theme),
                    ),
                  ),
                ),
                if (isSelected)
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check,
                      size: 14,
                      color: Colors.white,
                    ),
                  ),
                if (!slot.isAvailable || slot.isPast)
                  Text(
                    slot.isPast ? 'Past' : 'Full',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: theme.textTertiaryColor,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              '${slot.remainingSlots} slots left',
              style: TextStyle(
                fontSize: 11,
                color: theme.textTertiaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getBackgroundColor(GlassTheme theme) {
    if (isSelected) {
      return theme.primaryColor.withOpacity(0.08);
    }
    if (!slot.isAvailable || slot.isPast) {
      return theme.glassSurfaceColor.withOpacity(0.3);
    }
    return theme.glassSurfaceColor.withOpacity(0.5);
  }

  Color _getBorderColor(GlassTheme theme) {
    if (isSelected) {
      return theme.primaryColor.withOpacity(0.3);
    }
    if (!slot.isAvailable || slot.isPast) {
      return theme.glassBorderColor.withOpacity(0.3);
    }
    return theme.glassBorderColor;
  }

  Color _getTextColor(GlassTheme theme) {
    if (!slot.isAvailable || slot.isPast) {
      return theme.textTertiaryColor;
    }
    return theme.textPrimaryColor;
  }
}

/// List of available delivery slots grouped by date
class DeliverySlotsList extends ConsumerWidget {
  const DeliverySlotsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(deliverySlotsNotifierProvider);
    final theme = GlassTheme.of(context);

    // Handle loading state
    if (state.status == DeliverySlotStatus.initial ||
        state.status == DeliverySlotStatus.loading) {
      return Center(
        child: CircularProgressIndicator(
          color: theme.primaryColor,
        ),
      );
    }

    // Handle error state
    if (state.status == DeliverySlotStatus.error) {
      return Center(
        child: Text(
          state.errorMessage ?? 'Failed to load delivery slots',
          style: TextStyle(
            fontSize: 14,
            color: theme.textSecondaryColor,
          ),
        ),
      );
    }

    // Handle loaded/selected states
    if (state.slots.isEmpty) {
      return const Center(
        child: Text('No delivery slots available'),
      );
    }

    // Group slots by date
    final groupedSlots = <String, List<DeliverySlotEntity>>{};
    for (final slot in state.slots) {
      final dateKey = '${slot.date.year}-${slot.date.month}-${slot.date.day}';
      groupedSlots.putIfAbsent(dateKey, () => []).add(slot);
    }

    return ListView.builder(
      itemCount: groupedSlots.length,
      itemBuilder: (context, index) {
        final dateKey = groupedSlots.keys.elementAt(index);
        final slots = groupedSlots[dateKey]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4, bottom: 12, top: 8),
              child: Text(
                slots.first.formattedDate.split(',').first == 'Today'
                    ? 'Today'
                    : slots.first.formattedDate.split(',').first == 'Tomorrow'
                        ? 'Tomorrow'
                        : slots.first.formattedDate,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: theme.textSecondaryColor,
                ),
              ),
            ),
            ...slots.map(
              (slot) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: DeliverySlotCard(
                  slot: slot,
                  isSelected: state.selectedSlot?.id == slot.id,
                  onTap: () => ref
                      .read(deliverySlotsNotifierProvider.notifier)
                      .selectSlot(slot),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }
}
