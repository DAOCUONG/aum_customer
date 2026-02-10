/// Entity representing an item in the shopping cart
class CartItemEntity {
  final String id;
  final String menuItemId;
  final String name;
  final String description;
  final double price;
  final int quantity;
  final String imageUrl;
  final List<CartItemCustomization>? customizations;
  final String? notes;

  CartItemEntity({
    required this.id,
    required this.menuItemId,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.imageUrl,
    this.customizations,
    this.notes,
  });

  double get totalPrice {
    final customizationsTotal = customizations?.fold<double>(
          0.0,
          (sum, item) => sum + item.price,
        ) ??
        0.0;
    return (price + customizationsTotal) * quantity;
  }
}

class CartItemCustomization {
  final String id;
  final String name;
  final double price;

  CartItemCustomization({
    required this.id,
    required this.name,
    required this.price,
  });
}
