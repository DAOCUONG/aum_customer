import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../atoms/glass_button.dart';
import '../../../molecules/glass_profile_components.dart';
import '../../../theme/glass_design_system.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  int _selectedTab = 0;

  final List<Map<String, dynamic>> _orders = [
    {
      'restaurantName': 'Sushi Master',
      'date': 'Feb 24',
      'time': '12:30 PM',
      'items': '3 items • Salmon Roll, Miso Soup, Edamame',
      'price': '\$32.50',
      'status': 'Delivered',
      'isDelivered': true,
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBpwfw3eu_NkQhfS3KZGvAM_ylE8n_z2WSC0Bv2TVN4d-H7ne2ofMAE8g6sSxVcKvdfZvNOcPSm2UsFuKzEJE_WO5hjPlcdqKh6NqZGOSTRlHz6JhQNmVfeif9fOtpSkMY8Cgs0pr0TXbkh4S719qm8rwh8_D8I461n8m4bScBTRUV_PpOT6YK7-AR_6wGL5ccIO0FjwvRShzSZsKRKHuFP1VXeyNOv6ZggEIqP7yus_DKz2e91DQO7uevec1Mpjo3ApG4XSaYCNks',
    },
    {
      'restaurantName': 'Burger King',
      'date': 'Feb 18',
      'time': '7:15 PM',
      'items': '2 items • Double Whopper, Fries',
      'price': '\$24.00',
      'status': 'Delivered',
      'isDelivered': true,
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAAlY9q4sO60DMNVto4alI4o4YlV8at5eouKD43zXq7nPWprRFNf_OdjiWVxIoVRjLBVi5tAP0SBNi1HNW5oI3MUYLpF5NY3VUK3whh-DXnrAPR5emU0ua726-TRUrG76N-3oW9Z70-5szgtmShCtMiJxq34idmn3ICY-mKONTx8OMEcUfgl2zPGCvRQ5IaXLukYuZHOw7X-gIO-Inp-f7ad5aYpilTvyy2Gukg85c-CFJcniC7uQ7h7IPwqp1Fynuc2mIrMYo7xqA',
    },
    {
      'restaurantName': 'Pizza Hut',
      'date': 'Feb 10',
      'time': '8:40 PM',
      'items': '1 item • Pepperoni Feast Large',
      'price': '\$18.99',
      'status': 'Cancelled',
      'isDelivered': false,
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuB8jmp0nxbzI0C5IIl5H4stBrKPnWZHgEApd08pgjl4AqD0mZqTc5zsBlV38ITFS0f3HRhxYZ2z7enVyRRSnTzL9G4giTgXIzP2DxSTalB6GLFih8T3JOoJ-6iDodKlfHRPyl3eDNNlG-3c5irUFV-wz2JM4lv5roWlUxWM9OUoKkrBvTFegCcTDgbwU00bkOes-jewqI2OXVLWNp8QxHjDduuW_FwfG0SdxhJBrEJOYKsCSyw4ojQDjmUv-SCTXcRhmMJ4zqHc-S8',
    },
  ];

  final List<Map<String, dynamic>> _januaryOrders = [
    {
      'restaurantName': 'Thai Spice',
      'date': 'Jan 28',
      'time': '1:10 PM',
      'items': '2 items • Pad Thai, Spring Rolls',
      'price': '\$21.40',
      'status': 'Delivered',
      'isDelivered': true,
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBgA7rIYjcB5ECWxcUdnJ_ZQ0zvaEGFasS6CAmd03r0RDe_QVCl9HEx92eEUUvJZV7gJXlAlmz6YTtRJybi_wa2Vw3OPkJBEq9qM1N9NPhmp1ChKDuUuw8OS6PxSvvODA6IyuEpCwaGBFWj9eTE4QStzZrXfFV0kUD9p6ax_sb7o-AZnOG4_e3IACyZt01Cs_DbMVqB9KYI9we6JL-tXPvKCT13Ttr_uzu5szGjK3PwZq_80ysmibRmw4dfPfBoxwCBOLLlAlZacr0',
    },
    {
      'restaurantName': 'Starbucks',
      'date': 'Jan 15',
      'time': '9:00 AM',
      'items': '3 items • Latte, Croissant, Muffin',
      'price': '\$16.20',
      'status': 'Delivered',
      'isDelivered': true,
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuB71YwD7fZuIEmdugPn0bMiy756lBFrkKxq-cdwg8-Id3Wo4S6n7Pw7FFnHE2Vg_-ybPXqEpbV77SOQD3qsFgmzD_oEyfpjIRQOUEj_W8in7ei5gPT6NoYsbUCsCNtzxG2rMCW5O0lDOhZzMoAwPtZgHnrdp56xq6L1sjV2qn0oWbkfkJbklBMjgfv4cmWdK0l1mabPq0THE4wgf2CPF4WofUgiX0y3C8MC-Ch7AB375OOF51N37I-SinSF4BffeMK3tp3utU9pezQ',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: meshGradient,
        ),
        child: Column(
          children: [
            // Header
            _buildHeader(),
            // Tabs
            _buildTabs(),
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    // February section
                    _buildMonthSection('February 2026', _orders),
                    // January section
                    _buildMonthSection('January 2026', _januaryOrders),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.6),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
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
                'Order History',
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

  Widget _buildTabs() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          _buildTabButton('All', 0),
          _buildTabButton('Delivered', 1),
          _buildTabButton('Cancelled', 2),
        ],
      ),
    );
  }

  Widget _buildTabButton(String label, int index) {
    final isSelected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTab = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected ? primaryColor : Colors.grey.shade500,
                ),
              ),
              if (isSelected)
                Container(
                  height: 2,
                  margin: const EdgeInsets.only(top: 8),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMonthSection(String month, List<Map<String, dynamic>> orders) {
    final filteredOrders = _filterOrders(orders);

    if (filteredOrders.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            month,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: textSecondary,
              letterSpacing: 0.5,
            ),
          ),
        ),
        ...List.generate(filteredOrders.length, (index) {
          final order = filteredOrders[index];
          return GlassOrderCard(
            restaurantName: order['restaurantName'] as String,
            date: order['date'] as String,
            time: order['time'] as String,
            items: order['items'] as String,
            price: order['price'] as String,
            status: order['status'] as String,
            isDelivered: order['isDelivered'] as bool,
            imageUrl: order['imageUrl'] as String,
            onRateTap: order['isDelivered'] ? () {} : null,
            onReorderTap: () {},
            onHelpTap: order['isDelivered'] ? null : () {},
          );
        }),
      ],
    );
  }

  List<Map<String, dynamic>> _filterOrders(List<Map<String, dynamic>> orders) {
    switch (_selectedTab) {
      case 0: // All
        return orders;
      case 1: // Delivered
        return orders.where((o) => o['isDelivered'] as bool).toList();
      case 2: // Cancelled
        return orders.where((o) => !(o['isDelivered'] as bool)).toList();
      default:
        return orders;
    }
  }
}
