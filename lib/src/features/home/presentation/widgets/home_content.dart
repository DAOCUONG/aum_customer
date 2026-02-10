import 'package:flutter/material.dart';

import '../../../../ui/atoms/glass_category_icon.dart';
import '../../../../ui/atoms/glass_section_header.dart';
import '../../../../ui/molecules/glass_food_card.dart';
import '../../../../ui/molecules/glass_promo_banner.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/food_entity.dart';
import '../../domain/entities/restaurant_entity.dart';

/// Home content widget that displays all home data.
///
/// This widget receives data via parameters rather than watching providers
/// to allow for proper separation of concerns. It handles both loaded data
/// and empty states gracefully.
class HomeContent extends StatelessWidget {
  final List<CategoryEntity> categories;
  final List<FoodEntity> recommendedFoods;
  final List<RestaurantEntity> fastDeliveryRestaurants;
  final VoidCallback onCategoryTap;
  final VoidCallback onFoodTap;
  final VoidCallback onRestaurantTap;
  final VoidCallback onSeeAllRestaurantsTap;

  /// Creates a new [HomeContent] instance.
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
    final hasCategories = categories.isNotEmpty;
    final hasFoods = recommendedFoods.isNotEmpty;
    final hasRestaurants = fastDeliveryRestaurants.isNotEmpty;

    // Check if all sections are empty
    final isEmpty = !hasCategories && !hasFoods && !hasRestaurants;

    if (isEmpty) {
      return _buildEmptyContent();
    }

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

          // Categories Section - only show if available
          if (hasCategories) ...[
            _buildCategoriesSection(),
            const SizedBox(height: 24),
          ],

          // Recommended Section - only show if available
          if (hasFoods) ...[
            _buildRecommendedSection(),
            const SizedBox(height: 24),
          ],

          // Fast Delivery Section - only show if available
          if (hasRestaurants) ...[
            _buildFastDeliverySection(),
            const SizedBox(height: 100),
          ],

          // Padding for bottom nav
          if (!hasCategories && !hasFoods && hasRestaurants) ...[
            const SizedBox(height: 100),
          ],
        ],
      ),
    );
  }

  /// Builds the empty content state when no data is available.
  Widget _buildEmptyContent() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.restaurant_menu,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            const Text(
              'No Content Available',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'We couldn\'t find any restaurants or food items at the moment.',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the categories horizontal list section.
  ///
  /// Shows a "No categories available" message if empty.
  Widget _buildCategoriesSection() {
    if (categories.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GlassSectionHeader(
            number: 1,
            title: 'Categories',
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 100,
          child: ListView.builder(
            key: const ValueKey('categories_list'),
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: categories.length,
            itemBuilder: _buildCategoryItem,
          ),
        ),
      ],
    );
  }

  /// Builds a single category item with proper keying.
  Widget _buildCategoryItem(BuildContext context, int index) {
    final category = categories[index];
    return Padding(
      key: ValueKey('category_${category.id}'),
      padding: const EdgeInsets.only(right: 16),
      child: GlassCategoryIcon(
        emoji: category.icon,
        label: category.name,
        isSelected: index == 0,
        onTap: () => _onCategoryTap(category),
      ),
    );
  }

  /// Builds the recommended foods horizontal list section.
  ///
  /// Shows a "No recommendations available" message if empty.
  Widget _buildRecommendedSection() {
    if (recommendedFoods.isEmpty) {
      return const SizedBox.shrink();
    }

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
            key: const ValueKey('recommended_list'),
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: recommendedFoods.length,
            itemBuilder: _buildFoodItem,
          ),
        ),
      ],
    );
  }

  /// Builds a single food item with proper keying.
  Widget _buildFoodItem(BuildContext context, int index) {
    final food = recommendedFoods[index];
    return Padding(
      key: ValueKey('food_${food.id}'),
      padding: const EdgeInsets.only(right: 12),
      child: GlassFoodCard(
        imageUrl: food.imageUrl,
        name: food.name,
        restaurant: food.restaurantName,
        rating: food.rating,
        price: '\$${food.price.toStringAsFixed(2)}',
        time: '${food.timeMinutes} min',
        onTap: () => _onFoodTap(food),
      ),
    );
  }

  /// Builds the fast delivery restaurants horizontal list section.
  ///
  /// Shows a "No restaurants available" message if empty.
  Widget _buildFastDeliverySection() {
    if (fastDeliveryRestaurants.isEmpty) {
      return const SizedBox.shrink();
    }

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
            key: const ValueKey('restaurants_list'),
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: fastDeliveryRestaurants.length,
            itemBuilder: _buildRestaurantItem,
          ),
        ),
      ],
    );
  }

  /// Builds a single restaurant item with proper keying.
  Widget _buildRestaurantItem(BuildContext context, int index) {
    final restaurant = fastDeliveryRestaurants[index];
    return Padding(
      key: ValueKey('restaurant_${restaurant.id}'),
      padding: const EdgeInsets.only(right: 12),
      child: GlassRestaurantCard(
        imageUrl: restaurant.imageUrl,
        name: restaurant.name,
        cuisine: restaurant.cuisine,
        rating: restaurant.rating,
        deliveryTime: '${restaurant.deliveryTimeMinutes} min',
        deliveryFee: restaurant.deliveryFee,
        onTap: () => _onRestaurantTap(restaurant),
      ),
    );
  }

  // Callback handlers that pass the tapped entity
  void _onCategoryTap(CategoryEntity category) => onCategoryTap();
  void _onFoodTap(FoodEntity food) => onFoodTap();
  void _onRestaurantTap(RestaurantEntity restaurant) => onRestaurantTap();
}
