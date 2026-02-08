import 'package:flutter/material.dart';

/// Glassmorphism Theme Extension
/// Provides custom colors and effects for the glass design system
class GlassTheme extends ThemeExtension<GlassTheme> {
  // Primary Colors
  static const Color primary = Color(0xFFFF5E2B);
  static const Color primaryLight = Color(0xFFFF7A45);
  static const Color primaryDark = Color(0xFFE54E1F);

  // Glass Surface Colors
  static const Color glassSurface = Color(0xA6FFFFFF); // rgba(255, 255, 255, 0.65)
  static const Color glassSurfaceLight = Color(0xCCFFFFFF); // rgba(255, 255, 255, 0.8)
  static const Color glassBorder = Color(0x66FFFFFF); // rgba(255, 255, 255, 0.4)
  static const Color glassBorderLight = Color(0x99FFFFFF); // rgba(255, 255, 255, 0.6)

  // Glass Input Colors
  static const Color glassInputBg = Color(0x80FFFFFF); // rgba(255, 255, 255, 0.5)
  static const Color glassInputBorder = Color(0x0D000000); // rgba(0, 0, 0, 0.05)

  // Background Colors
  static const Color backgroundLight = Color(0xFFF2F2F7);
  static const Color surfaceLight = Color(0xFFFFFFFF);

  // Status Colors
  static const Color success = Color(0xFF34C759);
  static const Color warning = Color(0xFFFF9500);
  static const Color error = Color(0xFFFF3B30);
  static const Color info = Color(0xFF007AFF);

  // Text Colors
  static const Color textPrimary = Color(0xFF1C1C1E);
  static const Color textSecondary = Color(0xFF636366);
  static const Color textTertiary = Color(0xFF8E8E93);
  static const Color textInverse = Color(0xFFFFFFFF);

  // Dark Mode Colors
  static const Color glassSurfaceDark = Color(0x40000000); // rgba(0, 0, 0, 0.25)
  static const Color glassBorderDark = Color(0x40FFFFFF); // rgba(255, 255, 255, 0.25)
  static const Color backgroundDark = Color(0xFF1C1C1E);
  static const Color surfaceDark = Color(0xFF2C2C2E);

  final Color primaryColor;
  final Color glassSurfaceColor;
  final Color glassBorderColor;
  final Color glassInputBgColor;
  final Color glassInputBorderColor;
  final Color background;
  final Color surface;
  final Color textPrimaryColor;
  final Color textSecondaryColor;
  final Color textTertiaryColor;
  final Color dividerColor;

  GlassTheme({
    required this.primaryColor,
    required this.glassSurfaceColor,
    required this.glassBorderColor,
    required this.glassInputBgColor,
    required this.glassInputBorderColor,
    required this.background,
    required this.surface,
    required this.textPrimaryColor,
    required this.textSecondaryColor,
    required this.textTertiaryColor,
    required this.dividerColor,
  });

  /// Light theme configuration
  static GlassTheme light = GlassTheme(
    primaryColor: primary,
    glassSurfaceColor: glassSurface,
    glassBorderColor: glassBorderLight,
    glassInputBgColor: glassInputBg,
    glassInputBorderColor: glassInputBorder,
    background: backgroundLight,
    surface: surfaceLight,
    textPrimaryColor: textPrimary,
    textSecondaryColor: textSecondary,
    textTertiaryColor: textTertiary,
    dividerColor: const Color(0x1A000000),
  );

  /// Dark theme configuration
  static GlassTheme dark = GlassTheme(
    primaryColor: primary,
    glassSurfaceColor: glassSurfaceDark,
    glassBorderColor: glassBorderDark,
    glassInputBgColor: const Color(0x33FFFFFF),
    glassInputBorderColor: const Color(0x1AFFFFFF),
    background: backgroundDark,
    surface: surfaceDark,
    textPrimaryColor: textInverse,
    textSecondaryColor: const Color(0xFFEBEBF5),
    textTertiaryColor: const Color(0xFF636366),
    dividerColor: const Color(0x1AFFFFFF),
  );

  @override
  ThemeExtension<GlassTheme> copyWith({
    Color? primaryColor,
    Color? glassSurface,
    Color? glassBorder,
    Color? glassInputBg,
    Color? glassInputBorder,
    Color? background,
    Color? surface,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? dividerColor,
  }) {
    return GlassTheme(
      primaryColor: primaryColor ?? this.primaryColor,
      glassSurfaceColor: glassSurface ?? this.glassSurfaceColor,
      glassBorderColor: glassBorder ?? this.glassBorderColor,
      glassInputBgColor: glassInputBg ?? this.glassInputBgColor,
      glassInputBorderColor: glassInputBorder ?? this.glassInputBorderColor,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      textPrimaryColor: textPrimary ?? this.textPrimaryColor,
      textSecondaryColor: textSecondary ?? this.textSecondaryColor,
      textTertiaryColor: textTertiary ?? this.textTertiaryColor,
      dividerColor: dividerColor ?? this.dividerColor,
    );
  }

  @override
  ThemeExtension<GlassTheme> lerp(covariant ThemeExtension<GlassTheme>? other, double t) {
    if (other is! GlassTheme) return this;
    return GlassTheme(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
      glassSurfaceColor: Color.lerp(glassSurfaceColor, other.glassSurfaceColor, t)!,
      glassBorderColor: Color.lerp(glassBorderColor, other.glassBorderColor, t)!,
      glassInputBgColor: Color.lerp(glassInputBgColor, other.glassInputBgColor, t)!,
      glassInputBorderColor: Color.lerp(glassInputBorderColor, other.glassInputBorderColor, t)!,
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      textPrimaryColor: Color.lerp(textPrimaryColor, other.textPrimaryColor, t)!,
      textSecondaryColor: Color.lerp(textSecondaryColor, other.textSecondaryColor, t)!,
      textTertiaryColor: Color.lerp(textTertiaryColor, other.textTertiaryColor, t)!,
      dividerColor: Color.lerp(dividerColor, other.dividerColor, t)!,
    );
  }

  /// Get current GlassTheme from context
  static GlassTheme of(BuildContext context) {
    return Theme.of(context).extension<GlassTheme>() ?? light;
  }
}

/// Extension for quick access to glass theme colors
extension GlassColors on BuildContext {
  GlassTheme get glass => GlassTheme.of(this);

  Color get primaryColor => glass.primaryColor;
  Color get glassSurface => glass.glassSurfaceColor;
  Color get glassBorder => glass.glassBorderColor;
  Color get glassInputBg => glass.glassInputBgColor;
  Color get glassInputBorder => glass.glassInputBorderColor;
  Color get backgroundColor => glass.background;
  Color get surfaceColor => glass.surface;
  Color get textPrimaryColor => glass.textPrimaryColor;
  Color get textSecondaryColor => glass.textSecondaryColor;
  Color get textTertiaryColor => glass.textTertiaryColor;
}

/// Glassmorphism box decoration builder
class GlassDecoration {
  /// Panel glass effect - used for main containers
  static BoxDecoration panel({
    required BuildContext context,
    double blur = 50,
    double borderOpacity = 0.6,
  }) {
    final theme = GlassTheme.of(context);
    return BoxDecoration(
      color: theme.glassSurfaceColor,
      border: Border.all(
        color: theme.glassBorderColor.withOpacity(borderOpacity),
      ),
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 32,
          offset: const Offset(0, 8),
        ),
      ],
    );
  }

  /// Atom glass effect - used for smaller components
  static BoxDecoration atom({
    required BuildContext context,
    double blur = 30,
    double borderOpacity = 0.6,
    BorderRadiusGeometry borderRadius = const BorderRadius.all(Radius.circular(20)),
  }) {
    final theme = GlassTheme.of(context);
    return BoxDecoration(
      color: theme.glassSurfaceColor.withOpacity(0.5),
      border: Border.all(
        color: theme.glassBorderColor.withOpacity(borderOpacity),
      ),
      borderRadius: borderRadius,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.03),
          blurRadius: blur / 2,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  /// Input glass effect - used for text fields
  static BoxDecoration input({
    required BuildContext context,
    BorderRadiusGeometry borderRadius = const BorderRadius.all(Radius.circular(16)),
    Color? backgroundColor,
    Color? borderColor,
  }) {
    final theme = GlassTheme.of(context);
    return BoxDecoration(
      color: backgroundColor ?? theme.glassInputBgColor,
      border: Border.all(
        color: borderColor ?? theme.glassInputBorderColor,
      ),
      borderRadius: borderRadius,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.03),
          blurRadius: 4,
          offset: const Offset(0, 1),
        ),
      ],
    );
  }

  /// Strong glass effect for prominent elements
  static BoxDecoration strong({
    required BuildContext context,
    double blur = 60,
    BorderRadiusGeometry borderRadius = const BorderRadius.all(Radius.circular(28)),
  }) {
    final theme = GlassTheme.of(context);
    return BoxDecoration(
      color: theme.glassSurfaceColor,
      border: Border.all(
        color: theme.glassBorderColor,
      ),
      borderRadius: borderRadius,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.12),
          blurRadius: blur / 2,
          offset: const Offset(0, 8),
        ),
      ],
    );
  }
}

/// Gradient backgrounds
class GlassGradients {
  /// Mesh gradient background for main screens
  static const List<Color> meshGradient = [
    Color(0xFFFFF0E6), // Light peach
    Color(0xFFE6F4FF), // Light blue
    Color(0xFFFFE6F0), // Light pink
    Color(0xFFE6FFF5), // Light green
  ];

  /// Button gradient for primary buttons
  static const LinearGradient primaryButton = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFFF7A45), // Light orange
      Color(0xFFFF5E2B), // Primary orange
    ],
  );

  /// Button gloss overlay gradient
  static const LinearGradient buttonGloss = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Colors.white38,
      Colors.white10,
      Color(0x0DFFFFFF), // 5% white
    ],
  );

  /// Frosted wireframe gradient
  static LinearGradient frosted({
    required Color surfaceColor,
    required Color highlightColor,
  }) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        surfaceColor,
        highlightColor.withOpacity(0.3),
      ],
    );
  }
}

/// Common text styles for the glass design system
class GlassTextStyles {
  static TextStyle displayLarge(BuildContext context) {
    return const TextStyle(
      fontSize: 34,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.02,
      height: 1.1,
    );
  }

  static TextStyle displayMedium(BuildContext context) {
    return const TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.02,
      height: 1.15,
    );
  }

  static TextStyle displaySmall(BuildContext context) {
    return const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.01,
      height: 1.2,
    );
  }

  static TextStyle headlineLarge(BuildContext context) {
    return const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.01,
      height: 1.25,
    );
  }

  static TextStyle headlineMedium(BuildContext context) {
    return const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      height: 1.3,
    );
  }

  static TextStyle headlineSmall(BuildContext context) {
    return const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      height: 1.35,
    );
  }

  static TextStyle titleLarge(BuildContext context) {
    return const TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w600,
      height: 1.35,
    );
  }

  static TextStyle titleMedium(BuildContext context) {
    return const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      height: 1.4,
    );
  }

  static TextStyle titleSmall(BuildContext context) {
    return const TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      height: 1.4,
    );
  }

  static TextStyle bodyLarge(BuildContext context) {
    return const TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w400,
      height: 1.4,
    );
  }

  static TextStyle bodyMedium(BuildContext context) {
    return const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      height: 1.4,
    );
  }

  static TextStyle bodySmall(BuildContext context) {
    return const TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w400,
      height: 1.4,
    );
  }

  static TextStyle labelLarge(BuildContext context) {
    return const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      height: 1.35,
    );
  }

  static TextStyle labelMedium(BuildContext context) {
    return const TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      height: 1.4,
    );
  }

  static TextStyle labelSmall(BuildContext context) {
    return const TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w600,
      height: 1.4,
      letterSpacing: 0.5,
    );
  }

  static TextStyle caption(BuildContext context) {
    return const TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      height: 1.4,
    );
  }
}

/// Shadow constants for the glass design system
class GlassShadows {
  /// Default glass shadow
  static const BoxShadow glass = BoxShadow(
    color: Color(0x0D000000),
    blurRadius: 8,
    offset: Offset(0, 4),
  );

  /// Strong glass shadow
  static const BoxShadow glassStrong = BoxShadow(
    color: Color(0x14000000),
    blurRadius: 24,
    offset: Offset(0, 12),
  );

  /// Inset shadow for pressed states
  static const BoxShadow glassInset = BoxShadow(
    color: Color(0x08000000),
    blurRadius: 8,
    offset: Offset(0, 2),
    spreadRadius: -1,
  );

  /// Primary color glow shadow
  static const BoxShadow glow = BoxShadow(
    color: Color(0x40FF5E2B),
    blurRadius: 20,
    offset: Offset(0, 0),
  );

  /// Button gloss shadow
  static const BoxShadow buttonGloss = BoxShadow(
    color: Color(0x4DFF5E2B),
    blurRadius: 12,
    offset: Offset(0, 4),
  );
}
