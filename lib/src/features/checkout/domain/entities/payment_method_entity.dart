import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_method_entity.freezed.dart';

/// Entity representing a payment method
@freezed
class PaymentMethodEntity with _$PaymentMethodEntity {
  const factory PaymentMethodEntity({
    required String id,
    required PaymentMethodType type,
    required String lastFourDigits,
    required String? cardBrand,
    required String? cardholderName,
    required String? expiryMonth,
    required String? expiryYear,
    required bool isDefault,
    required String? iconName,
  }) = _PaymentMethodEntity;

  const PaymentMethodEntity._();

  /// Display name for the payment method
  String get displayName {
    switch (type) {
      case PaymentMethodType.creditCard:
      case PaymentMethodType.debitCard:
        return '$cardBrand ****$lastFourDigits';
      case PaymentMethodType.applePay:
        return 'Apple Pay ****$lastFourDigits';
      case PaymentMethodType.googlePay:
        return 'Google Pay ****$lastFourDigits';
      case PaymentMethodType.cash:
        return 'Cash on Delivery';
    }
  }

  /// Create an empty payment method
  factory PaymentMethodEntity.empty() {
    return const PaymentMethodEntity(
      id: '',
      type: PaymentMethodType.creditCard,
      lastFourDigits: '',
      cardBrand: null,
      cardholderName: null,
      expiryMonth: null,
      expiryYear: null,
      isDefault: false,
      iconName: null,
    );
  }

  /// Check if payment method is valid
  bool get isValid {
    return id.isNotEmpty && type != PaymentMethodType.cash
        ? lastFourDigits.isNotEmpty
        : true;
  }
}

/// Enum for payment method types
enum PaymentMethodType {
  creditCard,
  debitCard,
  applePay,
  googlePay,
  cash,
}
