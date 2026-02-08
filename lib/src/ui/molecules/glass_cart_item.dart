import 'package:flutter/material.dart';
import '../atoms/glass_quantity_stepper.dart';
import '../atoms/glass_icon_button.dart';
import '../theme/glass_design_system.dart';

/// Glass Cart Item - Cart item row
class GlassCartItem extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String price;
  final String description;
  final int quantity;
  final List<String> modifications;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final Function(int) onQuantityChanged;

  const GlassCartItem({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.description,
    required this.quantity,
    required this.modifications,
    this.onEdit,
    this.onDelete,
    required this.onQuantityChanged,
  });

  @override
  State<GlassCartItem> createState() => _GlassCartItemState();
}

class _GlassCartItemState extends State<GlassCartItem> {
  bool _showActions = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.4),
            borderRadius: cardRadius,
            border: Border.all(color: Colors.white.withOpacity(0.5)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                // Main content row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        width: 80,
                        height: 80,
                        color: Colors.orange.shade100,
                        child: Image.network(
                          widget.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Center(
                            child: Text(
                              widget.name[0],
                              style: const TextStyle(fontSize: 32),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.name,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.price,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: primaryColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.description,
                            style: TextStyle(
                              fontSize: 13,
                              color: textSecondary,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          // Modifications
                          if (widget.modifications.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                widget.modifications.join(', '),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: textTertiary,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Actions row
                Row(
                  children: [
                    GlassQuantityStepper(
                      quantity: widget.quantity,
                      onQuantityChanged: widget.onQuantityChanged,
                    ),
                    const Spacer(),
                    // Edit button
                    GlassIconButton.transparent(
                      onPressed: widget.onEdit,
                      icon: const Icon(Icons.edit, size: 18),
                      size: 36,
                    ),
                    const SizedBox(width: 4),
                    // Delete button
                    GlassIconButton.transparent(
                      onPressed: widget.onDelete,
                      icon: Icon(
                        Icons.delete_outline,
                        size: 18,
                        color: errorRed,
                      ),
                      size: 36,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Glass Menu Item - Restaurant menu item
class GlassMenuItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String description;
  final String price;
  final double rating;
  final bool isPopular;
  final bool isSoldOut;
  final VoidCallback? onTap;
  final VoidCallback? onAdd;

  const GlassMenuItem({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    this.isPopular = false,
    this.isSoldOut = false,
    this.onTap,
    this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.4),
          borderRadius: cardRadius,
          border: Border.all(color: Colors.white.withOpacity(0.5)),
        ),
        child: Row(
          children: [
            // Image with badges
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                    bottom: Radius.circular(16),
                  ),
                  child: Container(
                    width: 110,
                    height: 110,
                    color: Colors.orange.shade100,
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Center(
                        child: Text(
                          name[0],
                          style: const TextStyle(fontSize: 36),
                        ),
                      ),
                    ),
                  ),
                ),
                if (isPopular)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white.withOpacity(0.5)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.local_fire_department,
                            size: 14,
                            color: primaryColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Popular',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (isSoldOut)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                          bottom: Radius.circular(16),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Sold Out',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: textSecondary,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (isPopular)
                          Icon(
                            Icons.local_fire_department,
                            size: 14,
                            color: primaryColor,
                          ),
                        if (isPopular) const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            name,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 13,
                        color: textSecondary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        // Rating
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: 14,
                              color: Colors.amber.shade500,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              rating.toStringAsFixed(1),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: textPrimary,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        // Price and Add button
                        Row(
                          children: [
                            Text(
                              price,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: primaryColor,
                              ),
                            ),
                            const SizedBox(width: 8),
                            if (!isSoldOut)
                              GestureDetector(
                                onTap: onAdd,
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [primaryLight, primaryColor],
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
