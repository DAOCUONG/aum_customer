import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../ui/atoms/glass_divider.dart';
import '../../../../ui/theme/glass_theme.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../providers/cart_notifier.dart';
import '../widgets/cart_item_card.dart';

/// Shopping cart screen with glassmorphism design
/// Displays cart items, promo code input, and price summary
class ShoppingCartScreen extends ConsumerWidget {
  const ShoppingCartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartNotifierProvider);

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
              _buildHeader(context, ref),
              const SizedBox(height: 16),
              // Content
              Expanded(
                child: cartState.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : cartState.isEmpty
                        ? _buildEmptyState(context)
                        : _buildCartContent(context, ref),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartNotifierProvider);
    final theme = GlassTheme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          GlassIconButton(
            icon: Icons.arrow_back,
            onTap: () => context.pop(),
          ),
          const SizedBox(width: 16),
          Text(
            'Shopping Cart',
            style: GlassTextStyles.headlineMedium(context),
          ),
          const Spacer(),
          if (cartState.totalItems > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: theme.primaryColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: theme.primaryColor.withValues(alpha: 0.3),
                ),
              ),
              child: Text(
                '${cartState.totalItems} items',
                style: GlassTextStyles.labelMedium(context).copyWith(
                  color: theme.primaryColor,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'Your cart is empty',
            style: GlassTextStyles.titleLarge(context),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => context.go('/home'),
            child: const Text('Browse Restaurants'),
          ),
        ],
      ),
    );
  }

  Widget _buildCartContent(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartNotifierProvider);

    return Column(
      children: [
        // Cart items list
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                // Promo code section
                _buildPromoCodeSection(context, ref),
                const SizedBox(height: 24),
                // Cart items
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: cartState.items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final item = cartState.items[index] as CartItemEntity;
                    return CartItemCard(
                      key: ValueKey(item.id),
                      item: item,
                      onIncrement: () => ref
                          .read(cartNotifierProvider.notifier)
                          .incrementQuantity(item.id),
                      onDecrement: () => ref
                          .read(cartNotifierProvider.notifier)
                          .decrementQuantity(item.id),
                      onRemove: () => ref
                          .read(cartNotifierProvider.notifier)
                          .removeItem(cartItemId: item.id),
                    );
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
        // Price summary and checkout
        _buildPriceSummary(context, ref),
      ],
    );
  }

  Widget _buildPromoCodeSection(BuildContext context, WidgetRef ref) {
    final theme = GlassTheme.of(context);
    final cartState = ref.watch(cartNotifierProvider);
    final cartNotifier = ref.read(cartNotifierProvider.notifier);
    final promoController = TextEditingController();

    return Container(
      decoration: GlassDecoration.atom(context: context),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.local_offer_outlined,
                color: theme.primaryColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Promo Code',
                style: GlassTextStyles.titleMedium(context),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (cartState.promoCode != null)
            _buildAppliedPromo(context, ref, cartState.promoCode!)
          else
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: promoController,
                    decoration: InputDecoration(
                      hintText: 'Enter promo code',
                      filled: true,
                      fillColor: theme.glassInputBgColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    textInputAction: TextInputAction.done,
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        cartNotifier.applyPromoCode(promoCode: value);
                      }
                    },
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: cartState.isApplyingPromo
                        ? null
                        : () {
                            if (promoController.text.isNotEmpty) {
                              cartNotifier.applyPromoCode(
                                promoCode: promoController.text,
                              );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                      foregroundColor: Colors.white,
                    ),
                    child: cartState.isApplyingPromo
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text('Apply'),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildAppliedPromo(BuildContext context, WidgetRef ref, String promoCode) {
    final cartNotifier = ref.read(cartNotifierProvider.notifier);
    final cartState = ref.watch(cartNotifierProvider);

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: GlassTheme.success.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: GlassTheme.success.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.check_circle,
                color: GlassTheme.success,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                promoCode,
                style: GlassTextStyles.labelMedium(context).copyWith(
                  color: GlassTheme.success,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Text(
          '- \$${cartState.discount.toStringAsFixed(2)}',
          style: GlassTextStyles.titleMedium(context).copyWith(
            color: GlassTheme.success,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: () => cartNotifier.removePromoCode(),
          child: const Text('Remove'),
        ),
      ],
    );
  }

  Widget _buildPriceSummary(BuildContext context, WidgetRef ref) {
    final theme = GlassTheme.of(context);
    final cartState = ref.watch(cartNotifierProvider);

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
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Price rows
          _buildPriceRow(context, 'Subtotal', cartState.subtotal),
          const SizedBox(height: 8),
          _buildPriceRow(context, 'Delivery', cartState.deliveryFee),
          const SizedBox(height: 8),
          _buildPriceRow(context, 'Tax', cartState.tax),
          if (cartState.discount > 0) ...[
            const SizedBox(height: 8),
            _buildPriceRow(
              context,
              'Discount',
              -cartState.discount,
              isDiscount: true,
            ),
          ],
          const SizedBox(height: 16),
          GlassDivider.solid(color: theme.dividerColor),
          const SizedBox(height: 16),
          // Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: GlassTextStyles.titleLarge(context),
              ),
              Text(
                '\$${cartState.total.toStringAsFixed(2)}',
                style: GlassTextStyles.headlineMedium(context).copyWith(
                  color: theme.primaryColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Checkout button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => context.push('/checkout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              child: const Text(
                'Proceed to Checkout',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(
    BuildContext context,
    String label,
    double amount, {
    bool isDiscount = false,
  }) {
    final theme = GlassTheme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GlassTextStyles.bodyMedium(context).copyWith(
            color: isDiscount ? GlassTheme.success : theme.textSecondaryColor,
          ),
        ),
        Text(
          isDiscount ? '- \$${amount.abs().toStringAsFixed(2)}' : '\$${amount.toStringAsFixed(2)}',
          style: GlassTextStyles.bodyMedium(context).copyWith(
            color: isDiscount ? GlassTheme.success : theme.textPrimaryColor,
            fontWeight: isDiscount ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

/// Glass icon button widget
class GlassIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final double? size;

  const GlassIconButton({
    super.key,
    required this.icon,
    this.onTap,
    this.size = 44,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: theme.glassSurfaceColor,
        borderRadius: BorderRadius.circular(size! / 2),
        border: Border.all(
          color: theme.glassBorderColor.withValues(alpha: 0.5),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(size! / 2),
          child: Icon(
            icon,
            size: size! * 0.5,
            color: theme.textPrimaryColor,
          ),
        ),
      ),
    );
  }
}
