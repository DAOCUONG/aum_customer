import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/food_entity.dart';

part 'food_model.freezed.dart';

/// Data model for food items (DTO from API)
@freezed
class FoodModel with _$FoodModel {
  const factory FoodModel({
    required String id,
    required String name,
    required String restaurantId,
    required String restaurantName,
    required double rating,
    required double price,
    required int timeMinutes,
    required String imageUrl,
  }) = _FoodModel;

  const FoodModel._();

  /// Creates a FoodModel from JSON (API response)
  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
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

  /// Converts model to JSON (for API requests)
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

  /// Converts model to domain entity
  FoodEntity toEntity() {
    return FoodEntity(
      id: id,
      name: name,
      restaurantId: restaurantId,
      restaurantName: restaurantName,
      rating: rating,
      price: price,
      timeMinutes: timeMinutes,
      imageUrl: imageUrl,
    );
  }

  /// Creates model from domain entity
  static FoodModel fromEntity(FoodEntity entity) {
    return FoodModel(
      id: entity.id,
      name: entity.name,
      restaurantId: entity.restaurantId,
      restaurantName: entity.restaurantName,
      rating: entity.rating,
      price: entity.price,
      timeMinutes: entity.timeMinutes,
      imageUrl: entity.imageUrl,
    );
  }
}
