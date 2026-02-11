import 'package:flutter/material.dart';

import '../../domain/entities/delivery_slot_entity.dart';

/// Data model for delivery slots
class DeliverySlotModel {
  final String id;
  final String date;
  final String startTime;
  final String endTime;
  final bool isAvailable;
  final double? additionalFee;
  final int remainingSlots;

  const DeliverySlotModel({
    required this.id,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.isAvailable,
    this.additionalFee,
    required this.remainingSlots,
  });

  /// Convert to domain entity
  DeliverySlotEntity toEntity() {
    return DeliverySlotEntity(
      id: id,
      date: _parseDate(date),
      startTime: _parseTime(startTime),
      endTime: _parseTime(endTime),
      isAvailable: isAvailable,
      additionalFee: additionalFee,
      remainingSlots: remainingSlots,
    );
  }

  DateTime _parseDate(String dateStr) {
    // Parse date string in format "YYYY-MM-DD"
    final parts = dateStr.split('-');
    return DateTime(
      int.parse(parts[0]),
      int.parse(parts[1]),
      int.parse(parts[2]),
    );
  }

  TimeOfDay _parseTime(String timeStr) {
    // Parse time string in format "HH:mm"
    final parts = timeStr.split(':');
    return TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );
  }

  /// Create from domain entity
  static DeliverySlotModel fromEntity(DeliverySlotEntity entity) {
    return DeliverySlotModel(
      id: entity.id,
      date: '${entity.date.year}-${entity.date.month.toString().padLeft(2, '0')}-${entity.date.day.toString().padLeft(2, '0')}',
      startTime: '${entity.startTime.hour.toString().padLeft(2, '0')}:${entity.startTime.minute.toString().padLeft(2, '0')}',
      endTime: '${entity.endTime.hour.toString().padLeft(2, '0')}:${entity.endTime.minute.toString().padLeft(2, '0')}',
      isAvailable: entity.isAvailable,
      additionalFee: entity.additionalFee,
      remainingSlots: entity.remainingSlots,
    );
  }
}
