import 'package:flutter/material.dart';
import '../theme/glass_design_system.dart';

/// Glass Category Icon - Circular icon with glass effect
class GlassCategoryIcon extends StatelessWidget {
  final String emoji;
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  const GlassCategoryIcon({
    super.key,
    required this.emoji,
    required this.label,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: isSelected ? primaryColor.withOpacity(0.15) : Colors.white.withOpacity(0.5),
              borderRadius: categoryIconRadius,
              border: Border.all(
                color: isSelected ? primaryColor.withOpacity(0.3) : Colors.white.withOpacity(0.6),
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.15),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
            ),
            child: Center(
              child: Text(
                emoji,
                style: const TextStyle(fontSize: 28),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isSelected ? primaryColor : textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
