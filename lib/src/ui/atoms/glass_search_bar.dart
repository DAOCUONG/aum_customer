import 'package:flutter/material.dart';
import '../theme/glass_design_system.dart';

/// Glass Search Bar - Search input with glass effect
class GlassSearchBar extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final VoidCallback? onFilterTap;
  final bool showFilter;
  final bool autofocus;
  final String? initialValue;
  final VoidCallback? onTap;

  const GlassSearchBar({
    super.key,
    this.hintText = 'Search for restaurants or dishes...',
    this.controller,
    this.onFilterTap,
    this.showFilter = true,
    this.autofocus = false,
    this.initialValue,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.6),
          borderRadius: searchBarRadius,
          border: Border.all(color: Colors.white.withOpacity(0.5)),
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Icon(
              Icons.search,
              size: 20,
              color: textSecondary,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: controller != null
                  ? TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: hintText,
                        border: InputBorder.none,
                        isDense: true,
                        hintStyle: TextStyle(color: textSecondary),
                      ),
                      style: const TextStyle(fontSize: 15),
                      autofocus: autofocus,
                    )
                  : Text(
                      initialValue ?? hintText,
                      style: TextStyle(
                        fontSize: 15,
                        color: initialValue != null ? textPrimary : textSecondary,
                      ),
                    ),
            ),
            if (showFilter)
              GestureDetector(
                onTap: onFilterTap,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.tune,
                    size: 20,
                    color: primaryColor,
                  ),
                ),
              ),
            const SizedBox(width: 4),
          ],
        ),
      ),
    );
  }
}

/// Glass Location Bar - Shows current location
class GlassLocationBar extends StatelessWidget {
  final String address;
  final VoidCallback? onTap;

  const GlassLocationBar({
    super.key,
    required this.address,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: locationBarRadius,
          border: Border.all(color: Colors.white.withOpacity(0.4)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.location_on,
              size: 18,
              color: primaryColor,
            ),
            const SizedBox(width: 6),
            Text(
              address,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: textPrimary,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.expand_more,
              size: 18,
              color: textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}

/// Glass Search Input with Back Button (for search screens)
class GlassSearchInput extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final VoidCallback? onBackTap;
  final VoidCallback? onFilterTap;
  final bool autofocus;

  const GlassSearchInput({
    super.key,
    required this.hintText,
    required this.controller,
    this.onBackTap,
    this.onFilterTap,
    this.autofocus = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GlassIconButton.transparent(
          onPressed: onBackTap ?? () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          size: 40,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
              borderRadius: locationBarRadius,
              border: Border.all(color: Colors.white.withOpacity(0.5)),
            ),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Icon(
                    Icons.search,
                    size: 20,
                    color: textSecondary,
                  ),
                ),
                border: InputBorder.none,
                isDense: true,
                hintStyle: TextStyle(color: textSecondary),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              style: const TextStyle(fontSize: 15),
              autofocus: autofocus,
            ),
          ),
        ),
        if (onFilterTap != null) ...[
          const SizedBox(width: 8),
          GlassIconButton.transparent(
            onPressed: onFilterTap,
            icon: const Icon(Icons.tune, size: 20),
            size: 40,
          ),
        ],
      ],
    );
  }
}
