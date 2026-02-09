import 'package:flutter/material.dart';

/// Glass Design System Constants for Foodie Express
/// Matches the atomic design system from journey 2 HTML files

// Primary Colors
const Color primaryColor = Color(0xFFFF5E2B);
const Color primaryLight = Color(0xFFFF7A45);
const Color primaryDark = Color(0xFFE5451D);

// Background Colors
const Color backgroundLight = Color(0xFFF2F2F7);

// Glass Surface Colors
const Color glassSurfaceLight = Color(0xA6FFFFFF); // 65% white
const Color glassSurfaceMedium = Color(0x73FFFFFF); // 45% white
const Color glassSurfaceHeavy = Color(0x4DFFFFFF); // 30% white

// Glass Border Colors
const Color glassBorderLight = Color(0x99FFFFFF); // 60% white
const Color glassBorderMedium = Color(0x80FFFFFF); // 50% white

// Text Colors
const Color textPrimary = Color(0xFF1C1C1E);
const Color textSecondary = Color(0xFF6E6E73);
const Color textTertiary = Color(0xFF9E9E9E);

// Semantic Colors
const Color successGreen = Color(0xFF34C759);
const Color warningYellow = Color(0xFFFF9500);
const Color errorRed = Color(0xFFFF3B30);

// Rating Colors
const Color ratingGreen = Color(0xFFD1FAE5);
const Color ratingGreenText = Color(0xFF047857);
const Color ratingGray = Color(0xFFF3F4F6);
const Color ratingGrayText = Color(0xFF374151);
const Color promoBadgeBg = Color(0xFFFFEDD5);
const Color promoBadgeText = Color(0xFFC2410C);

// Mesh Gradient for main screens
const Gradient meshGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFFF2F2F7),
    Color(0xFFF8F0E8),
    Color(0xFFF0F8FF),
    Color(0xFFF2F2F7),
  ],
);

// Success Gradient for order success screen
const Gradient successGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFFE8F5E9),
    Color(0xFFFFF3E0),
    Color(0xFFE3F2FD),
    Color(0xFFF2F2F7),
  ],
);

// Glass Shadows
final BoxShadow glassShadow = BoxShadow(
  color: Colors.black.withOpacity(0.08),
  blurRadius: 32,
  offset: const Offset(0, 8),
);

final BoxShadow glassShadowStrong = BoxShadow(
  color: Colors.black.withOpacity(0.12),
  blurRadius: 48,
  offset: const Offset(0, 12),
);

final BoxShadow glowShadow = BoxShadow(
  color: primaryColor.withOpacity(0.25),
  blurRadius: 20,
  offset: const Offset(0, 0),
);

final BoxShadow buttonGlossShadow = BoxShadow(
  color: Colors.white.withOpacity(0.3),
  blurRadius: 1,
  offset: const Offset(0, 1),
  spreadRadius: 0,
);

// Border Radius Constants (matching Tailwind)
const BorderRadius largeRadius = BorderRadius.all(Radius.circular(56));
const BorderRadius cardRadius = BorderRadius.all(Radius.circular(24));
const BorderRadius largeCardRadius = BorderRadius.all(Radius.circular(24));
const BorderRadius bannerRadius = BorderRadius.all(Radius.circular(32));
const BorderRadius buttonRadius = BorderRadius.all(Radius.circular(16));
const BorderRadius searchBarRadius = BorderRadius.all(Radius.circular(24));
const BorderRadius locationBarRadius = BorderRadius.all(Radius.circular(12));
const BorderRadius fullRadius = BorderRadius.all(Radius.circular(9999));
const BorderRadius categoryIconRadius = BorderRadius.all(Radius.circular(9999));
const BorderRadius chipRadius = BorderRadius.all(Radius.circular(9999));
const BorderRadius filterChipRadius = BorderRadius.all(Radius.circular(20));
const BorderRadius panelRadius = BorderRadius.all(Radius.circular(40));

/// Glass decoration for containers
BoxDecoration glassDecoration({
  double opacity = 0.65,
  double borderOpacity = 0.6,
  BorderRadiusGeometry borderRadius = BorderRadius.zero,
  List<BoxShadow> shadows = const [],
}) {
  return BoxDecoration(
    color: Colors.white.withOpacity(opacity),
    borderRadius: borderRadius,
    border: Border.all(
      color: Colors.white.withOpacity(borderOpacity),
    ),
    boxShadow: shadows.isNotEmpty ? shadows : [glassShadow],
  );
}

/// Primary button decoration
BoxDecoration primaryButtonDecoration({
  bool disabled = false,
  BorderRadiusGeometry borderRadius = buttonRadius,
}) {
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: disabled
          ? [Colors.grey.shade400, Colors.grey.shade500]
          : [primaryLight, primaryColor],
    ),
    borderRadius: borderRadius,
    border: Border.all(
      color: primaryColor.withOpacity(0.1),
      width: 0.5,
    ),
    boxShadow: [
      if (!disabled)
        BoxShadow(
          color: primaryColor.withOpacity(0.35),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      buttonGlossShadow,
    ],
  );
}

/// Section decoration for glass sections
BoxDecoration sectionDecoration({
  double opacity = 0.45,
  double borderOpacity = 0.5,
  double blur = 20,
}) {
  return BoxDecoration(
    color: Colors.white.withOpacity(opacity),
    borderRadius: cardRadius,
    border: Border.all(
      color: Colors.white.withOpacity(borderOpacity),
    ),
  );
}

/// Horizontal card decoration
BoxDecoration horizontalCardDecoration({
  double opacity = 0.55,
  double borderOpacity = 0.5,
  double blur = 25,
}) {
  return BoxDecoration(
    color: Colors.white.withOpacity(opacity),
    borderRadius: cardRadius,
    border: Border.all(
      color: Colors.white.withOpacity(borderOpacity),
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.04),
        blurRadius: 20,
        offset: Offset(0, 4),
      ),
    ],
  );
}

/// Input decoration for glass inputs
InputDecoration glassInputDecoration({
  required String hintText,
  IconData? prefixIcon,
  Widget? suffixIcon,
  EdgeInsetsGeometry contentPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
}) {
  return InputDecoration(
    hintText: hintText,
    prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: textSecondary) : null,
    suffixIcon: suffixIcon,
    filled: true,
    fillColor: Colors.white.withOpacity(0.6),
    contentPadding: contentPadding,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(24),
      borderSide: BorderSide(
        color: Colors.white.withOpacity(0.5),
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(24),
      borderSide: BorderSide(
        color: Colors.white.withOpacity(0.5),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(24),
      borderSide: BorderSide(
        color: primaryColor.withOpacity(0.3),
        width: 2,
      ),
    ),
  );
}
