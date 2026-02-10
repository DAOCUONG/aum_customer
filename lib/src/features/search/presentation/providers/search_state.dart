import 'package:equatable/equatable.dart';

import '../../domain/entities/search_result.dart';
import '../../domain/entities/search_filter.dart';

/// Base state class for search feature
sealed class SearchState with EquatableMixin {
  const SearchState();
}

/// Initial/loading state
class InitialSearchState extends SearchState {
  const InitialSearchState();

  @override
  List<Object?> get props => [];
}

/// Loading state
class LoadingSearchState extends SearchState {
  final bool isInitialLoad;

  const LoadingSearchState({this.isInitialLoad = true});

  @override
  List<Object?> get props => [isInitialLoad];
}

/// Successful search results state
class SuccessSearchState extends SearchState {
  final List<SearchResult> results;
  final String query;
  final FilterState filter;
  final bool hasMore;
  final int currentPage;

  const SuccessSearchState({
    required this.results,
    required this.query,
    required this.filter,
    this.hasMore = false,
    this.currentPage = 1,
  });

  @override
  List<Object?> get props => [results, query, filter, hasMore, currentPage];
}

/// Empty results state
class EmptySearchState extends SearchState {
  final String query;
  final FilterState filter;

  const EmptySearchState({required this.query, required this.filter});

  @override
  List<Object?> get props => [query, filter];
}

/// Error state
class ErrorSearchState extends SearchState {
  final String message;
  final String code;
  final String? query;
  final FilterState? filter;

  const ErrorSearchState({
    required this.message,
    required this.code,
    this.query,
    this.filter,
  });

  @override
  List<Object?> get props => [message, code, query, filter];
}
