import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../ui/atoms/glass_icon_button.dart';
import '../../../../ui/theme/glass_design_system.dart';
import '../../../../core/routing/app_router.dart';
import '../providers/search_suggestions_notifier.dart';
import '../providers/search_suggestions_state.dart';
import '../widgets/search_suggestion_item.dart';
import '../../domain/entities/search_suggestion.dart';

/// Search Suggestions Screen - Shows search history and suggestions
class SearchSuggestionsScreen extends ConsumerStatefulWidget {
  const SearchSuggestionsScreen({super.key});

  @override
  ConsumerState<SearchSuggestionsScreen> createState() =>
      _SearchSuggestionsScreenState();
}

class _SearchSuggestionsScreenState extends ConsumerState<SearchSuggestionsScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ref.read(searchSuggestionsNotifierProvider.notifier).loadSuggestions();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      ref.read(searchSuggestionsNotifierProvider.notifier).search(query);
    } else {
      ref.read(searchSuggestionsNotifierProvider.notifier).loadSuggestions();
    }
  }

  void _onSearchTap(String query) {
    context.push('${RouteNames.searchResults}?query=$query');
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(searchSuggestionsNotifierProvider);

    return Scaffold(
      backgroundColor: backgroundLight,
      body: Stack(
        children: [
          _buildMeshBackground(),
          SafeArea(
            child: Column(
              children: [
                _buildSearchHeader(),
                _buildContent(state),
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
              Colors.orange.shade100.withValues(alpha: 0.6),
              backgroundLight,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchHeader() {
    return Padding(
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
                color: Colors.white.withValues(alpha: 0.6),
                borderRadius: locationBarRadius,
                border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
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
    );
  }

  Widget _buildContent(SearchSuggestionsState state) {
    if (state is InitialSuggestionsState || state is LoadingSuggestionsState) {
      return const Expanded(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (state is ErrorSuggestionsState) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(state.message),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref.read(searchSuggestionsNotifierProvider.notifier).loadSuggestions();
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (state is LoadedSuggestionsState) {
      return Expanded(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (state.recentSearches.isNotEmpty && _searchController.text.isEmpty)
                _buildRecentSearches(state.recentSearches),
              if (state.recentSearches.isNotEmpty && _searchController.text.isEmpty)
                const SizedBox(height: 24),
              _buildPopularNearYou(state.groups),
              const SizedBox(height: 24),
              _buildTrendingNow(state.groups),
            ],
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildRecentSearches(List<String> recentSearches) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
              child: const Text(
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
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.45),
            borderRadius: cardRadius,
            border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
          ),
          child: Column(
            children: recentSearches.asMap().entries.map((entry) {
              return SearchSuggestionItem(
                key: ValueKey('recent_${entry.key}'),
                suggestion: SearchSuggestion.recent(text: entry.value),
                onTap: () => _onSearchTap(entry.value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildPopularNearYou(List<SearchSuggestionGroup> groups) {
    final popularGroup =
        groups.firstWhere((g) => g.title == 'Popular Near You', orElse: () {
      return SearchSuggestionGroup(
        title: 'Popular Near You',
        suggestions: const [],
      );
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          popularGroup.title,
          style: const TextStyle(
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
            color: Colors.white.withValues(alpha: 0.45),
            borderRadius: cardRadius,
            border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
          ),
          child: Column(
            children: popularGroup.suggestions.asMap().entries.map((entry) {
              return PopularSearchItem(
                key: ValueKey('popular_${entry.key}'),
                text: entry.value.text,
                onTap: () => _onSearchTap(entry.value.text),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildTrendingNow(List<SearchSuggestionGroup> groups) {
    final trendingGroup =
        groups.firstWhere((g) => g.title == 'Trending Now', orElse: () {
      return SearchSuggestionGroup(
        title: 'Trending Now',
        suggestions: const [],
      );
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          trendingGroup.title,
          style: const TextStyle(
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
          children: trendingGroup.suggestions.map((suggestion) {
            return _TrendingChip(
              label: suggestion.text,
              onTap: () => _onSearchTap(suggestion.text),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _TrendingChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _TrendingChip({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.4),
          borderRadius: filterChipRadius,
          border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textPrimary,
          ),
        ),
      ),
    );
  }
}
