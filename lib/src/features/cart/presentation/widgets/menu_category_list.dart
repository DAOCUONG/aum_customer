import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../ui/theme/glass_theme.dart';
import '../../domain/entities/menu_category.dart';

/// Glassmorphism category sidebar for menu navigation
class MenuCategoryList extends ConsumerWidget {
  final List<MenuCategory> categories;
  final String selectedCategoryId;
  final Function(String categoryId) onCategorySelected;

  const MenuCategoryList({
    super.key,
    required this.categories,
    required this.selectedCategoryId,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = GlassTheme.of(context);

    return Container(
      width: 100,
      decoration: BoxDecoration(
        color: theme.glassSurfaceColor.withOpacity(0.5),
        borderRadius: const BorderRadius.horizontal(
          right: Radius.circular(24),
        ),
      ),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category.id == selectedCategoryId;

          return _CategoryItem(
            category: category,
            isSelected: isSelected,
            onTap: () => onCategorySelected(category.id),
          );
        },
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final MenuCategory category;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryItem({
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  IconData _getIcon() {
    switch (category.icon) {
      case 'pizza':
        return Icons.local_pizza;
      case 'restaurant':
        return Icons.restaurant;
      case 'leaf':
        return Icons.eco;
      case 'cake':
        return Icons.cake;
      case 'appetizer':
        return Icons.lunch_dining;
      default:
        return Icons.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.primaryColor.withOpacity(0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: isSelected
              ? Border.all(
                  color: theme.primaryColor.withOpacity(0.3),
                  width: 1,
                )
              : null,
        ),
        child: Column(
          children: [
            Icon(
              _getIcon(),
              color: isSelected ? theme.primaryColor : theme.textSecondaryColor,
              size: 28,
            ),
            const SizedBox(height: 6),
            Text(
              category.name,
              style: GlassTextStyles.labelSmall(context).copyWith(
                color: isSelected ? theme.primaryColor : theme.textSecondaryColor,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (category.itemCount != null) ...[
              const SizedBox(height: 4),
              Text(
                '${category.itemCount}',
                style: GlassTextStyles.caption(context).copyWith(
                  color: theme.textTertiaryColor,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
