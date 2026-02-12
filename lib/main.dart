import 'dart:async';
import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:aum_order/src/rust/frb_generated.dart';
import 'package:aum_order/src/core/routing/app_router.dart';

Future<void> main() async {
  await RustLib.init();
  runApp(const MyApp());
}

/// Maps route names to screen names
final _screenNames = {
  '/': 'SplashScreen',
  '/onboarding/discover': 'OnboardingDiscoverScreen',
  '/onboarding/order': 'OnboardingOrderScreen',
  '/onboarding/track': 'OnboardingTrackScreen',
  '/signIn': 'SignInScreen',
  '/locationPermission': 'LocationPermissionScreen',
  '/dietaryPreferences': 'DietaryPreferencesScreen',
  '/home': 'HomeScreen',
  '/search': 'SearchSuggestionsScreen',
  '/search/results': 'SearchResultsScreen',
  '/filter': 'FilterPanelScreen',
  '/restaurant': 'RestaurantDetailScreen',
  '/cart': 'ShoppingCartScreen',
  '/cart/empty': 'EmptyCartScreen',
  '/item/customize': 'ItemCustomizationScreen',
  '/checkout': 'CheckoutDetailsScreen',
  '/schedule-delivery': 'ScheduleDeliveryScreen',
  '/order-success': 'OrderSuccessScreen',
  '/live-tracking': 'LiveTrackingScreen',
  '/pickup-tracking': 'PickupTrackingScreen',
  '/order-rating': 'OrderRatingScreen',
  '/rating-detail': 'RatingDetailScreen',
  '/rewards-dashboard': 'RewardsDashboardScreen',
  '/referral-program': 'ReferralProgramScreen',
  '/settings': 'SettingsScreen',
  '/address-entry': 'AddressEntryScreen',
  '/order-history': 'OrderHistoryScreen',
  '/manage-addresses': 'ManageAddressesScreen',
  '/profile': 'ProfileOverviewScreen',
};

String _previousRoute = '';

void _logRoute(String route) {
  if (_previousRoute == route) return;
  _previousRoute = route;

  final screenName = _screenNames[route] ?? 'UnknownScreen';
  print('📱 ENTER: $screenName');
}

/// Monitors route changes using GoRouter's routeInformationProvider
class RouteObserverWidget extends StatefulWidget {
  final Widget child;
  const RouteObserverWidget({required this.child, super.key});

  @override
  State<RouteObserverWidget> createState() => _RouteObserverWidgetState();
}

class _RouteObserverWidgetState extends State<RouteObserverWidget> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startMonitoring();
  }

  void _startMonitoring() {
    _timer = Timer.periodic(const Duration(milliseconds: 200), (_) {
      if (!mounted) return;
      _checkRoute();
    });
  }

  void _checkRoute() {
    final route = appRouter.routeInformationProvider.value.uri.toString();
    _logRoute(route);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _checkRoute();
    return widget.child;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: RouteObserverWidget(
        child: MaterialApp.router(
          routerConfig: appRouter,
          title: 'Foodie Express',
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
