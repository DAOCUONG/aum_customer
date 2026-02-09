import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../ui/atoms/glass_search_bar.dart';
import '../../ui/atoms/glass_category_icon.dart';
import '../../ui/atoms/glass_icon_button.dart';
import '../../ui/molecules/glass_food_card.dart';
import '../../ui/molecules/glass_restaurant_card.dart';
import '../../ui/molecules/glass_bottom_nav.dart';
import '../../ui/molecules/glass_promo_banner.dart';
import '../../ui/theme/glass_design_system.dart';
import '../../core/routing/app_router.dart';

/// Home Screen - Main food ordering screen
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundLight,
      body: Stack(
        children: [
          // Mesh Background
          _buildMeshBackground(),
          // Main Content
          SafeArea(
            child: Column(
              children: [
                // Header
                _buildHeader(),
                // Search & Location
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Column(
                    children: [
                      GlassLocationBar(
                        address: '8502 Preston Rd. Inglewood',
                        onTap: () {},
                      ),
                      const SizedBox(height: 12),
                      GlassSearchBar(
                        hintText: 'Restaurants, dishes, or groceries',
                        onFilterTap: () => context.push(RouteNames.filter),
                      ),
                    ],
                  ),
                ),
                // Content
                Expanded(
                  child: SingleChildScrollView(
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
                        // Categories
                        _buildCategories(),
                        const SizedBox(height: 24),
                        // Recommended Section
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: SectionHeader(title: 'Recommended for You'),
                        ),
                        const SizedBox(height: 12),
                        _buildRecommendedFoods(),
                        const SizedBox(height: 24),
                        // Fast Delivery Section
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: SectionHeader(
                            title: 'Fast & Free Delivery',
                            onSeeAllTap: () {},
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildFastDeliveryRestaurants(),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Bottom Navigation
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: GlassBottomNavBar(
              currentIndex: _currentNavIndex,
              onTap: (index) => setState(() => _currentNavIndex = index),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMeshBackground() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topLeft,
            radius: 1.5,
            colors: [
              Colors.orange.shade100.withOpacity(0.6),
              backgroundLight,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          GlassIconButton.transparent(
            onPressed: () {},
            icon: const Icon(Icons.menu, size: 24),
            size: 44,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [primaryColor, primaryLight],
              ).createShader(bounds),
              child: const Text(
                'Foodie Express',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          GlassIconButton(
            onPressed: () {},
            icon: Stack(
              children: [
                const Icon(Icons.notifications, size: 24),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: errorRed,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ],
            ),
            size: 44,
          ),
          const SizedBox(width: 8),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              image: const DecorationImage(
                image: NetworkImage('https://i.pravatar.cc/100'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    final categories = [
      {'emoji': '🔥', 'label': 'Popular'},
      {'emoji': '🍔', 'label': 'Burger'},
      {'emoji': '🍕', 'label': 'Pizza'},
      {'emoji': '🍣', 'label': 'Sushi'},
      {'emoji': '🌮', 'label': 'Mexican'},
      {'emoji': '🍩', 'label': 'Dessert'},
    ];

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GlassCategoryIcon(
              emoji: categories[index]['emoji']!,
              label: categories[index]['label']!,
              isSelected: index == 0,
              onTap: () {},
            ),
          );
        },
      ),
    );
  }

  Widget _buildRecommendedFoods() {
    return SizedBox(
      height: 240,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GlassFoodCard(
              imageUrl: 'https://picsum.photos/200?random=$index',
              name: _foodNames[index],
              restaurant: _restaurantNames[index % 3],
              rating: 4.5 + (index % 2) * 0.5,
              price: '\$${(10 + index * 3).toStringAsFixed(2)}',
              time: '${20 + index * 5} min',
              onTap: () {},
            ),
          );
        },
      ),
    );
  }

  Widget _buildFastDeliveryRestaurants() {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GlassRestaurantCard(
              imageUrl: 'https://picsum.photos/200?random=${index + 10}',
              name: _restaurantNames[index % 3],
              cuisine: _cuisines[index % 4],
              rating: 4.2 + (index % 3) * 0.3,
              deliveryTime: '${15 + index * 5} min',
              deliveryFee: index % 2 == 0 ? 'Free' : '\$2.99',
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}

const List<String> _foodNames = [
  'Whopper Meal',
  'Chicken Pizza',
  'Sushi Platter',
  'Tacos Special',
  'Cheesecake',
];

const List<String> _restaurantNames = [
  'Burger King',
  'Pizza Hut',
  'McDonald\'s',
];

const List<String> _cuisines = [
  'American',
  'Italian',
  'Fast Food',
  'Asian',
];
