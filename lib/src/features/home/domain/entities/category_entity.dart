import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_entity.freezed.dart';

/// Domain entity representing a category
@freezed
class CategoryEntity with _$CategoryEntity {
  const factory CategoryEntity({
    required String id,
    required String name,
    required String icon,
    required String color,
  }) = _CategoryEntity;

  const CategoryEntity._();

  /// Creates a CategoryEntity from JSON (for testing/future API use)
  factory CategoryEntity.fromJson(Map<String, dynamic> json) {
    return CategoryEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      icon: json['icon'] as String,
      color: json['color'] as String,
    );
  }

  /// Converts entity to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'color': color,
    };
  }
}
