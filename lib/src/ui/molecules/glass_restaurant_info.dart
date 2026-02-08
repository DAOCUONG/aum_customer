import 'package:flutter/material.dart';
import '../atoms/glass_rating_badge.dart';
import '../theme/glass_design_system.dart';

/// Glass Restaurant Info Card - Restaurant detail header
class GlassRestaurantInfoCard extends StatelessWidget {
  final String name;
  final String cuisine;
  final String address;
  final String deliveryTime;
  final String deliveryFee;
  final double rating;
  final int reviewCount;
  final int followerCount;

  const GlassRestaurantInfoCard({
    super.key,
    required this.name,
    required this.cuisine,
    required this.address,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.rating,
    required this.reviewCount,
    required this.followerCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.65),
        borderRadius: cardRadius,
        border: Border.all(color: Colors.white.withOpacity(0.6)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 32,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name and verified
          Row(
            children: [
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: textPrimary,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: successGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  Icons.verified,
                  size: 16,
                  color: successGreen,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          // Cuisine
          Text(
            cuisine,
            style: TextStyle(
              fontSize: 14,
              color: textSecondary,
            ),
          ),
          const SizedBox(height: 12),
          // Stats row
          Row(
            children: [
              // Rating
              GlassRatingBadge(rating: rating),
              const SizedBox(width: 8),
              Container(
                width: 1,
                height: 16,
                color: textTertiary.withOpacity(0.3),
              ),
              const SizedBox(width: 8),
              Text(
                '$reviewCount+ reviews',
                style: TextStyle(
                  fontSize: 13,
                  color: textSecondary,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 1,
                height: 16,
                color: textTertiary.withOpacity(0.3),
              ),
              const SizedBox(width: 8),
              Text(
                '$followerCount+ followers',
                style: TextStyle(
                  fontSize: 13,
                  color: textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Delivery info
          GlassDeliveryInfoRow(
            deliveryTime: deliveryTime,
            deliveryFee: deliveryFee,
          ),
        ],
      ),
    );
  }
}

/// Glass Delivery Info Row
class GlassDeliveryInfoRow extends StatelessWidget {
  final String deliveryTime;
  final String deliveryFee;

  const GlassDeliveryInfoRow({
    super.key,
    required this.deliveryTime,
    required this.deliveryFee,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: locationBarRadius,
        border: Border.all(color: Colors.white.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          // Time
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Text(
                  'Time',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: textTertiary,
                  ),
                ),
                Text(
                  deliveryTime,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: textPrimary,
                  ),
                ),
                Text(
                  'min',
                  style: TextStyle(
                    fontSize: 10,
                    color: textTertiary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Fee
          Container(
            width: 1,
            height: 32,
            color: textTertiary.withOpacity(0.3),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Delivery Fee',
                  style: TextStyle(
                    fontSize: 12,
                    color: textSecondary,
                  ),
                ),
                Text(
                  deliveryFee,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: deliveryFee == 'Free' ? successGreen : textPrimary,
                  ),
                ),
              ],
            ),
          ),
          // Offer badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: successGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: successGreen.withOpacity(0.2)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.local_offer,
                  size: 12,
                  color: successGreen,
                ),
                const SizedBox(width: 4),
                Text(
                  'Free Delivery',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: successGreen,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Glass Tab Header - For menu/reviews/info tabs
class GlassTabHeader extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final Function(int) onTabSelected;

  const GlassTabHeader({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: locationBarRadius,
        border: Border.all(color: Colors.white.withOpacity(0.5)),
      ),
      child: Row(
        children: tabs.asMap().entries.map((entry) {
          final index = entry.key;
          final tab = entry.value;
          final isSelected = selectedIndex == index;

          return Expanded(
            child: GestureDetector(
              onTap: () => onTabSelected(index),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected ? primaryColor : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Center(
                  child: Text(
                    tab,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: isSelected ? primaryColor : textSecondary,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

/// Glass Floating Cart Button - Sticky bottom cart
class GlassFloatingCartButton extends StatelessWidget {
  final int itemCount;
  final String totalPrice;
  final VoidCallback? onTap;

  const GlassFloatingCartButton({
    super.key,
    required this.itemCount,
    required this.totalPrice,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 20,
      right: 20,
      bottom: 24,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [primaryLight, primaryColor],
            ),
            borderRadius: buttonRadius,
            boxShadow: [
              BoxShadow(
                color: primaryColor.withOpacity(0.4),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              const SizedBox(width: 16),
              // Item count badge
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Text(
                    '$itemCount',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Divider
              Container(
                width: 1,
                height: 24,
                color: Colors.white.withOpacity(0.3),
              ),
              const SizedBox(width: 12),
              // Price
              Expanded(
                child: Text(
                  totalPrice,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              // Checkout text
              const Text(
                'Checkout',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 16),
              Icon(
                Icons.arrow_forward,
                size: 20,
                color: Colors.white.withOpacity(0.8),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }
}
