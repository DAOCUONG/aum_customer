// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$homeNotifierHash() => r'd06f5a88193a651c7a9683e5fe6c5639574fa259';

/// Notifier for managing Home screen state with proper dependency injection.
///
/// Responsibilities:
/// - Load home data on initialization
/// - Handle loading, success, and error states
/// - Provide refresh capability for pull-to-refresh
/// - Clean up resources on disposal
///
/// Dependencies are injected via Riverpod for testability.
///
/// Copied from [HomeNotifier].
@ProviderFor(HomeNotifier)
final homeNotifierProvider =
    AutoDisposeNotifierProvider<HomeNotifier, HomeState>.internal(
      HomeNotifier.new,
      name: r'homeNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$homeNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$HomeNotifier = AutoDisposeNotifier<HomeState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
