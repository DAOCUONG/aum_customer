import 'package:freezed_annotation/freezed_annotation.dart';

part 'restaurant_entity.freezed.dart';

/// Domain entity representing a restaurant
@freezed
class RestaurantEntity with _$RestaurantEntity {
  const factory RestaurantEntity({
    required String id,
    required String name,
    required String cuisine,
    required double rating,
    required int deliveryTimeMinutes,
    required String deliveryFee,
    required String imageUrl,
  }) = _RestaurantEntity;

  const RestaurantEntity._();

  /// Creates a RestaurantEntity from JSON (for testing/future API use)
  factory RestaurantEntity.fromJson(Map<String, dynamic> json) {
    return RestaurantEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      cuisine: json['cuisine'] as String,
      rating: (json['rating'] as num).toDouble(),
      deliveryTimeMinutes: json['deliveryTimeMinutes'] as int,
      deliveryFee: json['deliveryFee'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }

  /// Converts entity to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'cuisine': cuisine,
      'rating': rating,
      'deliveryTimeMinutes': deliveryTimeMinutes,
      'deliveryFee': deliveryFee,
      'imageUrl': imageUrl,
    };
  }
}
