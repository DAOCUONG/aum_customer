import 'package:flutter/material.dart';
import '../theme/glass_theme.dart';
import '../atoms/glass_card.dart';
import '../atoms/glass_divider.dart';
import '../molecules/glass_search_bar.dart';
import '../molecules/glass_category_item.dart';
import '../organisms/user_home_header.dart';
import '../organisms/category_rail.dart';
import '../organisms/featured_item_card.dart';

/// FeedLayout - Grid feed layout template
///
/// Complete layout template for grid feed pages
class FeedLayout extends StatefulWidget {
  final String userName;
  final String greeting;
  final String? userImageUrl;
  final List<CategoryItem> categories;
  final int selectedCategoryIndex;
  final Function(int) onCategorySelected;
  final List<Widget> feedItems;
  final VoidCallback? onSearchTap;
  final VoidCallback? onNotificationTap;
  final int notificationCount;
  final VoidCallback? onProfileTap;
  final String searchPlaceholder;
  final bool showSearch;
  final bool showCategories;
  final Widget? customHeader;
  final Widget? customBottomNav;
  final ScrollController? scrollController;
  final bool isLoading;
  final VoidCallback? onRefresh;

  const FeedLayout({
    super.key,
    required this.userName,
    this.greeting = 'Good Morning',
    this.userImageUrl,
    required this.categories,
    this.selectedCategoryIndex = 0,
    required this.onCategorySelected,
    required this.feedItems,
    this.onSearchTap,
    this.onNotificationTap,
    this.notificationCount = 0,
    this.onProfileTap,
    this.searchPlaceholder = 'What are you craving?',
    this.showSearch = true,
    this.showCategories = true,
    this.customHeader,
    this.customBottomNav,
    this.scrollController,
    this.isLoading = false,
    this.onRefresh,
  });

  @override
  State<FeedLayout> createState() => _FeedLayoutState();
}

class _FeedLayoutState extends State<FeedLayout> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController ?? ScrollController();
  }

  @override
  void dispose() {
    if (widget.scrollController == null) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return Scaffold(
      backgroundColor: theme.background,
      body: Stack(
        children: [
          // Background gradient
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0.3, -0.3),
                  colors: [
                    GlassTheme.primary.withOpacity(0.08),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 1.0],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: RadialGradient(
                center: const Alignment(-0.5, 1.0),
                colors: [
                  const Color(0xFFE6F4FF).withOpacity(0.5),
                  Colors.transparent,
                ],
                stops: const [0.0, 1.0],
              ),
            ),
          ),

          // Main content
          Column(
            children: [
              // Header
              widget.customHeader ??
                  UserHomeHeader(
                    greeting: widget.greeting,
                    userName: widget.userName,
                    userImageUrl: widget.userImageUrl,
                    onNotificationTap: widget.onNotificationTap,
                    notificationCount: widget.notificationCount,
                    onProfileTap: widget.onProfileTap,
                    searchPlaceholder: widget.searchPlaceholder,
                    showSearch: widget.showSearch,
                  ),

              // Content
              Expanded(
                child: RefreshIndicator(
                  onRefresh: widget.onRefresh ?? () async {},
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Categories
                        if (widget.showCategories && widget.categories.isNotEmpty)
                          CategoryRail(
                            categories: widget.categories,
                            selectedIndex: widget.selectedCategoryIndex,
                            onSelect: widget.onCategorySelected,
                            itemSize: 64,
                          ),

                        // Featured section
                        if (widget.feedItems.isNotEmpty) ...[
                          const SizedBox(height: 20),
                          _buildSectionHeader(context, 'Featured'),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 260,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              itemCount: widget.feedItems.take(4).length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(width: 12),
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  width: 200,
                                  child: widget.feedItems[index],
                                );
                              },
                            ),
                          ),
                        ],

                        // All items grid
                        if (widget.feedItems.isNotEmpty) ...[
                          const SizedBox(height: 24),
                          _buildSectionHeader(context, 'All Items'),
                          const SizedBox(height: 12),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20),
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.75,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                              ),
                              itemCount: widget.feedItems.length,
                              itemBuilder: (context, index) {
                                return widget.feedItems[index];
                              },
                            ),
                          ),
                        ],

                        // Loading state
                        if (widget.isLoading)
                          const Padding(
                            padding: EdgeInsets.all(40),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),

                        // Bottom spacing
                        const SizedBox(height: 120),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Custom bottom nav
          if (widget.customBottomNav != null)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: widget.customBottomNav!,
            ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    final theme = GlassTheme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: theme.textPrimary,
            ),
          ),
          const Spacer(),
          Text(
            'See all',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: theme.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

/// Masonry grid layout
class MasonryFeedLayout extends StatelessWidget {
  final List<Widget> items;
  final int columnCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final ScrollController? scrollController;

  const MasonryFeedLayout({
    super.key,
    required this.items,
    this.columnCount = 2,
    this.crossAxisSpacing = 12,
    this.mainAxisSpacing = 12,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return GridView.builder(
      controller: scrollController,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columnCount,
        childAspectRatio: 0.8,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return items[index];
      },
    );
  }
}

/// List feed layout
class ListFeedLayout extends StatelessWidget {
  final List<Widget> items;
  final ScrollController? scrollController;
  final bool showDividers;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onRefresh;

  const ListFeedLayout({
    super.key,
    required this.items,
    this.scrollController,
    this.showDividers = true,
    this.padding = const EdgeInsets.symmetric(horizontal: 20),
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh ?? () async {},
      child: ListView.separated(
        controller: scrollController,
        padding: padding,
        itemCount: items.length,
        separatorBuilder: (context, index) =>
            showDividers ? const SizedBox(height: 16) : const SizedBox.shrink(),
        itemBuilder: (context, index) {
          return items[index];
        },
      ),
    );
  }
}

/// Horizontal scroll feed
class HorizontalFeedLayout extends StatelessWidget {
  final List<Widget> items;
  final EdgeInsetsGeometry padding;
  final double itemWidth;
  final ScrollController? scrollController;

  const HorizontalFeedLayout({
    super.key,
    required this.items,
    this.padding = const EdgeInsets.symmetric(horizontal: 20),
    this.itemWidth = 180,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: itemWidth + 60,
      child: ListView.separated(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        padding: padding,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return SizedBox(
            width: itemWidth,
            child: items[index],
          );
        },
      ),
    );
  }
}

/// Section with header and content
class FeedSection extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<Widget> items;
  final VoidCallback? onSeeAllTap;
  final EdgeInsetsGeometry? padding;
  final Widget Function(BuildContext, int)? itemBuilder;
  final int itemCount;
  final Axis scrollDirection;
  final double? itemWidth;
  final bool showDivider;

  const FeedSection({
    super.key,
    required this.title,
    this.subtitle,
    required this.items,
    this.onSeeAllTap,
    this.padding,
    this.itemBuilder,
    required this.itemCount,
    this.scrollDirection = Axis.horizontal,
    this.itemWidth,
    this.showDivider = true,
  }) : assert(
           (itemBuilder == null && items.isNotEmpty) ||
               (itemBuilder != null && itemCount > 0),
         );

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: theme.textPrimary,
                      ),
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle!,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: theme.textSecondary,
                        ),
                      ),
                  ],
                ),
              ),
              if (onSeeAllTap != null)
                GestureDetector(
                  onTap: onSeeAllTap,
                  child: Text(
                    'See all',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: theme.primaryColor,
                    ),
                  ),
                ),
            ],
          ),
        ),
        if (showDivider) ...[
          const SizedBox(height: 4),
          Padding(
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 20),
            child: GlassDivider(variant: GlassDividerVariant.dashed),
          ),
        ],
        const SizedBox(height: 12),
        if (scrollDirection == Axis.horizontal)
          SizedBox(
            height: itemWidth != null ? itemWidth! + 80 : 220,
            child: ListView.separated(
              scrollDirection: scrollDirection,
              padding: padding ?? const EdgeInsets.symmetric(horizontal: 20),
              itemCount: itemBuilder != null ? itemCount : items.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: itemBuilder ??
                  (context, index) {
                    return SizedBox(
                      width: itemWidth ?? 180,
                      child: items[index],
                    );
                  },
            ),
          )
        else
          ...items,
      ],
    );
  }
}
