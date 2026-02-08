import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../atoms/glass_button.dart';
import '../../../molecules/glass_rewards_components.dart';
import '../../../theme/glass_design_system.dart';

class ReferralProgramScreen extends StatefulWidget {
  const ReferralProgramScreen({super.key});

  @override
  State<ReferralProgramScreen> createState() => _ReferralProgramScreenState();
}

class _ReferralProgramScreenState extends State<ReferralProgramScreen> {
  bool _copied = false;

  final List<Map<String, dynamic>> _referrals = [
    {
      'initials': 'JD',
      'name': 'John Doe',
      'dateText': 'Invited 2 days ago',
      'avatarColor': Colors.indigo,
      'isJoined': true,
    },
    {
      'initials': 'MK',
      'name': 'Mike K.',
      'dateText': 'Invited yesterday',
      'avatarColor': Colors.pink,
      'isJoined': false,
    },
    {
      'initials': 'AS',
      'name': 'Anna Smith',
      'dateText': 'Invited 1 week ago',
      'avatarColor': Colors.orange,
      'isJoined': true,
    },
    {
      'initials': 'TR',
      'name': 'Tom R.',
      'dateText': 'Reminder sent',
      'avatarColor': Colors.blue,
      'isJoined': false,
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
                  children: [
                    const SizedBox(height: 24),
                    // Hero section
                    _buildHeroSection(),
                    const SizedBox(height: 24),
                    // Referral code card
                    GlassReferralCodeCard(
                      code: 'SARAH-J24',
                      onCopyTap: _copyCode,
                    ),
                    const SizedBox(height: 32),
                    // Share buttons
                    _buildShareButtons(),
                    const SizedBox(height: 40),
                    // Referrals section
                    _buildReferralsSection(),
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
        color: Colors.white.withValues(alpha: 0.5),
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
                'Invite Friends',
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

  Widget _buildHeroSection() {
    return Column(
      children: [
        // Animated gift icon
        Container(
          width: 160,
          height: 160,
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              colors: [
                Color(0xFFBBDEFB),
                Color(0xFFFFCCBC),
                Color(0xFFE1BEE7),
              ],
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.6)),
                ),
                child: const Icon(
                  Icons.card_giftcard,
                  size: 64,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'Give ',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: textPrimary,
                ),
              ),
              TextSpan(
                text: '\$10',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: primaryColor,
                ),
              ),
              TextSpan(
                text: ',\nGet ',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: textPrimary,
                ),
              ),
              TextSpan(
                text: '1000 Points!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Share your unique code with friends. They get a discount, and you earn rewards.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            color: textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildShareButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GlassShareButton(
          icon: Icons.chat_bubble,
          color: Colors.green.shade600,
          label: 'Messages',
          onTap: _shareViaMessages,
        ),
        const SizedBox(width: 24),
        GlassShareButton(
          icon: Icons.mail,
          color: Colors.blue.shade500,
          label: 'Email',
          onTap: _shareViaEmail,
        ),
        const SizedBox(width: 24),
        GlassShareButton(
          icon: Icons.call,
          color: Colors.green.shade500,
          label: 'WhatsApp',
          onTap: _shareViaWhatsApp,
        ),
        const SizedBox(width: 24),
        GlassShareButton(
          icon: Icons.ios_share,
          color: Colors.grey.shade600,
          label: 'More',
          onTap: _shareMore,
        ),
      ],
    );
  }

  Widget _buildReferralsSection() {
    final pendingCount = _referrals.where((r) => !r['isJoined']).length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Your Referrals',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: textPrimary,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: primaryColor.withValues(alpha: 0.1),
                ),
              ),
              child: Text(
                '$pendingCount Pending',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...List.generate(_referrals.length, (index) {
          final referral = _referrals[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: GlassReferralItem(
              initials: referral['initials'] as String,
              avatarColor: referral['avatarColor'] as Color,
              name: referral['name'] as String,
              dateText: referral['dateText'] as String,
              isJoined: referral['isJoined'] as bool,
            ),
          );
        }),
      ],
    );
  }

  void _copyCode() {
    setState(() {
      _copied = true;
    });
    // In a real app, you'd use the clipboard package
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Code copied!'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _copied = false;
      });
    });
  }

  void _shareViaMessages() {
    // Implement messaging share
  }

  void _shareViaEmail() {
    // Implement email share
  }

  void _shareViaWhatsApp() {
    // Implement WhatsApp share
  }

  void _shareMore() {
    // Implement more share options
  }
}
