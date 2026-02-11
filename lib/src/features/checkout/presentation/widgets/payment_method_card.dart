import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../ui/theme/glass_theme.dart';
import '../../domain/entities/payment_method_entity.dart';
import '../../domain/entities/payment_method_entity.dart' as pm;
import '../providers/checkout_notifier.dart';

/// A glassmorphic card for displaying and selecting payment methods
class PaymentMethodCard extends ConsumerWidget {
  final PaymentMethodEntity paymentMethod;
  final bool isSelected;
  final VoidCallback onTap;

  const PaymentMethodCard({
    super.key,
    required this.paymentMethod,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).extension<GlassTheme>()!;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.primaryColor.withOpacity(0.1)
              : theme.glassSurfaceColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? theme.primaryColor.withOpacity(0.3)
                : theme.glassBorderColor,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            _buildPaymentIcon(theme),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getPaymentDisplayName(),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: theme.textPrimaryColor,
                    ),
                  ),
                  if (paymentMethod.type != pm.PaymentMethodType.cash) ...[
                    const SizedBox(height: 4),
                    Text(
                      '**** ${paymentMethod.lastFourDigits}',
                      style: TextStyle(
                        fontSize: 13,
                        color: theme.textSecondaryColor,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (isSelected)
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check,
                  size: 14,
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentIcon(GlassTheme theme) {
    final iconData = switch (paymentMethod.type) {
      pm.PaymentMethodType.applePay => Icons.apple,
      pm.PaymentMethodType.googlePay => Icons.paypal,
      pm.PaymentMethodType.creditCard || pm.PaymentMethodType.debitCard =>
        Icons.credit_card,
      pm.PaymentMethodType.cash => Icons.money,
    };

    final iconColor = switch (paymentMethod.type) {
      pm.PaymentMethodType.applePay => Colors.black,
      pm.PaymentMethodType.googlePay => Colors.blue,
      pm.PaymentMethodType.creditCard || pm.PaymentMethodType.debitCard =>
        theme.primaryColor,
      pm.PaymentMethodType.cash => Colors.green,
    };

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: theme.glassSurfaceColor.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.glassBorderColor),
      ),
      child: Icon(
        iconData,
        size: 20,
        color: iconColor,
      ),
    );
  }

  String _getPaymentDisplayName() {
    return switch (paymentMethod.type) {
      pm.PaymentMethodType.applePay => 'Apple Pay',
      pm.PaymentMethodType.googlePay => 'Google Pay',
      pm.PaymentMethodType.creditCard =>
        paymentMethod.cardBrand ?? 'Credit Card',
      pm.PaymentMethodType.debitCard =>
        paymentMethod.cardBrand ?? 'Debit Card',
      pm.PaymentMethodType.cash => 'Cash on Delivery',
    };
  }
}

/// List of available payment methods
class PaymentMethodsList extends ConsumerWidget {
  const PaymentMethodsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(checkoutNotifierProvider);
    final theme = Theme.of(context).extension<GlassTheme>()!;

    if (state.paymentMethods.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Method',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: theme.textSecondaryColor,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 12),
        ...state.paymentMethods.map(
          (method) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: PaymentMethodCard(
              paymentMethod: method,
              isSelected: method.id == state.effectivePaymentMethod.id,
              onTap: () =>
                  ref.read(checkoutNotifierProvider.notifier).selectPaymentMethod(method),
            ),
          ),
        ),
      ],
    );
  }
}
