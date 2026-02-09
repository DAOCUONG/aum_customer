import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../ui/theme/glass_theme.dart';
import '../../../ui/atoms/glass_button.dart';
import '../../../core/providers/providers.dart';
import '../../../core/routing/app_router.dart';
import '../../../domain/entities/dietary_preference.dart';
import 'dietary_preferences_notifier.dart';
import 'dietary_preferences_state.dart';

/// Dietary Preferences Screen - Select dietary restrictions
class DietaryPreferencesScreen extends ConsumerWidget {
  const DietaryPreferencesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const DietaryPreferencesScreenContent();
  }
}

/// Dietary preferences screen content
class DietaryPreferencesScreenContent extends ConsumerStatefulWidget {
  const DietaryPreferencesScreenContent({super.key});

  @override
  ConsumerState<DietaryPreferencesScreenContent> createState() =>
      _DietaryPreferencesScreenContentState();
}

class _DietaryPreferencesScreenContentState
    extends ConsumerState<DietaryPreferencesScreenContent> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // Load available preferences after widget builds
    Future.microtask(() {
      ref.read(dietaryPreferencesNotifierProvider.notifier).loadPreferences();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dietaryPreferencesNotifierProvider);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: _buildBody(context, state),
    );
  }

  Widget _buildBody(BuildContext context, DietaryPreferencesState state) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.orange.shade50.withValues(alpha: 0.3),
            Colors.white.withValues(alpha: 0),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Mesh background
          _buildMeshBackground(),
          // Main content
          SafeArea(
            child: Column(
              children: [
                // Top bar
                _buildTopBar(context),
                // Content
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        // Step indicator
                        _buildStepIndicator(),
                        const SizedBox(height: 24),
                        // Title section
                        _buildTitleSection(),
                        const SizedBox(height: 24),
                        // Preferences list
                        if (state.isLoading)
                          const Center(child: CircularProgressIndicator())
                        else
                          _buildPreferencesList(state),
                        const SizedBox(height: 120),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Bottom button
          Positioned(
            bottom: 32,
            left: 24,
            right: 24,
            child: _buildContinueButton(context, state),
          ),
        ],
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
              Colors.orange.shade100.withValues(alpha: 0.8),
              Colors.blue.shade50.withValues(alpha: 0.8),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Step indicator
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.2),
              ),
            ),
            child: const Center(
              child: Text(
                '1/2',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: GlassTheme.textSecondary,
                ),
              ),
            ),
          ),
          // Skip button
          TextButton(
            onPressed: () {
              context.go(RouteNames.home);
            },
            child: Text(
              'Skip',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: GlassTheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStepDot(true),
        const SizedBox(width: 8),
        _buildStepDot(false),
      ],
    );
  }

  Widget _buildStepDot(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? GlassTheme.primary : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _buildTitleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Help us personalize',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            letterSpacing: -1,
            height: 1.1,
            color: GlassTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'your feed',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            letterSpacing: -1,
            height: 1.1,
            color: GlassTheme.primary,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Select any dietary preferences or allergies so we can curate the best food options for you.',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            height: 1.5,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildPreferencesList(DietaryPreferencesState state) {
    return Column(
      children: List.generate(
        state.preferences.length,
        (index) => _buildPreferenceItem(
          state.preferences[index],
          index,
          state,
        ),
      ),
    );
  }

  Widget _buildPreferenceItem(
    DietaryPreference item,
    int index,
    DietaryPreferencesState state,
  ) {
    final isSelected = item.isSelected;

    return GestureDetector(
      onTap: () {
        ref
            .read(dietaryPreferencesNotifierProvider.notifier)
            .toggleSelection(index);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFFFF4F0)
              : Colors.white.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? GlassTheme.primary : Colors.white.withValues(alpha: 0.6),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: GlassTheme.primary.withValues(alpha: 0.15),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            // Emoji icon
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  item.emoji,
                  style: const TextStyle(fontSize: 26),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: GlassTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.description,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            // Checkbox
            _buildCheckbox(isSelected),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckbox(bool isSelected) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: isSelected ? GlassTheme.primary : Colors.transparent,
        border: Border.all(
          color: isSelected ? GlassTheme.primary : const Color(0xFFD1D1D6),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: isSelected
          ? const Icon(
              Icons.check,
              size: 14,
              color: Colors.white,
            )
          : null,
    );
  }

  Widget _buildContinueButton(
      BuildContext context, DietaryPreferencesState state) {
    return GlassButton(
      onPressed: state.isSaving
          ? null
          : () async {
              final success = await ref
                  .read(dietaryPreferencesNotifierProvider.notifier)
                  .savePreferences();

              if (success && mounted) {
                context.go(RouteNames.home);
              }
            },
      label: 'Continue',
      icon: Icons.arrow_forward,
      height: 56,
      borderRadius: const BorderRadius.all(Radius.circular(18)),
      isLoading: state.isSaving,
    );
  }
}
