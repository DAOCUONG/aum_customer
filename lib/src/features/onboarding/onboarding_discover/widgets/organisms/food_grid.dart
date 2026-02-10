import 'package:flutter/material.dart';
import '../../../../../ui/atoms/glass_card.dart';
import '../atoms/food_image.dart';

/// FoodGrid - An organism component displaying staggered food images
///
/// ORGANISM component combining food images in a grid layout
/// with glassmorphism effects and staggered positioning
class FoodGrid extends StatelessWidget {
  final List<String> foodImagePaths;
  final double size;
  final double gridSpacing;
  final double verticalOffset;

  const FoodGrid({
    super.key,
    required this.foodImagePaths,
    this.size = 320,
    this.gridSpacing = 8,
    this.verticalOffset = 32,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          _buildGradientBackground(context),
          _buildRotatingOverlay(),
          _buildGlassCardContainer(context),
          _buildInnerGradientOverlay(),
        ],
      ),
    );
  }

  Widget _buildGradientBackground(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFFFFE4CC).withValues(alpha: 0.4),
              const Color(0xFFCCE0FF).withValues(alpha: 0.4),
            ],
          ),
          borderRadius: BorderRadius.circular(48),
        ),
      ),
    );
  }

  Widget _buildRotatingOverlay() {
    return Positioned.fill(
      child: Transform.rotate(
        angle: 0.05,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(48),
          ),
        ),
      ),
    );
  }

  Widget _buildGlassCardContainer(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size - 40,
        height: size - 40,
        child: GlassCard.atom(
          padding: const EdgeInsets.all(12),
          borderRadius: BorderRadius.circular(40),
          shadows: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
          child: _buildImageGrid(),
        ),
      ),
    );
  }

  Widget _buildInnerGradientOverlay() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withValues(alpha: 0.2),
              Colors.transparent,
            ],
          ),
          borderRadius: BorderRadius.circular(32),
        ),
      ),
    );
  }

  Widget _buildImageGrid() {
    // Order: Food1, Food2, Food3, Food4
    // Row 1: Food1, Food2 (Food2 has mt-8)
    // Row 2: Food3 (-mt-8), Food4
    return Wrap(
      runSpacing: gridSpacing,
      spacing: gridSpacing,
      alignment: WrapAlignment.center,
      children: List.generate(
        foodImagePaths.length,
        (index) => _buildFoodItem(index),
      ),
    );
  }

  Widget _buildFoodItem(int index) {
    // Even indices (0, 2) have upward offset
    // Odd indices (1, 3) have downward offset
    final offset = index % 2 == 0 ? -verticalOffset : verticalOffset;

    return Transform.translate(
      offset: Offset(0, offset),
      child: FoodImage(
        assetPath: foodImagePaths[index],
        width: 115,
        height: 115,
        borderRadius: 16,
      ),
    );
  }
}

/// CompactFoodGrid - A smaller variant for limited spaces
class CompactFoodGrid extends StatelessWidget {
  final List<String> foodImagePaths;
  final double size;

  const CompactFoodGrid({
    super.key,
    required this.foodImagePaths,
    this.size = 200,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          _buildBackground(),
          Center(
            child: SizedBox(
              width: size - 30,
              height: size - 30,
              child: GlassCard.atom(
                padding: const EdgeInsets.all(8),
                borderRadius: BorderRadius.circular(24),
                child: _buildGridContent(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFFFFE4CC).withValues(alpha: 0.3),
              const Color(0xFFCCE0FF).withValues(alpha: 0.3),
            ],
          ),
          borderRadius: BorderRadius.circular(size / 2),
        ),
      ),
    );
  }

  Widget _buildGridContent() {
    final itemSize = size / 2.5;

    return Wrap(
      runSpacing: 4,
      spacing: 4,
      alignment: WrapAlignment.center,
      children: List.generate(
        foodImagePaths.length,
        (index) => Transform.translate(
          offset: Offset(0, index % 2 == 0 ? -12 : 12),
          child: SizedBox(
            width: itemSize,
            height: itemSize,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                foodImagePaths[index],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFFFFE4CC),
                    child: const Icon(Icons.fastfood, color: Color(0xFFFF7A45)),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
