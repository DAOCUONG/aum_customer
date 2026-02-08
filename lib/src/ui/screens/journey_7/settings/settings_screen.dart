import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../atoms/glass_button.dart';
import '../../../molecules/glass_profile_components.dart';
import '../../../theme/glass_design_system.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushNotifications = true;
  bool _orderUpdates = true;
  bool _emailNewsletters = false;

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
                    const SizedBox(height: 16),
                    // Profile section
                    _buildProfileSection(),
                    const SizedBox(height: 24),
                    // Account section
                    const GlassSectionHeader(title: 'Account'),
                    const SizedBox(height: 8),
                    const GlassSettingsSection(
                      children: [
                        GlassSettingsRow(
                          icon: Icons.person,
                          iconColor: Colors.blue,
                          title: 'Personal Information',
                        ),
                        GlassSettingsRow(
                          icon: Icons.payments,
                          iconColor: Colors.indigo,
                          title: 'Payment Methods',
                        ),
                        GlassSettingsRow(
                          icon: Icons.location_on,
                          iconColor: Colors.orange,
                          title: 'Saved Addresses',
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Preferences section
                    const GlassSectionHeader(title: 'Preferences'),
                    const SizedBox(height: 8),
                    GlassSettingsSection(
                      children: [
                        GlassSettingsRow(
                          icon: Icons.language,
                          iconColor: Colors.grey,
                          title: 'Language',
                          subtitle: 'English',
                        ),
                        GlassSettingsRow(
                          icon: Icons.dark_mode,
                          iconColor: Colors.grey,
                          title: 'Dark Mode',
                          showDivider: false,
                          trailing: GlassToggleSwitch(
                            value: false,
                            onChanged: (value) {},
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Notifications section
                    const GlassSectionHeader(title: 'Notifications'),
                    const SizedBox(height: 8),
                    GlassSettingsSection(
                      children: [
                        GlassSettingsRow(
                          icon: Icons.notifications_active,
                          iconColor: Colors.red,
                          title: 'Push Notifications',
                          trailing: GlassToggleSwitch(
                            value: _pushNotifications,
                            onChanged: (value) {
                              setState(() {
                                _pushNotifications = value;
                              });
                            },
                          ),
                        ),
                        GlassSettingsRow(
                          icon: Icons.local_shipping,
                          iconColor: Colors.green,
                          title: 'Order Updates',
                          trailing: GlassToggleSwitch(
                            value: _orderUpdates,
                            onChanged: (value) {
                              setState(() {
                                _orderUpdates = value;
                              });
                            },
                          ),
                        ),
                        GlassSettingsRow(
                          icon: Icons.mail,
                          iconColor: Colors.amber.shade600,
                          title: 'Email Newsletters',
                          trailing: GlassToggleSwitch(
                            value: _emailNewsletters,
                            onChanged: (value) {
                              setState(() {
                                _emailNewsletters = value;
                              });
                            },
                          ),
                          showDivider: false,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // About section
                    const GlassSectionHeader(title: 'About'),
                    const SizedBox(height: 8),
                    const GlassSettingsSection(
                      children: [
                        GlassSettingsRow(
                          icon: Icons.help,
                          iconColor: Colors.purple,
                          title: 'Help & Support',
                        ),
                        GlassSettingsRow(
                          icon: Icons.privacy_tip,
                          iconColor: Colors.cyan,
                          title: 'Privacy Policy',
                        ),
                        GlassSettingsRow(
                          icon: Icons.info,
                          iconColor: Colors.teal,
                          title: 'Terms of Service',
                          showDivider: false,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Delete account button
                    _buildDeleteAccountButton(),
                    const SizedBox(height: 24),
                    // Version info
                    _buildVersionInfo(),
                    const SizedBox(height: 32),
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
                'Settings',
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

  Widget _buildProfileSection() {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(48),
                border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(44),
                child: Image.network(
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuDrTAbWkngsaWBd_eCoPqKD3VNe9NgtawbK7ttK39xPAlk5EDLkNcoEU_FzatGZaUokwVy1xh9EoeoeiVmGeGogKF_ns6UhnHsJSBoVyEg3LMbpXOSAXRgl7d1d_QmyjMf0lKw5DJN64xiIxrJNX-8B0bcLj78i8IYQHZEmad9NK9_TG118pFB5g4k1WBesBxGuWMEYfg-fw9v345KOsh_TpXa7YNywnsyOG-FUsIOuIiOQkJ2Sslx_1_ifUSFwXyUWMDGgreWk2Vk',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white),
                ),
                child: Icon(
                  Icons.edit,
                  size: 16,
                  color: Colors.blue.shade500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Text(
          'Sarah Jenkins',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: textPrimary,
          ),
        ),
        Text(
          'sarah.j@example.com',
          style: TextStyle(
            fontSize: 14,
            color: textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildDeleteAccountButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: errorRed.withValues(alpha: 0.05),
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          border: Border.all(
            color: errorRed.withValues(alpha: 0.1),
          ),
        ),
        child: const Center(
          child: Text(
            'Delete Account',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: errorRed,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVersionInfo() {
    return Center(
      child: Text(
        'Foodie Express v4.2.0 (Build 302)',
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey.shade400,
        ),
      ),
    );
  }
}
