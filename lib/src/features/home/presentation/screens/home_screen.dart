import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/app_router.dart';
import '../../../../ui/atoms/glass_icon_button.dart';
import '../../../../ui/atoms/glass_search_bar.dart';
import '../../../../ui/atoms/shimmer_skeleton.dart';
import '../../../../ui/molecules/glass_bottom_nav.dart';
import '../../../../ui/theme/glass_design_system.dart';
import '../providers/home_notifier.dart';
import '../widgets/home_content.dart';

/// Home Screen - Main food ordering screen.
///
/// Uses ConsumerWidget with Riverpod for reactive state management.
/// Automatically loads data on initialization and handles all state transitions.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeNotifierProvider);
    final notifier = ref.read(homeNotifierProvider.notifier);

    return Scaffold(
      backgroundColor: backgroundLight,
      body: Stack(
        children: [
          // Mesh Background
          _buildMeshBackground(),
          // Main Content
          SafeArea(
            child: Column(
              children: [
                // Header
                _buildHeader(),
                // Search & Location
                _buildSearchLocationSection(context),
                // Content Area
                Expanded(
                  child: _buildContent(homeState, notifier.refresh),
                ),
              ],
            ),
          ),
          // Bottom Navigation
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _BottomNavBar(key: const ValueKey('bottom_nav')),
          ),
        ],
      ),
    );
  }

  /// Builds the appropriate content based on current state.
  Widget _buildContent(HomeState homeState, VoidCallback onRetry) {
    return homeState.map(
      initial: (_) => const SizedBox.shrink(),
      loading: (_) => const ShimmerHomeContent(),
      loaded: (state) => HomeContent(
        categories: state.categories,
        recommendedFoods: state.recommendedFoods,
        fastDeliveryRestaurants: state.fastDeliveryRestaurants,
        onCategoryTap: _onCategoryTap,
        onFoodTap: _onFoodTap,
        onRestaurantTap: _onRestaurantTap,
        onSeeAllRestaurantsTap: _onSeeAllRestaurantsTap,
      ),
      empty: (state) => _buildEmptyState(state),
      error: (state) => _buildErrorState(state, onRetry),
    );
  }

  /// Builds the error state with user-friendly message and retry action.
  Widget _buildErrorState(HomeError state, VoidCallback onRetry) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: errorRed,
            ),
            const SizedBox(height: 16),
            Text(
              state.message,
              style: const TextStyle(
                color: textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh, size: 20),
              label: const Text('Try Again'),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the empty state when no content is available.
  Widget _buildEmptyState(HomeEmpty state) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.restaurant_menu,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            const Text(
              'No Content Available',
              style: TextStyle(
                color: textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'We couldn\'t find any restaurants or food items at the moment. Please check back later.',
              style: TextStyle(
                color: textSecondary,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the mesh gradient background.
  Widget _buildMeshBackground() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topLeft,
            radius: 1.5,
            colors: [
              Colors.orange.shade100.withValues(alpha: 0.6),
              backgroundLight,
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the app header with menu, title, and profile.
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          GlassIconButton.transparent(
            onPressed: _onMenuPressed,
            icon: const Icon(Icons.menu, size: 24),
            size: 44,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [primaryColor, primaryLight],
              ).createShader(bounds),
              child: const Text(
                'Foodie Express',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          GlassIconButton(
            onPressed: _onNotificationPressed,
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.notifications, size: 24),
                Positioned(
                  top: -2,
                  right: -2,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: errorRed,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ],
            ),
            size: 44,
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: _onProfilePressed,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
                image: const DecorationImage(
                  image: NetworkImage('https://i.pravatar.cc/100'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the search bar and location section.
  Widget _buildSearchLocationSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        children: [
          GlassLocationBar(
            address: '8502 Preston Rd. Inglewood',
            onTap: _onLocationPressed,
          ),
          const SizedBox(height: 12),
          GlassSearchBar(
            hintText: 'Restaurants, dishes, or groceries',
            onFilterTap: () => context.push(RouteNames.filter),
          ),
        ],
      ),
    );
  }

  // Navigation handlers - currently empty, to be implemented
  void _onMenuPressed() {}
  void _onNotificationPressed() {}
  void _onProfilePressed() {}
  void _onLocationPressed() {}

  void _onCategoryTap() {}
  void _onFoodTap() {}
  void _onRestaurantTap() {}
  void _onSeeAllRestaurantsTap() {}
}

/// Separate widget for bottom navigation bar.
///
/// Uses StateMixin for internal state management.
class _BottomNavBar extends StatefulWidget {
  const _BottomNavBar({super.key});

  @override
  State<_BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<_BottomNavBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GlassBottomNavBar(
      currentIndex: _currentIndex,
      onTap: (index) => setState(() => _currentIndex = index),
    );
  }
}
