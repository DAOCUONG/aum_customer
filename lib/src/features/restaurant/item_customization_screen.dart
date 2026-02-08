import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../ui/atoms/glass_quantity_stepper.dart';
import '../../ui/atoms/glass_icon_button.dart';
import '../../ui/theme/glass_design_system.dart';

/// Item Customization Screen - Modal for customizing menu items
class ItemCustomizationScreen extends StatefulWidget {
  final String itemName;
  final String itemPrice;
  final String itemDescription;
  final String imageUrl;

  const ItemCustomizationScreen({
    super.key,
    required this.itemName,
    required this.itemPrice,
    required this.itemDescription,
    required this.imageUrl,
  });

  @override
  State<ItemCustomizationScreen> createState() => _ItemCustomizationScreenState();
}

class _ItemCustomizationScreenState extends State<ItemCustomizationScreen> {
  int _selectedPattyIndex = 0;
  int _quantity = 1;
  final List<int> _selectedToppings = [0, 1];

  final List<String> _pattyOptions = [
    'Medium Rare',
    'Medium',
    'Well Done',
  ];

  final List<Map<String, dynamic>> _toppings = [
    {'name': 'Extra Cheese', 'price': 1.50},
    {'name': 'Bacon Strips', 'price': 2.00},
    {'name': 'Fried Egg', 'price': 2.50},
    {'name': 'Avocado', 'price': 3.00},
    {'name': 'Jalapeños', 'price': 1.00},
    {'name': 'Mushrooms', 'price': 2.00},
  ];

  double get _basePrice {
    return double.tryParse(widget.itemPrice.replaceAll('\$', '')) ?? 0;
  }

  double get _toppingsPrice {
    return _selectedToppings.fold(0, (sum, index) => sum + (_toppings[index]['price'] as double));
  }

  double get _totalPrice {
    return (_basePrice + _toppingsPrice) * _quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topCenter,
            radius: 2,
            colors: [
              Colors.white,
              Color(0xFFF2F2F7),
            ],
          ),
        ),
        child: Column(
          children: [
            // Background Image
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      widget.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      color: Colors.white.withOpacity(0.3),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Item Customization Modal - Full bottom sheet implementation
class ItemCustomizationModal extends StatelessWidget {
  final String itemName;
  final String itemPrice;
  final String itemDescription;
  final String imageUrl;

  const ItemCustomizationModal({
    super.key,
    required this.itemName,
    required this.itemPrice,
    required this.itemDescription,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(40),
        ),
      ),
      child: Column(
        children: [
          // Content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    // Drag handle
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Close button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GlassIconButton.transparent(
                          onPressed: () => context.pop(),
                          icon: const Icon(Icons.close, size: 24),
                          size: 40,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Item Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Container(
                        width: double.infinity,
                        height: 200,
                        color: Colors.orange.shade100,
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Title and Price
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            itemName,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1C1C1E),
                            ),
                          ),
                        ),
                        Text(
                          itemPrice,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFFF5E2B),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Description
                    Text(
                      itemDescription,
                      style: TextStyle(
                        fontSize: 14,
                        color: const Color(0xFF6E6E73),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Patty Style Section
                    _buildSectionTitle('Patty Style (Required)'),
                    const SizedBox(height: 12),
                    _buildRadioOption(label: 'Medium Rare', isSelected: true, onTap: () {}),
                    _buildRadioOption(label: 'Medium', isSelected: false, onTap: () {}),
                    _buildRadioOption(label: 'Well Done', isSelected: false, onTap: () {}),
                    const SizedBox(height: 24),
                    // Extra Toppings Section
                    _buildSectionTitle('Extra Toppings (Optional)'),
                    const SizedBox(height: 12),
                    _buildCheckboxOption(label: 'Extra Cheese', price: '+\$1.50', isSelected: true, onTap: () {}),
                    _buildCheckboxOption(label: 'Bacon Strips', price: '+\$2.00', isSelected: true, onTap: () {}),
                    _buildCheckboxOption(label: 'Fried Egg', price: '+\$2.50', isSelected: false, onTap: () {}),
                    _buildCheckboxOption(label: 'Avocado', price: '+\$3.00', isSelected: false, onTap: () {}),
                    _buildCheckboxOption(label: 'Jalapeños', price: '+\$1.00', isSelected: false, onTap: () {}),
                    _buildCheckboxOption(label: 'Mushrooms', price: '+\$2.00', isSelected: false, onTap: () {}),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ),
          // Bottom Bar
          _buildBottomBar(context),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Color(0xFF6E6E73),
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildRadioOption({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.4),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? const Color(0xFFFF5E2B).withOpacity(0.3)
                : Colors.white.withOpacity(0.5),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFFF5E2B) : Colors.transparent,
                border: Border.all(
                  color: isSelected ? const Color(0xFFFF5E2B) : const Color(0xFF8E8E93),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 12, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: isSelected ? const Color(0xFFFF5E2B) : const Color(0xFF1C1C1E),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckboxOption({
    required String label,
    required String price,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFFF5E2B).withOpacity(0.1)
              : Colors.white.withOpacity(0.4),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? const Color(0xFFFF5E2B).withOpacity(0.3)
                : Colors.white.withOpacity(0.5),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFFF5E2B) : Colors.transparent,
                border: Border.all(
                  color: isSelected ? const Color(0xFFFF5E2B) : const Color(0xFF8E8E93),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? const Color(0xFFFF5E2B) : const Color(0xFF1C1C1E),
                ),
              ),
            ),
            Text(
              price,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isSelected ? const Color(0xFFFF5E2B) : const Color(0xFF6E6E73),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 20,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            // Quantity
            GlassQuantityStepper(
              quantity: 1,
              onQuantityChanged: (value) {},
              size: 40,
            ),
            const SizedBox(width: 16),
            // Add to Cart Button
            Expanded(
              child: GestureDetector(
                onTap: () => context.pop(),
                child: Container(
                  height: 52,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFFF7A45), Color(0xFFFF5E2B)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFF5E2B).withOpacity(0.4),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Add to Cart',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '\$14.50',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
