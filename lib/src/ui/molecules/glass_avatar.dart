import 'package:flutter/material.dart';
import '../theme/glass_theme.dart';

/// GlassAvatar - Profile avatar with status indicator
///
/// Displays user avatar with optional status badge
class GlassAvatar extends StatefulWidget {
  final String? imageUrl;
  final double size;
  final GlassAvatarSize avatarSize;
  final GlassAvatarStatus? status;
  final Color? statusColor;
  final VoidCallback? onTap;
  final bool showBorder;
  final Color? borderColor;
  final double borderWidth;
  final Widget? customStatusWidget;

  const GlassAvatar({
    super.key,
    this.imageUrl,
    this.size = 48,
    this.avatarSize = GlassAvatarSize.medium,
    this.status,
    this.statusColor,
    this.onTap,
    this.showBorder = true,
    this.borderColor,
    this.borderWidth = 2,
    this.customStatusWidget,
  });

  const GlassAvatar.small({
    super.key,
    this.imageUrl,
    this.size = 40,
    this.avatarSize = GlassAvatarSize.small,
    this.status,
    this.statusColor,
    this.onTap,
    this.showBorder = true,
    this.borderWidth = 2,
    this.customStatusWidget,
  }) : borderColor = null;

  const GlassAvatar.medium({
    super.key,
    this.imageUrl,
    this.size = 56,
    this.avatarSize = GlassAvatarSize.medium,
    this.status,
    this.statusColor,
    this.onTap,
    this.showBorder = true,
    this.borderWidth = 2,
    this.customStatusWidget,
  }) : borderColor = null;

  const GlassAvatar.large({
    super.key,
    this.imageUrl,
    this.size = 80,
    this.avatarSize = GlassAvatarSize.large,
    this.status,
    this.statusColor,
    this.onTap,
    this.showBorder = true,
    this.borderWidth = 3,
    this.customStatusWidget,
  }) : borderColor = null;

  @override
  State<GlassAvatar> createState() => _GlassAvatarState();
}

enum GlassAvatarSize {
  small,
  medium,
  large,
}

enum GlassAvatarStatus {
  online,
  offline,
  away,
  busy,
}

class _GlassAvatarState extends State<GlassAvatar> {
  bool _isPressed = false;

  void _handleTapDown(TapDownDetails details) {
    if (widget.onTap != null) {
      setState(() => _isPressed = true);
    }
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);
    final effectiveBorderColor =
        widget.borderColor ?? theme.glassBorder.withOpacity(0.6);
    final effectiveStatusColor = widget.statusColor ?? _getStatusColor(theme);
    final statusSize = widget.size * 0.25;

    Widget avatarContent;

    if (widget.imageUrl != null && widget.imageUrl!.isNotEmpty) {
      avatarContent = ClipRRect(
        borderRadius: BorderRadius.circular(widget.size / 2),
        child: Image.network(
          widget.imageUrl!,
          fit: BoxFit.cover,
          width: widget.size,
          height: widget.size,
          errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return Center(
              child: SizedBox(
                width: widget.size * 0.3,
                height: widget.size * 0.3,
                child: const CircularProgressIndicator(strokeWidth: 2),
              ),
            );
          },
        ),
      );
    } else {
      avatarContent = _buildPlaceholder();
    }

    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        transform:
            _isPressed ? Matrix4.translationValues(0, 2, 0) : Matrix4.identity(),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                border: widget.showBorder
                    ? Border.all(
                        color: effectiveBorderColor,
                        width: widget.borderWidth,
                      )
                    : null,
                borderRadius: BorderRadius.circular(widget.size / 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: avatarContent,
            ),
            if (widget.status != null || widget.customStatusWidget != null)
              Positioned(
                bottom: 0,
                right: 0,
                child: widget.customStatusWidget ??
                    Container(
                      width: statusSize + 6,
                      height: statusSize + 6,
                      decoration: BoxDecoration(
                        color: theme.glassSurface,
                        borderRadius: BorderRadius.circular((statusSize + 6) / 2),
                        border: Border.all(
                          color: effectiveBorderColor,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Container(
                          width: statusSize,
                          height: statusSize,
                          decoration: BoxDecoration(
                            color: effectiveStatusColor,
                            borderRadius: BorderRadius.circular(statusSize / 2),
                          ),
                        ),
                      ),
                    ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.grey.shade300,
            Colors.grey.shade400,
          ],
        ),
        borderRadius: BorderRadius.circular(widget.size / 2),
      ),
      child: Icon(
        Icons.person,
        size: widget.size * 0.5,
        color: Colors.white,
      ),
    );
  }

  Color _getStatusColor(GlassTheme theme) {
    switch (widget.status) {
      case GlassAvatarStatus.online:
        return const Color(0xFF34C759);
      case GlassAvatarStatus.offline:
        return const Color(0xFF8E8E93);
      case GlassAvatarStatus.away:
        return const Color(0xFFFF9500);
      case GlassAvatarStatus.busy:
        return const Color(0xFFFF3B30);
      case null:
        return Colors.transparent;
    }
  }
}

/// User info row with avatar and name
class GlassUserRow extends StatelessWidget {
  final String name;
  final String? subtitle;
  final String? imageUrl;
  final GlassAvatarStatus? status;
  final VoidCallback? onTap;
  final VoidCallback? onActionTap;
  final IconData? actionIcon;
  final GlassAvatarSize avatarSize;

  const GlassUserRow({
    super.key,
    required this.name,
    this.subtitle,
    this.imageUrl,
    this.status,
    this.onTap,
    this.onActionTap,
    this.actionIcon,
    this.avatarSize = GlassAvatarSize.medium,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);
    final avatarSizes = {
      GlassAvatarSize.small: 40.0,
      GlassAvatarSize.medium: 48.0,
      GlassAvatarSize.large: 56.0,
    };
    final avatarSize = avatarSizes[avatarSize] ?? 48.0;

    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          GlassAvatar(
            imageUrl: imageUrl,
            size: avatarSize,
            avatarSize: avatarSize,
            status: status,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: theme.textPrimary,
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: theme.textSecondary,
                    ),
                  ),
              ],
            ),
          ),
          if (onActionTap != null && actionIcon != null)
            GlassIconButton.transparent(
              onPressed: onActionTap,
              icon: Icon(actionIcon, size: 22),
            ),
        ],
      ),
    );
  }
}

/// Avatar group for displaying multiple users
class GlassAvatarGroup extends StatelessWidget {
  final List<String?> imageUrls;
  final int maxDisplay;
  final double size;
  final double overlap;
  final bool showCount;

  const GlassAvatarGroup({
    super.key,
    required this.imageUrls,
    this.maxDisplay = 3,
    this.size = 36,
    this.overlap = 12,
    this.showCount = true,
  });

  @override
  Widget build(BuildContext context) {
    final displayCount = imageUrls.length > maxDisplay ? maxDisplay : imageUrls.length;
    final remaining = imageUrls.length - maxDisplay;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(displayCount, (index) {
        final margin = index > 0 ? -overlap : 0;
        return Container(
          margin: EdgeInsets.only(left: margin),
          child: GlassAvatar(
            imageUrl: imageUrls[index],
            size: size,
            avatarSize: GlassAvatarSize.small,
            showBorder: true,
            borderColor: Colors.white,
            borderWidth: 2,
          ),
        );
      }),
    );
  }
}

/// Profile header with avatar and greeting
class GlassProfileHeader extends StatelessWidget {
  final String greeting;
  final String userName;
  final String? imageUrl;
  final GlassAvatarStatus? status;
  final VoidCallback? onNotificationTap;
  final int notificationCount;

  const GlassProfileHeader({
    super.key,
    required this.greeting,
    required this.userName,
    this.imageUrl,
    this.status,
    this.onNotificationTap,
    this.notificationCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GlassAvatar(
              imageUrl: imageUrl,
              size: 52,
              avatarSize: GlassAvatarSize.medium,
              status: status,
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  greeting,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: theme.textSecondary,
                    letterSpacing: 0.3,
                  ),
                ),
                Text(
                  userName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: theme.textPrimary,
                  ),
                ),
              ],
            ),
          ],
        ),
        GlassIconButton.surface(
          onPressed: onNotificationTap,
          icon: Icon(
            Icons.notifications,
            size: 22,
            color: theme.textSecondary,
          ),
          size: 44,
          badgeText: notificationCount > 0
              ? (notificationCount > 99 ? '99+' : notificationCount.toString())
              : null,
          badgeColor: GlassTheme.primary,
          badgeTextColor: Colors.white,
        ),
      ],
    );
  }
}
