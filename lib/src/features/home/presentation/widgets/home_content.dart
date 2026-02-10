import 'package:flutter/material.dart';
import '../../../../ui/atoms/glass_category_icon.dart';
import '../../../../ui/atoms/glass_section_header.dart';
import '../../../../ui/molecules/glass_food_card.dart';
import '../../../../ui/molecules/glass_promo_banner.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/food_entity.dart';
import '../../domain/entities/restaurant_entity.dart';

/// Home content widget that displays all home data
/// This widget receives data via parameters rather than watching providers
/// to allow for proper separation of concerns
class HomeContent extends StatelessWidget {
  final List<CategoryEntity> categories;
  final List<FoodEntity> recommendedFoods;
  final List<RestaurantEntity> fastDeliveryRestaurants;
  final VoidCallback onCategoryTap;
  final VoidCallback onFoodTap;
  final VoidCallback onRestaurantTap;
  final VoidCallback onSeeAllRestaurantsTap;

  const HomeContent({
    super.key,
    required this.categories,
    required this.recommendedFoods,
    required this.fastDeliveryRestaurants,
    required this.onCategoryTap,
    required this.onFoodTap,
    required this.onRestaurantTap,
    required this.onSeeAllRestaurantsTap,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Promo Banner
          const GlassPromoBanner(
            title: '30% Off',
            subtitle: 'on your first order',
            promoCode: 'FOODIE30',
          ),
          const SizedBox(height: 24),

          // Categories Section
          _buildCategoriesSection(),
          const SizedBox(height: 24),

          // Recommended Section
          _buildRecommendedSection(),
          const SizedBox(height: 24),

          // Fast Delivery Section
          _buildFastDeliverySection(),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildCategoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: GlassCategoryIcon(
                  emoji: category.icon,
                  label: category.name,
                  isSelected: index == 0,
                  onTap: onCategoryTap,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GlassSectionHeader(
            number: 2,
            title: 'Recommended for You',
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 240,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: recommendedFoods.length,
            itemBuilder: (context, index) {
              final food = recommendedFoods[index];
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: GlassFoodCard(
                  imageUrl: food.imageUrl,
                  name: food.name,
                  restaurant: food.restaurantName,
                  rating: food.rating,
                  price: '\$${food.price.toStringAsFixed(2)}',
                  time: '${food.timeMinutes} min',
                  onTap: onFoodTap,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFastDeliverySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GlassSectionHeader(
            number: 3,
            title: 'Fast & Free Delivery',
            hasAction: true,
            onActionTap: onSeeAllRestaurantsTap,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: fastDeliveryRestaurants.length,
            itemBuilder: (context, index) {
              final restaurant = fastDeliveryRestaurants[index];
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: GlassRestaurantCard(
                  imageUrl: restaurant.imageUrl,
                  name: restaurant.name,
                  cuisine: restaurant.cuisine,
                  rating: restaurant.rating,
                  deliveryTime: '${restaurant.deliveryTimeMinutes} min',
                  deliveryFee: restaurant.deliveryFee,
                  onTap: onRestaurantTap,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
