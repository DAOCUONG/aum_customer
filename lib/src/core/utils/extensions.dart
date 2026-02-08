import 'package:flutter/material.dart';

/// Extension methods for BuildContext
extension BuildContextX on BuildContext {
  /// Get screen size
  Size get screenSize => MediaQuery.of(this).size;

  /// Get screen width
  double get screenWidth => screenSize.width;

  /// Get screen height => screenSize.height;

  /// Check if screen is small (< 600px)
  bool get isSmallScreen => screenWidth < 600;

  /// Check if screen is medium (600-840px)
  bool get isMediumScreen => screenWidth >= 600 && screenWidth < 840;

  /// Check if screen is large (> 840px)
  bool get isLargeScreen => screenWidth >= 840;

  /// Get safe area padding
  EdgeInsets get safeAreaPadding => MediaQuery.of(this).padding;

  /// Get bottom safe area
  double get bottomSafePadding => safeAreaPadding.bottom;

  /// Get top safe area
  double get topSafePadding => safeAreaPadding.top;

  /// Check if keyboard is visible
  bool get isKeyboardVisible => MediaQuery.of(this).viewInsets.bottom > 0;

  /// Get keyboard height
  double get keyboardHeight => MediaQuery.of(this).viewInsets.bottom;
}

/// Extension methods for String
extension StringX on String {
  /// Check if string is a valid email
  bool get isValidEmail {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(this);
  }

  /// Check if string is a valid phone number (basic validation)
  bool get isValidPhone {
    final phoneRegex = RegExp(r'^\+?[0-9]{10,15}$');
    return phoneRegex.hasMatch(this);
  }

  /// Capitalize first letter
  String get capitalizeFirst {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  /// Capitalize each word
  String get capitalizeWords {
    return split(' ').map((word) => word.capitalizeFirst).join(' ');
  }
}

/// Extension methods for DateTime
extension DateTimeX on DateTime {
  /// Check if date is today
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Check if date is yesterday
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  /// Format to readable date string
  String toReadableDate() {
    return '${month}/${day}/${year}';
  }

  /// Format to readable time string
  String toReadableTime() {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }
}

/// Extension methods for List
extension ListX<T> on List<T> {
  /// Safe get element at index
  T? safeGet(int index) {
    if (index < 0 || index >= length) return null;
    return this[index];
  }

  /// Check if index is valid
  bool isValidIndex(int index) => index >= 0 && index < length;
}

/// Extension methods for AsyncSnapshot
extension AsyncSnapshotX<T> on AsyncSnapshot<T> {
  /// Check if has data
  bool get hasData => hasData;

  /// Check if is waiting
  bool get isWaiting => connectionState == ConnectionState.waiting;

  /// Check if has error
  bool get hasError => hasError;

  /// Get error message if available
  String? get errorMessage =>
      hasError ? (error as dynamic)?.toString() : null;
}
