import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/search_suggestion.dart';
import 'search_suggestions_state.dart';

/// Notifier for search suggestions state management
class SearchSuggestionsNotifier extends Notifier<SearchSuggestionsState> {
  @override
  SearchSuggestionsState build() {
    return const InitialSuggestionsState();
  }

  /// Load initial suggestions
  Future<void> loadSuggestions() async {
    state = const LoadingSuggestionsState();

    try {
      await Future.delayed(const Duration(milliseconds: 300));
      final groups = _getMockSuggestions();
      state = LoadedSuggestionsState(
        groups: groups,
        recentSearches: const ['Burger', 'Pizza', 'Sushi'],
        currentQuery: '',
      );
    } catch (e) {
      state = ErrorSuggestionsState(message: e.toString());
    }
  }

  /// Search with query
  Future<void> search(String query) async {
    state = const LoadingSuggestionsState();

    try {
      await Future.delayed(const Duration(milliseconds: 200));
      final groups = _getMockSuggestions();
      final recentSearches = state is LoadedSuggestionsState
          ? (state as LoadedSuggestionsState).recentSearches
          : <String>[];
      state = LoadedSuggestionsState(
        groups: groups,
        recentSearches: recentSearches,
        currentQuery: query,
      );
    } catch (e) {
      state = ErrorSuggestionsState(message: e.toString());
    }
  }

  /// Clear all state
  void clear() {
    state = const InitialSuggestionsState();
  }

  List<SearchSuggestionGroup> _getMockSuggestions() {
    return [
      SearchSuggestionGroup(
        title: 'Recent Searches',
        suggestions: const ['Burger', 'Pizza', 'Sushi', 'Salad', 'Pasta']
            .asMap()
            .entries
            .map((entry) => SearchSuggestion.recent(
                  text: entry.value,
                  id: 'recent_${entry.key}',
                ))
            .toList(),
      ),
      SearchSuggestionGroup(
        title: 'Popular Near You',
        suggestions: const ['Korean BBQ', 'Thai Cuisine', 'Mexican Food']
            .map((text) => SearchSuggestion.popular(text: text))
            .toList(),
      ),
      SearchSuggestionGroup(
        title: 'Trending Now',
        suggestions: const ['Fried Chicken', 'Bubble Tea', 'Ramen']
            .map((text) => SearchSuggestion.trending(text: text))
            .toList(),
      ),
    ];
  }
}

/// Provider for search suggestions notifier
final searchSuggestionsNotifierProvider =
    NotifierProvider<SearchSuggestionsNotifier, SearchSuggestionsState>(
        SearchSuggestionsNotifier.new);
