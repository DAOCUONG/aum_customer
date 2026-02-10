import 'package:equatable/equatable.dart';

import '../../domain/entities/search_suggestion.dart';

/// Base state class for search suggestions feature
sealed class SearchSuggestionsState with EquatableMixin {
  const SearchSuggestionsState();
}

/// Initial state
class InitialSuggestionsState extends SearchSuggestionsState {
  const InitialSuggestionsState();

  @override
  List<Object?> get props => [];
}

/// Loading state
class LoadingSuggestionsState extends SearchSuggestionsState {
  const LoadingSuggestionsState();

  @override
  List<Object?> get props => [];
}

/// Loaded state with suggestions
class LoadedSuggestionsState extends SearchSuggestionsState {
  final List<SearchSuggestionGroup> groups;
  final List<String> recentSearches;
  final String currentQuery;

  const LoadedSuggestionsState({
    required this.groups,
    required this.recentSearches,
    required this.currentQuery,
  });

  @override
  List<Object?> get props => [groups, recentSearches, currentQuery];
}

/// Error state
class ErrorSuggestionsState extends SearchSuggestionsState {
  final String message;

  const ErrorSuggestionsState({required this.message});

  @override
  List<Object?> get props => [message];
}
