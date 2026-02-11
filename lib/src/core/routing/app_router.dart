import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/onboarding/splash/splash_screen.dart';
import '../../features/onboarding/onboarding_discover/onboarding_discover_screen.dart';
import '../../features/onboarding/onboarding_order/onboarding_order_screen.dart';
import '../../features/onboarding/onboarding_track/onboarding_track_screen.dart';
import '../../features/onboarding/sign_in/sign_in_screen.dart';
import '../../features/onboarding/location_permission/location_permission_screen.dart';
import '../../features/onboarding/dietary_preferences/dietary_preferences_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/search/presentation/screens/search_suggestions_screen.dart';
import '../../features/search/presentation/screens/search_results_screen.dart';
import '../../features/search/presentation/screens/filter_panel_screen.dart';
import '../../features/cart/presentation/screens/restaurant_detail_screen.dart';
import '../../features/cart/presentation/screens/shopping_cart_screen.dart';
import '../../features/cart/presentation/screens/empty_cart_screen.dart';
import '../../features/cart/presentation/screens/item_customization_screen.dart';
import '../../features/checkout/presentation/screens/checkout_details_screen.dart';
import '../../features/checkout/presentation/screens/schedule_delivery_screen.dart';
import '../../features/checkout/presentation/screens/order_success_screen.dart';
import '../../ui/screens/journey_5/live_tracking/live_tracking_screen.dart';
import '../../ui/screens/journey_5/pickup_tracking/pickup_tracking_screen.dart';
import '../../ui/screens/journey_5/order_rating/order_rating_screen.dart';
import '../../ui/screens/journey_5/rating_detail/rating_detail_screen.dart';
import '../../ui/screens/journey_6/rewards_dashboard/rewards_dashboard_screen.dart';
import '../../ui/screens/journey_6/referral_program/referral_program_screen.dart';
import '../../ui/screens/journey_7/settings/settings_screen.dart';
import '../../ui/screens/journey_7/address_entry/address_entry_screen.dart';
import '../../ui/screens/journey_7/order_history/order_history_screen.dart';
import '../../ui/screens/journey_7/manage_addresses/manage_addresses_screen.dart';
import '../../ui/screens/journey_7/profile_overview/profile_overview_screen.dart';

/// Route names constants
class RouteNames {
  static const String splash = '/';
  static const String onboardingDiscover = '/onboarding/discover';
  static const String onboardingOrder = '/onboarding/order';
  static const String onboardingTrack = '/onboarding/track';
  static const String signIn = '/signIn';
  static const String locationPermission = '/locationPermission';
  static const String dietaryPreferences = '/dietaryPreferences';
  static const String home = '/home';
  static const String searchSuggestions = '/search';
  static const String searchResults = '/search/results';
  static const String filter = '/filter';
  static const String restaurantDetail = '/restaurant';
  static const String cart = '/cart';
  static const String emptyCart = '/cart/empty';
  static const String itemCustomize = '/item/customize';
  static const String checkoutDetails = '/checkout';
  static const String scheduleDelivery = '/schedule-delivery';
  static const String orderSuccess = '/order-success';
  static const String liveTracking = '/live-tracking';
  static const String pickupTracking = '/pickup-tracking';
  static const String orderRating = '/order-rating';
  static const String ratingDetail = '/rating-detail';
  static const String rewardsDashboard = '/rewards-dashboard';
  static const String referralProgram = '/referral-program';
  static const String settings = '/settings';
  static const String addressEntry = '/address-entry';
  static const String orderHistory = '/order-history';
  static const String manageAddresses = '/manage-addresses';
  static const String profileOverview = '/profile';

  /// Onboarding journey flow navigation
  static String get nextRoute {
    // This can be extended for dynamic routing based on onboarding state
    return onboardingDiscover;
  }
}

/// GoRouter configuration
final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: RouteNames.splash,
      name: RouteNames.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: RouteNames.onboardingDiscover,
      name: RouteNames.onboardingDiscover,
      builder: (context, state) => const OnboardingDiscoverScreen(),
    ),
    GoRoute(
      path: RouteNames.onboardingOrder,
      name: RouteNames.onboardingOrder,
      builder: (context, state) => const OnboardingOrderScreen(),
    ),
    GoRoute(
      path: RouteNames.onboardingTrack,
      name: RouteNames.onboardingTrack,
      builder: (context, state) => const OnboardingTrackScreen(),
    ),
    GoRoute(
      path: RouteNames.signIn,
      name: RouteNames.signIn,
      builder: (context, state) => const SignInScreen(),
    ),
    GoRoute(
      path: RouteNames.locationPermission,
      name: RouteNames.locationPermission,
      builder: (context, state) => const LocationPermissionScreen(),
    ),
    GoRoute(
      path: RouteNames.dietaryPreferences,
      name: RouteNames.dietaryPreferences,
      builder: (context, state) => const DietaryPreferencesScreen(),
    ),
    GoRoute(
      path: RouteNames.home,
      name: RouteNames.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: RouteNames.searchSuggestions,
      name: RouteNames.searchSuggestions,
      builder: (context, state) => const SearchSuggestionsScreen(),
    ),
    GoRoute(
      path: RouteNames.searchResults,
      name: RouteNames.searchResults,
      builder: (context, state) => SearchResultsScreen(
        query: state.uri.queryParameters['query'] ?? '',
      ),
    ),
    GoRoute(
      path: RouteNames.filter,
      name: RouteNames.filter,
      builder: (context, state) => const FilterPanelScreen(),
    ),
    GoRoute(
      path: RouteNames.restaurantDetail,
      name: RouteNames.restaurantDetail,
      builder: (context, state) => RestaurantDetailScreen(
        restaurantId: state.uri.queryParameters['id'] ?? '',
      ),
    ),
    GoRoute(
      path: RouteNames.cart,
      name: RouteNames.cart,
      builder: (context, state) => const ShoppingCartScreen(),
    ),
    GoRoute(
      path: RouteNames.emptyCart,
      name: RouteNames.emptyCart,
      builder: (context, state) => const EmptyCartScreen(),
    ),
    GoRoute(
      path: RouteNames.itemCustomize,
      name: RouteNames.itemCustomize,
      builder: (context, state) => ItemCustomizationScreen(
        menuItemId: state.uri.queryParameters['id'] ?? '',
      ),
    ),
    GoRoute(
      path: RouteNames.checkoutDetails,
      name: RouteNames.checkoutDetails,
      builder: (context, state) => const CheckoutDetailsScreen(),
    ),
    GoRoute(
      path: RouteNames.scheduleDelivery,
      name: RouteNames.scheduleDelivery,
      builder: (context, state) => const ScheduleDeliveryScreen(),
    ),
    GoRoute(
      path: RouteNames.orderSuccess,
      name: RouteNames.orderSuccess,
      builder: (context, state) => const OrderSuccessScreen(),
    ),
    GoRoute(
      path: RouteNames.liveTracking,
      name: RouteNames.liveTracking,
      builder: (context, state) => const LiveTrackingScreen(),
    ),
    GoRoute(
      path: RouteNames.pickupTracking,
      name: RouteNames.pickupTracking,
      builder: (context, state) => const PickupTrackingScreen(),
    ),
    GoRoute(
      path: RouteNames.orderRating,
      name: RouteNames.orderRating,
      builder: (context, state) => const OrderRatingScreen(),
    ),
    GoRoute(
      path: RouteNames.ratingDetail,
      name: RouteNames.ratingDetail,
      builder: (context, state) => const RatingDetailScreen(),
    ),
    GoRoute(
      path: RouteNames.rewardsDashboard,
      name: RouteNames.rewardsDashboard,
      builder: (context, state) => const RewardsDashboardScreen(),
    ),
    GoRoute(
      path: RouteNames.referralProgram,
      name: RouteNames.referralProgram,
      builder: (context, state) => const ReferralProgramScreen(),
    ),
    GoRoute(
      path: RouteNames.settings,
      name: RouteNames.settings,
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: RouteNames.addressEntry,
      name: RouteNames.addressEntry,
      builder: (context, state) => const AddressEntryScreen(),
    ),
    GoRoute(
      path: RouteNames.orderHistory,
      name: RouteNames.orderHistory,
      builder: (context, state) => const OrderHistoryScreen(),
    ),
    GoRoute(
      path: RouteNames.manageAddresses,
      name: RouteNames.manageAddresses,
      builder: (context, state) => const ManageAddressesScreen(),
    ),
    GoRoute(
      path: RouteNames.profileOverview,
      name: RouteNames.profileOverview,
      builder: (context, state) => const ProfileOverviewScreen(),
    ),
  ],
);
