import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../ui/theme/glass_theme.dart';
import '../../domain/entities/cart_item_entity.dart';
import 'quantity_selector.dart';

/// Widget displaying a cart item with glassmorphism design
class CartItemCard extends ConsumerWidget {
  final CartItemEntity item;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
  final VoidCallback? onRemove;
  final bool Function()? onQuantityChanged;

  const CartItemCard({
    super.key,
    required this.item,
    this.onIncrement,
    this.onDecrement,
    this.onRemove,
    this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = GlassTheme.of(context);

    return Container(
      decoration: GlassDecoration.panel(context: context),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Food image
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                item.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: theme.textTertiaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.fastfood, color: Colors.grey),
                  );
                },
              ),
            ),
            const SizedBox(width: 16),
            // Item details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: GlassTextStyles.titleMedium(context),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.description,
                    style: GlassTextStyles.bodySmall(context).copyWith(
                      color: theme.textSecondaryColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (item.customizations?.isNotEmpty == true) ...[
                    const SizedBox(height: 8),
                    ...item.customizations!.map(
                      (customization) => Text(
                        '+ ${customization.name}',
                        style: GlassTextStyles.caption(context).copyWith(
                          color: theme.textSecondaryColor,
                        ),
                      ),
                    ),
                  ],
                  if (item.notes?.isNotEmpty == true) ...[
                    const SizedBox(height: 4),
                    Text(
                      'Note: ${item.notes}',
                      style: GlassTextStyles.caption(context).copyWith(
                        color: theme.textSecondaryColor,
                        fontStyle: FontStyle.italic,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const SizedBox(height: 12),
                  // Quantity selector and price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      QuantitySelector(
                        quantity: item.quantity,
                        onIncrement: onIncrement,
                        onDecrement: onDecrement,
                        size: QuantitySelectorSize.small,
                      ),
                      Text(
                        '\$${item.totalPrice.toStringAsFixed(2)}',
                        style: GlassTextStyles.titleMedium(context).copyWith(
                          color: theme.primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Remove button
            IconButton(
              onPressed: onRemove,
              icon: Icon(
                Icons.close,
                color: theme.textTertiaryColor,
                size: 20,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      ),
    );
  }
}
