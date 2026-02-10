import 'package:equatable/equatable.dart';

/// Domain entity representing a search result (restaurant)
class SearchResult with EquatableMixin {
  final String id;
  final String name;
  final List<String> tags;
  final double rating;
  final String deliveryTime;
  final String deliveryFee;
  final String imageUrl;
  final bool isOpen;
  final double distance;
  final double? discountPercentage;

  const SearchResult({
    required this.id,
    required this.name,
    required this.tags,
    required this.rating,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.imageUrl,
    this.isOpen = true,
    this.distance = 0.0,
    this.discountPercentage,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        tags,
        rating,
        deliveryTime,
        deliveryFee,
        imageUrl,
        isOpen,
        distance,
        discountPercentage,
      ];

  bool get isFreeDelivery => deliveryFee == 'Free';
  String get ratingText => rating.toStringAsFixed(1);
}
