/// Entity representing a menu item from a restaurant
class MenuItemEntity {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String categoryId;
  final String categoryName;
  final bool? isAvailable;
  final double? rating;
  final int? ratingCount;
  final List<MenuItemCustomizationGroup>? customizationGroups;

  MenuItemEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.categoryId,
    required this.categoryName,
    this.isAvailable,
    this.rating,
    this.ratingCount,
    this.customizationGroups,
  });

  bool get isInStock => isAvailable ?? true;
}

class MenuItemCustomizationGroup {
  final String id;
  final String name;
  final bool isRequired;
  final int maxSelections;
  final List<MenuItemCustomizationOption> options;

  MenuItemCustomizationGroup({
    required this.id,
    required this.name,
    required this.isRequired,
    required this.maxSelections,
    required this.options,
  });
}

class MenuItemCustomizationOption {
  final String id;
  final String name;
  final double price;

  MenuItemCustomizationOption({
    required this.id,
    required this.name,
    required this.price,
  });
}

class RestaurantEntity {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String coverUrl;
  final double rating;
  final int ratingCount;
  final String deliveryTime;
  final double deliveryFee;
  final String address;
  final List<String>? cuisineTypes;
  final bool? isOpen;
  final int? preparationTime;

  RestaurantEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.coverUrl,
    required this.rating,
    required this.ratingCount,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.address,
    this.cuisineTypes,
    this.isOpen,
    this.preparationTime,
  });

  bool get isOpenNow => isOpen ?? true;

  String get formattedDeliveryFee => deliveryFee > 0
      ? '\$${deliveryFee.toStringAsFixed(2)} delivery'
      : 'Free delivery';
}
