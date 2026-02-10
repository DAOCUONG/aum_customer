import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../ui/atoms/glass_search_bar.dart';
import '../../../../ui/atoms/glass_icon_button.dart';
import '../../../../ui/molecules/glass_bottom_nav.dart';
import '../../../../ui/theme/glass_design_system.dart';
import '../providers/home_notifier.dart';
import '../widgets/home_content.dart';

/// Home Screen - Main food ordering screen
/// Refactored to use ConsumerWidget with Riverpod for state management
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
                // Content
                Expanded(
                  child: _buildContent(homeState, notifier),
                ),
              ],
            ),
          ),
          // Bottom Navigation
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _BottomNavBar(),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(HomeState homeState, HomeNotifier notifier) {
    return homeState.map(
      initial: (_) => const SizedBox.shrink(),
      loading: (_) => const Center(
        child: CircularProgressIndicator(color: primaryColor),
      ),
      loaded: (state) => HomeContent(
        categories: state.categories,
        recommendedFoods: state.recommendedFoods,
        fastDeliveryRestaurants: state.fastDeliveryRestaurants,
        onCategoryTap: _onCategoryTap,
        onFoodTap: _onFoodTap,
        onRestaurantTap: _onRestaurantTap,
        onSeeAllRestaurantsTap: _onSeeAllRestaurantsTap,
      ),
      error: (state) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              state.message,
              style: const TextStyle(color: errorRed),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: notifier.refresh,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

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
              children: [
                const Icon(Icons.notifications, size: 24),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: errorRed,
                      borderRadius: BorderRadius.circular(4),
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

  // Navigation handlers
  void _onMenuPressed() {}
  void _onNotificationPressed() {}
  void _onProfilePressed() {}
  void _onLocationPressed() {}

  void _onCategoryTap() {}
  void _onFoodTap() {}
  void _onRestaurantTap() {}
  void _onSeeAllRestaurantsTap() {}
}

/// Separate widget for bottom nav bar to manage its own state
class _BottomNavBar extends StatefulWidget {
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
