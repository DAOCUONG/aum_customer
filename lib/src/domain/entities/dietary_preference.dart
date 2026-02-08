import 'package:equatable/equatable.dart';

/// Dietary preference entity
class DietaryPreference extends Equatable {
  const DietaryPreference({
    required this.id,
    required this.title,
    required this.description,
    required this.emoji,
    this.isSelected = false,
  });

  final String id;
  final String title;
  final String description;
  final String emoji;
  final bool isSelected;

  @override
  List<Object?> get props => [id, title, description, emoji, isSelected];

  DietaryPreference copyWith({
    String? id,
    String? title,
    String? description,
    String? emoji,
    bool? isSelected,
  }) {
    return DietaryPreference(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      emoji: emoji ?? this.emoji,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  /// Toggle selection
  DietaryPreference toggleSelected() {
    return copyWith(isSelected: !isSelected);
  }
}

/// Available dietary preference options
enum DietaryPreferenceType {
  vegetarian(
    id: 'vegetarian',
    title: 'Vegetarian',
    description: 'No meat, fish, or poultry',
    emoji: '🥗',
  ),
  vegan(
    id: 'vegan',
    title: 'Vegan',
    description: 'Plant-based only',
    emoji: '🌱',
  ),
  glutenFree(
    id: 'gluten_free',
    title: 'Gluten-Free',
    description: 'Safe for celiac diet',
    emoji: '🌾',
  ),
  dairyFree(
    id: 'dairy_free',
    title: 'Dairy-Free',
    description: 'Lactose intolerance friendly',
    emoji: '🥛',
  ),
  nutAllergy(
    id: 'nut_allergy',
    title: 'Nut Allergy',
    description: 'Peanut & tree nut free',
    emoji: '🥜',
  ),
  halal(
    id: 'halal',
    title: 'Halal',
    description: 'Halal-certified food only',
    emoji: '☪️',
  ),
  kosher(
    id: 'kosher',
    title: 'Kosher',
    description: 'Kosher-certified food only',
    emoji: '✡️',
  ),
  lowCarb(
    id: 'low_carb',
    title: 'Low Carb',
    description: 'Low carbohydrate options',
    emoji: '🥩',
  ),
  keto(
    id: 'keto',
    title: 'Keto',
    description: 'Ketogenic diet friendly',
    emoji: '🥑',
  ),
  organic(
    id: 'organic',
    title: 'Organic',
    description: 'Organic ingredients preferred',
    emoji: '🍃',
  );

  const DietaryPreferenceType({
    required this.id,
    required this.title,
    required this.description,
    required this.emoji,
  });

  final String id;
  final String title;
  final String description;
  final String emoji;

  /// Convert to DietaryPreference entity
  DietaryPreference toEntity({bool isSelected = false}) {
    return DietaryPreference(
      id: id,
      title: title,
      description: description,
      emoji: emoji,
      isSelected: isSelected,
    );
  }

  /// Find by id
  static DietaryPreferenceType? fromId(String id) {
    try {
      return values.firstWhere((type) => type.id == id);
    } catch (_) {
      return null;
    }
  }
}
