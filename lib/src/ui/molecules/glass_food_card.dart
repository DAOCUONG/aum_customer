import 'package:flutter/material.dart';
import '../atoms/glass_rating_badge.dart';
import '../atoms/glass_icon_button.dart';
import '../theme/glass_design_system.dart';

/// Glass Food Card - Horizontal food item card (160x220px)
class GlassFoodCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String restaurant;
  final double rating;
  final String price;
  final String time;
  final VoidCallback? onTap;

  const GlassFoodCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.restaurant,
    required this.rating,
    required this.price,
    required this.time,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        height: 220,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Container
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                  child: Container(
                    height: 140,
                    width: double.infinity,
                    color: Colors.orange.shade100,
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Center(
                        child: Text(
                          name[0],
                          style: const TextStyle(fontSize: 48),
                        ),
                      ),
                    ),
                  ),
                ),
                // Rating Badge - Top Right
                Positioned(
                  top: 8,
                  right: 8,
                  child: GlassRatingBadge(rating: rating),
                ),
              ],
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    restaurant,
                    style: TextStyle(
                      fontSize: 12,
                      color: textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        price,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '• $time',
                        style: TextStyle(
                          fontSize: 12,
                          color: textSecondary,
                        ),
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

/// Glass Restaurant Card - Horizontal restaurant card (240x140px)
class GlassRestaurantCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String cuisine;
  final double rating;
  final String deliveryTime;
  final String deliveryFee;
  final VoidCallback? onTap;

  const GlassRestaurantCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.cuisine,
    required this.rating,
    required this.deliveryTime,
    required this.deliveryFee,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 240,
        height: 140,
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
            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      cuisine,
                      style: TextStyle(
                        fontSize: 13,
                        color: textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        GlassRatingBadge(rating: rating),
                        const SizedBox(width: 8),
                        Container(
                          width: 1,
                          height: 12,
                          color: textTertiary.withOpacity(0.5),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          deliveryTime,
                          style: TextStyle(
                            fontSize: 12,
                            color: textSecondary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '• $deliveryFee',
                          style: TextStyle(
                            fontSize: 12,
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
