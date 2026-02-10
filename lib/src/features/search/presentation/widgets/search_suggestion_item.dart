import 'package:flutter/material.dart';
import '../../domain/entities/search_suggestion.dart';
import '../../../../ui/theme/glass_design_system.dart';

/// Widget for displaying a single search suggestion item
class SearchSuggestionItem extends StatelessWidget {
  final SearchSuggestion suggestion;
  final VoidCallback onTap;
  final VoidCallback? onDelete;

  const SearchSuggestionItem({
    required this.suggestion,
    required this.onTap,
    this.onDelete,
    super.key,
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
                _getIcon(),
                size: 20,
                color: textSecondary,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  suggestion.text,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: textPrimary,
                  ),
                ),
              ),
              if (onDelete != null) ...[
                GestureDetector(
                  onTap: onDelete,
                  child: Icon(
                    Icons.close,
                    size: 18,
                    color: textTertiary,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIcon() {
    switch (suggestion.type) {
      case SuggestionType.recent:
        return Icons.schedule;
      case SuggestionType.popular:
        return Icons.trending_up;
      case SuggestionType.trending:
        return Icons.local_fire_department;
    }
  }
}

/// Widget for displaying a popular search item
class PopularSearchItem extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const PopularSearchItem({
    required this.text,
    required this.onTap,
    super.key,
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
