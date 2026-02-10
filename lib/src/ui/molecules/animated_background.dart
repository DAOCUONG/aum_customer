import 'package:flutter/material.dart';
import '../theme/glass_theme.dart';
import '../atoms/glass_background.dart';
import '../atoms/glass_panel.dart';

/// AnimatedBackground - Background with animated glow pulses
///
/// Creates an engaging background with pulsing glow effects that add
/// visual interest and depth to the UI.
class AnimatedBackground extends StatefulWidget {
  final Widget child;
  final List<Color> glowColors;
  final List<double> glowSizes;
  final List<Duration> animationDurations;
  final bool enableMesh;
  final bool enableGlow;
  final int glowCount;

  const AnimatedBackground({
    super.key,
    required this.child,
    this.glowColors = const [
      Color(0xFF60A5FA),
      Color(0xFFFF5E2B),
    ],
    this.glowSizes = const [280, 220],
    this.animationDurations = const [
      Duration(seconds: 4),
      Duration(seconds: 5),
    ],
    this.enableMesh = true,
    this.enableGlow = true,
    this.glowCount = 2,
  });

  const AnimatedBackground.subtle({
    super.key,
    required this.child,
    this.glowColors = const [
      Color(0xFF60A5FA),
      Color(0xFFFF5E2B),
    ],
    this.glowSizes = const [200],
    this.animationDurations = const [Duration(seconds: 4)],
    this.enableMesh = true,
    this.enableGlow = true,
    this.glowCount = 1,
  });

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _controllers = List.generate(
      widget.glowCount,
      (index) => AnimationController(
        duration: widget.animationDurations[index % widget.animationDurations.length],
        vsync: this,
      )..repeat(reverse: true),
    );

    _animations = _controllers.map((controller) {
      return Tween<double>(begin: 0.8, end: 1.1).animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.easeInOutSine,
        ),
      );
    }).toList();
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GlassBackground(
      child: Stack(
        children: [
          if (widget.enableGlow) ..._buildGlowOrbs(),
          widget.child,
        ],
      ),
    );
  }

  List<Widget> _buildGlowOrbs() {
    final List<Widget> orbs = [];

    // First orb - centered blue glow
    if (widget.glowCount >= 1) {
      orbs.add(
        Positioned.fill(
          child: Center(
            child: AnimatedBuilder(
              animation: _animations[0],
              builder: (context, child) {
                return Transform.scale(
                  scale: _animations[0].value,
                  child: Container(
                    width: widget.glowSizes[0],
                    height: widget.glowSizes[0],
                    decoration: BoxDecoration(
                      color: widget.glowColors[0].withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(widget.glowSizes[0] / 2),
                      boxShadow: [
                        BoxShadow(
                          color: widget.glowColors[0].withValues(alpha: 0.15),
                          blurRadius: 60,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );
    }

    // Second orb - offset primary glow
    if (widget.glowCount >= 2) {
      orbs.add(
        Positioned.fill(
          child: Center(
            child: AnimatedBuilder(
              animation: _animations[1],
              builder: (context, child) {
                return Transform.translate(
                  offset: const Offset(0, 40),
                  child: Transform.scale(
                    scale: _animations[1].value * 0.9,
                    child: Container(
                      width: widget.glowSizes[1],
                      height: widget.glowSizes[1],
                      decoration: BoxDecoration(
                        color: widget.glowColors[1].withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(widget.glowSizes[1] / 2),
                        boxShadow: [
                          BoxShadow(
                            color: widget.glowColors[1].withValues(alpha: 0.15),
                            blurRadius: 50,
                            spreadRadius: 8,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );
    }

    return orbs;
  }
}

/// PulsingGlow - Single pulsing glow effect
class PulsingGlow extends StatefulWidget {
  final Color color;
  final double size;
  final Duration duration;
  final Curve curve;
  final double minOpacity;
  final double maxOpacity;
  final double minScale;
  final double maxScale;
  final List<BoxShadow>? boxShadow;

  const PulsingGlow({
    super.key,
    this.color = GlassTheme.primary,
    this.size = 200,
    this.duration = const Duration(seconds: 4),
    this.curve = Curves.easeInOutSine,
    this.minOpacity = 0.15,
    this.maxOpacity = 0.25,
    this.minScale = 0.8,
    this.maxScale = 1.1,
    this.boxShadow,
  });

  const PulsingGlow.blue({
    super.key,
    this.color = const Color(0xFF60A5FA),
    this.size = 280,
    this.duration = const Duration(seconds: 4),
    this.curve = Curves.easeInOutSine,
    this.minOpacity = 0.15,
    this.maxOpacity = 0.25,
    this.minScale = 0.8,
    this.maxScale = 1.1,
    this.boxShadow,
  });

  const PulsingGlow.primary({
    super.key,
    this.color = GlassTheme.primary,
    this.size = 220,
    this.duration = const Duration(seconds: 5),
    this.curve = Curves.easeInOutSine,
    this.minOpacity = 0.15,
    this.maxOpacity = 0.25,
    this.minScale = 0.85,
    this.maxScale = 1.0,
    this.boxShadow,
  });

  @override
  State<PulsingGlow> createState() => _PulsingGlowState();
}

class _PulsingGlowState extends State<PulsingGlow> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(
      begin: widget.minScale,
      end: widget.maxScale,
    ).animate(
      CurvedAnimation(parent: _controller, curve: widget.curve),
    );

    _opacityAnimation = Tween<double>(
      begin: widget.minOpacity,
      end: widget.maxOpacity,
    ).animate(
      CurvedAnimation(parent: _controller, curve: widget.curve),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              color: widget.color.withValues(alpha: _opacityAnimation.value),
              borderRadius: BorderRadius.circular(widget.size / 2),
              boxShadow: widget.boxShadow ??
                  [
                    BoxShadow(
                      color: widget.color.withValues(alpha: _opacityAnimation.value),
                      blurRadius: widget.size * 0.25,
                      spreadRadius: widget.size * 0.05,
                    ),
                  ],
            ),
          ),
        );
      },
    );
  }
}

/// AnimatedGlowContainer - Container with built-in pulsing glow
class AnimatedGlowContainer extends StatelessWidget {
  final Widget child;
  final Color glowColor;
  final double glowSize;
  final Duration glowDuration;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;

  const AnimatedGlowContainer({
    super.key,
    required this.child,
    this.glowColor = GlassTheme.primary,
    this.glowSize = 200,
    this.glowDuration = const Duration(seconds: 4),
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Center(
            child: PulsingGlow(
              color: glowColor,
              size: glowSize,
              duration: glowDuration,
            ),
          ),
        ),
        GlassContainer(
          padding: padding,
          borderRadius: borderRadius,
          child: child,
        ),
      ],
    );
  }
}

/// BreathingGradient - Subtle breathing gradient effect
class BreathingGradient extends StatefulWidget {
  final List<Color> colors;
  final Duration duration;
  final Widget child;
  final Curve curve;

  const BreathingGradient({
    super.key,
    required this.colors,
    this.duration = const Duration(seconds: 8),
    required this.child,
    this.curve = Curves.easeInOutSine,
  });

  @override
  State<BreathingGradient> createState() => _BreathingGradientState();
}

class _BreathingGradientState extends State<BreathingGradient>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: widget.colors.map((color) {
                return Color.lerp(
                      color,
                      color.withValues(alpha: 0.8),
                      _controller.value,
                    ) ??
                    color;
              }).toList(),
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

/// AnimatedPulseWidget - Wrapper for adding pulse animation to any widget
class AnimatedPulseWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final double minScale;
  final double maxScale;

  const AnimatedPulseWidget({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 2),
    this.curve = Curves.easeInOutSine,
    this.minScale = 0.98,
    this.maxScale = 1.02,
  });

  @override
  State<AnimatedPulseWidget> createState() => _AnimatedPulseWidgetState();
}

class _AnimatedPulseWidgetState extends State<AnimatedPulseWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(
      begin: widget.minScale,
      end: widget.maxScale,
    ).animate(
      CurvedAnimation(parent: _controller, curve: widget.curve),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
