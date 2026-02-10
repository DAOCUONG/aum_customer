import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../ui/atoms/glass_icon_button.dart';
import '../../../../ui/atoms/glass_filter_chip.dart';
import '../../../../ui/molecules/glass_restaurant_card.dart';
import '../../../../ui/theme/glass_design_system.dart';
import '../../../../core/routing/app_router.dart';
import '../providers/search_notifier.dart';
import '../providers/filter_notifier.dart';
import '../providers/search_state.dart';
import '../widgets/search_loading_widgets.dart';
import '../widgets/search_empty_state.dart' as empty;
import '../widgets/search_error_state.dart' as error;
import '../../domain/entities/search_result.dart';

/// Search Results Screen - Shows search results with filters
/// Uses Riverpod for state management
class SearchResultsScreen extends ConsumerStatefulWidget {
  final String query;

  const SearchResultsScreen({super.key, required this.query});

  @override
  ConsumerState<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends ConsumerState<SearchResultsScreen> {
  bool _isListView = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(searchNotifierProvider.notifier).search(query: widget.query);
    });
  }

  void _onRetry() {
    ref.read(searchNotifierProvider.notifier).retry();
  }

  void _onClearFilters() {
    ref.read(filterNotifierProvider.notifier).resetFilters();
    ref.read(searchNotifierProvider.notifier).clearSearch();
    ref.read(searchNotifierProvider.notifier).search(query: widget.query);
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(searchNotifierProvider);

    return Scaffold(
      backgroundColor: backgroundLight,
      body: Stack(
        children: [
          _buildMeshBackground(),
          Column(
            children: [
              _buildSearchHeader(),
              _buildFilterChips(),
              _buildToolbar(),
              _buildResultsContent(searchState),
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
              Colors.orange.shade100.withValues(alpha: 0.6),
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
        color: backgroundLight.withValues(alpha: 0.9),
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
                  color: Colors.white.withValues(alpha: 0.6),
                  borderRadius: locationBarRadius,
                  border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
                ),
                child: TextField(
                  readOnly: true,
                  controller: TextEditingController(text: widget.query),
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
    final filterOptions = ['Open Now', 'Rating 4.5+', 'Free Delivery', 'Fastest'];

    return SizedBox(
      height: 48,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: filterOptions.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GlassFilterChip(
              label: filterOptions[index],
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
    final sortOptions = ['Recommended', 'Fastest Delivery', 'Highest Rated'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
            ),
            child: Row(
              children: [
                Text(
                  sortOptions[0],
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
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
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
                                color: Colors.black.withValues(alpha: 0.05),
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
                                color: Colors.black.withValues(alpha: 0.05),
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

  Widget _buildResultsContent(SearchState state) {
    if (state is InitialSearchState) {
      return const SizedBox.shrink();
    }
    if (state is LoadingSearchState) {
      return const Expanded(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: SearchResultsSkeleton(),
        ),
      );
    }
    if (state is EmptySearchState) {
      return Expanded(
        child: empty.SearchEmptyState(
          query: state.query,
          onClearFilters: _onClearFilters,
        ),
      );
    }
    if (state is ErrorSearchState) {
      return Expanded(
        child: error.SearchErrorState(
          message: state.message,
          onRetry: _onRetry,
        ),
      );
    }
    if (state is SuccessSearchState) {
      return Expanded(
        child: _buildResultsList(state.results),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildResultsList(List<SearchResult> results) {
    if (results.isEmpty) {
      return empty.SearchEmptyState(
        query: widget.query,
        onClearFilters: _onClearFilters,
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        children: results.map((restaurant) {
          return GlassRestaurantCardHorizontal(
            key: ValueKey(restaurant.id),
            imageUrl: restaurant.imageUrl,
            name: restaurant.name,
            tags: restaurant.tags,
            rating: restaurant.rating,
            deliveryTime: restaurant.deliveryTime,
            deliveryFee: restaurant.deliveryFee,
            onTap: () {},
            onFavoriteTap: () {},
          );
        }).toList(),
      ),
    );
  }
}
