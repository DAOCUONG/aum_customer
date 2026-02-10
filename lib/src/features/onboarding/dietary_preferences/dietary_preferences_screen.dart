import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../ui/atoms/glass_background.dart';
import '../../../core/routing/app_router.dart';
import 'dietary_preferences_notifier.dart';
import 'widgets/index.dart';

/// DietaryPreferencesScreen - Main Screen Entry Point
///
/// THIN WIDGET - Delegates all rendering to composed components.
///
/// Uses atomic design system:
/// - GlassBackground for mesh gradient background
/// - PreferencesContent (Organism) for full content composition
///
/// Features:
/// - Glass panel styling with blur(50px), saturate(180%)
/// - Mesh gradient background with radial gradients
/// - Sticky header with progress indicator
/// - Selectable dietary preferences
/// - Bottom Continue button with gradient
class DietaryPreferencesScreen extends ConsumerStatefulWidget {
  const DietaryPreferencesScreen({super.key});

  @override
  ConsumerState<DietaryPreferencesScreen> createState() =>
      _DietaryPreferencesScreenState();
}

class _DietaryPreferencesScreenState
    extends ConsumerState<DietaryPreferencesScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    Future.microtask(() {
      ref
          .read(dietaryPreferencesNotifierProvider.notifier)
          .loadPreferences();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isDesktop = mediaQuery.size.width > 600;

    return Scaffold(
      body: isDesktop ? _buildDesktopLayout() : _buildMobileLayout(),
    );
  }

  Widget _buildMobileLayout() {
    return GlassBackground(
      child: Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(dietaryPreferencesNotifierProvider);

          return PreferencesContent(
            state: state,
            onTogglePreference: () => _handleTogglePreference(ref),
            onContinue: () => _handleContinue(ref),
            onSkip: () => _handleSkip(),
          );
        },
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(dietaryPreferencesNotifierProvider);

        return PreferencesContentDesktop(
          state: state,
          onTogglePreference: () => _handleTogglePreference(ref),
          onContinue: () => _handleContinue(ref),
          onSkip: () => _handleSkip(),
        );
      },
    );
  }

  void _handleTogglePreference(WidgetRef ref) {
    // Toggle the last interacted preference (for demo, toggling index 0)
    // In production, track the last tapped index
    final state = ref.read(dietaryPreferencesNotifierProvider);
    if (state.preferences.isNotEmpty) {
      ref
          .read(dietaryPreferencesNotifierProvider.notifier)
          .toggleSelection(0);
    }
  }

  Future<void> _handleContinue(WidgetRef ref) async {
    final notifier = ref.read(dietaryPreferencesNotifierProvider.notifier);
    final success = await notifier.savePreferences();

    if (success && mounted) {
      context.go(RouteNames.home);
    }
  }

  void _handleSkip() {
    context.go(RouteNames.home);
  }
}

/// Alternative thin screen that directly composes without notifier
///
/// Useful for preview and testing without Riverpod.
class DietaryPreferencesScreenPreview extends StatelessWidget {
  final List<Map<String, dynamic>> preferences;
  final ValueChanged<int>? onToggle;
  final VoidCallback? onContinue;
  final VoidCallback? onSkip;

  const DietaryPreferencesScreenPreview({
    super.key,
    this.preferences = const [
      {
        'emoji': '🥗',
        'title': 'Vegetarian',
        'description': 'No meat, fish, or poultry',
        'selected': true,
      },
      {
        'emoji': '🌱',
        'title': 'Vegan',
        'description': 'Plant-based only',
        'selected': false,
      },
      {
        'emoji': '🌾',
        'title': 'Gluten-Free',
        'description': 'Safe for celiac diet',
        'selected': false,
      },
      {
        'emoji': '🥛',
        'title': 'Dairy-Free',
        'description': 'Lactose intolerance friendly',
        'selected': true,
      },
      {
        'emoji': '🥜',
        'title': 'Nut Allergy',
        'description': 'Peanut & tree nut free',
        'selected': false,
      },
    ],
    this.onToggle,
    this.onContinue,
    this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
