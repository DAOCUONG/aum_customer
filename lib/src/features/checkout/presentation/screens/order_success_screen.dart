import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/app_router.dart';
import '../../../../ui/atoms/glass_button.dart';
import '../../../../ui/theme/glass_theme.dart';
import '../../presentation/providers/checkout_notifier.dart';

/// Order Success Screen
///
/// Screen displayed after a successful order placement.
/// Shows order confirmation details and next steps.
class OrderSuccessScreen extends ConsumerWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(checkoutNotifierProvider);
    final theme = Theme.of(context).extension<GlassTheme>()!;
    final order = state.order;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              GlassTheme.success.withValues(alpha: 0.1),
              GlassTheme.success.withValues(alpha: 0.05),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Spacer(),
                // Success Icon
                _buildSuccessIcon(theme),
                const SizedBox(height: 32),
                // Success Message
                _buildSuccessMessage(theme),
                const SizedBox(height: 32),
                // Order Details Card
                if (order != null) _buildOrderDetailsCard(theme, order),
                const Spacer(),
                // Action Buttons
                _buildActionButtons(context, theme),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessIcon(GlassTheme theme) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: GlassTheme.success.withOpacity(0.2),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: GlassTheme.success.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Icon(
        Icons.check,
        size: 50,
        color: GlassTheme.success,
      ),
    );
  }

  Widget _buildSuccessMessage(GlassTheme theme) {
    return Column(
      children: [
        Text(
          'Order Confirmed!',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: theme.textPrimaryColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Your delicious meal is on its way',
          style: TextStyle(
            fontSize: 16,
            color: theme.textSecondaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildOrderDetailsCard(GlassTheme theme, dynamic order) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.glassSurfaceColor.withOpacity(0.7),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: theme.glassBorderColor),
        boxShadow: [GlassShadows.glass],
      ),
      child: Column(
        children: [
          // Order ID
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Order #',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: theme.textSecondaryColor,
                ),
              ),
              Text(
                order.orderNumber,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: theme.textPrimaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Divider
          Divider(color: theme.dividerColor),
          const SizedBox(height: 20),
          // Estimated Delivery
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: GlassTheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.delivery_dining,
                  size: 24,
                  color: GlassTheme.primary,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Estimated Delivery',
                    style: TextStyle(
                      fontSize: 12,
                      color: theme.textSecondaryColor,
                    ),
                  ),
                  Text(
                    '${order.estimatedDeliveryMinutes} minutes',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: theme.textPrimaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Restaurant Info
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: theme.glassSurfaceColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: theme.glassBorderColor),
                ),
                child: const Icon(
                  Icons.restaurant,
                  size: 24,
                  color: GlassTheme.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bella Italia',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: theme.textPrimaryColor,
                      ),
                    ),
                    Text(
                      '123 Main Street, Downtown',
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
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, GlassTheme theme) {
    return Column(
      children: [
        GlassButton.primary(
          onPressed: () {
            // TODO: Navigate to live tracking
            context.push(RouteNames.liveTracking);
          },
          icon: Icons.local_shipping,
          iconSize: 20,
          child: const Text(
            'Track Order',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 12),
        GlassButtonVariants.ghost(
          context: context,
          onPressed: () {
            // Navigate to home and clear stack
            context.go(RouteNames.home);
          },
          label: 'Back to Home',
        ),
      ],
    );
  }
}
