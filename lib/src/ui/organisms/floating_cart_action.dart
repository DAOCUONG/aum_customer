import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/glass_theme.dart';
import '../atoms/glass_card.dart';
import '../atoms/glass_button.dart';
import '../molecules/glass_avatar.dart';
import '../molecules/glass_price_tag.dart';

/// FloatingCartAction - Bottom cart action bar
///
/// Displays floating cart summary with checkout button
class FloatingCartAction extends StatefulWidget {
  final int itemCount;
  final String? storeName;
  final String totalPrice;
  final VoidCallback? onViewCartTap;
  final VoidCallback? onCheckoutTap;
  final String? currencySymbol;
  final double bottomPadding;

  const FloatingCartAction({
    super.key,
    required this.itemCount,
    this.storeName,
    required this.totalPrice,
    this.onViewCartTap,
    required this.onCheckoutTap,
    this.currencySymbol = '\$',
    this.bottomPadding = 16,
  });

  @override
  State<FloatingCartAction> createState() => _FloatingCartActionState();
}

class _FloatingCartActionState extends State<FloatingCartAction> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return Positioned(
      bottom: widget.bottomPadding,
      left: 16,
      right: 16,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              theme.glassSurface.withOpacity(0.95),
              theme.glassSurface.withOpacity(0.85),
            ],
          ),
          border: Border.all(
            color: theme.glassBorder.withOpacity(0.6),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onViewCartTap,
            borderRadius: BorderRadius.circular(24),
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          theme.textPrimary,
                          theme.textSecondary,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Center(
                      child: Text(
                        '${widget.itemCount}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'View Cart',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: theme.textPrimary,
                          ),
                        ),
                        if (widget.storeName != null)
                          Text(
                            '${widget.storeName} • ${widget.currencySymbol}${widget.totalPrice}',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: theme.textTertiary,
                            ),
                          ),
                      ],
                    ),
                  ),
                  GlassButton.primary(
                    onPressed: widget.onCheckoutTap,
                    label: 'Checkout',
                    icon: Icons.arrow_forward,
                    height: 42,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
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

/// Compact cart badge button
class CartBadgeButton extends StatelessWidget {
  final int itemCount;
  final VoidCallback? onTap;
  final double size;

  const CartBadgeButton({
    super.key,
    required this.itemCount,
    this.onTap,
    this.size = 48,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: theme.glassSurface.withOpacity(0.7),
              borderRadius: BorderRadius.circular(size / 2),
              border: Border.all(
                color: theme.glassBorder,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              Icons.shopping_bag,
              size: size * 0.45,
              color: theme.textPrimary,
            ),
          ),
          if (itemCount > 0)
            Positioned(
              top: -4,
              right: -4,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: GlassTheme.primary,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: theme.glassSurface,
                    width: 2,
                  ),
                ),
                child: Text(
                  itemCount > 99 ? '99+' : '$itemCount',
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Mini cart summary sheet
class MiniCartSheet extends StatelessWidget {
  final List<CartItem> items;
  final String totalPrice;
  final VoidCallback? onItemRemoved;
  final VoidCallback? onCheckout;

  const MiniCartSheet({
    super.key,
    required this.items,
    required this.totalPrice,
    this.onItemRemoved,
    this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return GlassCard(
      variant: GlassCardVariant.panel,
      size: GlassCardSize.large,
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Cart (${items.length} items)',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: theme.textPrimary,
                  ),
                ),
                GlassIconButton.transparent(
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.close, size: 20),
                  size: 32,
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Flexible(
            child: ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = items[index];
                return _CartItemRow(
                  item: item,
                  onRemoved: () => onItemRemoved?.call(),
                );
              },
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: theme.textPrimary,
                      ),
                    ),
                    Text(
                      '\$$totalPrice',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: theme.textPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                GlassButton.primary(
                  onPressed: onCheckout,
                  label: 'Checkout',
                  fullWidth: true,
                  height: 50,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CartItem {
  final String id;
  final String name;
  final String price;
  final int quantity;
  final String? imageUrl;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    this.imageUrl,
  });
}

class _CartItemRow extends StatelessWidget {
  final CartItem item;
  final VoidCallback? onRemoved;

  const _CartItemRow({required this.item, this.onRemoved});

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return Row(
      children: [
        if (item.imageUrl != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              item.imageUrl!,
              width: 56,
              height: 56,
              fit: BoxFit.cover,
            ),
          ),
        if (item.imageUrl != null) const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: theme.textPrimary,
                ),
              ),
              Text(
                '\$${item.price}',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: theme.textSecondary,
                ),
              ),
            ],
          ),
        ),
        Text(
          'x${item.quantity}',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: theme.textTertiary,
          ),
        ),
        const SizedBox(width: 12),
        GlassIconButton.transparent(
          onPressed: onRemoved,
          icon: const Icon(Icons.delete_outline, size: 18),
          size: 32,
          foregroundColor: GlassTheme.error,
        ),
      ],
    );
  }
}
