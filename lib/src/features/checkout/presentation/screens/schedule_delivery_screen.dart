import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/app_router.dart';
import '../../../../ui/atoms/glass_button.dart';
import '../../../../ui/theme/glass_theme.dart';
import '../../presentation/providers/delivery_slots_notifier.dart';
import '../../presentation/widgets/delivery_slot_picker.dart';

/// Schedule Delivery Screen
///
/// Screen for selecting a delivery time slot and adding
/// delivery instructions before finalizing the order.
class ScheduleDeliveryScreen extends ConsumerStatefulWidget {
  const ScheduleDeliveryScreen({super.key});

  @override
  ConsumerState<ScheduleDeliveryScreen> createState() =>
      _ScheduleDeliveryScreenState();
}

class _ScheduleDeliveryScreenState
    extends ConsumerState<ScheduleDeliveryScreen> {
  final TextEditingController _instructionsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () =>
          ref.read(deliverySlotsNotifierProvider.notifier).loadDeliverySlots(),
    );
  }

  @override
  void dispose() {
    _instructionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(deliverySlotsNotifierProvider);
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
                        const SizedBox(height: 24),
                        // Schedule Info
                        _buildScheduleInfo(theme),
                        const SizedBox(height: 24),
                        // Delivery Slots
                        _buildDeliverySlotsSection(theme),
                        const SizedBox(height: 24),
                        // Delivery Instructions
                        _buildInstructionsSection(theme),
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
                'Schedule Delivery',
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

  Widget _buildScheduleInfo(GlassTheme theme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.primaryColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.primaryColor.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: theme.primaryColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.access_time,
              size: 24,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Choose Delivery Time',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: theme.textPrimaryColor,
                  ),
                ),
                Text(
                  'Select a convenient time slot for your delivery',
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
    );
  }

  Widget _buildDeliverySlotsSection(GlassTheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: theme.glassSurfaceColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: theme.glassBorderColor),
              ),
              child: const Center(
                child: Text(
                  '1',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: GlassTheme.textSecondary,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Select Time Slot',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: theme.textPrimaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 400,
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: const DeliverySlotsList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInstructionsSection(GlassTheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: theme.glassSurfaceColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: theme.glassBorderColor),
              ),
              child: const Center(
                child: Text(
                  '2',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: GlassTheme.textSecondary,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Delivery Instructions (Optional)',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: theme.textPrimaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: theme.glassInputBgColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: theme.glassInputBorderColor),
          ),
          child: TextField(
            controller: _instructionsController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'Add special instructions for the driver...',
              hintStyle: TextStyle(color: theme.textTertiaryColor),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
            ),
            style: TextStyle(
              fontSize: 14,
              color: theme.textPrimaryColor,
            ),
            onChanged: (value) => ref
                .read(deliverySlotsNotifierProvider.notifier)
                .updateInstructions(value),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomButton(GlassTheme theme) {
    final state = ref.watch(deliverySlotsNotifierProvider);
    final selectedSlot = state.selectedSlot;

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
          child: GlassButton.primary(
            onPressed: selectedSlot == null
                ? null
                : () {
                    // Proceed to confirmation
                    ref
                        .read(deliverySlotsNotifierProvider.notifier)
                        .updateInstructions(_instructionsController.text);
                    context.push(RouteNames.orderSuccess);
                  },
            icon: Icons.check,
            iconSize: 20,
            child: Text(
              selectedSlot != null
                  ? 'Confirm for ${selectedSlot.timeRange}'
                  : 'Select a Time Slot',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
