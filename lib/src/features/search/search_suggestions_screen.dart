import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../ui/atoms/glass_icon_button.dart';
import '../../ui/atoms/glass_filter_chip.dart';
import '../../ui/theme/glass_design_system.dart';
import '../../core/routing/app_router.dart';

/// Search Suggestions Screen - Shows search history and suggestions
class SearchSuggestionsScreen extends StatefulWidget {
  const SearchSuggestionsScreen({super.key});

  @override
  State<SearchSuggestionsScreen> createState() => _SearchSuggestionsScreenState();
}

class _SearchSuggestionsScreenState extends State<SearchSuggestionsScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<String> _recentSearches = [
    'Burger',
    'Pizza',
    'Sushi',
    'Salad',
    'Pasta',
  ];

  final List<String> _popularNearYou = [
    'Korean BBQ',
    'Thai Cuisine',
    'Mexican Food',
    'Indian Curry',
    'Chinese Takeout',
  ];

  final List<String> _trendingNow = [
    'Fried Chicken',
    'Bubble Tea',
    'Acai Bowl',
    'Ramen',
    'Dim Sum',
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundLight,
      body: Stack(
        children: [
          // Mesh Background
          _buildMeshBackground(),
          SafeArea(
            child: Column(
              children: [
                // Search Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
                            controller: _searchController,
                            autofocus: true,
                            decoration: InputDecoration(
                              hintText: 'Restaurants, dishes, or groceries',
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
                              hintStyle: TextStyle(color: textSecondary),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            ),
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      GlassIconButton.transparent(
                        onPressed: () {},
                        icon: const Icon(Icons.tune, size: 20),
                        size: 40,
                      ),
                    ],
                  ),
                ),
                // Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Recent Searches
                        _buildRecentSearches(),
                        const SizedBox(height: 24),
                        // Popular Near You
                        _buildPopularNearYou(),
                        const SizedBox(height: 24),
                        // Trending Now
                        _buildTrendingNow(),
                      ],
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

  Widget _buildRecentSearches() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recent Searches',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: textSecondary,
                letterSpacing: 0.5,
                height: 1.2,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                'Clear All',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: primaryColor,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Search Items
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.45),
            borderRadius: cardRadius,
            border: Border.all(color: Colors.white.withOpacity(0.5)),
          ),
          child: Column(
            children: _recentSearches.asMap().entries.map((entry) {
              return _SearchItem(
                text: entry.value,
                icon: Icons.schedule,
                onTap: () => _onSearchTap(entry.value),
                onDelete: () => _onDeleteTap(entry.key),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildPopularNearYou() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Popular Near You',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: textSecondary,
            letterSpacing: 0.5,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.45),
            borderRadius: cardRadius,
            border: Border.all(color: Colors.white.withOpacity(0.5)),
          ),
          child: Column(
            children: _popularNearYou.asMap().entries.map((entry) {
              return _PopularItem(
                text: entry.value,
                onTap: () => _onSearchTap(entry.value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildTrendingNow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Trending Now',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: textSecondary,
            letterSpacing: 0.5,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: _trendingNow.map((item) {
            return GlassTrendingChip(
              label: item,
              onTap: () => _onSearchTap(item),
            );
          }).toList(),
        ),
      ],
    );
  }

  void _onSearchTap(String query) {
    _searchController.text = query;
    context.push('${RouteNames.searchResults}?query=$query');
  }

  void _onDeleteTap(int index) {
    setState(() {
      _recentSearches.removeAt(index);
    });
  }
}

class _SearchItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _SearchItem({
    required this.text,
    required this.icon,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.zero,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: textSecondary,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: textPrimary,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onDelete,
                child: Icon(
                  Icons.close,
                  size: 18,
                  color: textTertiary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PopularItem extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _PopularItem({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.zero,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: textPrimary,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                size: 20,
                color: textTertiary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
