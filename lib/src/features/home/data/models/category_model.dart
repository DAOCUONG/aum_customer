import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/category_entity.dart';

part 'category_model.freezed.dart';

/// Data model for category items (DTO from API)
@freezed
class CategoryModel with _$CategoryModel {
  const factory CategoryModel({
    required String id,
    required String name,
    required String icon,
    required String color,
  }) = _CategoryModel;

  const CategoryModel._();

  /// Creates a CategoryModel from JSON (API response)
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      icon: json['icon'] as String,
      color: json['color'] as String,
    );
  }

  /// Converts model to JSON (for API requests)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'color': color,
    };
  }

  /// Converts model to domain entity
  CategoryEntity toEntity() {
    return CategoryEntity(
      id: id,
      name: name,
      icon: icon,
      color: color,
    );
  }

  /// Creates model from domain entity
  static CategoryModel fromEntity(CategoryEntity entity) {
    return CategoryModel(
      id: entity.id,
      name: entity.name,
      icon: entity.icon,
      color: entity.color,
    );
  }
}
