import 'package:equatable/equatable.dart';

/// Domain entity representing a search suggestion
class SearchSuggestion with EquatableMixin {
  final String id;
  final String text;
  final SuggestionType type;
  final DateTime? timestamp;

  const SearchSuggestion({
    required this.id,
    required this.text,
    required this.type,
    this.timestamp,
  });

  @override
  List<Object?> get props => [id, text, type, timestamp];

  factory SearchSuggestion.recent({
    required String text,
    String? id,
    DateTime? timestamp,
  }) {
    return SearchSuggestion(
      id: id ?? text.hashCode.toString(),
      text: text,
      type: SuggestionType.recent,
      timestamp: timestamp ?? DateTime.now(),
    );
  }

  factory SearchSuggestion.popular({
    required String text,
    String? id,
  }) {
    return SearchSuggestion(
      id: id ?? 'popular_${text.hashCode}',
      text: text,
      type: SuggestionType.popular,
    );
  }

  factory SearchSuggestion.trending({
    required String text,
    String? id,
  }) {
    return SearchSuggestion(
      id: id ?? 'trending_${text.hashCode}',
      text: text,
      type: SuggestionType.trending,
    );
  }
}

enum SuggestionType {
  recent,
  popular,
  trending,
}

/// Domain entity representing a group of search suggestions
class SearchSuggestionGroup with EquatableMixin {
  final String title;
  final List<SearchSuggestion> suggestions;

  const SearchSuggestionGroup({
    required this.title,
    required this.suggestions,
  });

  @override
  List<Object?> get props => [title, suggestions];
}
