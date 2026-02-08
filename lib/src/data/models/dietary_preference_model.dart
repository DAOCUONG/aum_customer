import '../../domain/entities/dietary_preference.dart';

/// Dietary preference model for data layer
class DietaryPreferenceModel extends DietaryPreference {
  const DietaryPreferenceModel({
    required super.id,
    required super.title,
    required super.description,
    required super.emoji,
    super.isSelected = false,
  });

  /// Create from JSON
  factory DietaryPreferenceModel.fromJson(Map<String, dynamic> json) {
    return DietaryPreferenceModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      emoji: json['emoji'] as String,
      isSelected: json['isSelected'] as bool? ?? false,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'emoji': emoji,
      'isSelected': isSelected,
    };
  }

  /// Convert to domain entity
  DietaryPreference toEntity() {
    return DietaryPreference(
      id: id,
      title: title,
      description: description,
      emoji: emoji,
      isSelected: isSelected,
    );
  }

  /// Create from domain entity
  factory DietaryPreferenceModel.fromEntity(DietaryPreference entity) {
    return DietaryPreferenceModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      emoji: entity.emoji,
      isSelected: entity.isSelected,
    );
  }

  /// Create list from JSON
  static List<DietaryPreferenceModel> listFromJson(List<Map<String, dynamic>> json) {
    return json.map(DietaryPreferenceModel.fromJson).toList();
  }

  /// Convert list to domain entities
  static List<DietaryPreference> listToEntities(List<DietaryPreferenceModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }
}
