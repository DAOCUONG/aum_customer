import 'package:flutter_test/flutter_test.dart';

import '../entities/order_entity.dart';

void main() {
  group('OrderEntity', () {
    test('generateOrderNumber creates valid order', () {
      final order = OrderEntity.generateOrderNumber();

      expect(order.id, isNotEmpty);
      expect(order.orderNumber, startsWith('ORD-'));
      expect(order.status, OrderStatus.pending);
      expect(order.items, isEmpty);
    });

    test('OrderItemEntity totalPrice calculates correctly', () {
      final item = OrderItemEntity(
        id: 'item_1',
        menuItemId: 'menu_001',
        name: 'Test Item',
        description: 'Test',
        price: 10.0,
        quantity: 2,
        imageUrl: 'http://test.com/image.jpg',
      );

      expect(item.totalPrice, 20.0);
    });

    test('OrderItemEntity totalPrice includes customizations', () {
      final item = OrderItemEntity(
        id: 'item_1',
        menuItemId: 'menu_001',
        name: 'Test Item',
        description: 'Test',
        price: 10.0,
        quantity: 1,
        imageUrl: 'http://test.com/image.jpg',
        customizations: [
          const OrderItemCustomization(id: 'c1', name: 'Extra Cheese', price: 2.0),
          const OrderItemCustomization(id: 'c2', name: 'Pepperoni', price: 3.0),
        ],
      );

      // 10 + 2 + 3 = 15
      expect(item.totalPrice, 15.0);
    });
  });
}
