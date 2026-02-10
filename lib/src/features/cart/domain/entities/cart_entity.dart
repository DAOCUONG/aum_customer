import 'cart_item_entity.dart';

/// Entity representing the complete shopping cart
class CartEntity {
  final String id;
  final List<CartItemEntity> items;
  final DateTime updatedAt;
  final String? promoCode;
  final double? promoDiscount;

  CartEntity({
    required this.id,
    required this.items,
    required this.updatedAt,
    this.promoCode,
    this.promoDiscount,
  });

  bool get isEmpty => items.isEmpty;

  int get totalItemCount => items.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal {
    return items.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  double get deliveryFee => 2.99;

  double get tax => subtotal * 0.08;

  double get discountAmount => promoDiscount ?? 0.0;

  double get total {
    return subtotal + deliveryFee + tax - discountAmount;
  }

  factory CartEntity.empty() {
    return CartEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      items: const [],
      updatedAt: DateTime.now(),
    );
  }
}
