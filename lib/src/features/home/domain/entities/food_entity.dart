import 'package:freezed_annotation/freezed_annotation.dart';

part 'food_entity.freezed.dart';

/// Domain entity representing a food item
@freezed
class FoodEntity with _$FoodEntity {
  const factory FoodEntity({
    required String id,
    required String name,
    required String restaurantId,
    required String restaurantName,
    required double rating,
    required double price,
    required int timeMinutes,
    required String imageUrl,
  }) = _FoodEntity;

  const FoodEntity._();

  /// Creates a FoodEntity from JSON (for testing/future API use)
  factory FoodEntity.fromJson(Map<String, dynamic> json) {
    return FoodEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      restaurantId: json['restaurantId'] as String,
      restaurantName: json['restaurantName'] as String,
      rating: (json['rating'] as num).toDouble(),
      price: (json['price'] as num).toDouble(),
      timeMinutes: json['timeMinutes'] as int,
      imageUrl: json['imageUrl'] as String,
    );
  }

  /// Converts entity to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'restaurantId': restaurantId,
      'restaurantName': restaurantName,
      'rating': rating,
      'price': price,
      'timeMinutes': timeMinutes,
      'imageUrl': imageUrl,
    };
  }
}
