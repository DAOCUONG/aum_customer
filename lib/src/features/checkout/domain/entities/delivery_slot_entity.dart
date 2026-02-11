import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'delivery_slot_entity.freezed.dart';

/// Entity representing a delivery time slot
@freezed
class DeliverySlotEntity with _$DeliverySlotEntity {
  const factory DeliverySlotEntity({
    required String id,
    required DateTime date,
    required TimeOfDay startTime,
    required TimeOfDay endTime,
    required bool isAvailable,
    required double? additionalFee,
    required int remainingSlots,
  }) = _DeliverySlotEntity;

  const DeliverySlotEntity._();

  /// Formatted time range string (e.g., "10:00 AM - 12:00 PM")
  String get timeRange {
    final start = _formatTime(startTime);
    final end = _formatTime(endTime);
    return '$start - $end';
  }

  /// Formatted date string (e.g., "Today, Jan 15")
  String get formattedDate {
    final now = DateTime.now();
    final tomorrow = DateTime.now().add(const Duration(days: 1));

    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      return 'Today, ${_formatDate(date)}';
    }
    if (date.year == tomorrow.year &&
        date.month == tomorrow.month &&
        date.day == tomorrow.day) {
      return 'Tomorrow, ${_formatDate(date)}';
    }
    return _formatDate(date);
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hour;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '$displayHour:$minute $period';
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[date.month - 1]} ${date.day}';
  }

  /// Check if slot is in the past
  bool get isPast {
    final now = DateTime.now();
    final slotDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      startTime.hour,
      startTime.minute,
    );
    return slotDateTime.isBefore(now);
  }
}
