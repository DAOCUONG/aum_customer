import 'package:flutter/material.dart';
import '../theme/glass_design_system.dart';

/// Glass Filter Chip - Filter option with glass effect
class GlassFilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;
  final Widget? leading;
  final Widget? trailing;
  final bool showClose;

  const GlassFilterChip({
    super.key,
    required this.label,
    this.isSelected = false,
    this.onTap,
    this.leading,
    this.trailing,
    this.showClose = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withOpacity(0.15) : Colors.white.withOpacity(0.4),
          borderRadius: filterChipRadius,
          border: Border.all(
            color: isSelected
                ? primaryColor.withOpacity(0.3)
                : Colors.white.withOpacity(0.5),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (leading != null) ...[
              leading!,
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: isSelected ? primaryColor : textPrimary,
              ),
            ),
            if (trailing != null) ...[
              const SizedBox(width: 6),
              trailing!,
            ],
            if (showClose) ...[
              const SizedBox(width: 6),
              Icon(
                Icons.close,
                size: 16,
                color: isSelected ? primaryColor : textSecondary,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Glass Sort Option - Radio option for sort
class GlassSortOption extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback? onTap;

  const GlassSortOption({
    super.key,
    required this.label,
    required this.icon,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withOpacity(0.1) : Colors.white.withOpacity(0.4),
          borderRadius: buttonRadius,
          border: Border.all(
            color: isSelected
                ? primaryColor.withOpacity(0.3)
                : Colors.white.withOpacity(0.5),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isSelected ? primaryColor : Colors.transparent,
                border: Border.all(
                  color: isSelected ? primaryColor : textTertiary,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: isSelected
                  ? Icon(
                      Icons.check,
                      size: 12,
                      color: Colors.white,
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isSelected
                    ? primaryColor
                    : (icon == Icons.bolt
                        ? Colors.blue.shade100
                        : icon == Icons.star
                            ? successGreen.withOpacity(0.2)
                            : Colors.white.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                size: 18,
                color: isSelected
                    ? Colors.white
                    : (icon == Icons.bolt
                        ? Colors.blue
                        : icon == Icons.star
                            ? successGreen
                            : textSecondary),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: isSelected ? primaryColor : textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Glass Price Toggle - Price range selector
class GlassPriceToggle extends StatelessWidget {
  final List<String> labels;
  final int selectedIndex;
  final Function(int) onSelect;

  const GlassPriceToggle({
    super.key,
    required this.labels,
    this.selectedIndex = -1,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(labels.length, (index) {
        final isSelected = index == selectedIndex;
        return Expanded(
          child: GestureDetector(
            onTap: () => onSelect(index),
            child: Container(
              height: 48,
              margin: EdgeInsets.only(right: index < labels.length - 1 ? 8 : 0),
              decoration: BoxDecoration(
                color: isSelected ? primaryColor : Colors.white.withOpacity(0.4),
                borderRadius: buttonRadius,
                border: Border.all(
                  color: isSelected
                      ? primaryColor.withOpacity(0.3)
                      : Colors.white.withOpacity(0.5),
                ),
              ),
              child: Center(
                child: Text(
                  labels[index],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : textPrimary,
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

/// Glass Dietary Chip - Dietary preference toggle
class GlassDietaryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  const GlassDietaryChip({
    super.key,
    required this.label,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? successGreen.withOpacity(0.15) : Colors.white.withOpacity(0.4),
          borderRadius: filterChipRadius,
          border: Border.all(
            color: isSelected
                ? successGreen.withOpacity(0.3)
                : Colors.white.withOpacity(0.5),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: isSelected ? successGreen : Colors.transparent,
                border: Border.all(
                  color: isSelected ? successGreen : textTertiary,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: isSelected
                  ? Icon(
                      Icons.check,
                      size: 12,
                      color: Colors.white,
                    )
                  : null,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isSelected ? successGreen : textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Glass Trending Chip - For search suggestions
class GlassTrendingChip extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;

  const GlassTrendingChip({super.key, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.4),
          borderRadius: filterChipRadius,
          border: Border.all(color: Colors.white.withOpacity(0.5)),
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
