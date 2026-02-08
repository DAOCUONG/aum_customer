import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../atoms/glass_button.dart';
import '../../../atoms/glass_section_header.dart';
import '../../../molecules/glass_delivery_components.dart';
import '../../../theme/glass_design_system.dart';

class CheckoutDetailsScreen extends StatefulWidget {
  const CheckoutDetailsScreen({super.key});

  @override
  State<CheckoutDetailsScreen> createState() => _CheckoutDetailsScreenState();
}

class _CheckoutDetailsScreenState extends State<CheckoutDetailsScreen> {
  int selectedTipIndex = 2;
  bool leaveAtDoor = false;
  bool priorityDelivery = true;
  final TextEditingController instructionsController = TextEditingController();

  final List<double> tipPercentages = [10, 15, 18, 20];
  final List<double> tipAmounts = [3.45, 5.15, 6.20, 6.90];

  @override
  void dispose() {
    instructionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: meshGradient,
        ),
        child: Stack(
          children: [
            // Main content
            Column(
              children: [
                // Header
                _buildHeader(),
                // Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        // Delivery Details Section
                        _buildDeliveryDetailsSection(),
                        const SizedBox(height: 16),
                        // Payment Method Section
                        _buildPaymentMethodSection(),
                        const SizedBox(height: 16),
                        // Tip Section
                        _buildTipSection(),
                        const SizedBox(height: 20),
                        // Price Breakdown
                        _buildPriceBreakdown(),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Bottom Button
            _buildBottomButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha:0.7),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        border: Border(bottom: BorderSide(color: Colors.white.withValues(alpha:0.3))),
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
                  color: textPrimary,
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

  Widget _buildDeliveryDetailsSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha:0.5),
        borderRadius: const BorderRadius.all(cardRadius),
        border: Border.all(color: Colors.white.withValues(alpha:0.6)),
        boxShadow: [glassShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlassSectionHeader(
            number: 1,
            title: 'Delivery Details',
            hasAction: true,
            onActionTap: () {},
          ),
          const SizedBox(height: 16),
          // Address Card
          _buildAddressCard(),
          const SizedBox(height: 16),
          // Instructions
          const Text(
            'Delivery Instructions',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: textTertiary,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha:0.4),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withValues(alpha:0.5)),
            ),
            child: TextField(
              controller: instructionsController,
              maxLines: 2,
              decoration: InputDecoration(
                hintText: 'Gate code, drop-off details...',
                hintStyle: TextStyle(color: textSecondary),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(12),
              ),
              style: const TextStyle(
                fontSize: 14,
                color: textPrimary,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Checkboxes
          Row(
            children: [
              Expanded(
                child: GlassCheckboxRow(
                  label: 'Leave at door',
                  isChecked: leaveAtDoor,
                  onChanged: (value) => setState(() => leaveAtDoor = value),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: GlassCheckboxRow(
                  label: 'Priority',
                  subtitle: '+\$1.99',
                  isChecked: priorityDelivery,
                  onChanged: (value) => setState(() => priorityDelivery = value),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddressCard() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha:0.4),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withValues(alpha:0.5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.home, size: 20, color: textTertiary),
                    const SizedBox(width: 8),
                    Text(
                      'Home',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: textTertiary,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Edit',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              '245 Highland Ave, Apt 4B',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: textPrimary,
              ),
            ),
            Text(
              'San Francisco, CA 94110',
              style: TextStyle(
                fontSize: 13,
                color: textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodSection() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha:0.5),
          borderRadius: const BorderRadius.all(cardRadius),
          border: Border.all(color: Colors.white.withValues(alpha:0.6)),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Text(
                  '2',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Payment Method',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      'Apple Pay',
                      style: TextStyle(
                        fontSize: 12,
                        color: textSecondary,
                      ),
                    ),
                    Container(
                      width: 4,
                      height: 4,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    Text(
                      '**** 4242',
                      style: TextStyle(
                        fontSize: 12,
                        color: textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, size: 14, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha:0.5),
        borderRadius: const BorderRadius.all(cardRadius),
        border: Border.all(color: Colors.white.withValues(alpha:0.6)),
        boxShadow: [glassShadow],
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
                  color: Colors.white.withValues(alpha:0.6),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white),
                ),
                child: const Center(
                  child: Text(
                    '3',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: textSecondary,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Tip Your Dasher',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: textPrimary,
                  ),
                ),
              ),
              Text(
                '100% goes to driver',
                style: TextStyle(
                  fontSize: 13,
                  color: textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Tip chips
          Row(
            children: List.generate(tipPercentages.length, (index) {
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => selectedTipIndex = index),
                  child: Container(
                    margin: EdgeInsets.only(right: index < tipPercentages.length - 1 ? 8 : 0),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: selectedTipIndex == index
                          ? primaryColor.withValues(alpha:0.1)
                          : Colors.white.withValues(alpha:0.4),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: selectedTipIndex == index
                            ? primaryColor.withValues(alpha:0.3)
                            : Colors.white.withValues(alpha:0.5),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '${tipPercentages[index]}%',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: selectedTipIndex == index ? primaryColor : textPrimary,
                          ),
                        ),
                        Text(
                          '\$${tipAmounts[index].toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 11,
                            color: textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
          // Custom tip
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Center(
                child: Text(
                  'Enter custom amount',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: primaryColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceBreakdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          GlassPriceRow(label: 'Subtotal', value: '\$34.50'),
          const SizedBox(height: 8),
          GlassPriceRow(label: 'Service Fee', value: '\$2.50'),
          const SizedBox(height: 8),
          GlassPriceRow(label: 'Delivery Fee', value: '\$1.99'),
          const SizedBox(height: 8),
          GlassPriceRow(label: 'Tip (${tipPercentages[selectedTipIndex]}%)', value: '\$${tipAmounts[selectedTipIndex].toStringAsFixed(2)}'),
          const SizedBox(height: 12),
          Divider(color: Colors.black.withValues(alpha:0.05)),
          const SizedBox(height: 4),
          GlassPriceRow(
            label: 'Total',
            value: '\$45.19',
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha:0.7),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
          border: Border(top: BorderSide(color: Colors.white.withValues(alpha:0.4))),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GlassButton.primary(
                onPressed: () => context.push('/schedule-delivery'),
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
                      '\$47.27',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white.withValues(alpha:0.8),
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
                  color: textTertiary,
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
