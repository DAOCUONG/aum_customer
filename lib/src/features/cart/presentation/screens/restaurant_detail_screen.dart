import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../ui/theme/glass_theme.dart';
import '../providers/menu_notifier.dart';
import '../providers/menu_state.dart';
import '../providers/item_customization_notifier.dart';
import '../providers/cart_notifier.dart';
import '../widgets/menu_category_list.dart';
import '../widgets/menu_item_card.dart';
import '../../domain/entities/menu_item_entity.dart';

/// Restaurant detail screen with glassmorphism design
/// Displays restaurant info, menu categories, and menu items
class RestaurantDetailScreen extends ConsumerWidget {
  final String restaurantId;

  const RestaurantDetailScreen({
    super.key,
    required this.restaurantId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menuState = ref.watch(menuNotifierProvider);
    final menuNotifier = ref.read(menuNotifierProvider.notifier);

    // Load restaurant data on first build
    ref.listen(menuNotifierProvider, (_, next) {
      if (next.restaurantId != restaurantId) {
        menuNotifier.loadRestaurant(restaurantId: restaurantId);
      }
    });

    // Initial load
    if (menuState.restaurantId != restaurantId) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        menuNotifier.loadRestaurant(restaurantId: restaurantId);
      });
    }

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
          child: menuState.status == MenuStatus.loading
              ? const Center(child: CircularProgressIndicator())
              : menuState.restaurant == null
                  ? _buildErrorState(context)
                  : _buildContent(context, ref),
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'Restaurant not found',
            style: GlassTextStyles.titleLarge(context),
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
    final menuState = ref.watch(menuNotifierProvider);
    final restaurant = menuState.restaurant!;

    return Column(
      children: [
        // Restaurant header
        _buildRestaurantHeader(context, restaurant),
        const SizedBox(height: 16),
        // Menu content
        Expanded(
          child: Row(
            children: [
              // Category sidebar
              MenuCategoryList(
                categories: menuState.categories,
                selectedCategoryId: menuState.selectedCategoryId,
                onCategorySelected: (categoryId) {
                  ref.read(menuNotifierProvider.notifier).selectCategory(categoryId: categoryId);
                },
              ),
              const SizedBox(width: 16),
              // Menu items
              Expanded(
                child: _buildMenuItems(context, ref),
              ),
            ],
          ),
        ),
        // Floating cart button
        _buildFloatingCartButton(context, ref),
      ],
    );
  }

  Widget _buildRestaurantHeader(
    BuildContext context,
    RestaurantEntity restaurant,
  ) {
    final theme = GlassTheme.of(context);

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: GlassDecoration.panel(context: context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cover image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(24),
            ),
            child: Image.network(
              restaurant.coverUrl,
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 160,
                  decoration: BoxDecoration(
                    color: theme.textTertiaryColor.withOpacity(0.2),
                  ),
                  child: const Icon(Icons.restaurant, size: 48),
                );
              },
            ),
          ),
          // Restaurant info
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        restaurant.name,
                        style: GlassTextStyles.headlineMedium(context),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: restaurant.isOpenNow
                            ? GlassTheme.success.withValues(alpha: 0.15)
                            : GlassTheme.error.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: restaurant.isOpenNow
                              ? GlassTheme.success.withValues(alpha: 0.3)
                              : GlassTheme.error.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Text(
                        restaurant.isOpenNow ? 'Open' : 'Closed',
                        style: GlassTextStyles.labelSmall(context).copyWith(
                          color: restaurant.isOpenNow
                              ? GlassTheme.success
                              : GlassTheme.error,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Rating, time, delivery
                Row(
                  children: [
                    // Rating
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFB800).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 14,
                            color: Color(0xFFFFB800),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${restaurant.rating}',
                            style: GlassTextStyles.labelSmall(context).copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Delivery time
                    Icon(
                      Icons.access_time,
                      size: 14,
                      color: theme.textSecondaryColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      restaurant.deliveryTime,
                      style: GlassTextStyles.labelSmall(context).copyWith(
                        color: theme.textSecondaryColor,
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Delivery fee
                    Icon(
                      Icons.delivery_dining,
                      size: 14,
                      color: theme.textSecondaryColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      restaurant.formattedDeliveryFee,
                      style: GlassTextStyles.labelSmall(context).copyWith(
                        color: theme.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Description
                Text(
                  restaurant.description,
                  style: GlassTextStyles.bodySmall(context).copyWith(
                    color: theme.textSecondaryColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItems(BuildContext context, WidgetRef ref) {
    final menuState = ref.watch(menuNotifierProvider);
    final customizationNotifier = ref.read(itemCustomizationNotifierProvider.notifier);

    final items = menuState.itemsForSelectedCategory;

    return Container(
      decoration: BoxDecoration(
        color: GlassTheme.of(context).glassSurfaceColor.withOpacity(0.3),
        borderRadius: const BorderRadius.horizontal(
          right: Radius.circular(24),
        ),
      ),
      child: menuState.categories.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: MenuItemCard(
                    key: ValueKey(item.id),
                    item: item,
                    onTap: () {
                      // Navigate to customization screen
                      customizationNotifier.setMenuItem(item);
                      context.push('/item/customize?id=${item.id}');
                    },
                    onAddToCart: () {
                      // Add to cart with default customization
                      ref.read(cartNotifierProvider.notifier).addItem(
                            menuItemId: item.id,
                            name: item.name,
                            description: item.description,
                            price: item.price,
                            imageUrl: item.imageUrl,
                            quantity: 1,
                          );
                    },
                  ),
                );
              },
            ),
    );
  }

  Widget _buildFloatingCartButton(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartNotifierProvider);
    final theme = GlassTheme.of(context);

    if (cartState.totalItems == 0) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          gradient: GlassGradients.primaryButton,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: theme.primaryColor.withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => context.push('/cart'),
            borderRadius: BorderRadius.circular(28),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${cartState.totalItems}',
                          style: GlassTextStyles.labelMedium(context).copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'View Cart',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '\$${cartState.total.toStringAsFixed(2)}',
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
    );
  }
}
