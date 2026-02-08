import 'package:flutter/material.dart';
import '../theme/glass_design_system.dart';

/// Glass Date Chip for delivery date selection
class GlassDateChip extends StatelessWidget {
  final String dayLabel;
  final int dateNumber;
  final bool isActive;
  final VoidCallback onTap;

  const GlassDateChip({
    super.key,
    required this.dayLabel,
    required this.dateNumber,
    this.isActive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 72,
        height: 78,
        decoration: BoxDecoration(
          color: isActive ? primaryColor : Colors.white.withValues(alpha: 0.4),
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          border: Border.all(
            color: isActive ? primaryColor.withValues(alpha: 0.2) : Colors.white.withValues(alpha: 0.5),
          ),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: primaryColor.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              dayLabel,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: isActive ? Colors.white.withValues(alpha: 0.8) : textTertiary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '$dateNumber',
              style: TextStyle(
                fontSize: 24,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
                color: isActive ? Colors.white : textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Glass Time Slot Card for delivery time selection
class GlassTimeSlotCard extends StatelessWidget {
  final String timeRange;
  final String? label;
  final bool isSelected;
  final bool isUnavailable;
  final IconData? icon;
  final VoidCallback onTap;

  const GlassTimeSlotCard({
    super.key,
    required this.timeRange,
    this.label,
    this.isSelected = false,
    this.isUnavailable = false,
    this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isUnavailable ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isUnavailable
              ? Colors.white.withValues(alpha: 0.2)
              : isSelected
                  ? Colors.white.withValues(alpha: 0.85)
                  : Colors.white.withValues(alpha: 0.5),
          borderRadius: const BorderRadius.all(Radius.circular(24)),
          border: Border.all(
            color: isSelected
                ? primaryColor.withValues(alpha: 0.3)
                : Colors.white.withValues(alpha: 0.6),
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: primaryColor.withValues(alpha: 0.15),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: isUnavailable
                    ? Colors.grey.shade200
                    : isSelected
                        ? primaryColor.withValues(alpha: 0.1)
                        : Colors.white.withValues(alpha: 0.5),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: Icon(
                isUnavailable ? Icons.block : icon ?? Icons.schedule,
                size: 22,
                color: isUnavailable ? Colors.grey.shade400 : (isSelected ? primaryColor : textSecondary),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    timeRange,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: isUnavailable ? FontWeight.w500 : FontWeight.w600,
                      color: isUnavailable ? textTertiary : textPrimary,
                    ),
                  ),
                  if (label != null)
                    Text(
                      label!,
                      style: TextStyle(
                        fontSize: 12,
                        color: isUnavailable ? textTertiary : (isSelected ? primaryColor : textSecondary),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                ],
              ),
            ),
            // Radio indicator
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isUnavailable ? Colors.transparent : (isSelected ? primaryColor : Colors.transparent),
                border: Border.all(
                  color: isUnavailable ? Colors.grey.shade300 : (isSelected ? primaryColor : textTertiary),
                  width: 2,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: isSelected && !isUnavailable
                  ? const Icon(Icons.check, size: 12, color: Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

/// Glass Info Card for delivery estimates
class GlassInfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color? iconColor;

  const GlassInfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50.withValues(alpha: 0.45),
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.shade100.withValues(alpha: 0.5),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Icon(
              icon,
              size: 20,
              color: iconColor ?? Colors.blue.shade600,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: textSecondary,
                    height: 1.4,
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

/// Glass Delivery Summary Card
class GlassDeliverySummary extends StatelessWidget {
  final String selectedDate;
  final String selectedTime;
  final VoidCallback onEditTap;

  const GlassDeliverySummary({
    super.key,
    required this.selectedDate,
    required this.selectedTime,
    required this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.4),
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          Text(
            'Selected Time',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: textSecondary,
            ),
          ),
          const Spacer(),
          Text(
            '$selectedDate, $selectedTime',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
