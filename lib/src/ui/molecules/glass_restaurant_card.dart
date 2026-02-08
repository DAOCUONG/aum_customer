import 'package:flutter/material.dart';
import '../atoms/glass_rating_badge.dart';
import '../atoms/glass_icon_button.dart';
import '../theme/glass_design_system.dart';

/// Glass Restaurant Card Horizontal - For search results
class GlassRestaurantCardHorizontal extends StatelessWidget {
  final String imageUrl;
  final String name;
  final List<String> tags;
  final double rating;
  final String deliveryTime;
  final String deliveryFee;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;

  const GlassRestaurantCardHorizontal({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.tags,
    required this.rating,
    required this.deliveryTime,
    required this.deliveryFee,
    this.onTap,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.55),
          borderRadius: cardRadius,
          border: Border.all(color: Colors.white.withOpacity(0.5)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Image
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(24),
                  ),
                  child: Container(
                    width: 100,
                    height: double.infinity,
                    color: Colors.orange.shade100,
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Center(
                        child: Text(
                          name[0],
                          style: const TextStyle(fontSize: 36),
                        ),
                      ),
                    ),
                  ),
                ),
                // Favorite Button
                Positioned(
                  top: 8,
                  left: 8,
                  child: GlassIconButton.transparent(
                    onPressed: onFavoriteTap,
                    icon: Icon(
                      Icons.favorite_border,
                      size: 18,
                      color: textSecondary,
                    ),
                    size: 32,
                  ),
                ),
              ],
            ),
            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: textPrimary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        GlassRatingBadge(rating: rating),
                      ],
                    ),
                    // Tags
                    Row(
                      children: tags.take(3).map((tag) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: Text(
                            tag,
                            style: TextStyle(
                              fontSize: 12,
                              color: textSecondary,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    // Delivery Info
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 14,
                          color: textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          deliveryTime,
                          style: TextStyle(
                            fontSize: 12,
                            color: textSecondary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 1,
                          height: 12,
                          color: textTertiary.withOpacity(0.5),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          deliveryFee,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: deliveryFee == 'Free' ? successGreen : textSecondary,
                          ),
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
