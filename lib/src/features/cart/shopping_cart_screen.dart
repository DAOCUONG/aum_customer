import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../ui/atoms/glass_icon_button.dart';
import '../../ui/atoms/glass_quantity_stepper.dart';
import '../../ui/atoms/glass_promo_input.dart';
import '../../ui/molecules/glass_cart_item.dart';
import '../../ui/theme/glass_design_system.dart';

/// Shopping Cart Screen
class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({super.key});

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  final TextEditingController _promoController = TextEditingController();

  final List<Map<String, dynamic>> _cartItems = [
    {
      'image': 'https://picsum.photos/200?random=1',
      'name': 'Classic Cheeseburger',
      'price': '\$12.50',
      'description': 'Extra cheese, Medium',
      'quantity': 1,
      'modifications': ['Extra cheese', 'Medium'],
    },
    {
      'image': 'https://picsum.photos/200?random=2',
      'name': 'Truffle Fries',
      'price': '\$6.00',
      'description': 'Large, Garlic aioli',
      'quantity': 2,
      'modifications': ['Large', 'Garlic aioli'],
    },
    {
      'image': 'https://picsum.photos/200?random=3',
      'name': 'Craft Cola',
      'price': '\$3.50',
      'description': 'No Ice',
      'quantity': 1,
      'modifications': ['No Ice'],
    },
  ];

  double get _subtotal {
    return _cartItems.fold(0, (sum, item) {
      final price = double.tryParse(item['price'].toString().replaceAll('\$', '')) ?? 0;
      return sum + (price * (item['quantity'] as int));
    });
  }

  double get _deliveryFee => 2.50;
  double get _discount => 4.40;
  double get _total => _subtotal + _deliveryFee - _discount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundLight,
      body: Stack(
        children: [
          // Mesh Background
          _buildMeshBackground(),
          SafeArea(
            child: Column(
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
                        // Delivery Address Card
                        _buildDeliveryAddressCard(),
                        const SizedBox(height: 16),
                        // Cart Items
                        ..._cartItems.map((item) => GlassCartItem(
                              imageUrl: item['image'],
                              name: item['name'],
                              price: item['price'],
                              description: item['description'],
                              quantity: item['quantity'],
                              modifications: List<String>.from(item['modifications']),
                              onEdit: () {},
                              onDelete: () {},
                              onQuantityChanged: (value) {},
                            )),
                        const SizedBox(height: 16),
                        // Promo Code
                        GlassPromoInput(
                          controller: _promoController,
                          onApply: () {},
                        ),
                        const SizedBox(height: 16),
                        // Order Summary
                        _buildOrderSummary(),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Checkout Button
          _buildCheckoutButton(),
        ],
      ),
    );
  }

  Widget _buildMeshBackground() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topLeft,
            radius: 1.5,
            colors: [
              Colors.orange.shade100.withOpacity(0.6),
              backgroundLight,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          GlassIconButton.transparent(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back_ios_new, size: 20),
            size: 40,
          ),
          const SizedBox(width: 12),
          Text(
            'Cart (${_cartItems.length})',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: textPrimary,
            ),
          ),
          const Spacer(),
          GlassIconButton.transparent(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz, size: 24),
            size: 40,
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryAddressCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.65),
        borderRadius: cardRadius,
        border: Border.all(color: Colors.white.withOpacity(0.6)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 32,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Address
          Row(
            children: [
              Icon(
                Icons.location_on,
                size: 20,
                color: primaryColor,
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Home • 2425 Wilson Blvd',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: textPrimary,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Edit',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const GlassGradientDivider(),
          // Delivery Time
          Row(
            children: [
              Icon(
                Icons.access_time,
                size: 20,
                color: textSecondary,
              ),
              const SizedBox(width: 8),
              const Text(
                '15-20 min',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: textPrimary,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'Standard',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.65),
        borderRadius: cardRadius,
        border: Border.all(color: Colors.white.withOpacity(0.6)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 32,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order Summary',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          _buildSummaryRow('Subtotal', '\$${_subtotal.toStringAsFixed(2)}'),
          const SizedBox(height: 8),
          _buildSummaryRow('Delivery Fee', '\$${_deliveryFee.toStringAsFixed(2)}'),
          const SizedBox(height: 8),
          _buildSummaryRow(
            'Discount (HELLO20)',
            '-\$${_discount.toStringAsFixed(2)}',
            textColor: successGreen,
          ),
          const GlassGradientDivider(),
          _buildSummaryRow(
            'Total',
            '\$${_total.toStringAsFixed(2)}',
            isBold: true,
            fontSize: 18,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    bool isBold = false,
    Color? textColor,
  }) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isBold ? 17 : 14,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
            color: textColor ?? textPrimary,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: isBold ? 17 : 14,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
            color: textColor ?? textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildCheckoutButton() {
    return Positioned(
      left: 20,
      right: 20,
      bottom: 24,
      child: GestureDetector(
        onTap: () {},
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [primaryLight, primaryColor],
            ),
            borderRadius: buttonRadius,
            boxShadow: [
              BoxShadow(
                color: primaryColor.withOpacity(0.4),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Proceed to Checkout',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_forward,
                size: 20,
                color: Colors.white.withOpacity(0.8),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
