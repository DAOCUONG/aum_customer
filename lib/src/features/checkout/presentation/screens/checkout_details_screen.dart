import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/app_router.dart';
import '../../../../ui/atoms/glass_button.dart';
import '../../../../ui/theme/glass_theme.dart';
import '../../presentation/providers/checkout_notifier.dart';
import '../../presentation/providers/checkout_state.dart';
import '../../presentation/widgets/delivery_address_form.dart';
import '../../presentation/widgets/order_summary_widgets.dart';
import '../../presentation/widgets/payment_method_card.dart';

/// Checkout Details Screen
///
/// Main checkout screen where users can:
/// - View and edit delivery address
/// - Select payment method
/// - Add tip
/// - Apply promo codes
/// - Review order summary
/// - Proceed to schedule delivery or place order
class CheckoutDetailsScreen extends ConsumerStatefulWidget {
  const CheckoutDetailsScreen({super.key});

  @override
  ConsumerState<CheckoutDetailsScreen> createState() =>
      _CheckoutDetailsScreenState();
}

class _CheckoutDetailsScreenState extends ConsumerState<CheckoutDetailsScreen> {
  final TextEditingController _instructionsController = TextEditingController();
  final TextEditingController _promoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(checkoutNotifierProvider.notifier).initialize(),
    );
  }

  @override
  void dispose() {
    _instructionsController.dispose();
    _promoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(checkoutNotifierProvider);
    final theme = Theme.of(context).extension<GlassTheme>()!;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: GlassGradients.meshGradient,
          ),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                // Header
                _buildHeader(context),
                // Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        // Delivery Details Section
                        _buildDeliveryDetailsSection(theme),
                        const SizedBox(height: 16),
                        // Payment Method Section
                        _buildPaymentMethodSection(theme),
                        const SizedBox(height: 16),
                        // Tip Section
                        const TipSelectionSection(),
                        const SizedBox(height: 16),
                        // Promo Code Section
                        PromoCodeSection(promoController: _promoController),
                        const SizedBox(height: 20),
                        // Price Breakdown
                        const OrderSummarySection(),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Bottom Button
            _buildBottomButton(theme),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.7),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        border: Border(
          bottom: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            GlassButton.icon(
              onPressed: () => context.pop(),
              icon: Icons.arrow_back_ios_new,
              size: 40,
            ),
            const Expanded(
              child: Text(
                'Checkout',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: GlassTheme.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryDetailsSection(GlassTheme theme) {
    final state = ref.watch(checkoutNotifierProvider);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.glassSurfaceColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: theme.glassBorderColor),
        boxShadow: [GlassShadows.glass],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section number and title
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
                child: const Center(
                  child: Text(
                    '1',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: GlassTheme.textSecondary,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Delivery Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: theme.textPrimaryColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Address Card
          DeliveryAddressCard(
            address: state.effectiveDeliveryAddress,
            onEdit: () {
              // TODO: Navigate to address edit
            },
            onChangeAddress: () {
              // TODO: Show address selection bottom sheet
            },
          ),
          const SizedBox(height: 16),
          // Instructions
          DeliveryInstructionsForm(controller: _instructionsController),
          const SizedBox(height: 16),
          // Checkboxes
          Row(
            children: [
              Expanded(
                child: DeliveryOptionCheckbox(
                  label: 'Leave at door',
                  isChecked: state.leaveAtDoor,
                  onChanged: (value) => ref
                      .read(checkoutNotifierProvider.notifier)
                      .setLeaveAtDoor(value ?? false),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: DeliveryOptionCheckbox(
                  label: 'Priority',
                  subtitle: '+\$1.99',
                  isChecked: state.priorityDelivery,
                  onChanged: (value) => ref
                      .read(checkoutNotifierProvider.notifier)
                      .setPriorityDelivery(value ?? false),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodSection(GlassTheme theme) {
    final state = ref.watch(checkoutNotifierProvider);

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
          // Section number and title
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
                child: const Center(
                  child: Text(
                    '2',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: GlassTheme.textSecondary,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Payment Method',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: theme.textPrimaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Payment methods list
          ...state.paymentMethods.map(
            (method) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: PaymentMethodCard(
                paymentMethod: method,
                isSelected: method.id == state.effectivePaymentMethod.id,
                onTap: () => ref
                    .read(checkoutNotifierProvider.notifier)
                    .selectPaymentMethod(method),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton(GlassTheme theme) {
    final state = ref.watch(checkoutNotifierProvider);

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.7),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
          border: Border(
            top: BorderSide(color: theme.glassBorderColor),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GlassButton.primary(
                onPressed: state.status == CheckoutStatus.processing
                    ? null
                    : () async {
                        final success = await ref
                            .read(checkoutNotifierProvider.notifier)
                            .processCheckout();
                        if (success && mounted) {
                          context.push(RouteNames.orderSuccess);
                        }
                      },
                isLoading: state.status == CheckoutStatus.processing,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Place Order',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '\$${state.total.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'By placing your order, you agree to our Terms of Service and Privacy Policy.',
                style: TextStyle(
                  fontSize: 10,
                  color: theme.textTertiaryColor,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
