import 'package:flutter/material.dart';

/// FoodImage - An image widget for food items with overlay
///
/// ATOM component displaying food images with gradient overlay
/// Used in the food grid layout
class FoodImage extends StatelessWidget {
  final String assetPath;
  final double width;
  final double height;
  final double borderRadius;
  final BoxFit fit;

  const FoodImage({
    super.key,
    required this.assetPath,
    this.width = 115,
    this.height = 115,
    this.borderRadius = 16,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Stack(
          fit: StackFit.expand,
          children: [
            _buildImage(),
            _buildGradientOverlay(),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Image.asset(
      assetPath,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        debugPrint('ERROR loading: $assetPath - $error');
        return Container(
          color: const Color(0xFFFFE4CC),
          child: const Icon(Icons.fastfood, color: Color(0xFFFF7A45)),
        );
      },
    );
  }

  Widget _buildGradientOverlay() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withValues(alpha: 0.2),
            ],
          ),
        ),
      ),
    );
  }
}

/// FoodImagePlaceholder - A placeholder when image is loading or unavailable
class FoodImagePlaceholder extends StatelessWidget {
  final double size;

  const FoodImagePlaceholder({super.key, this.size = 115});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xFFFFE4CC).withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Icon(
        Icons.fastfood,
        color: Color(0xFFFF7A45),
        size: 48,
      ),
    );
  }
}
