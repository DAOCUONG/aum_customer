import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repository/checkout_repository_impl.dart';
import '../../domain/usecases/checkout_usecases.dart';

/// Provider for checkout repository
final checkoutRepositoryProvider = Provider<CheckoutRepositoryImpl>((ref) {
  return CheckoutRepositoryImpl();
});

/// Provider for GetDeliverySlotsUseCase
final getDeliverySlotsUseCaseProvider = Provider<GetDeliverySlotsUseCase>((ref) {
  final repository = ref.watch(checkoutRepositoryProvider);
  return GetDeliverySlotsUseCase(repository);
});

/// Provider for ApplyPromoCodeUseCase
final applyPromoCodeUseCaseProvider = Provider<ApplyPromoCodeUseCase>((ref) {
  final repository = ref.watch(checkoutRepositoryProvider);
  return ApplyPromoCodeUseCase(repository);
});

/// Provider for GetPaymentMethodsUseCase
final getPaymentMethodsUseCaseProvider = Provider<GetPaymentMethodsUseCase>((ref) {
  final repository = ref.watch(checkoutRepositoryProvider);
  return GetPaymentMethodsUseCase(repository);
});

/// Provider for GetDeliveryAddressesUseCase
final getDeliveryAddressesUseCaseProvider = Provider<GetDeliveryAddressesUseCase>((ref) {
  final repository = ref.watch(checkoutRepositoryProvider);
  return GetDeliveryAddressesUseCase(repository);
});
