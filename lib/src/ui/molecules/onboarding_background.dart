import 'package:flutter/material.dart';
import '../theme/glass_theme.dart';
import '../atoms/glass_background.dart';
import '../atoms/glass_panel.dart';
import '../atoms/glass_atom.dart';
import 'animated_background.dart';

/// OnboardingBackground - Combined background for onboarding screens
class OnboardingBackground extends StatelessWidget {
  final Widget child;
  final bool enableMesh;
  final bool enableGlow;
  final Color? meshPrimaryColor;
  final Color? meshSecondaryColor;
  final List<Widget> floatingElements;
  final Widget? headerWidget;
  final Widget? footerWidget;

  const OnboardingBackground({
    super.key,
    required this.child,
    this.enableMesh = true,
    this.enableGlow = true,
    this.meshPrimaryColor,
    this.meshSecondaryColor,
    this.floatingElements = const [],
    this.headerWidget,
    this.footerWidget,
  });

  const OnboardingBackground.standard({
    super.key,
    required this.child,
    this.enableMesh = true,
    this.enableGlow = true,
    this.meshPrimaryColor,
    this.meshSecondaryColor,
    this.floatingElements = const [],
    this.headerWidget,
    this.footerWidget,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(
      enableMesh: enableMesh,
      enableGlow: enableGlow,
      child: Stack(
        children: [
          if (enableMesh)
            RadialMeshBackground(
              child: Container(),
              warmSpotColor: meshPrimaryColor ?? const Color(0xFFFFDCC8),
              coolSpotColor: meshSecondaryColor ?? const Color(0xFFC8E6FF),
            ),
          if (floatingElements.isNotEmpty)
            Positioned.fill(
              child: IgnorePointer(
                child: Stack(
                  children: floatingElements,
                ),
              ),
            ),
          Column(
            children: [
              if (headerWidget != null) headerWidget!,
              Expanded(child: child),
              if (footerWidget != null) footerWidget!,
            ],
          ),
        ],
      ),
    );
  }
}

/// OnboardingScreen - Complete onboarding screen wrapper
class OnboardingScreen extends StatelessWidget {
  final Widget progressIndicator;
  final Widget? skipButton;
  final Widget child;
  final Widget? continueButton;
  final EdgeInsetsGeometry? contentPadding;

  const OnboardingScreen({
    super.key,
    required this.progressIndicator,
    this.skipButton,
    required this.child,
    this.continueButton,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isLargeScreen = screenSize.height > 800;

    return OnboardingBackground(
      child: GlassPanel.screen(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isLargeScreen ? 420 : double.infinity,
            maxHeight: screenSize.height * 0.85,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 40),
                    progressIndicator,
                    if (skipButton != null) skipButton!,
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: contentPadding ??
                      EdgeInsets.only(
                        top: isLargeScreen ? 40 : 20,
                        bottom: 24,
                        left: 24,
                        right: 24,
                      ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [child],
                  ),
                ),
              ),
              if (continueButton != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  child: continueButton!,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// OnboardingCard - Glass card for onboarding content
class OnboardingCard extends StatelessWidget {
  final Widget? header;
  final Widget body;
  final Widget? footer;
  final EdgeInsetsGeometry? headerPadding;
  final EdgeInsetsGeometry? bodyPadding;
  final EdgeInsetsGeometry? footerPadding;
  final BorderRadiusGeometry? borderRadius;

  const OnboardingCard({
    super.key,
    this.header,
    required this.body,
    this.footer,
    this.headerPadding,
    this.bodyPadding,
    this.footerPadding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.width > 600;

    return GlassPanel.screen(
      borderRadius: borderRadius ??
          (isTablet ? const BorderRadius.all(Radius.circular(56)) : BorderRadius.zero),
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (header != null)
            Padding(
              padding: headerPadding ?? const EdgeInsets.fromLTRB(24, 24, 24, 16),
              child: header,
            ),
          Expanded(
            child: Padding(
              padding: bodyPadding ?? const EdgeInsets.symmetric(horizontal: 24),
              child: body,
            ),
          ),
          if (footer != null)
            Padding(
              padding: footerPadding ?? const EdgeInsets.fromLTRB(24, 16, 24, 24),
              child: footer,
            ),
        ],
      ),
    );
  }
}

/// DecorativeFloatingElements - Pre-built floating elements
class DecorativeFloatingElements extends StatelessWidget {
  final bool includeDonut;
  final bool includeDrink;
  final bool includeAddButton;
  final double? elementSize;

  const DecorativeFloatingElements({
    super.key,
    this.includeDonut = true,
    this.includeDrink = true,
    this.includeAddButton = true,
    this.elementSize,
  });

  @override
  Widget build(BuildContext context) {
    final size = elementSize ?? 48.0;

    return Stack(
      children: [
        if (includeDonut)
          Positioned(
            top: 0.20 * MediaQuery.of(context).size.height,
            right: 0.08 * MediaQuery.of(context).size.width,
            child: GlassFloatingElement.rotated(
              size: size,
              child: const Text('🍩', style: TextStyle(fontSize: 24)),
            ),
          ),
        if (includeDrink)
          Positioned(
            bottom: 0.22 * MediaQuery.of(context).size.height,
            left: 0.05 * MediaQuery.of(context).size.width,
            child: GlassFloatingElement.inverted(
              size: size,
              child: const Text('🥤', style: TextStyle(fontSize: 24)),
            ),
          ),
        if (includeAddButton)
          Positioned(
            top: 0.40 * MediaQuery.of(context).size.height,
            left: -0.05 * MediaQuery.of(context).size.width,
            child: GlassAtom.icon(
              padding: const EdgeInsets.all(8),
              child: const Icon(Icons.add, size: 16, color: GlassTheme.success),
            ),
          ),
      ],
    );
  }
}

/// OnboardingProgressIndicator - Slide indicator dots
class OnboardingProgressIndicator extends StatelessWidget {
  final int currentIndex;
  final int totalSlides;
  final double dotSize;
  final double activeDotWidth;
  final Color? activeColor;
  final Color? inactiveColor;

  const OnboardingProgressIndicator({
    super.key,
    required this.currentIndex,
    this.totalSlides = 3,
    this.dotSize = 8,
    this.activeDotWidth = 24,
    this.activeColor,
    this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveActiveColor = activeColor ?? GlassTheme.textPrimary;
    final effectiveInactiveColor =
        inactiveColor ?? GlassTheme.textPrimary.withValues(alpha: 0.2);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalSlides,
        (index) {
          final isActive = index == currentIndex;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              width: isActive ? activeDotWidth : dotSize,
              height: dotSize,
              decoration: BoxDecoration(
                color: isActive ? effectiveActiveColor : effectiveInactiveColor,
                borderRadius: BorderRadius.circular(dotSize / 2),
                border: isActive
                    ? null
                    : Border.all(
                        color: GlassTheme.glassBorder.withValues(alpha: 0.3),
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// SkipButton - Standard skip button
class SkipButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;

  const SkipButton({
    super.key,
    this.onPressed,
    this.text = 'Skip',
    this.textStyle,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        minimumSize: const Size(0, 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        text,
        style: textStyle ??
            const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: GlassTheme.textSecondary,
            ),
      ),
    );
  }
}

/// ContinueButton - Primary action button
class ContinueButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final ButtonStyle? style;
  final EdgeInsetsGeometry? padding;
  final double? height;

  const ContinueButton({
    super.key,
    required this.onPressed,
    this.text = 'Continue',
    this.leadingIcon,
    this.trailingIcon,
    this.style,
    this.padding,
    this.height = 56,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          backgroundColor: GlassTheme.primary,
          foregroundColor: GlassTheme.textInverse,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leadingIcon != null) ...[
              leadingIcon!,
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (trailingIcon != null) ...[
              const SizedBox(width: 8),
              trailingIcon!,
            ],
          ],
        ),
      ),
    );
  }
}

/// BackButton - Standard back navigation button
class BackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final double size;

  const BackButton({
    super.key,
    this.onPressed,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return GlassAtom.icon(
      padding: EdgeInsets.all((size - 24) / 2),
      child: Icon(Icons.arrow_back, size: 20),
    );
  }
}
