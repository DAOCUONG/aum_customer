import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../atoms/glass_button.dart';
import '../../../molecules/glass_profile_components.dart';
import '../../../theme/glass_design_system.dart';

class ManageAddressesScreen extends StatefulWidget {
  const ManageAddressesScreen({super.key});

  @override
  State<ManageAddressesScreen> createState() => _ManageAddressesScreenState();
}

class _ManageAddressesScreenState extends State<ManageAddressesScreen> {
  final List<Map<String, dynamic>> _addresses = [
    {
      'label': 'Home',
      'address': '1243 Maplewood Drive, Apt 4B\nSan Francisco, CA 94103',
      'icon': Icons.home,
      'iconColor': primaryColor,
      'isDefault': true,
    },
    {
      'label': 'Work',
      'address': '800 Market Street, Suite 300\nSan Francisco, CA 94102',
      'icon': Icons.work,
      'iconColor': Colors.grey.shade600,
      'isDefault': false,
    },
    {
      'label': "Mom's House",
      'address': '4528 Sunset Blvd\nLos Angeles, CA 90027',
      'icon': Icons.favorite,
      'iconColor': Colors.grey.shade600,
      'isDefault': false,
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
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    // Add new address button
                    _buildAddAddressButton(),
                    const SizedBox(height: 32),
                    // Addresses section
                    _buildAddressesSection(),
                    const SizedBox(height: 24),
                    // Use current location
                    _buildCurrentLocationButton(),
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
        color: Colors.white.withValues(alpha: 0.7),
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
                'Saved Addresses',
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

  Widget _buildAddAddressButton() {
    return GestureDetector(
      onTap: () {
        // Navigate to add address screen
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: primaryColor,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.add,
                size: 20,
                color: primaryColor,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Add New Address',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'My Locations',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade400,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 12),
        ...List.generate(_addresses.length, (index) {
          final address = _addresses[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: GlassAddressCard(
              label: address['label'] as String,
              address: address['address'] as String,
              icon: address['icon'] as IconData,
              iconColor: address['iconColor'] as Color,
              isDefault: address['isDefault'] as bool,
              onEditTap: () {},
              onDeleteTap: () {},
              onSetDefaultTap: () {},
            ),
          );
        }),
      ],
    );
  }

  Widget _buildCurrentLocationButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.45),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                Icons.near_me,
                size: 18,
                color: Colors.blue.shade500,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Use Current Location',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue.shade500,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: 20,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
}
