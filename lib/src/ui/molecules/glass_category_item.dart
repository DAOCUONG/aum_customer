import 'package:flutter/material.dart';
import '../theme/glass_theme.dart';
import '../atoms/primary_icon.dart';
import '../atoms/glass_chip.dart';

/// GlassCategoryItem - A category item with icon and selection state
///
/// Displays a category with icon, name, and optional item count
class GlassCategoryItem extends StatefulWidget {
  final String name;
  final IconData icon;
  final String? emoji;
  final bool isSelected;
  final bool isActive;
  final int? itemCount;
  final VoidCallback? onTap;
  final double size;
  final bool showShadow;

  const GlassCategoryItem({
    super.key,
    required this.name,
    required this.icon,
    this.emoji,
    this.isSelected = false,
    this.isActive = true,
    this.itemCount,
    this.onTap,
    this.size = 64,
    this.showShadow = true,
  });

  @override
  State<GlassCategoryItem> createState() => _GlassCategoryItemState();
}

class _GlassCategoryItemState extends State<GlassCategoryItem> {
  bool _isPressed = false;

  void _handleTapDown(TapDownDetails details) {
    if (widget.isActive && widget.onTap != null) {
      setState(() => _isPressed = true);
    }
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return GestureDetector(
      onTap: widget.isActive ? widget.onTap : null,
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOutCubic,
        transform:
            _isPressed ? Matrix4.translationValues(0, 2, 0) : Matrix4.identity(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                color: widget.isSelected
                    ? GlassTheme.primary.withOpacity(0.1)
                    : theme.glassSurface.withOpacity(0.5),
                borderRadius: BorderRadius.circular(widget.size * 0.3),
                border: widget.isSelected
                    ? Border.all(
                        color: GlassTheme.primary.withOpacity(0.2),
                        width: 2,
                      )
                    : Border.all(
                        color: theme.glassBorder,
                        width: 1,
                      ),
                boxShadow: widget.isSelected && widget.showShadow
                    ? [
                        BoxShadow(
                          color: GlassTheme.primary.withOpacity(0.15),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
                gradient: !widget.isSelected
                    ? LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(0.5),
                          Colors.white.withOpacity(0.2),
                        ],
                      )
                    : null,
              ),
              child: Stack(
                children: [
                  Center(
                    child: widget.emoji != null
                        ? Text(
                            widget.emoji!,
                            style: TextStyle(
                              fontSize: widget.size * 0.4,
                            ),
                          )
                        : Icon(
                            widget.icon,
                            size: widget.size * 0.4,
                            color: widget.isSelected
                                ? GlassTheme.primary
                                : theme.textSecondary,
                          ),
                  ),
                  if (widget.itemCount != null && widget.itemCount! > 0)
                    Positioned(
                      top: -2,
                      right: -2,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: widget.isSelected
                              ? GlassTheme.primary
                              : theme.textSecondary,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: theme.glassSurface,
                            width: 2,
                          ),
                        ),
                        child: Text(
                          widget.itemCount! > 99 ? '99+' : '${widget.itemCount}',
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w700,
                            color: widget.isSelected
                                ? Colors.white
                                : theme.textPrimary,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Text(
              widget.name,
              style: TextStyle(
                fontSize: 11,
                fontWeight: widget.isSelected ? FontWeight.w700 : FontWeight.w500,
                color: widget.isSelected
                    ? GlassTheme.primary
                    : theme.textSecondary,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Horizontal scrolling category rail
class CategoryRail extends StatefulWidget {
  final List<CategoryItem> items;
  final int selectedIndex;
  final Function(int index) onSelect;
  final double itemSize;
  final bool showItemCount;
  final EdgeInsetsGeometry? padding;

  const CategoryRail({
    super.key,
    required this.items,
    this.selectedIndex = 0,
    required this.onSelect,
    this.itemSize = 64,
    this.showItemCount = true,
    this.padding,
  });

  @override
  State<CategoryRail> createState() => _CategoryRailState();
}

class CategoryItem {
  final String name;
  final IconData icon;
  final String? emoji;
  final int? itemCount;

  CategoryItem({
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
    return SizedBox(
      height: widget.itemSize + 24,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        padding: widget.padding ??
            const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          final item = widget.items[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: GlassCategoryItem(
              name: item.name,
              icon: item.icon,
              emoji: item.emoji,
              isSelected: widget.selectedIndex == index,
              itemCount: widget.showItemCount ? item.itemCount : null,
              onTap: () => widget.onSelect(index),
              size: widget.itemSize,
            ),
          );
        },
      ),
    );
  }
}

/// Compact category chip for horizontal lists
class GlassCategoryChip extends StatelessWidget {
  final String name;
  final IconData icon;
  final String? emoji;
  final bool isSelected;
  final VoidCallback? onTap;
  final double iconSize;

  const GlassCategoryChip({
    super.key,
    required this.name,
    required this.icon,
    this.emoji,
    this.isSelected = false,
    this.onTap,
    this.iconSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds:200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? GlassTheme.primary.withOpacity(0.1)
              : theme.glassSurface.withOpacity(0.4),
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(
                  color: GlassTheme.primary.withOpacity(0.2),
                  width: 1,
                )
              : Border.all(
                  color: theme.glassBorder,
                  width: 1,
                ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (emoji != null)
              Text(emoji!, style: TextStyle(fontSize: iconSize * 0.5))
            else
              Icon(
                icon,
                size: iconSize,
                color: isSelected ? GlassTheme.primary : theme.textSecondary,
              ),
            if (name.isNotEmpty) ...[
              const SizedBox(width: 6),
              Text(
                name,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected
                      ? GlassTheme.primary
                      : theme.textSecondary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
