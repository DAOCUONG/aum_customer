import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../ui/theme/glass_theme.dart';
import '../providers/item_customization_notifier.dart';
import '../providers/cart_notifier.dart';
import '../providers/item_customization_state.dart';
import '../widgets/quantity_selector.dart';
import '../../domain/entities/menu_item_entity.dart';

/// Item customization screen with glassmorphism design
/// Allows users to customize menu items before adding to cart
class ItemCustomizationScreen extends ConsumerStatefulWidget {
  final String menuItemId;

  const ItemCustomizationScreen({
    super.key,
    required this.menuItemId,
  });

  @override
  ConsumerState<ItemCustomizationScreen> createState() =>
      _ItemCustomizationScreenState();
}

class _ItemCustomizationScreenState
    extends ConsumerState<ItemCustomizationScreen> {
  @override
  void initState() {
    super.initState();
    // Load menu item on first build
    Future.microtask(() {
      ref
          .read(itemCustomizationNotifierProvider.notifier)
          .loadMenuItem(menuItemId: widget.menuItemId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final customizationState = ref.watch(itemCustomizationNotifierProvider);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: GlassGradients.meshGradient,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              _buildHeader(context),
              const SizedBox(height: 16),
              // Content
              Expanded(
                child: customizationState.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : customizationState.menuItem == null
                        ? _buildErrorState(context, 'Menu item not found')
                        : _buildContent(context, ref),
              ),
              // Bottom bar with price and add to cart
              _buildBottomBar(context, ref),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = GlassTheme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: theme.glassSurfaceColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: theme.glassBorderColor),
            ),
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.black),
              onPressed: () => context.pop(),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              'Customize',
              style: GlassTextStyles.titleLarge(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 48,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: GlassTextStyles.bodyLarge(context),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => context.pop(),
            child: const Text('Go Back'),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, WidgetRef ref) {
    final customizationState = ref.watch(itemCustomizationNotifierProvider);
    final menuItem = customizationState.menuItem!;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Food image
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.network(
              menuItem.imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(Icons.fastfood, size: 64),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          // Item info
          Text(
            menuItem.name,
            style: GlassTextStyles.headlineMedium(context),
          ),
          const SizedBox(height: 8),
          Text(
            menuItem.description,
            style: GlassTextStyles.bodyMedium(context).copyWith(
              color: GlassTheme.of(context).textSecondaryColor,
            ),
          ),
          const SizedBox(height: 24),
          // Customization groups
          if (menuItem.customizationGroups != null)
            ...menuItem.customizationGroups!.map(
              (group) => _buildCustomizationGroup(context, group, ref),
            ),
          const SizedBox(height: 24),
          // Special instructions
          _buildSpecialInstructions(context, ref),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildCustomizationGroup(
    BuildContext context,
    MenuItemCustomizationGroup group,
    WidgetRef ref,
  ) {
    final customizationState = ref.watch(itemCustomizationNotifierProvider);

    return Container(
      decoration: GlassDecoration.atom(context: context),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                group.name,
                style: GlassTextStyles.titleMedium(context),
              ),
              if (group.isRequired) ...[
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: GlassTheme.error.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Required',
                    style: GlassTextStyles.labelSmall(context).copyWith(
                      color: GlassTheme.error,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 12),
          ...group.options.map(
            (option) => _buildOptionItem(
              context,
              option,
              customizationState.selectedRequiredOptions.contains(option.id) ||
                  customizationState.selectedOptionalOptions.contains(option.id),
              ref,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionItem(
    BuildContext context,
    MenuItemCustomizationOption option,
    bool isSelected,
    WidgetRef ref,
  ) {
    final customizationState = ref.watch(itemCustomizationNotifierProvider);
    final customizationNotifier =
        ref.read(itemCustomizationNotifierProvider.notifier);
    final theme = GlassTheme.of(context);

    final isRequiredSelected = customizationState.selectedRequiredOptions
        .contains(option.id);
    final isOptionalSelected = customizationState.selectedOptionalOptions
        .contains(option.id);
    final isCurrentlySelected = isRequiredSelected || isOptionalSelected;

    return GestureDetector(
      onTap: () {
        if (customizationState.menuItem?.customizationGroups != null) {
          final group = customizationState.menuItem!.customizationGroups!
              .firstWhere(
                (g) => g.options.any((o) => o.id == option.id),
                orElse: () => customizationState.menuItem!.customizationGroups!.first,
              );

          if (group.isRequired) {
            customizationNotifier.toggleRequiredOption(option.id);
          } else {
            customizationNotifier.toggleOptionalOption(option.id);
          }
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isCurrentlySelected
              ? theme.primaryColor.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isCurrentlySelected
                ? theme.primaryColor
                : theme.glassBorderColor.withValues(alpha: 0.3),
            width: isCurrentlySelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                option.name,
                style: GlassTextStyles.bodyMedium(context).copyWith(
                  color: isCurrentlySelected
                      ? theme.primaryColor
                      : theme.textPrimaryColor,
                  fontWeight:
                      isCurrentlySelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
            if (option.price > 0)
              Text(
                '+\$${option.price.toStringAsFixed(2)}',
                style: GlassTextStyles.labelMedium(context).copyWith(
                  color: isCurrentlySelected
                      ? theme.primaryColor
                      : theme.textSecondaryColor,
                ),
              ),
            const SizedBox(width: 12),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isCurrentlySelected ? theme.primaryColor : Colors.transparent,
                border: Border.all(
                  color: isCurrentlySelected
                      ? theme.primaryColor
                      : theme.textTertiaryColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: isCurrentlySelected
                  ? const Icon(
                      Icons.check,
                      size: 16,
                      color: Colors.white,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecialInstructions(BuildContext context, WidgetRef ref) {
    final customizationNotifier =
        ref.read(itemCustomizationNotifierProvider.notifier);
    final instructionsController = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.note_add_outlined,
              size: 20,
              color: GlassTheme.of(context).textSecondaryColor,
            ),
            const SizedBox(width: 8),
            Text(
              'Special Instructions',
              style: GlassTextStyles.titleMedium(context),
            ),
          ],
        ),
        const SizedBox(height: 12),
        TextField(
          controller: instructionsController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Any allergies or special requests?',
            filled: true,
            fillColor: GlassTheme.of(context).glassInputBgColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
          onChanged: (value) {
            customizationNotifier.setSpecialInstructions(value);
          },
        ),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context, WidgetRef ref) {
    final customizationState = ref.watch(itemCustomizationNotifierProvider);
    final cartNotifier = ref.read(cartNotifierProvider.notifier);
    final customizationNotifier =
        ref.read(itemCustomizationNotifierProvider.notifier);

    if (customizationState.menuItem == null) return const SizedBox.shrink();

    final menuItem = customizationState.menuItem!;
    final canAdd = customizationState.isRequiredOptionsComplete;

    final theme = GlassTheme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.glassSurfaceColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(28),
        ),
        border: Border(
          top: BorderSide(color: theme.glassBorderColor),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          // Quantity selector
          QuantitySelector(
            quantity: customizationState.quantity,
            onIncrement: customizationNotifier.incrementQuantity,
            onDecrement: customizationNotifier.decrementQuantity,
            size: QuantitySelectorSize.large,
          ),
          const SizedBox(width: 20),
          // Add to cart button
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: canAdd ? GlassGradients.primaryButton : null,
                color: canAdd ? null : Colors.grey.shade400,
                borderRadius: BorderRadius.circular(28),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: canAdd
                      ? () async {
                          await cartNotifier.addItem(
                            menuItemId: menuItem.id,
                            name: menuItem.name,
                            description: menuItem.description,
                            price: customizationState.basePrice,
                            imageUrl: menuItem.imageUrl,
                            quantity: customizationState.quantity,
                            customizations:
                                customizationNotifier.getSelectedCustomizations(),
                            notes: customizationState.specialInstructions,
                          );
                          if (context.mounted) {
                            context.pop();
                          }
                        }
                      : null,
                  borderRadius: BorderRadius.circular(28),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Add to Cart  ',
                          style: GlassTextStyles.titleMedium(context).copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          customizationState.formattedTotal,
                          style: GlassTextStyles.titleMedium(context).copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
