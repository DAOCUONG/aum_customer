import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../ui/atoms/glass_icon_button.dart';
import '../../ui/molecules/glass_restaurant_info.dart';
import '../../ui/molecules/glass_cart_item.dart';
import '../../ui/theme/glass_design_system.dart';
import '../../core/routing/app_router.dart';
import 'item_customization_screen.dart';

/// Restaurant Detail Screen
class RestaurantDetailScreen extends StatefulWidget {
  final String restaurantId;

  const RestaurantDetailScreen({super.key, required this.restaurantId});

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  int _selectedTab = 0;
  final ScrollController _scrollController = ScrollController();

  final List<String> _tabs = ['Menu', 'Reviews', 'Info'];

  final List<Map<String, dynamic>> _popularItems = [
    {
      'name': 'Classic Cheeseburger',
      'description': 'Angus beef patty, cheddar cheese, lettuce, tomato, pickles, house sauce',
      'price': '\$12.50',
      'rating': 4.8,
      'isPopular': true,
      'image': 'https://picsum.photos/200?random=1',
    },
    {
      'name': 'Truffle Fries',
      'description': 'Crispy fries with truffle oil, parmesan, garlic aioli',
      'price': '\$6.00',
      'rating': 4.7,
      'isPopular': true,
      'image': 'https://picsum.photos/200?random=2',
    },
  ];

  final List<Map<String, dynamic>> _mainsItems = [
    {
      'name': 'BBQ Bacon Burger',
      'description': 'Smoky BBQ sauce, crispy bacon, onion rings, american cheese',
      'price': '\$14.50',
      'rating': 4.6,
      'isPopular': false,
      'isSoldOut': false,
      'image': 'https://picsum.photos/200?random=3',
    },
    {
      'name': 'Veggie Supreme',
      'description': 'Plant-based patty, avocado, sprouts, tahini sauce',
      'price': '\$13.00',
      'rating': 4.5,
      'isPopular': false,
      'isSoldOut': false,
      'image': 'https://picsum.photos/200?random=4',
    },
    {
      'name': 'Crispy Chicken Sandwich',
      'description': 'Buttermilk fried chicken, slaw, spicy mayo, brioche bun',
      'price': '\$11.50',
      'rating': 4.7,
      'isPopular': true,
      'isSoldOut': false,
      'image': 'https://picsum.photos/200?random=5',
    },
    {
      'name': 'Double Smash Burger',
      'description': 'Two thin patties, american cheese, grilled onions, special sauce',
      'price': '\$15.00',
      'rating': 4.9,
      'isPopular': false,
      'isSoldOut': true,
      'image': 'https://picsum.photos/200?random=6',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundLight,
      body: Stack(
        children: [
          // Mesh Background
          _buildMeshBackground(),
          // Main Content
          Column(
            children: [
              // Header with back button
              _buildHeader(),
              // Content
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 140),
                      // Restaurant Info Card
                      GlassRestaurantInfoCard(
                        name: 'Burger King',
                        cuisine: 'American • Fast Food • Burgers',
                        address: '8502 Preston Rd. Inglewood',
                        deliveryTime: '25-35',
                        deliveryFee: 'Free',
                        rating: 4.8,
                        reviewCount: 1240,
                        followerCount: 5420,
                      ),
                      const SizedBox(height: 20),
                      // Tabs
                      GlassTabHeader(
                        tabs: _tabs,
                        selectedIndex: _selectedTab,
                        onTabSelected: (index) => setState(() => _selectedTab = index),
                      ),
                      const SizedBox(height: 20),
                      // Menu Content
                      _buildMenuContent(),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Floating Cart Button
          GlassFloatingCartButton(
            itemCount: 3,
            totalPrice: '\$34.50',
            onTap: () => context.push(RouteNames.cart),
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
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 8,
          left: 20,
          right: 20,
          bottom: 8,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              backgroundLight.withOpacity(0.9),
              backgroundLight.withOpacity(0),
            ],
          ),
        ),
        child: Row(
          children: [
            GlassIconButton.transparent(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back_ios_new, size: 20),
              size: 40,
            ),
            const Spacer(),
            GlassIconButton(
              onPressed: () {},
              icon: const Icon(Icons.search, size: 20),
              size: 40,
            ),
            const SizedBox(width: 8),
            GlassIconButton(
              onPressed: () {},
              icon: Icon(
                Icons.favorite_border,
                size: 20,
                color: errorRed,
              ),
              size: 40,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Popular Section
          if (_popularItems.isNotEmpty) ...[
            const Text(
              'Popular Items',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            ..._popularItems.map((item) => GlassMenuItem(
                  imageUrl: item['image'],
                  name: item['name'],
                  description: item['description'],
                  price: item['price'],
                  rating: item['rating'],
                  isPopular: item['isPopular'],
                  isSoldOut: item['isSoldOut'] ?? false,
                  onAdd: () => _showCustomization(item),
                )),
            const SizedBox(height: 24),
          ],
          // Mains Section
          const Text(
            'Mains',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          ..._mainsItems.map((item) => GlassMenuItem(
                imageUrl: item['image'],
                name: item['name'],
                description: item['description'],
                price: item['price'],
                rating: item['rating'],
                isPopular: item['isPopular'],
                isSoldOut: item['isSoldOut'] ?? false,
                onTap: item['isSoldOut'] ? null : () => _showCustomization(item),
                onAdd: item['isSoldOut'] ? null : () => _showCustomization(item),
              )),
        ],
      ),
    );
  }

  void _showCustomization(Map<String, dynamic> item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ItemCustomizationScreen(
        itemName: item['name'],
        itemPrice: item['price'],
        itemDescription: item['description'],
        imageUrl: item['image'],
      ),
    );
  }
}
