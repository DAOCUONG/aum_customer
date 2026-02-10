import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/search_filter.dart';
import '../../domain/entities/search_result.dart';
import 'search_state.dart';

/// Notifier for search results state management
class SearchNotifier extends Notifier<SearchState> {
  @override
  SearchState build() {
    return const InitialSearchState();
  }

  /// Perform a search with query and optional filters
  Future<void> search({
    required String query,
    FilterState filter = const FilterState(),
    bool append = false,
  }) async {
    if (query.trim().isEmpty) {
      state = const InitialSearchState();
      return;
    }

    state = LoadingSearchState(isInitialLoad: !append);

    try {
      await Future.delayed(const Duration(milliseconds: 500));
      final results = _getMockResults(query);

      if (results.isEmpty) {
        state = EmptySearchState(query: query, filter: filter);
      } else {
        final oldResults = state is SuccessSearchState ? (state as SuccessSearchState).results : <SearchResult>[];
        state = SuccessSearchState(
          results: append ? [...oldResults, ...results] : results,
          query: query,
          filter: filter,
          hasMore: results.length >= 20,
          currentPage: append && state is SuccessSearchState ? (state as SuccessSearchState).currentPage + 1 : 1,
        );
      }
    } catch (e) {
      state = ErrorSearchState(
        message: e.toString(),
        code: 'UNKNOWN',
        query: query,
        filter: filter,
      );
    }
  }

  List<SearchResult> _getMockResults(String query) {
    final baseRestaurants = [
      'Burger King',
      'Pizza Hut',
      "McDonald's",
      'Subway',
      'KFC',
    ];

    return baseRestaurants
        .where((name) =>
            name.toLowerCase().contains(query.toLowerCase()) || query.isEmpty)
        .toList()
        .asMap()
        .entries
        .map((entry) {
          final name = entry.value;
          final index = entry.key;
          return SearchResult(
            id: 'restaurant_$index',
            name: name,
            tags: const ['American', 'Fast Food', 'Burgers'],
            rating: 4.0 + (index * 0.1),
            deliveryTime: '${15 + (index * 5)}-${20 + (index * 5)}',
            deliveryFee: index % 3 == 0 ? 'Free' : '\$${(index + 1) * 0.99}',
            imageUrl: 'https://picsum.photos/200?random=$index',
          );
        })
        .toList();
  }

  /// Update filters and re-search
  Future<void> updateFilter(FilterState filter) async {
    final currentQuery = state is SuccessSearchState ? (state as SuccessSearchState).query : '';
    if (currentQuery.isNotEmpty) {
      await search(query: currentQuery, filter: filter);
    }
  }

  /// Clear search and reset state
  void clearSearch() {
    state = const InitialSearchState();
  }

  /// Retry last search
  Future<void> retry() async {
    if (state is ErrorSearchState) {
      final errorState = state as ErrorSearchState;
      await search(
        query: errorState.query ?? '',
        filter: errorState.filter ?? const FilterState(),
      );
    }
  }
}

/// Provider for search notifier
final searchNotifierProvider =
    NotifierProvider<SearchNotifier, SearchState>(SearchNotifier.new);
