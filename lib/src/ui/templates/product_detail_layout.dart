import 'package:flutter/material.dart';
import '../theme/glass_theme.dart';
import '../atoms/glass_card.dart';
import '../atoms/glass_divider.dart';
import '../atoms/glass_badge.dart' hide GlassRatingBadge;
import '../molecules/glass_rating_badge.dart';
import '../molecules/glass_price_tag.dart';
import '../molecules/glass_counter.dart';
import '../organisms/product_detail_header.dart';

/// ProductDetailLayout - Full product detail page layout
///
/// Complete layout template for product detail pages
class ProductDetailLayout extends StatelessWidget {
  final String productName;
  final String? productSubtitle;
  final String imageUrl;
  final String price;
  final String? originalPrice;
  final double? rating;
  final int? reviewCount;
  final List<String> tags;
  final Widget descriptionSection;
  final List<Widget> detailSections;
  final List<Widget> relatedProducts;
  final VoidCallback? onAddToCart;
  final VoidCallback? onBuyNow;
  final VoidCallback? onFavoriteTap;
  final bool isFavorite;
  final int quantity;
  final Function(int) onQuantityChanged;
  final List<Widget>? customActions;
  final bool showQuantitySelector;

  const ProductDetailLayout({
    super.key,
    required this.productName,
    this.productSubtitle,
    required this.imageUrl,
    required this.price,
    this.originalPrice,
    this.rating,
    this.reviewCount,
    this.tags = const [],
    required this.descriptionSection,
    this.detailSections = const [],
    this.relatedProducts = const [],
    this.onAddToCart,
    this.onBuyNow,
    this.onFavoriteTap,
    this.isFavorite = false,
    required this.quantity,
    required this.onQuantityChanged,
    this.customActions,
    this.showQuantitySelector = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return Scaffold(
      backgroundColor: theme.background,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Header
                ProductDetailHeader(
                  imageUrl: imageUrl,
                  onFavoriteTap: onFavoriteTap,
                  isFavorite: isFavorite,
                  badges: tags.isNotEmpty
                      ? tags
                          .map((tag) => GlassBadge(
                                text: tag,
                                variant: GlassBadgeVariant.glass,
                                size: GlassBadgeSize.small,
                              ))
                          .toList()
                      : null,
                ),

                // Product Info
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Rating
                      if (rating != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: GlassRatingBadge(
                            rating: rating!,
                            reviewCount: reviewCount,
                            size: GlassRatingSize.medium,
                          ),
                        ),

                      // Title
                      Text(
                        productName,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: theme.textPrimaryColor,
                          height: 1.2,
                        ),
                      ),

                      // Subtitle
                      if (productSubtitle != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          productSubtitle!,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: theme.textSecondaryColor,
                          ),
                        ),
                      ],

                      // Price
                      const SizedBox(height: 16),
                      GlassPriceTag(
                        currentPrice: price,
                        originalPrice: originalPrice,
                        size: GlassPriceTagSize.large,
                      ),

                      // Tags row
                      if (tags.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: tags.map((tag) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: GlassBadge(
                                  text: tag,
                                  variant: GlassBadgeVariant.glass,
                                  size: GlassBadgeSize.small,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],

                      // Quantity selector
                      if (showQuantitySelector) ...[
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              'Quantity',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: theme.textPrimaryColor,
                              ),
                            ),
                            const Spacer(),
                            GlassCounter(
                              initialQuantity: quantity,
                              onQuantityChanged: onQuantityChanged,
                            ),
                          ],
                        ),
                      ],

                      const SizedBox(height: 24),
                      GlassDivider(variant: GlassDividerVariant.glass),

                      // Description
                      const SizedBox(height: 24),
                      descriptionSection,

                      // Detail sections
                      ...detailSections,

                      // Related products
                      if (relatedProducts.isNotEmpty) ...[
                        const SizedBox(height: 32),
                        _buildSectionHeader(context, 'You May Also Like'),
                        const SizedBox(height: 16),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: relatedProducts
                                .map((product) => Padding(
                                      padding: const EdgeInsets.only(right: 16),
                                      child: SizedBox(
                                          width: 180, child: product),
                                    ))
                                .toList(),
                          ),
                        ),
                      ],

                      // Bottom spacing for action bar
                      const SizedBox(height: 120),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Floating action bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: ProductActionBar(
              price: price,
              originalPrice: originalPrice,
              onAddToCart: onAddToCart,
              onBuyNow: onBuyNow,
              onFavoriteTap: onFavoriteTap,
              isFavorite: isFavorite,
              showQuantitySelector: showQuantitySelector,
              onQuantityChanged: onQuantityChanged,
              initialQuantity: quantity,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    final theme = GlassTheme.of(context);

    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: theme.textPrimaryColor,
          ),
        ),
        const Spacer(),
        Text(
          'See all',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: theme.primaryColor,
          ),
        ),
      ],
    );
  }
}

/// Description section template
class ProductDescriptionSection extends StatelessWidget {
  final String title;
  final String description;
  final bool isExpanded;
  final VoidCallback? onToggleExpand;

  const ProductDescriptionSection({
    super.key,
    required this.title,
    required this.description,
    this.isExpanded = false,
    this.onToggleExpand,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onToggleExpand,
          child: Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: theme.textPrimaryColor,
                ),
              ),
              const Spacer(),
              Icon(
                isExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: theme.textTertiaryColor,
              ),
            ],
          ),
        ),
        if (isExpanded) ...[
          const SizedBox(height: 12),
          Text(
            description,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: theme.textSecondaryColor,
              height: 1.6,
            ),
          ),
        ],
      ],
    );
  }
}

/// Nutrition info section
class NutritionInfoSection extends StatelessWidget {
  final Map<String, String> nutritionItems;
  final String? servingSize;

  const NutritionInfoSection({
    super.key,
    required this.nutritionItems,
    this.servingSize,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return GlassCard(
      variant: GlassCardVariant.atom,
      size: GlassCardSize.small,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Nutrition',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: theme.textPrimaryColor,
                ),
              ),
              if (servingSize != null)
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    'Per $servingSize',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: theme.textTertiaryColor,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          ...nutritionItems.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      entry.key,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: theme.textSecondaryColor,
                      ),
                    ),
                  ),
                  Text(
                    entry.value,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: theme.textPrimaryColor,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

/// Review summary section
class ReviewSummarySection extends StatelessWidget {
  final double averageRating;
  final int totalReviews;
  final List<Widget> recentReviews;
  final VoidCallback? onSeeAllReviews;

  const ReviewSummarySection({
    super.key,
    required this.averageRating,
    required this.totalReviews,
    this.recentReviews = const [],
    this.onSeeAllReviews,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return GlassCard(
      variant: GlassCardVariant.atom,
      size: GlassCardSize.small,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Reviews',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: theme.textPrimaryColor,
                ),
              ),
              const Spacer(),
              Text(
                '($totalReviews)',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: theme.textTertiaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...recentReviews,
          if (onSeeAllReviews != null) ...[
            const SizedBox(height: 12),
            GestureDetector(
              onTap: onSeeAllReviews,
              child: Center(
                child: Text(
                  'See all reviews',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: theme.primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
