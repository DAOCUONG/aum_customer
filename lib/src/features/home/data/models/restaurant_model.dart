import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/restaurant_entity.dart';

part 'restaurant_model.freezed.dart';

/// Data model for restaurant items (DTO from API)
@freezed
class RestaurantModel with _$RestaurantModel {
  const factory RestaurantModel({
    required String id,
    required String name,
    required String cuisine,
    required double rating,
    required int deliveryTimeMinutes,
    required String deliveryFee,
    required String imageUrl,
  }) = _RestaurantModel;

  const RestaurantModel._();

  /// Creates a RestaurantModel from JSON (API response)
  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['id'] as String,
      name: json['name'] as String,
      cuisine: json['cuisine'] as String,
      rating: (json['rating'] as num).toDouble(),
      deliveryTimeMinutes: json['deliveryTimeMinutes'] as int,
      deliveryFee: json['deliveryFee'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }

  /// Converts model to JSON (for API requests)
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

  /// Converts model to domain entity
  RestaurantEntity toEntity() {
    return RestaurantEntity(
      id: id,
      name: name,
      cuisine: cuisine,
      rating: rating,
      deliveryTimeMinutes: deliveryTimeMinutes,
      deliveryFee: deliveryFee,
      imageUrl: imageUrl,
    );
  }

  /// Creates model from domain entity
  static RestaurantModel fromEntity(RestaurantEntity entity) {
    return RestaurantModel(
      id: entity.id,
      name: entity.name,
      cuisine: entity.cuisine,
      rating: entity.rating,
      deliveryTimeMinutes: entity.deliveryTimeMinutes,
      deliveryFee: entity.deliveryFee,
      imageUrl: entity.imageUrl,
    );
  }
}
