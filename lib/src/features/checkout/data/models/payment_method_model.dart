import '../../domain/entities/payment_method_entity.dart';

/// Data model for payment methods
class PaymentMethodModel {
  final String id;
  final String type;
  final String lastFourDigits;
  final String? cardBrand;
  final String? cardholderName;
  final String? expiryMonth;
  final String? expiryYear;
  final bool isDefault;

  const PaymentMethodModel({
    required this.id,
    required this.type,
    required this.lastFourDigits,
    this.cardBrand,
    this.cardholderName,
    this.expiryMonth,
    this.expiryYear,
    required this.isDefault,
  });

  /// Convert to domain entity
  PaymentMethodEntity toEntity() {
    return PaymentMethodEntity(
      id: id,
      type: _parsePaymentMethodType(type),
      lastFourDigits: lastFourDigits,
      cardBrand: cardBrand,
      cardholderName: cardholderName,
      expiryMonth: expiryMonth,
      expiryYear: expiryYear,
      isDefault: isDefault,
      iconName: _getIconName(type),
    );
  }

  /// Create from domain entity
  static PaymentMethodModel fromEntity(PaymentMethodEntity entity) {
    return PaymentMethodModel(
      id: entity.id,
      type: entity.type.name,
      lastFourDigits: entity.lastFourDigits,
      cardBrand: entity.cardBrand,
      cardholderName: entity.cardholderName,
      expiryMonth: entity.expiryMonth,
      expiryYear: entity.expiryYear,
      isDefault: entity.isDefault,
    );
  }

  PaymentMethodType _parsePaymentMethodType(String type) {
    switch (type.toLowerCase()) {
      case 'credit_card':
        return PaymentMethodType.creditCard;
      case 'debit_card':
        return PaymentMethodType.debitCard;
      case 'apple_pay':
        return PaymentMethodType.applePay;
      case 'google_pay':
        return PaymentMethodType.googlePay;
      case 'cash':
        return PaymentMethodType.cash;
      default:
        return PaymentMethodType.creditCard;
    }
  }

  String _getIconName(String type) {
    switch (type.toLowerCase()) {
      case 'credit_card':
      case 'debit_card':
        return 'credit_card';
      case 'apple_pay':
        return 'apple';
      case 'google_pay':
        return 'google';
      case 'cash':
        return 'money';
      default:
        return 'payment';
    }
  }
}
