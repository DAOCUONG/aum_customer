import 'package:flutter/material.dart';
import '../atoms/glass_button.dart';
import '../theme/glass_design_system.dart';

/// Glass Reward Card for displaying available rewards
class GlassRewardCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String points;
  final String emoji;
  final Color emojiGradientStart;
  final Color emojiGradientEnd;
  final bool isLocked;
  final VoidCallback? onRedeemTap;

  const GlassRewardCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.points,
    required this.emoji,
    required this.emojiGradientStart,
    required this.emojiGradientEnd,
    this.isLocked = false,
    this.onRedeemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isLocked
            ? Colors.white.withValues(alpha: 0.3)
            : Colors.white.withValues(alpha: 0.5),
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        border: Border.all(color: Colors.white.withValues(alpha: 0.6)),
        boxShadow: isLocked ? null : [glassShadow],
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              gradient: isLocked
                  ? null
                  : LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [emojiGradientStart, emojiGradientEnd],
                    ),
              color: isLocked ? Colors.grey.shade100 : null,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
            ),
            child: Center(
              child: Opacity(
                opacity: isLocked ? 0.5 : 1.0,
                child: Text(
                  emoji,
                  style: const TextStyle(
                    fontSize: 28,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: isLocked ? textPrimary.withValues(alpha: 0.6) : textPrimary,
                  ),
                ),
                if (subtitle.isNotEmpty)
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: textSecondary,
                    ),
                  ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.bolt,
                      size: 14,
                      color: isLocked ? Colors.grey.shade400 : primaryColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      points,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: isLocked ? Colors.grey.shade400 : primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (isLocked)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Locked',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey.shade400,
                ),
              ),
            )
          else
            GlassButton(
              onPressed: onRedeemTap ?? () {},
              label: 'Redeem',
              height: 36,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
        ],
      ),
    );
  }
}

/// Glass Progress Card for membership tier
class GlassProgressCard extends StatelessWidget {
  final String currentPoints;
  final String tierName;
  final String nextTierName;
  final String pointsNeeded;
  final double progress;

  const GlassProgressCard({
    super.key,
    required this.currentPoints,
    required this.tierName,
    required this.nextTierName,
    required this.pointsNeeded,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFF9466), Color(0xFFF2709C)],
        ),
        borderRadius: const BorderRadius.all(Radius.circular(40)),
        border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFF2709C).withValues(alpha: 0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Balance',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.white.withValues(alpha: 0.9),
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                currentPoints,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'pts',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withValues(alpha: 0.9),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Text(
                tierName,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withValues(alpha: 0.9),
                ),
              ),
              const Spacer(),
              Text(
                '$pointsNeeded for $nextTierName',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withValues(alpha: 0.9),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Stack(
            children: [
              Container(
                height: 10,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              Container(
                height: 10,
                width: MediaQuery.of(context).size.width * progress,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withValues(alpha: 0.5),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'You need $pointsNeeded more points to reach $nextTierName status',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }
}

/// Glass Referral Code Card
class GlassReferralCodeCard extends StatelessWidget {
  final String code;
  final VoidCallback onCopyTap;

  const GlassReferralCodeCard({
    super.key,
    required this.code,
    required this.onCopyTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.4),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(
          color: primaryColor.withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          Text(
            'Your Referral Code',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: textSecondary,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    code,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                GlassButton.primary(
                  onPressed: onCopyTap,
                  icon: Icons.content_copy,
                  iconSize: 16,
                  height: 36,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Glass Share Button
class GlassShareButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final VoidCallback onTap;

  const GlassShareButton({
    super.key,
    required this.icon,
    required this.color,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: Colors.white.withValues(alpha: 0.6)),
              boxShadow: [glassShadow],
            ),
            child: Icon(
              icon,
              size: 24,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

/// Glass Referral Item Card
class GlassReferralItem extends StatelessWidget {
  final String initials;
  final Color avatarColor;
  final String name;
  final String dateText;
  final bool isJoined;
  final VoidCallback? onResendTap;

  const GlassReferralItem({
    super.key,
    required this.initials,
    required this.avatarColor,
    required this.name,
    required this.dateText,
    required this.isJoined,
    this.onResendTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.5),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        border: Border.all(color: Colors.white.withValues(alpha: 0.6)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: avatarColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: Center(
              child: Text(
                initials,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: avatarColor,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: textPrimary,
                  ),
                ),
                Text(
                  dateText,
                  style: TextStyle(
                    fontSize: 11,
                    color: textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: isJoined
                  ? successGreen.withValues(alpha: 0.15)
                  : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isJoined
                    ? successGreen.withValues(alpha: 0.3)
                    : Colors.grey.shade200,
              ),
            ),
            child: Text(
              isJoined ? 'Joined' : 'Pending',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: isJoined ? successGreen : Colors.grey.shade500,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
