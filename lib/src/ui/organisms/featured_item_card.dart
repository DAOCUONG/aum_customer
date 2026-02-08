import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/glass_theme.dart';
import '../atoms/glass_card.dart';
import '../atoms/glass_badge.dart';
import '../atoms/glass_icon_button.dart';
import '../molecules/glass_price_tag.dart';
import '../molecules/glass_rating_badge.dart';
import '../molecules/glass_counter.dart';

/// FeaturedItemCard - Product card with image, price, and add button
///
/// Displays product with image, rating, price, and actions
class FeaturedItemCard extends StatefulWidget {
  final String id;
  final String title;
  final String? subtitle;
  final String imageUrl;
  final String price;
  final String? originalPrice;
  final double? rating;
  final int? reviewCount;
  final VoidCallback? onFavoriteTap;
  final bool isFavorite;
  final VoidCallback? onAddTap;
  final VoidCallback? onTap;
  final Widget? badge;
  final bool showDeliveryBadge;
  final String? deliveryText;
  final GlassItemCardSize size;

  const FeaturedItemCard({
    super.key,
    required this.id,
    required this.title,
    this.subtitle,
    required this.imageUrl,
    required this.price,
    this.originalPrice,
    this.rating,
    this.reviewCount,
    this.onFavoriteTap,
    this.isFavorite = false,
    this.onAddTap,
    this.onTap,
    this.badge,
    this.showDeliveryBadge = false,
    this.deliveryText,
    this.size = GlassItemCardSize.medium,
  });

  @override
  State<FeaturedItemCard> createState() => _FeaturedItemCardState();
}

class _FeaturedItemCardState extends State<FeaturedItemCard> {
  int _quantity = 0;

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);
    final imageHeight = widget.size == GlassItemCardSize.small ? 140.0 : 180.0;

    return GestureDetector(
      onTap: widget.onTap,
      child: GlassCard(
        variant: GlassCardVariant.atom,
        size: GlassCardSize.small,
        padding: EdgeInsets.zero,
        showOverlay: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  child: Image.network(
                    widget.imageUrl,
                    width: double.infinity,
                    height: imageHeight,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: double.infinity,
                        height: imageHeight,
                        color: theme.glassSurface.withOpacity(0.3),
                        child: const Center(
                          child: Icon(Icons.broken_image, size: 40),
                        ),
                      );
                    },
                  ),
                ),
                if (widget.badge != null ||
                    (widget.showDeliveryBadge && widget.deliveryText != null))
                  Positioned(
                    top: 12,
                    left: 12,
                    child: widget.badge ??
                        GlassBadge(
                          text: widget.deliveryText ?? 'Free Delivery',
                          variant: GlassBadgeVariant.glass,
                          size: GlassBadgeSize.small,
                        ),
                  ),
                if (widget.onFavoriteTap != null)
                  Positioned(
                    top: 12,
                    right: 12,
                    child: GlassFavoriteButton(
                      isFavorite: widget.isFavorite,
                      onPressed: widget.onFavoriteTap,
                      size: 36,
                      activeColor: GlassTheme.error,
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
                              style: TextStyle(
                                fontSize: widget.size == GlassItemCardSize.small
                                    ? 16
                                    : 20,
                                fontWeight: FontWeight.w700,
                                color: theme.textPrimary,
                              ),
                            ),
                            if (widget.subtitle != null) ...[
                              const SizedBox(height: 4),
                              Text(
                                widget.subtitle!,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: theme.textTertiary,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (widget.rating != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: GlassRatingBadge(
                        rating: widget.rating!,
                        reviewCount: widget.reviewCount,
                        size: GlassRatingSize.small,
                      ),
                    ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GlassPriceTag(
                          currentPrice: widget.price,
                          originalPrice: widget.originalPrice,
                          size: widget.size == GlassItemCardSize.small
                              ? GlassPriceTagSize.small
                              : GlassPriceTagSize.medium,
                        ),
                      ),
                      if (widget.onAddTap != null)
                        GlassButton(
                          onPressed: widget.onAddTap,
                          icon: Icons.add,
                          height: 36,
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum GlassItemCardSize {
  small,
  medium,
  large,
}

/// Quick add card with quantity selector
class QuickAddCard extends StatefulWidget {
  final String title;
  final String? subtitle;
  final String imageUrl;
  final String price;
  final String? originalPrice;
  final VoidCallback? onAddTap;

  const QuickAddCard({
    super.key,
    required this.title,
    this.subtitle,
    required this.imageUrl,
    required this.price,
    this.originalPrice,
    this.onAddTap,
  });

  @override
  State<QuickAddCard> createState() => _QuickAddCardState();
}

class _QuickAddCardState extends State<QuickAddCard> {
  int _quantity = 0;

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return GlassCard(
      variant: GlassCardVariant.atom,
      size: GlassCardSize.small,
      padding: EdgeInsets.zero,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(20),
            ),
            child: Image.network(
              widget.imageUrl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: theme.textPrimary,
                    ),
                  ),
                  if (widget.subtitle != null)
                    Text(
                      widget.subtitle!,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: theme.textTertiary,
                      ),
                    ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GlassPriceTag(
                        currentPrice: widget.price,
                        originalPrice: widget.originalPrice,
                        size: GlassPriceTagSize.small,
                      ),
                      if (_quantity == 0)
                        GlassButton(
                          onPressed: () {
                            setState(() => _quantity = 1);
                            widget.onAddTap?.call();
                          },
                          label: 'Add',
                          height: 28,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                        )
                      else
                        GlassCounter(
                          initialQuantity: _quantity,
                          onQuantityChanged: (qty) {
                            setState(() => _quantity = qty);
                          },
                          size: GlassCounterSize.small,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Horizontal product card
class HorizontalProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String? subtitle;
  final String price;
  final String? originalPrice;
  final double? rating;
  final int? deliveryTime;
  final VoidCallback? onTap;
  final VoidCallback? onAddTap;

  const HorizontalProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    this.subtitle,
    required this.price,
    this.originalPrice,
    this.rating,
    this.deliveryTime,
    this.onTap,
    this.onAddTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: GlassCard(
        variant: GlassCardVariant.atom,
        size: GlassCardSize.small,
        padding: EdgeInsets.zero,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(20),
              ),
              child: Image.network(
                imageUrl,
                width: 110,
                height: 110,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: theme.textPrimary,
                      ),
                    ),
                    if (subtitle != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          subtitle!,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: theme.textTertiary,
                          ),
                        ),
                      ),
                    if (rating != null || deliveryTime != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Row(
                          children: [
                            if (rating != null)
                              GlassRatingBadge(
                                rating: rating!,
                                size: GlassRatingSize.small,
                              ),
                            if (rating != null && deliveryTime != null)
                              const SizedBox(width: 8),
                            if (deliveryTime != null)
                              Text(
                                '$deliveryTime min',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: theme.textTertiary,
                                ),
                              ),
                          ],
                        ),
                      ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GlassPriceTag(
                          currentPrice: price,
                          originalPrice: originalPrice,
                          size: GlassPriceTagSize.small,
                        ),
                        GlassIconButton.surface(
                          onPressed: onAddTap,
                          icon: const Icon(Icons.add, size: 18),
                          size: 32,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
