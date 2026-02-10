import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../ui/atoms/glass_filter_chip.dart';
import '../../../../ui/atoms/glass_icon_button.dart';
import '../../../../ui/theme/glass_design_system.dart';
import '../providers/filter_notifier.dart';
import '../providers/search_notifier.dart';
import '../providers/filter_state.dart';
import '../../domain/entities/search_filter.dart';

/// Filter Panel Screen - Side panel for filtering search results
/// Uses Riverpod for state management
class FilterPanelScreen extends ConsumerStatefulWidget {
  const FilterPanelScreen({super.key});

  @override
  ConsumerState<FilterPanelScreen> createState() => _FilterPanelScreenState();
}

class _FilterPanelScreenState extends ConsumerState<FilterPanelScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(filterNotifierProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              color: Colors.black.withValues(alpha: 0.3),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: _buildFilterPanel(state),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterPanel(FilterPanelState state) {
    if (state is InitialFilterState || state is LoadingFilterState) {
      return Container(
        width: MediaQuery.of(context).size.width * 0.85,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(40),
          ),
        ),
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    if (state is ErrorFilterState) {
      return Container(
        width: MediaQuery.of(context).size.width * 0.85,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(40),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(state.message),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref.read(filterNotifierProvider.notifier);
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (state is LoadedFilterState) {
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
            _buildPanelHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    _buildSortBySection(state.currentFilter.sortOption),
                    const SizedBox(height: 24),
                    _buildPriceRangeSection(state.currentFilter.selectedPriceIndices),
                    const SizedBox(height: 24),
                    _buildDeliveryTimeSection(state.currentFilter.maxDeliveryTime),
                    const SizedBox(height: 24),
                    _buildDietarySection(state.currentFilter.selectedDietary),
                    const SizedBox(height: 24),
                    _buildOffersSection(state.currentFilter.specialOffersOnly),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            _buildBottomButton(state),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
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
              onTap: () {
                ref.read(filterNotifierProvider.notifier).resetFilters();
              },
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

  Widget _buildSortBySection(SortOption selectedOption) {
    final sortOptions = SortOption.values;

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
        _buildSortOption(sortOptions[0].label, Icons.thumb_up,
            selectedOption == SortOption.recommended, () {
          ref.read(filterNotifierProvider.notifier).updateSortOption(SortOption.recommended);
        }),
        _buildSortOption(sortOptions[1].label, Icons.bolt,
            selectedOption == SortOption.fastestDelivery, () {
          ref.read(filterNotifierProvider.notifier).updateSortOption(SortOption.fastestDelivery);
        }),
        _buildSortOption(sortOptions[2].label, Icons.star,
            selectedOption == SortOption.highestRated, () {
          ref.read(filterNotifierProvider.notifier).updateSortOption(SortOption.highestRated);
        }),
      ],
    );
  }

  Widget _buildSortOption(String label, IconData icon, bool isSelected, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: isSelected ? primaryColor.withValues(alpha: 0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? primaryColor : Colors.transparent,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 18,
                color: isSelected ? primaryColor : textSecondary,
              ),
              const SizedBox(width: 12),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? primaryColor : textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriceRangeSection(List<int> selectedIndices) {
    final priceLabels = ['\$', '\$\$', '\$\$\$', '\$\$\$'];

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
        Row(
          children: priceLabels.asMap().entries.map((entry) {
            final index = entry.key;
            final isSelected = selectedIndices.contains(index);
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  ref.read(filterNotifierProvider.notifier).togglePriceRange(index);
                },
                child: Container(
                  margin: EdgeInsets.only(right: index < priceLabels.length - 1 ? 8 : 0),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      entry.value,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : textPrimary,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDeliveryTimeSection(double deliveryTime) {
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
              '${deliveryTime.toInt()} min',
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
            color: Colors.white.withValues(alpha: 0.4),
            borderRadius: buttonRadius,
            border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
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
                  inactiveTrackColor: Colors.black.withValues(alpha: 0.1),
                  thumbColor: Colors.white,
                  overlayColor: primaryColor.withValues(alpha: 0.2),
                ),
                child: Slider(
                  value: deliveryTime,
                  min: 10,
                  max: 90,
                  divisions: 8,
                  onChanged: (value) {
                    ref.read(filterNotifierProvider.notifier).updateMaxDeliveryTime(value);
                  },
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

  Widget _buildDietarySection(List<String> selectedDietary) {
    final dietaryOptions = ['Vegetarian', 'Vegan', 'Gluten-Free', 'Halal'];

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
          children: dietaryOptions.asMap().entries.map((entry) {
            final isSelected = selectedDietary.contains(entry.value);
            return GlassDietaryChip(
              label: entry.value,
              isSelected: isSelected,
              onTap: () {
                ref.read(filterNotifierProvider.notifier).toggleDietary(entry.value);
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildOffersSection(bool specialOffersOnly) {
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
            _buildSwitch(specialOffersOnly),
          ],
        ),
      ],
    );
  }

  Widget _buildSwitch(bool value) {
    return GestureDetector(
      onTap: () {
        ref.read(filterNotifierProvider.notifier).toggleSpecialOffersOnly();
      },
      child: Container(
        width: 44,
        height: 24,
        decoration: BoxDecoration(
          color: value ? primaryColor : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: AnimatedAlign(
            alignment: value ? Alignment.centerRight : Alignment.centerLeft,
            duration: const Duration(milliseconds: 200),
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
      ),
    );
  }

  Widget _buildBottomButton(LoadedFilterState state) {
    final filterCount = state.currentFilter.activeFilterCount;
    const restaurantCount = 142;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.horizontal(
          left: Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
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
            onPressed: () {
              ref.read(searchNotifierProvider.notifier).updateFilter(state.currentFilter);
              context.pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: buttonRadius,
              ),
            ),
            child: Text(
              filterCount > 0
                  ? 'Show $restaurantCount Restaurants ($filterCount filters)'
                  : 'Show $restaurantCount Restaurants',
              style: const TextStyle(
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
