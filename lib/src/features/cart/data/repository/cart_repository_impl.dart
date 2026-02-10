import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/cart_entity.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../../domain/entities/menu_category.dart';
import '../../domain/entities/menu_item_entity.dart';
import '../../domain/repository/cart_repository_interface.dart';

/// Implementation of CartRepositoryInterface with mock data
class CartRepositoryImpl implements CartRepositoryInterface {
  CartModel _cart = CartModel.empty();

  CartRepositoryImpl();

  @override
  TaskEither<Failure, CartEntity> getCart() {
    return TaskEither.tryCatch(
      () async {
        await Future.delayed(const Duration(milliseconds: 100));
        return _cart.toEntity();
      },
      (error, stack) => ServerFailure(message: 'Failed to get cart: $error'),
    );
  }

  @override
  TaskEither<Failure, CartEntity> addItem({
    required String menuItemId,
    required String name,
    required String description,
    required double price,
    required String imageUrl,
    required int quantity,
    List<CartItemCustomization>? customizations,
    String? notes,
  }) {
    return TaskEither.tryCatch(
      () async {
        await Future.delayed(const Duration(milliseconds: 200));

        final item = CartItemModel(
          id: 'cart_${DateTime.now().millisecondsSinceEpoch}',
          menuItemId: menuItemId,
          name: name,
          description: description,
          price: price,
          quantity: quantity,
          imageUrl: imageUrl,
          customizations: customizations,
          notes: notes,
        );

        _cart = _cart.copyWith(
          items: [..._cart.items, item],
          updatedAt: DateTime.now(),
        );

        return _cart.toEntity();
      },
      (error, stack) => ServerFailure(message: 'Failed to add item: $error'),
    );
  }

  @override
  TaskEither<Failure, CartEntity> updateQuantity({
    required String cartItemId,
    required int quantity,
  }) {
    return TaskEither.tryCatch(
      () async {
        await Future.delayed(const Duration(milliseconds: 100));

        final items = _cart.items.map((item) {
          if (item.id == cartItemId) {
            return item.copyWith(quantity: quantity);
          }
          return item;
        }).toList();

        _cart = _cart.copyWith(items: items, updatedAt: DateTime.now());
        return _cart.toEntity();
      },
      (error, stack) => ServerFailure(message: 'Failed to update quantity: $error'),
    );
  }

  @override
  TaskEither<Failure, CartEntity> removeItem({required String cartItemId}) {
    return TaskEither.tryCatch(
      () async {
        await Future.delayed(const Duration(milliseconds: 100));

        final items = _cart.items.where((item) => item.id != cartItemId).toList();
        _cart = _cart.copyWith(items: items, updatedAt: DateTime.now());
        return _cart.toEntity();
      },
      (error, stack) => ServerFailure(message: 'Failed to remove item: $error'),
    );
  }

  @override
  TaskEither<Failure, CartEntity> clearCart() {
    return TaskEither.tryCatch(
      () async {
        await _simulateNetworkDelay();
        _cart = CartModel.empty();
        return _cart.toEntity();
      },
      (error, stack) => ServerFailure(message: 'Failed to clear cart: $error'),
    );
  }

  @override
  TaskEither<Failure, CartEntity> applyPromoCode({required String promoCode}) {
    return TaskEither.tryCatch(
      () async {
        await _simulateNetworkDelay();

        final validPromos = {
          'SAVE10': 0.10,
          'SAVE20': 0.20,
          'FIRST5': 5.0,
        };

        final discountPercent = validPromos[promoCode.toUpperCase()];

        if (discountPercent == null) {
          throw ValidationFailure(message: 'Invalid promo code');
        }

        final discount = discountPercent is int
            ? discountPercent.toDouble()
            : _cart.subtotal * discountPercent;

        _cart = _cart.copyWith(
          promoCode: promoCode.toUpperCase(),
          promoDiscount: discount,
          updatedAt: DateTime.now(),
        );

        return _cart.toEntity();
      },
      (error, stack) => ServerFailure(message: 'Failed to apply promo code: $error'),
    );
  }

  @override
  TaskEither<Failure, CartEntity> removePromoCode() {
    return TaskEither.tryCatch(
      () async {
        await _simulateNetworkDelay();

        _cart = _cart.copyWith(
          promoCode: null,
          promoDiscount: null,
          updatedAt: DateTime.now(),
        );

        return _cart.toEntity();
      },
      (error, stack) => ServerFailure(message: 'Failed to remove promo code: $error'),
    );
  }

  Future<void> _simulateNetworkDelay() async {
    await Future.delayed(const Duration(milliseconds: 300));
  }
}

class MenuRepositoryImpl implements MenuRepositoryInterface {
  final MockDataProvider _mockData;

  MenuRepositoryImpl() : _mockData = MockDataProvider();

  @override
  TaskEither<Failure, RestaurantEntity> getRestaurant({required String restaurantId}) {
    return TaskEither.tryCatch(
      () async {
        await Future.delayed(const Duration(milliseconds: 200));
        final restaurant = _mockData.getRestaurant(restaurantId);
        if (restaurant == null) {
          throw NotFoundFailure(message: 'Restaurant not found');
        }
        return restaurant;
      },
      (error, stack) => ServerFailure(message: 'Failed to get restaurant: $error'),
    );
  }

  @override
  TaskEither<Failure, List<MenuItemEntity>> getMenuItems({required String restaurantId}) {
    return TaskEither.tryCatch(
      () async {
        await Future.delayed(const Duration(milliseconds: 200));
        return _mockData.getMenuItems(restaurantId);
      },
      (error, stack) => ServerFailure(message: 'Failed to get menu items: $error'),
    );
  }

  @override
  TaskEither<Failure, List<MenuItemEntity>> getMenuItemsByCategory({
    required String restaurantId,
    required String categoryId,
  }) {
    return TaskEither.tryCatch(
      () async {
        await Future.delayed(const Duration(milliseconds: 150));
        return _mockData.getMenuItemsByCategory(restaurantId, categoryId);
      },
      (error, stack) => ServerFailure(message: 'Failed to get menu items by category: $error'),
    );
  }

  @override
  TaskEither<Failure, List<MenuCategory>> getMenuCategories({required String restaurantId}) {
    return TaskEither.tryCatch(
      () async {
        await Future.delayed(const Duration(milliseconds: 150));
        return _mockData.getMenuCategories(restaurantId);
      },
      (error, stack) => ServerFailure(message: 'Failed to get menu categories: $error'),
    );
  }

  @override
  TaskEither<Failure, MenuItemEntity> getMenuItem({required String menuItemId}) {
    return TaskEither.tryCatch(
      () async {
        await Future.delayed(const Duration(milliseconds: 100));
        final item = _mockData.getMenuItem(menuItemId);
        if (item == null) {
          throw NotFoundFailure(message: 'Menu item not found');
        }
        return item;
      },
      (error, stack) => ServerFailure(message: 'Failed to get menu item: $error'),
    );
  }
}

class MockDataProvider {
  static const String _restaurantId = 'rest_001';

  final List<RestaurantEntity> _restaurants = [
    RestaurantEntity(
      id: _restaurantId,
      name: 'Bella Italia',
      description: 'Authentic Italian cuisine with fresh ingredients',
      imageUrl: 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=400',
      coverUrl: 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800',
      rating: 4.7,
      ratingCount: 523,
      deliveryTime: '25-35 min',
      deliveryFee: 2.99,
      address: '123 Main Street, Downtown',
      cuisineTypes: ['Italian', 'Pizza', 'Pasta'],
      isOpen: true,
      preparationTime: 20,
    ),
  ];

  final List<MenuItemEntity> _menuItems = [
    MenuItemEntity(
      id: 'menu_001',
      name: 'Margherita Pizza',
      description: 'Classic tomato sauce, fresh mozzarella, basil',
      price: 14.99,
      imageUrl: 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=400',
      categoryId: 'cat_001',
      categoryName: 'Pizza',
      isAvailable: true,
      rating: 4.8,
      ratingCount: 234,
      customizationGroups: [
        MenuItemCustomizationGroup(
          id: 'cg_001',
          name: 'Size',
          isRequired: true,
          maxSelections: 1,
          options: [
            MenuItemCustomizationOption(id: 'opt_001', name: 'Medium (12")', price: 0),
            MenuItemCustomizationOption(id: 'opt_002', name: 'Large (14")', price: 3.00),
            MenuItemCustomizationOption(id: 'opt_003', name: 'Extra Large (16")', price: 5.00),
          ],
        ),
        MenuItemCustomizationGroup(
          id: 'cg_002',
          name: 'Extra Toppings',
          isRequired: false,
          maxSelections: 5,
          options: [
            MenuItemCustomizationOption(id: 'opt_004', name: 'Extra Cheese', price: 2.50),
            MenuItemCustomizationOption(id: 'opt_005', name: 'Pepperoni', price: 3.00),
            MenuItemCustomizationOption(id: 'opt_006', name: 'Mushrooms', price: 1.50),
            MenuItemCustomizationOption(id: 'opt_007', name: 'Olives', price: 1.50),
          ],
        ),
      ],
    ),
    MenuItemEntity(
      id: 'menu_002',
      name: 'Spaghetti Carbonara',
      description: 'Creamy sauce, pancetta, parmesan, egg yolk',
      price: 16.99,
      imageUrl: 'https://images.unsplash.com/photo-1612874742237-6526221588e3?w=400',
      categoryId: 'cat_002',
      categoryName: 'Pasta',
      isAvailable: true,
      rating: 4.6,
      ratingCount: 189,
    ),
    MenuItemEntity(
      id: 'menu_003',
      name: 'Caesar Salad',
      description: 'Romaine lettuce, croutons, parmesan, caesar dressing',
      price: 10.99,
      imageUrl: 'https://images.unsplash.com/photo-1550304943-4f24f54ddde9?w=400',
      categoryId: 'cat_003',
      categoryName: 'Salads',
      isAvailable: true,
      rating: 4.5,
      ratingCount: 156,
      customizationGroups: [
        MenuItemCustomizationGroup(
          id: 'cg_003',
          name: 'Add Protein',
          isRequired: false,
          maxSelections: 1,
          options: [
            MenuItemCustomizationOption(id: 'opt_008', name: 'Grilled Chicken', price: 4.00),
            MenuItemCustomizationOption(id: 'opt_009', name: 'Grilled Shrimp', price: 6.00),
            MenuItemCustomizationOption(id: 'opt_010', name: 'Grilled Salmon', price: 8.00),
          ],
        ),
      ],
    ),
    MenuItemEntity(
      id: 'menu_004',
      name: 'Tiramisu',
      description: 'Classic Italian dessert with espresso and mascarpone',
      price: 8.99,
      imageUrl: 'https://images.unsplash.com/photo-1571877227200-a0d98ea607e9?w=400',
      categoryId: 'cat_004',
      categoryName: 'Desserts',
      isAvailable: true,
      rating: 4.9,
      ratingCount: 312,
    ),
    MenuItemEntity(
      id: 'menu_005',
      name: 'Lasagna',
      description: 'Layers of pasta, meat sauce, bechamel, parmesan',
      price: 15.99,
      imageUrl: 'https://images.unsplash.com/photo-1574894709920-11b28e7367e3?w=400',
      categoryId: 'cat_002',
      categoryName: 'Pasta',
      isAvailable: true,
      rating: 4.7,
      ratingCount: 201,
    ),
    MenuItemEntity(
      id: 'menu_006',
      name: 'Bruschetta',
      description: 'Grilled bread topped with tomatoes, garlic, basil',
      price: 7.99,
      imageUrl: 'https://images.unsplash.com/photo-1572695157366-5e585ab2b69f?w=400',
      categoryId: 'cat_005',
      categoryName: 'Appetizers',
      isAvailable: true,
      rating: 4.4,
      ratingCount: 145,
    ),
  ];

  final List<MenuCategory> _categories = [
    MenuCategory(id: 'cat_001', name: 'Pizza', icon: 'pizza', itemCount: 8),
    MenuCategory(id: 'cat_002', name: 'Pasta', icon: 'restaurant', itemCount: 12),
    MenuCategory(id: 'cat_003', name: 'Salads', icon: 'leaf', itemCount: 5),
    MenuCategory(id: 'cat_004', name: 'Desserts', icon: 'cake', itemCount: 6),
    MenuCategory(id: 'cat_005', name: 'Appetizers', icon: 'appetizer', itemCount: 9),
  ];

  RestaurantEntity? getRestaurant(String id) {
    try {
      return _restaurants.firstWhere((r) => r.id == id);
    } catch (e) {
      return null;
    }
  }

  List<MenuItemEntity> getMenuItems(String restaurantId) {
    return _menuItems;
  }

  List<MenuItemEntity> getMenuItemsByCategory(String restaurantId, String categoryId) {
    return _menuItems.where((item) => item.categoryId == categoryId).toList();
  }

  MenuItemEntity? getMenuItem(String menuItemId) {
    try {
      return _menuItems.firstWhere((item) => item.id == menuItemId);
    } catch (e) {
      return null;
    }
  }

  List<MenuCategory> getMenuCategories(String restaurantId) {
    return _categories;
  }
}

class CartModel {
  String id;
  List<CartItemModel> items;
  DateTime updatedAt;
  String? promoCode;
  double? promoDiscount;

  CartModel({
    required this.id,
    required this.items,
    required this.updatedAt,
    this.promoCode,
    this.promoDiscount,
  });

  double get subtotal {
    return items.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  CartModel copyWith({
    String? id,
    List<CartItemModel>? items,
    DateTime? updatedAt,
    String? promoCode,
    double? promoDiscount,
  }) {
    return CartModel(
      id: id ?? this.id,
      items: items ?? this.items,
      updatedAt: updatedAt ?? this.updatedAt,
      promoCode: promoCode ?? this.promoCode,
      promoDiscount: promoDiscount ?? this.promoDiscount,
    );
  }

  factory CartModel.empty() {
    return CartModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      items: const [],
      updatedAt: DateTime.now(),
    );
  }

  CartEntity toEntity() {
    return CartEntity(
      id: id,
      items: items.map((item) => item.toEntity()).toList(),
      updatedAt: updatedAt,
      promoCode: promoCode,
      promoDiscount: promoDiscount,
    );
  }
}

class CartItemModel {
  final String id;
  final String menuItemId;
  final String name;
  final String description;
  final double price;
  final int quantity;
  final String imageUrl;
  final List<CartItemCustomization>? customizations;
  final String? notes;

  CartItemModel({
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

  CartItemModel copyWith({
    String? id,
    String? menuItemId,
    String? name,
    String? description,
    double? price,
    int? quantity,
    String? imageUrl,
    List<CartItemCustomization>? customizations,
    String? notes,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      menuItemId: menuItemId ?? this.menuItemId,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      imageUrl: imageUrl ?? this.imageUrl,
      customizations: customizations ?? this.customizations,
      notes: notes ?? this.notes,
    );
  }

  CartItemEntity toEntity() {
    return CartItemEntity(
      id: id,
      menuItemId: menuItemId,
      name: name,
      description: description,
      price: price,
      quantity: quantity,
      imageUrl: imageUrl,
      customizations: customizations,
      notes: notes,
    );
  }
}
