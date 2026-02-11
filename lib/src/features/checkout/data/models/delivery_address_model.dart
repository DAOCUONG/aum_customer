import '../../domain/entities/delivery_address_entity.dart';

/// Data model for delivery addresses
class DeliveryAddressModel {
  final String id;
  final String label;
  final String streetAddress;
  final String? apartment;
  final String city;
  final String state;
  final String zipCode;
  final String country;
  final double latitude;
  final double longitude;
  final bool isDefault;
  final String? deliveryInstructions;

  const DeliveryAddressModel({
    required this.id,
    required this.label,
    required this.streetAddress,
    this.apartment,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.isDefault,
    this.deliveryInstructions,
  });

  /// Convert to domain entity
  DeliveryAddressEntity toEntity() {
    return DeliveryAddressEntity(
      id: id,
      label: label,
      streetAddress: streetAddress,
      apartment: apartment,
      city: city,
      state: state,
      zipCode: zipCode,
      country: country,
      latitude: latitude,
      longitude: longitude,
      isDefault: isDefault,
      deliveryInstructions: deliveryInstructions,
    );
  }

  /// Create from domain entity
  static DeliveryAddressModel fromEntity(DeliveryAddressEntity entity) {
    return DeliveryAddressModel(
      id: entity.id,
      label: entity.label,
      streetAddress: entity.streetAddress,
      apartment: entity.apartment,
      city: entity.city,
      state: entity.state,
      zipCode: entity.zipCode,
      country: entity.country,
      latitude: entity.latitude,
      longitude: entity.longitude,
      isDefault: entity.isDefault,
      deliveryInstructions: entity.deliveryInstructions,
    );
  }
}
