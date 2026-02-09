import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../ui/atoms/glass_icon_button.dart';
import '../../ui/atoms/glass_filter_chip.dart';
import '../../ui/molecules/glass_restaurant_card.dart';
import '../../ui/theme/glass_design_system.dart';
import '../../core/routing/app_router.dart';

/// Search Results Screen - Shows search results with filters
class SearchResultsScreen extends StatefulWidget {
  final String query;

  const SearchResultsScreen({super.key, required this.query});

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  bool _isListView = true;

  final List<String> _filters = [
    'Open Now',
    'Rating 4.5+',
    'Free Delivery',
    'Fastest',
  ];

  final List<String> _sortOptions = [
    'Recommended',
    'Fastest Delivery',
    'Highest Rated',
  ];

  final List<Map<String, dynamic>> _restaurants = [
    {
      'name': 'Burger King',
      'tags': ['American', 'Fast Food', 'Burgers'],
      'rating': 4.8,
      'time': '20-30',
      'fee': 'Free',
      'image': 'https://picsum.photos/200?random=1',
    },
    {
      'name': 'Pizza Hut',
      'tags': ['Italian', 'Pizza', 'Pasta'],
      'rating': 4.5,
      'time': '25-35',
      'fee': '\$2.99',
      'image': 'https://picsum.photos/200?random=2',
    },
    {
      'name': 'McDonald\'s',
      'tags': ['American', 'Fast Food'],
      'rating': 4.3,
      'time': '15-25',
      'fee': 'Free',
      'image': 'https://picsum.photos/200?random=3',
    },
    {
      'name': 'Subway',
      'tags': ['Sandwiches', 'Healthy', 'Fast Food'],
      'rating': 4.4,
      'time': '15-20',
      'fee': '\$1.99',
      'image': 'https://picsum.photos/200?random=4',
    },
    {
      'name': 'KFC',
      'tags': ['American', 'Fried Chicken', 'Fast Food'],
      'rating': 4.6,
      'time': '20-30',
      'fee': 'Free',
      'image': 'https://picsum.photos/200?random=5',
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
          Column(
            children: [
              // Search Header
              _buildSearchHeader(),
              // Filter Chips
              _buildFilterChips(),
              // Toolbar
              _buildToolbar(),
              // Results
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Column(
                    children: _restaurants.map((restaurant) {
                      return GlassRestaurantCardHorizontal(
                        imageUrl: restaurant['image'] as String,
                        name: restaurant['name'] as String,
                        tags: List<String>.from(restaurant['tags'] as List),
                        rating: restaurant['rating'] as double,
                        deliveryTime: restaurant['time'] as String,
                        deliveryFee: restaurant['fee'] as String,
                        onTap: () {},
                        onFavoriteTap: () {},
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
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

  Widget _buildSearchHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: backgroundLight.withOpacity(0.9),
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            GlassIconButton.transparent(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back_ios_new, size: 20),
              size: 40,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  borderRadius: locationBarRadius,
                  border: Border.all(color: Colors.white.withOpacity(0.5)),
                ),
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: widget.query,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Icon(
                        Icons.search,
                        size: 20,
                        color: textSecondary,
                      ),
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    hintStyle: TextStyle(color: textPrimary),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  style: const TextStyle(fontSize: 15),
                ),
              ),
            ),
            const SizedBox(width: 12),
            GlassIconButton.transparent(
              onPressed: () => context.push(RouteNames.filter),
              icon: const Icon(Icons.tune, size: 20),
              size: 40,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    return SizedBox(
      height: 48,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: _filters.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GlassFilterChip(
              label: _filters[index],
              isSelected: index < 2,
              showClose: index >= 2,
              onTap: () {},
            ),
          );
        },
      ),
    );
  }

  Widget _buildToolbar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          // Sort Dropdown
          Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white.withOpacity(0.5)),
            ),
            child: Row(
              children: [
                Text(
                  _sortOptions[0],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: textPrimary,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.expand_more,
                  size: 20,
                  color: textSecondary,
                ),
              ],
            ),
          ),
          const Spacer(),
          // View Toggle
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white.withOpacity(0.5)),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => setState(() => _isListView = true),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: _isListView ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: _isListView
                          ? [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : null,
                    ),
                    child: Icon(
                      Icons.view_list,
                      size: 20,
                      color: _isListView ? primaryColor : textSecondary,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => setState(() => _isListView = false),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: !_isListView ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: !_isListView
                          ? [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : null,
                    ),
                    child: Icon(
                      Icons.grid_view,
                      size: 20,
                      color: !_isListView ? primaryColor : textSecondary,
                    ),
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
