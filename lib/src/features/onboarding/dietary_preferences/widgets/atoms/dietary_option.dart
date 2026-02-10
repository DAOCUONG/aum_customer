import 'package:flutter/material.dart';
import '../../../../../ui/theme/glass_theme.dart';

/// DietaryOption - ATOM
///
/// A single selectable dietary preference option with glassmorphism styling.
///
/// Features:
/// - Glass atom effect with blur(30px)
/// - Selected state with primary color highlight
/// - Emoji icon in white background
/// - Circular checkbox indicator
/// - Smooth animations on selection change
///
/// Usage:
/// ```dart
/// DietaryOption(
///   emoji: '🥗',
///   title: 'Vegetarian',
///   description: 'No meat, fish, or poultry',
///   isSelected: true,
///   onTap: () { /* toggle selection */ },
/// )
/// ```
class DietaryOption extends StatelessWidget {
  final String emoji;
  final String title;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  const DietaryOption({
    super.key,
    required this.emoji,
    required this.title,
    required this.description,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOutCubic,
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: _buildDecoration(),
        child: Row(
          children: [
            _buildEmojiIcon(),
            const SizedBox(width: 16),
            _buildTextContent(),
            const SizedBox(width: 12),
            _buildCheckbox(),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildDecoration() {
    return BoxDecoration(
      color: isSelected
          ? const Color(0xFFFFF4F0)
          : GlassTheme.glassSurface.withValues(alpha: 0.5),
      borderRadius: BorderRadius.circular(24),
      border: Border.all(
        color: isSelected ? GlassTheme.primary : GlassTheme.glassBorder,
        width: isSelected ? 2 : 1,
      ),
      boxShadow: isSelected
          ? [
              BoxShadow(
                color: GlassTheme.primary.withValues(alpha: 0.15),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ]
          : [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 12,
                offset: const Offset(0, 2),
              ),
            ],
    );
  }

  Widget _buildEmojiIcon() {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          emoji,
          style: const TextStyle(fontSize: 26),
        ),
      ),
    );
  }

  Widget _buildTextContent() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: GlassTheme.textPrimary,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: GlassTheme.textSecondary,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckbox() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: isSelected ? GlassTheme.primary : Colors.transparent,
        border: Border.all(
          color: isSelected ? GlassTheme.primary : const Color(0xFFD1D1D6),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: isSelected
          ? const Icon(
              Icons.check,
              size: 14,
              color: Colors.white,
              weight: 700,
            )
          : null,
    );
  }
}
