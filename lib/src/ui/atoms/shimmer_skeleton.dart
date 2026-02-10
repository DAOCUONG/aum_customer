import 'package:flutter/material.dart';

/// A shimmer loading skeleton widget for displaying placeholders
/// while data is loading.
///
/// Provides a pulsing gradient animation effect to indicate loading state.
class ShimmerSkeleton extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius borderRadius;

  /// Creates a shimmer skeleton with specified dimensions.
  const ShimmerSkeleton({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: Colors.grey[300],
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: _ShimmerGradient(
          child: SizedBox(width: width, height: height),
        ),
      ),
    );
  }
}

/// Horizontal list shimmer for category cards.
class ShimmerCategoryList extends StatelessWidget {
  final int itemCount;

  /// Creates a horizontal shimmer list for categories.
  const ShimmerCategoryList({
    super.key,
    this.itemCount = 6,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.only(right: 16),
          child: ShimmerSkeleton(
            width: 70,
            height: 90,
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        );
      },
    );
  }
}

/// Horizontal list shimmer for food cards.
class ShimmerFoodList extends StatelessWidget {
  final int itemCount;

  /// Creates a horizontal shimmer list for food items.
  const ShimmerFoodList({
    super.key,
    this.itemCount = 4,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.only(right: 12),
          child: ShimmerFoodCard(),
        );
      },
    );
  }
}

/// Shimmer placeholder for food card.
class ShimmerFoodCard extends StatelessWidget {
  const ShimmerFoodCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 240,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image placeholder
          const ShimmerSkeleton(
            width: 160,
            height: 120,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          // Content padding
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title placeholder
                const ShimmerSkeleton(width: 100, height: 16),
                const SizedBox(height: 8),
                // Restaurant name placeholder
                const ShimmerSkeleton(width: 70, height: 12),
                const SizedBox(height: 8),
                // Rating and price row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const ShimmerSkeleton(width: 40, height: 14),
                    const ShimmerSkeleton(width: 40, height: 14),
                  ],
                ),
                const SizedBox(height: 8),
                // Time placeholder
                const ShimmerSkeleton(width: 50, height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Shimmer placeholder for restaurant card.
class ShimmerRestaurantCard extends StatelessWidget {
  final int itemCount;

  /// Creates a horizontal shimmer list for restaurant items.
  const ShimmerRestaurantCard({
    super.key,
    this.itemCount = 4,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.only(right: 12),
          child: _ShimmerRestaurantItem(),
        );
      },
    );
  }
}

class _ShimmerRestaurantItem extends StatelessWidget {
  const _ShimmerRestaurantItem();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Image placeholder
          const ShimmerSkeleton(
            width: 140,
            height: 80,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          // Content padding
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Restaurant name
                const ShimmerSkeleton(width: 80, height: 14),
                const SizedBox(height: 6),
                // Cuisine type
                const ShimmerSkeleton(width: 50, height: 10),
                const SizedBox(height: 6),
                // Rating and time row
                Row(
                  children: [
                    const ShimmerSkeleton(width: 30, height: 12),
                    const SizedBox(width: 8),
                    const ShimmerSkeleton(width: 30, height: 12),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Shimmer loading content for the entire home screen.
class ShimmerHomeContent extends StatelessWidget {
  const ShimmerHomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          // Promo banner shimmer
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey[300],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: _ShimmerGradient(
                child: const SizedBox.expand(),
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Categories section header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 120,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const ShimmerCategoryList(itemCount: 6),
          const SizedBox(height: 24),
          // Recommended section header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 140,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const ShimmerFoodList(itemCount: 4),
          const SizedBox(height: 24),
          // Fast delivery section header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 160,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const ShimmerRestaurantCard(itemCount: 4),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

/// Widget that provides a gradient shimmer effect using an animated builder.
class _ShimmerGradient extends StatefulWidget {
  final Widget child;

  const _ShimmerGradient({required this.child});

  @override
  State<_ShimmerGradient> createState() => _ShimmerGradientState();
}

class _ShimmerGradientState extends State<_ShimmerGradient>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _gradientAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController.unbounded(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
    _gradientAnimation = Tween<double>(begin: -2, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
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
      animation: _gradientAnimation,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment(_gradientAnimation.value, 0),
              end: Alignment(-_gradientAnimation.value, 0),
              colors: [
                Colors.grey[300]!,
                Colors.grey[200]!,
                Colors.grey[300]!,
              ],
              stops: const [0.0, 0.5, 1.0],
            ).createShader(bounds);
          },
          child: widget.child,
        );
      },
    );
  }
}
