import 'package:flutter/material.dart';
import '../theme/glass_theme.dart';
import '../atoms/glass_card.dart';
import '../atoms/glass_icon_button.dart';
import '../molecules/glass_search_bar.dart';
import '../molecules/glass_avatar.dart';

/// UserHomeHeader - Header with profile, greeting, and search
///
/// Displays user info with avatar, greeting, and search bar
class UserHomeHeader extends StatefulWidget {
  final String greeting;
  final String userName;
  final String? userImageUrl;
  final GlassAvatarStatus? userStatus;
  final VoidCallback? onNotificationTap;
  final int notificationCount;
  final VoidCallback? onSearchTap;
  final String searchPlaceholder;
  final VoidCallback? onProfileTap;
  final bool showSearch;

  const UserHomeHeader({
    super.key,
    this.greeting = 'Good Morning',
    required this.userName,
    this.userImageUrl,
    this.userStatus,
    this.onNotificationTap,
    this.notificationCount = 0,
    this.onSearchTap,
    this.searchPlaceholder = 'What are you craving?',
    this.onProfileTap,
    this.showSearch = true,
  });

  @override
  State<UserHomeHeader> createState() => _UserHomeHeaderState();
}

class _UserHomeHeaderState extends State<UserHomeHeader> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GlassAvatar(
                    imageUrl: widget.userImageUrl,
                    size: 52,
                    avatarSize: GlassAvatarSize.medium,
                    status: widget.userStatus,
                    onTap: widget.onProfileTap,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.greeting,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: theme.textSecondary,
                          letterSpacing: 0.3,
                        ),
                      ),
                      Text(
                        widget.userName,
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
                onPressed: widget.onNotificationTap,
                icon: Icon(
                  Icons.notifications,
                  size: 22,
                  color: theme.textSecondary,
                ),
                size: 44,
                badgeText: widget.notificationCount > 0
                    ? (widget.notificationCount > 99
                        ? '99+'
                        : widget.notificationCount.toString())
                    : null,
                badgeColor: GlassTheme.primary,
                badgeTextColor: Colors.white,
              ),
            ],
          ),
        ),
        if (widget.showSearch)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GlassSearchBar(
              controller: _searchController,
              hint: widget.searchPlaceholder,
              onTap: widget.onSearchTap,
            ),
          ),
      ],
    );
  }
}

/// Compact header without search
class CompactHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onBackTap;
  final List<Widget>? actions;
  final bool centerTitle;

  const CompactHeader({
    super.key,
    required this.title,
    this.onBackTap,
    this.actions,
    this.centerTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: BoxDecoration(
        color: theme.glassSurface.withOpacity(0.7),
        border: Border(
          bottom: BorderSide(
            color: theme.glassBorder.withOpacity(0.5),
          ),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            if (onBackTap != null)
              GlassBackButton(onPressed: onBackTap),
            Expanded(
              child: centerTitle
                  ? Center(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: theme.textPrimary,
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: theme.textPrimary,
                        ),
                      ),
                    ),
            ),
            if (actions != null) ...actions!,
          ],
        ),
      ),
    );
  }
}

/// Navigation rail for bottom navigation
class GlassNavBar extends StatefulWidget {
  final List<GlassNavItem> items;
  final int selectedIndex;
  final Function(int) onItemTapped;
  final double height;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;

  const GlassNavBar({
    super.key,
    required this.items,
    this.selectedIndex = 0,
    required this.onItemTapped,
    this.height = 80,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
  });

  @override
  State<GlassNavBar> createState() => _GlassNavBarState();
}

class GlassNavItem {
  final IconData icon;
  final IconData? selectedIcon;
  final String? label;
  final int? badgeCount;
  final bool showBadge;

  GlassNavItem({
    required this.icon,
    this.selectedIcon,
    this.label,
    this.badgeCount,
    this.showBadge = false,
  });
}

class _GlassNavBarState extends State<GlassNavBar> {
  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);
    final selectedColor = widget.selectedItemColor ?? GlassTheme.primary;
    final unselectedColor = widget.unselectedItemColor ?? theme.textTertiary;

    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.backgroundColor ??
            theme.glassSurface.withOpacity(0.8),
        border: Border(
          top: BorderSide(
            color: theme.glassBorder.withOpacity(0.5),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(widget.items.length, (index) {
          final item = widget.items[index];
          final isSelected = index == widget.selectedIndex;

          return Expanded(
            child: GestureDetector(
              onTap: () => widget.onItemTapped(index),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Icon(
                          isSelected
                              ? (item.selectedIcon ?? item.icon)
                              : item.icon,
                          size: 24,
                          color: isSelected ? selectedColor : unselectedColor,
                        ),
                        if (item.showBadge && (item.badgeCount ?? 0) > 0)
                          Positioned(
                            top: -4,
                            right: -4,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: GlassTheme.primary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '${item.badgeCount}',
                                style: const TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    if (item.label != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        item.label!,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w500,
                          color: isSelected ? selectedColor : unselectedColor,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

/// Floating header with blur effect
class FloatingHeader extends StatelessWidget {
  final Widget child;
  final double height;
  final bool showDivider;

  const FloatingHeader({
    super.key,
    required this.child,
    this.height = 120,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return Container(
      height: height,
      decoration: BoxDecoration(
        color: theme.glassSurface.withOpacity(0.85),
        border: showDivider
            ? Border(
                bottom: BorderSide(
                  color: theme.glassBorder.withOpacity(0.5),
                ),
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: child,
      ),
    );
  }
}
