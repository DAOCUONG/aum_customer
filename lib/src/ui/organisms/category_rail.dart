import 'package:flutter/material.dart';
import '../theme/glass_theme.dart';
import '../atoms/glass_card.dart';
import '../atoms/primary_icon.dart';
import '../molecules/glass_category_item.dart';

/// CategoryRail - Horizontal scrolling category list
///
/// Horizontal scrollable rail for category selection
class CategoryRail extends StatefulWidget {
  final List<CategoryItem> categories;
  final int selectedIndex;
  final Function(int index) onSelect;
  final double itemSize;
  final bool showItemCount;
  final EdgeInsetsGeometry? padding;
  final bool showDivider;

  const CategoryRail({
    super.key,
    required this.categories,
    this.selectedIndex = 0,
    required this.onSelect,
    this.itemSize = 64,
    this.showItemCount = true,
    this.padding,
    this.showDivider = true,
  });

  @override
  State<CategoryRail> createState() => _CategoryRailState();
}

class CategoryItem {
  final String id;
  final String name;
  final IconData icon;
  final String? emoji;
  final int? itemCount;

  const CategoryItem({
    required this.id,
    required this.name,
    required this.icon,
    this.emoji,
    this.itemCount,
  });
}

class _CategoryRailState extends State<CategoryRail> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: widget.itemSize + 24,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            padding: widget.padding ??
                const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            itemCount: widget.categories.length,
            itemBuilder: (context, index) {
              final category = widget.categories[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: GlassCategoryItem(
                  name: category.name,
                  icon: category.icon,
                  emoji: category.emoji,
                  isSelected: widget.selectedIndex == index,
                  itemCount: widget.showItemCount ? category.itemCount : null,
                  onTap: () => widget.onSelect(index),
                  size: widget.itemSize,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Compact category chips rail
class CategoryChipsRail extends StatefulWidget {
  final List<CategoryChipItem> chips;
  final int selectedIndex;
  final Function(int index) onSelect;

  const CategoryChipsRail({
    super.key,
    required this.chips,
    this.selectedIndex = 0,
    required this.onSelect,
  });

  @override
  State<CategoryChipsRail> createState() => _CategoryChipsRailState();
}

class CategoryChipItem {
  final String id;
  final String name;
  final IconData icon;
  final String? emoji;

  CategoryChipItem({
    required this.id,
    required this.name,
    required this.icon,
    this.emoji,
  });
}

class _CategoryChipsRailState extends State<CategoryChipsRail> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: widget.chips.length,
        itemBuilder: (context, index) {
          final chip = widget.chips[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: GlassChip.icon(
              label: chip.name,
              icon: chip.icon,
              isSelected: widget.selectedIndex == index,
              onTap: () => widget.onSelect(index),
            ),
          );
        },
      ),
    );
  }
}

/// Category card with detailed view
class CategoryCard extends StatelessWidget {
  final String name;
  final IconData icon;
  final String? emoji;
  final int itemCount;
  final VoidCallback? onTap;
  final double size;

  const CategoryCard({
    super.key,
    required this.name,
    required this.icon,
    this.emoji,
    this.itemCount = 0,
    this.onTap,
    this.size = 120,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: GlassCard(
        variant: GlassCardVariant.atom,
        padding: const EdgeInsets.all(16),
        size: GlassCardSize.small,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: size * 0.6,
              height: size * 0.6,
              decoration: BoxDecoration(
                color: GlassTheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(size * 0.25),
                border: Border.all(
                  color: GlassTheme.primary.withOpacity(0.2),
                ),
              ),
              child: Center(
                child: emoji != null
                    ? Text(
                        emoji!,
                        style: TextStyle(fontSize: size * 0.3),
                      )
                    : Icon(
                        icon,
                        size: size * 0.3,
                        color: GlassTheme.primary,
                      ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              name,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: theme.textPrimary,
              ),
            ),
            if (itemCount > 0)
              Text(
                '$itemCount items',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: theme.textTertiary,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Featured category with highlight
class FeaturedCategoryCard extends StatelessWidget {
  final String name;
  final IconData icon;
  final String? emoji;
  final VoidCallback? onTap;
  final double size;

  const FeaturedCategoryCard({
    super.key,
    required this.name,
    required this.icon,
    this.emoji,
    this.onTap,
    this.size = 140,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: GlassCard(
        variant: GlassCardVariant.panel,
        size: GlassCardSize.small,
        padding: EdgeInsets.zero,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      GlassTheme.primary.withOpacity(0.15),
                      GlassTheme.primary.withOpacity(0.05),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: size * 0.4,
                    height: size * 0.4,
                    decoration: BoxDecoration(
                      color: GlassTheme.primary.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(size * 0.2),
                    ),
                    child: Center(
                      child: emoji != null
                          ? Text(
                              emoji!,
                              style: TextStyle(fontSize: size * 0.25),
                            )
                          : Icon(
                              icon,
                              size: size * 0.25,
                              color: GlassTheme.primary,
                            ),
                    ),
                  ),
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: theme.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
