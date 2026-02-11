import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../ui/theme/glass_theme.dart';
import '../providers/checkout_notifier.dart';

/// A glassmorphic row for displaying price breakdown
class PriceRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;
  final bool isDiscount;

  const PriceRow({
    super.key,
    required this.label,
    required this.value,
    this.isTotal = false,
    this.isDiscount = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<GlassTheme>()!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 15 : 13,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
            color: isTotal ? theme.textPrimaryColor : theme.textSecondaryColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 15 : 13,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
            color: isDiscount
                ? theme.primaryColor
                : (isTotal ? theme.primaryColor : theme.textPrimaryColor),
          ),
        ),
      ],
    );
  }
}

/// Order summary section with price breakdown
class OrderSummarySection extends ConsumerWidget {
  const OrderSummarySection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(checkoutNotifierProvider);
    final theme = Theme.of(context).extension<GlassTheme>()!;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.glassSurfaceColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: theme.glassBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Summary',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: theme.textPrimaryColor,
            ),
          ),
          const SizedBox(height: 16),
          PriceRow(
            label: 'Subtotal',
            value: '\$${state.subtotal.toStringAsFixed(2)}',
          ),
          const SizedBox(height: 8),
          PriceRow(
            label: 'Service Fee',
            value: '\$2.50',
          ),
          const SizedBox(height: 8),
          PriceRow(
            label: 'Delivery Fee',
            value: '\$${state.deliveryFee.toStringAsFixed(2)}',
          ),
          if (state.tipAmount > 0) ...[
            const SizedBox(height: 8),
            PriceRow(
              label: 'Tip',
              value: '\$${state.tipAmount.toStringAsFixed(2)}',
            ),
          ],
          if (state.promoDiscount > 0) ...[
            const SizedBox(height: 8),
            PriceRow(
              label: 'Discount',
              value: '-\$${state.promoDiscount.toStringAsFixed(2)}',
              isDiscount: true,
            ),
          ],
          const SizedBox(height: 12),
          Divider(color: theme.dividerColor),
          const SizedBox(height: 4),
          PriceRow(
            label: 'Total',
            value: '\$${state.total.toStringAsFixed(2)}',
            isTotal: true,
          ),
        ],
      ),
    );
  }
}

/// Promo code input section
class PromoCodeSection extends ConsumerWidget {
  final TextEditingController promoController;

  const PromoCodeSection({
    super.key,
    required this.promoController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(checkoutNotifierProvider);
    final theme = Theme.of(context).extension<GlassTheme>()!;
    final notifier = ref.read(checkoutNotifierProvider.notifier);

    if (state.promoCode.isNotEmpty) {
      // Show applied promo
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.primaryColor.withOpacity(0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: theme.primaryColor.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: theme.primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.check,
                size: 18,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.promoCode,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: theme.textPrimaryColor,
                    ),
                  ),
                  Text(
                    'Discount applied',
                    style: TextStyle(
                      fontSize: 12,
                      color: theme.textSecondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: notifier.removePromoCode,
              child: Text(
                'Remove',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: theme.primaryColor,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Promo Code',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: theme.textSecondaryColor,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: theme.glassInputBgColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: state.promoErrorMessage.isNotEmpty
                        ? theme.primaryColor
                        : theme.glassInputBorderColor,
                  ),
                ),
                child: TextField(
                  controller: promoController,
                  decoration: InputDecoration(
                    hintText: 'Enter promo code',
                    hintStyle: TextStyle(color: theme.textTertiaryColor),
                    border: InputBorder.none,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  style: TextStyle(
                    fontSize: 14,
                    color: theme.textPrimaryColor,
                  ),
                  textCapitalization: TextCapitalization.characters,
                ),
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: state.isApplyingPromo
                    ? null
                    : () => notifier.applyPromoCode(promoController.text),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: state.isApplyingPromo
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                      )
                    : const Text(
                        'Apply',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ],
        ),
        if (state.promoErrorMessage.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              state.promoErrorMessage,
              style: TextStyle(
                fontSize: 12,
                color: theme.primaryColor,
              ),
            ),
          ),
      ],
    );
  }
}

/// Tip selection section
class TipSelectionSection extends ConsumerWidget {
  const TipSelectionSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(checkoutNotifierProvider);
    final theme = Theme.of(context).extension<GlassTheme>()!;
    final notifier = ref.read(checkoutNotifierProvider.notifier);

    final tipPercentages = state.tipPercentages;
    final tipAmounts = tipPercentages.map((p) {
      return state.subtotal * (p / 100);
    }).toList();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.glassSurfaceColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: theme.glassBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: theme.glassSurfaceColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: theme.glassBorderColor),
                ),
                child: Center(
                  child: Text(
                    '3',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: theme.textSecondaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tip Your Dasher',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: theme.textPrimaryColor,
                      ),
                    ),
                    Text(
                      '100% goes to driver',
                      style: TextStyle(
                        fontSize: 13,
                        color: theme.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Tip percentage chips
          Row(
            children: List.generate(tipPercentages.length, (index) {
              return Expanded(
                child: GestureDetector(
                  onTap: () => notifier.selectTip(index),
                  child: Container(
                    margin: EdgeInsets.only(
                        right: index < tipPercentages.length - 1 ? 8 : 0),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: state.selectedTipIndex == index
                          ? theme.primaryColor.withOpacity(0.1)
                          : theme.glassSurfaceColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: state.selectedTipIndex == index
                            ? theme.primaryColor.withOpacity(0.3)
                            : theme.glassBorderColor,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '${tipPercentages[index]}%',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: state.selectedTipIndex == index
                                ? theme.primaryColor
                                : theme.textPrimaryColor,
                          ),
                        ),
                        Text(
                          '\$${tipAmounts[index].toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 11,
                            color: theme.textTertiaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
          // Custom tip option
          GestureDetector(
            onTap: () {
              // TODO: Show custom tip dialog
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Center(
                child: Text(
                  'Enter custom amount',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: theme.primaryColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
