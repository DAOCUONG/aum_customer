import 'package:flutter/material.dart';
import '../theme/glass_design_system.dart';

/// Glass Bottom Navigation Bar
class GlassBottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const GlassBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<GlassBottomNavBar> createState() => _GlassBottomNavBarState();
}

class _GlassBottomNavBarState extends State<GlassBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    final items = [
      {'icon': Icons.home, 'label': 'Home'},
      {'icon': Icons.favorite, 'label': 'Favorites'},
      {'icon': Icons.shopping_bag, 'label': 'Bag'},
      {'icon': Icons.receipt_long, 'label': 'Orders'},
      {'icon': Icons.person, 'label': 'Profile'},
    ];

    return Container(
      height: 88,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.85),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(32),
        ),
        border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final isSelected = widget.currentIndex == index;
          final isFloating = index == 2; // Shopping bag is floating

          if (isFloating) {
            // Floating Shopping Bag Button
            return GestureDetector(
              onTap: () => widget.onTap(index),
              child: Container(
                width: 56,
                height: 56,
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [primaryLight, primaryColor],
                  ),
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withValues(alpha: 0.4),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Icon(
                  item['icon'] as IconData,
                  size: 26,
                  color: Colors.white,
                ),
              ),
            );
          }

          return GestureDetector(
            onTap: () => widget.onTap(index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    item['icon'] as IconData,
                    size: isSelected ? 26 : 24,
                    color: isSelected ? primaryColor : textSecondary,
                  ),
                  if (isSelected)
                    Text(
                      item['label'] as String,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
                      ),
                    )
                  else
                    const SizedBox(height: 16),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
