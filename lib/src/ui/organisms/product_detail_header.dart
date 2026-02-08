import 'package:flutter/material.dart';
import '../theme/glass_theme.dart';
import '../atoms/glass_card.dart';
import '../atoms/glass_icon_button.dart';
import '../atoms/glass_badge.dart';
import '../atoms/glass_favorite_button.dart';
import '../molecules/glass_rating_badge.dart';

/// ProductDetailHeader - Product image with actions
///
/// Displays product image with back, favorite, and share buttons
class ProductDetailHeader extends StatefulWidget {
  final String imageUrl;
  final VoidCallback? onBackTap;
  final VoidCallback? onFavoriteTap;
  final bool isFavorite;
  final VoidCallback? onShareTap;
  final VoidCallback? onImageTap;
  final List<Widget>? badges;
  final double height;
  final bool showActions;

  const ProductDetailHeader({
    super.key,
    required this.imageUrl,
    this.onBackTap,
    this.onFavoriteTap,
    this.isFavorite = false,
    this.onShareTap,
    this.onImageTap,
    this.badges,
    this.height = 320,
    this.showActions = true,
  });

  @override
  State<ProductDetailHeader> createState() => _ProductDetailHeaderState();
}

class _ProductDetailHeaderState extends State<ProductDetailHeader> {
  bool _isPressed = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return SizedBox(
      height: widget.height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background gradient blobs
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(-0.5, -0.3),
                  colors: [
                    GlassTheme.primary.withOpacity(0.1),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 1.0],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0.5, 0.8),
                  colors: [
                    const Color(0xFFFFE4D6).withOpacity(0.5),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 1.0],
                ),
              ),
            ),
          ),

          // Product image
          Positioned.fill(
            child: GestureDetector(
              onTap: widget.onImageTap,
              onTapDown: _handleTapDown,
              onTapUp: _handleTapUp,
              onTapCancel: _handleTapCancel,
              child: AnimatedScale(
                duration: const Duration(milliseconds: 150),
                scale: _isPressed ? 0.98 : 1.0,
                curve: Curves.easeOutCubic,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(32),
                  ),
                  child: Image.network(
                    widget.imageUrl,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: theme.glassSurface.withOpacity(0.3),
                        child: const Center(
                          child: Icon(Icons.broken_image, size: 60),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),

          // Glass overlay at bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 100,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    theme.glassSurface.withOpacity(0.4),
                    theme.glassSurface.withOpacity(0.7),
                  ],
                  stops: const [0.0, 0.4, 1.0],
                ),
              ),
            ),
          ),

          // Action buttons
          if (widget.showActions)
            Positioned(
              top: 48,
              left: 16,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GlassBackButton(
                    onPressed: widget.onBackTap,
                    size: 40,
                    backgroundColor: theme.glassSurface.withOpacity(0.7),
                  ),
                  Row(
                    children: [
                      if (widget.onShareTap != null)
                        GlassIconButton.surface(
                          onPressed: widget.onShareTap,
                          icon: const Icon(Icons.share, size: 20),
                          size: 40,
                          backgroundColor: theme.glassSurface.withOpacity(0.7),
                        ),
                      if (widget.onFavoriteTap != null) ...[
                        const SizedBox(width: 8),
                        GlassFavoriteButton(
                          isFavorite: widget.isFavorite,
                          onPressed: widget.onFavoriteTap,
                          size: 40,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),

          // Badges
          if (widget.badges != null)
            Positioned(
              top: 96,
              left: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.badges!,
              ),
            ),
        ],
      ),
    );
  }
}

/// Product gallery with thumbnails
class ProductGallery extends StatefulWidget {
  final List<String> imageUrls;
  final VoidCallback? onImageTap;
  final int selectedIndex;

  const ProductGallery({
    super.key,
    required this.imageUrls,
    this.onImageTap,
    this.selectedIndex = 0,
  });

  @override
  State<ProductGallery> createState() => _ProductGalleryState();
}

class _ProductGalleryState extends State<ProductGallery> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return Column(
      children: [
        SizedBox(
          height: 280,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.imageUrls.length,
            onPageChanged: (index) {
              // Handle page change
            },
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: widget.onImageTap,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(24),
                        ),
                        child: Image.network(
                          widget.imageUrls[index],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color:
                                  theme.glassSurface.withOpacity(0.3),
                              child: const Center(
                                child: Icon(Icons.broken_image, size: 60),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          widget.imageUrls.length,
                          (index) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: widget.selectedIndex == index
                                  ? GlassTheme.primary
                                  : theme.textTertiary.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 64,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: widget.imageUrls.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOutCubic,
                  );
                },
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: widget.selectedIndex == index
                          ? GlassTheme.primary
                          : theme.glassBorder,
                      width: widget.selectedIndex == index ? 2 : 1,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(11),
                    child: Image.network(
                      widget.imageUrls[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Product action bar with add to cart
class ProductActionBar extends StatefulWidget {
  final String price;
  final String? originalPrice;
  final VoidCallback? onAddToCart;
  final VoidCallback? onBuyNow;
  final VoidCallback? onFavoriteTap;
  final bool isFavorite;
  final bool showQuantitySelector;
  final Function(int quantity) onQuantityChanged;
  final int initialQuantity;

  const ProductActionBar({
    super.key,
    required this.price,
    this.originalPrice,
    this.onAddToCart,
    this.onBuyNow,
    this.onFavoriteTap,
    this.isFavorite = false,
    this.showQuantitySelector = false,
    required this.onQuantityChanged,
    this.initialQuantity = 1,
  });

  @override
  State<ProductActionBar> createState() => _ProductActionBarState();
}

class _ProductActionBarState extends State<ProductActionBar> {
  late int _quantity;

  @override
  void initState() {
    super.initState();
    _quantity = widget.initialQuantity;
  }

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.glassSurface.withOpacity(0.95),
        border: Border(
          top: BorderSide(
            color: theme.glassBorder.withOpacity(0.5),
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            if (widget.showQuantitySelector)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: theme.glassSurface.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: theme.glassBorder),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (_quantity > 1) {
                          setState(() => _quantity--);
                          widget.onQuantityChanged(_quantity);
                        }
                      },
                      child: Icon(
                        Icons.remove,
                        size: 18,
                        color: _quantity > 1
                            ? theme.textPrimary
                            : theme.textTertiary,
                      ),
                    ),
                    SizedBox(
                      width: 32,
                      child: Text(
                        '$_quantity',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: theme.textPrimary,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() => _quantity++);
                        widget.onQuantityChanged(_quantity);
                      },
                      child: const Icon(
                        Icons.add,
                        size: 18,
                        color: GlassTheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            if (widget.showQuantitySelector) const SizedBox(width: 12),
            if (widget.onFavoriteTap != null)
              GlassIconButton.surface(
                onPressed: widget.onFavoriteTap,
                icon: Icon(
                  widget.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                  size: 22,
                  color: widget.isFavorite
                      ? GlassTheme.error
                      : theme.textSecondary,
                ),
                size: 48,
              ),
            if (widget.onFavoriteTap != null)
              const SizedBox(width: 12),
            Expanded(
              child: GlassButton.primary(
                onPressed: widget.onAddToCart,
                label: 'Add to Cart - \$${widget.price}',
                height: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
