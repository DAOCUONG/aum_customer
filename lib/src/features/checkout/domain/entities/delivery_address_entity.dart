import 'package:freezed_annotation/freezed_annotation.dart';

part 'delivery_address_entity.freezed.dart';

/// Entity representing a delivery address
@freezed
class DeliveryAddressEntity with _$DeliveryAddressEntity {
  const factory DeliveryAddressEntity({
    required String id,
    required String label,
    required String streetAddress,
    required String? apartment,
    required String city,
    required String state,
    required String zipCode,
    required String country,
    required double latitude,
    required double longitude,
    required bool isDefault,
    required String? deliveryInstructions,
  }) = _DeliveryAddressEntity;

  const DeliveryAddressEntity._();

  /// Full formatted address
  String get fullAddress {
    final parts = [
      streetAddress,
      if (apartment != null && apartment!.isNotEmpty) apartment!,
      '$city, $state $zipCode',
      country,
    ];
    return parts.join(', ');
  }

  /// Short address for display
  String get shortAddress {
    return '$streetAddress, $city';
  }

  /// Create an empty delivery address
  factory DeliveryAddressEntity.empty() {
    return const DeliveryAddressEntity(
      id: '',
      label: '',
      streetAddress: '',
      apartment: null,
      city: '',
      state: '',
      zipCode: '',
      country: 'USA',
      latitude: 0,
      longitude: 0,
      isDefault: false,
      deliveryInstructions: null,
    );
  }

  /// Check if address is valid
  bool get isValid {
    return streetAddress.isNotEmpty &&
        city.isNotEmpty &&
        state.isNotEmpty &&
        zipCode.isNotEmpty;
  }
}
