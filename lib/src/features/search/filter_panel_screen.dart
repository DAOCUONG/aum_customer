import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../ui/atoms/glass_filter_chip.dart';
import '../../ui/atoms/glass_icon_button.dart';
import '../../ui/theme/glass_design_system.dart';

/// Filter Panel Screen - Side panel for filtering search results
class FilterPanelScreen extends StatefulWidget {
  const FilterPanelScreen({super.key});

  @override
  State<FilterPanelScreen> createState() => _FilterPanelScreenState();
}

class _FilterPanelScreenState extends State<FilterPanelScreen> {
  int _selectedSortIndex = 0;
  int _selectedPriceIndex = -1;
  int _selectedDietaryIndex = -1;
  double _deliveryTime = 45;

  final List<String> _sortOptions = [
    'Recommended',
    'Fastest Delivery',
    'Highest Rated',
  ];

  final List<String> _priceLabels = ['\$', '\$\$', '\$\$\$', '\$\$\$'];

  final List<String> _dietaryOptions = [
    'Vegetarian',
    'Vegan',
    'Gluten-Free',
    'Halal',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Dark Overlay
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              color: Colors.black.withOpacity(0.3),
            ),
          ),
          // Side Panel
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: _buildFilterPanel(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterPanel() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(40),
        ),
      ),
      child: Column(
        children: [
          // Header
          _buildPanelHeader(),
          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  // Sort By Section
                  _buildSortBySection(),
                  const SizedBox(height: 24),
                  // Price Range Section
                  _buildPriceRangeSection(),
                  const SizedBox(height: 24),
                  // Max Delivery Time Section
                  _buildDeliveryTimeSection(),
                  const SizedBox(height: 24),
                  // Dietary Section
                  _buildDietarySection(),
                  const SizedBox(height: 24),
                  // Offers Section
                  _buildOffersSection(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          // Bottom Button
          _buildBottomButton(),
        ],
      ),
    );
  }

  Widget _buildPanelHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(40),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            GlassIconButton.transparent(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.close, size: 20),
              size: 40,
            ),
            const SizedBox(width: 12),
            const Text(
              'Filters',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: textPrimary,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {},
              child: const Text(
                'Clear All',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSortBySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sort By',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: textSecondary,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 12),
        GlassSortOption(
          label: _sortOptions[0],
          icon: Icons.thumb_up,
          isSelected: _selectedSortIndex == 0,
          onTap: () => setState(() => _selectedSortIndex = 0),
        ),
        GlassSortOption(
          label: _sortOptions[1],
          icon: Icons.bolt,
          isSelected: _selectedSortIndex == 1,
          onTap: () => setState(() => _selectedSortIndex = 1),
        ),
        GlassSortOption(
          label: _sortOptions[2],
          icon: Icons.star,
          isSelected: _selectedSortIndex == 2,
          onTap: () => setState(() => _selectedSortIndex = 2),
        ),
      ],
    );
  }

  Widget _buildPriceRangeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Price Range',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: textSecondary,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 12),
        GlassPriceToggle(
          labels: _priceLabels,
          selectedIndex: _selectedPriceIndex,
          onSelect: (index) => setState(() => _selectedPriceIndex = index),
        ),
      ],
    );
  }

  Widget _buildDeliveryTimeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Max Delivery Time',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: textSecondary,
                letterSpacing: 1,
              ),
            ),
            Text(
              '${_deliveryTime.toInt()} min',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.4),
            borderRadius: buttonRadius,
            border: Border.all(color: Colors.white.withOpacity(0.5)),
          ),
          child: Column(
            children: [
              SliderTheme(
                data: SliderThemeData(
                  trackHeight: 4,
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 12,
                    elevation: 2,
                  ),
                  overlayShape: const RoundSliderOverlayShape(
                    overlayRadius: 24,
                  ),
                  activeTrackColor: primaryColor,
                  inactiveTrackColor: Colors.black.withOpacity(0.1),
                  thumbColor: Colors.white,
                  overlayColor: primaryColor.withOpacity(0.2),
                ),
                child: Slider(
                  value: _deliveryTime,
                  min: 10,
                  max: 90,
                  divisions: 8,
                  onChanged: (value) => setState(() => _deliveryTime = value),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '10 min',
                    style: TextStyle(
                      fontSize: 12,
                      color: textTertiary,
                    ),
                  ),
                  Text(
                    '90 min',
                    style: TextStyle(
                      fontSize: 12,
                      color: textTertiary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDietarySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Dietary',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: textSecondary,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: _dietaryOptions.asMap().entries.map((entry) {
            return GlassDietaryChip(
              label: entry.value,
              isSelected: entry.key == 2, // Gluten-Free is selected by default
              onTap: () => setState(() => _selectedDietaryIndex = entry.key),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildOffersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Special Offers Only',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: textPrimary,
              ),
            ),
            Container(
              width: 44,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBottomButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.horizontal(
          left: Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        bottom: true,
        child: SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: () => context.pop(),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: buttonRadius,
              ),
            ),
            child: const Text(
              'Show 142 Restaurants',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
