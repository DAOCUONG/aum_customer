import 'package:flutter/material.dart';
import '../theme/glass_theme.dart';
import '../atoms/index.dart';
import '../molecules/index.dart';
import '../organisms/index.dart';

/// Glass Design System Demo Showcase
///
/// A comprehensive demo page showcasing all components
class GlassDesignShowcase extends StatefulWidget {
  final bool useDarkMode;

  const GlassDesignShowcase({
    super.key,
    this.useDarkMode = false,
  });

  @override
  State<GlassDesignShowcase> createState() => _GlassDesignShowcaseState();
}

class _GlassDesignShowcaseState extends State<GlassDesignShowcase>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return Scaffold(
      backgroundColor: theme.background,
      body: Stack(
        children: [
          // Background mesh gradient
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0.2, -0.3),
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
                center: const Alignment(-0.3, 1.0),
                colors: [
                  const Color(0xFFE6F4FF).withOpacity(0.5),
                  Colors.transparent,
                ],
                stops: const [0.0, 1.0],
              ),
            ),
          ),

          // Main content
          SafeArea(
            child: Column(
              children: [
                // Header
                Container(
                  padding:
                      const EdgeInsets.fromLTRB(20, 12, 20, 16),
                  decoration: BoxDecoration(
                    color: theme.glassSurface.withOpacity(0.7),
                    border: Border(
                      bottom: BorderSide(
                        color: theme.glassBorder.withOpacity(0.5),
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Glass Design System',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: theme.textPrimary,
                        ),
                      ),
                      const Spacer(),
                      GlassBadge(
                        text: 'O-01',
                        variant: GlassBadgeVariant.primary,
                        size: GlassBadgeSize.small,
                      ),
                    ],
                  ),
                ),

                // Tab bar
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: theme.glassSurface.withOpacity(0.5),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicatorColor: GlassTheme.primary,
                    labelColor: GlassTheme.primary,
                    unselectedLabelColor: theme.textTertiary,
                    labelStyle: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                    tabs: const [
                      Tab(text: 'Atoms'),
                      Tab(text: 'Molecules'),
                      Tab(text: 'Organisms'),
                    ],
                  ),
                ),

                // Content
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildAtomsTab(),
                      _buildMoleculesTab(),
                      _buildOrganismsTab(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAtomsTab() {
    final theme = GlassTheme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Buttons'),
          const SizedBox(height: 12),
          _buildSubsectionTitle('Primary Button'),
          const SizedBox(height: 8),
          GlassButton(
            onPressed: () {},
            label: 'Primary Button',
            icon: Icons.add,
          ),
          const SizedBox(height: 12),
          _buildSubsectionTitle('Secondary Button'),
          const SizedBox(height: 8),
          GlassButtonVariants.secondary(
            context: context,
            onPressed: () {},
            label: 'Secondary',
            icon: Icons.shopping_bag,
          ),
          const SizedBox(height: 12),
          _buildSubsectionTitle('Icon Buttons'),
          const SizedBox(height: 8),
          Row(
            children: [
              GlassIconButton.surface(
                onPressed: () {},
                icon: const Icon(Icons.favorite_border),
              ),
              const SizedBox(width: 12),
              GlassIconButton.primary(
                onPressed: () {},
                icon: const Icon(Icons.add),
              ),
              const SizedBox(width: 12),
              GlassIconButton.transparent(
                onPressed: () {},
                icon: const Icon(Icons.settings),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSectionTitle('Cards & Containers'),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: GlassCard(
                  variant: GlassCardVariant.panel,
                  child: Center(
                    child: Text(
                      'Panel Card',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: theme.textPrimary,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GlassCard(
                  variant: GlassCardVariant.atom,
                  child: Center(
                    child: Text(
                      'Atom Card',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: theme.textPrimary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSectionTitle('Badges'),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              GlassBadge(text: 'Primary', variant: GlassBadgeVariant.primary),
              GlassBadge.success(text: 'Success'),
              GlassBadge.warning(text: 'Warning'),
              GlassBadge.error(text: 'Error'),
              GlassBadge.info(text: 'Info'),
              GlassBadge.outlined(text: 'Outlined'),
              GlassBadge.glass(text: 'Glass'),
              GlassRatingBadge(rating: 4.8, reviewCount: 234),
            ],
          ),
          const SizedBox(height: 24),
          _buildSectionTitle('Chips'),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              GlassChip(label: 'Selected', isSelected: true),
              GlassChip(label: 'Unselected'),
              GlassChip(label: 'With Icon', icon: Icons.star),
              GlassCategoryChip(
                label: 'Pizza',
                icon: Icons.local_pizza,
                isSelected: true,
              ),
              GlassCategoryChip(
                label: 'Sushi',
                icon: Icons.ramen_dining,
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSectionTitle('Dividers'),
          const SizedBox(height: 12),
          GlassDivider(label: 'With Label'),
          const SizedBox(height: 12),
          GlassDivider(variant: GlassDividerVariant.dashed),
          const SizedBox(height: 12),
          GlassDivider(variant: GlassDividerVariant.dotted),
          const SizedBox(height: 24),
          _buildSectionTitle('Inputs'),
          const SizedBox(height: 12),
          GlassInput(
            labelText: 'Email',
            hintText: 'Enter your email',
            prefixIcon: const Icon(Icons.email),
          ),
          const SizedBox(height: 16),
          GlassSearchBar(
            controller: TextEditingController(),
            hint: 'Search...',
          ),
          const SizedBox(height: 24),
          _buildSectionTitle('Counter'),
          const SizedBox(height: 12),
          GlassCounter(
            initialQuantity: 2,
            onQuantityChanged: (qty) {},
          ),
          const SizedBox(height: 24),
          _buildSectionTitle('Avatar'),
          const SizedBox(height: 12),
          Row(
            children: [
              GlassAvatar.small(
                imageUrl:
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuDrTAbWkngsaWBd_eCoPqKD3VNe9NgtawbK7ttK39xPAlk5EDLkNcoEU_FzatGZaUokwVy1xh9EoeoeiVmGeGogKF_ns6UhnHsJSBoVyEg3LMbpXOSAXRgl7d1d_QmyjMf0lKw5DJN64xiIxrJNX-8B0bcLj78i8IYQHZEmad9NK9_TG118pFB5g4k1WBesBxGuWMEYfg-fw9v345KOsh_TpXa7YNywnsyOG-FUsIOuIiOQkJ2Sslx_1_ifUSFwXyUWMDGgreWk2Vk',
              ),
              const SizedBox(width: 12),
              GlassAvatar.medium(
                imageUrl:
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuDrTAbWkngsaWBd_eCoPqKD3VNe9NgtawbK7ttK39xPAlk5EDLkNcoEU_FzatGZaUokwVy1xh9EoeoeiVmGeGogKF_ns6UhnHsJSBoVyEg3LMbpXOSAXRgl7d1d_QmyjMf0lKw5DJN64xiIxrJNX-8B0bcLj78i8IYQHZEmad9NK9_TG118pFB5g4k1WBesBxGuWMEYfg-fw9v345KOsh_TpXa7YNywnsyOG-FUsIOuIiOQkJ2Sslx_1_ifUSFwXyUWMDGgreWk2Vk',
                status: GlassAvatarStatus.online,
              ),
              const SizedBox(width: 12),
              GlassAvatar.large(
                imageUrl:
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuDrTAbWkngsaWBd_eCoPqKD3VNe9NgtawbK7ttK39xPAlk5EDLkNcoEU_FzatGZaUokwVy1xh9EoeoeiVmGeGogKF_ns6UhnHsJSBoVyEg3LMbpXOSAXRgl7d1d_QmyjMf0lKw5DJN64xiIxrJNX-8B0bcLj78i8IYQHZEmad9NK9_TG118pFB5g4k1WBesBxGuWMEYfg-fw9v345KOsh_TpXa7YNywnsyOG-FUsIOuIiOQkJ2Sslx_1_ifUSFwXyUWMDGgreWk2Vk',
                status: GlassAvatarStatus.busy,
              ),
            ],
          ),
          const SizedBox(height: 120),
        ],
      ),
    );
  }

  Widget _buildMoleculesTab() {
    final theme = GlassTheme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Category Rail'),
          const SizedBox(height: 12),
          CategoryRail(
            categories: const [
              CategoryItem(id: '1', name: 'Burger', icon: Icons.lunch_dining),
              CategoryItem(id: '2', name: 'Pizza', icon: Icons.local_pizza),
              CategoryItem(id: '3', name: 'Sushi', icon: Icons.ramen_dining),
              CategoryItem(id: '4', name: 'Salad', icon: Icons.eco),
              CategoryItem(id: '5', name: 'Drinks', icon: Icons.local_drink),
            ],
            selectedIndex: 0,
            onSelect: (index) {},
          ),
          const SizedBox(height: 24),
          _buildSectionTitle('Featured Item Card'),
          const SizedBox(height: 12),
          Center(
            child: SizedBox(
              width: 220,
              child: FeaturedItemCard(
                id: '1',
                title: 'Green Goddess Salad',
                subtitle: 'Kale, Avocado, Edamame',
                imageUrl:
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuAIvS-G-S1hzW9_E_KHLC68kiLtWTC_H0R_W8lHCo1dfnFu83fsqULEKDJK8aj_vCjXO3zNbVK60Jv0rJXW6HBUAJglR1AexIpPis_QLz4PTZyPJHxYCBdn3QCOVm2LRL05wnqx_30qCe2c9z_lzvbnJdMxxw2uDY8EMEGJlxQaDVly4z4klJmh4hlLz6pqomjrK_ihIB0HklvWxUugfJMBbMFWuSxP4Bb56-yX_Q6pSNJOJ7UfSWSWmthXKNLlv0Y5UmCxHgcGBW4',
                price: '14.50',
                originalPrice: '18.00',
                rating: 4.9,
                reviewCount: 234,
                showDeliveryBadge: true,
              ),
            ),
          ),
          const SizedBox(height: 24),
          _buildSectionTitle('Promo Code Section'),
          const SizedBox(height: 12),
          PromoCodeSection(
            appliedCode: 'SAVE2024',
            originalTotal: 32.40,
            discountAmount: 8.09,
            deliveryFee: 2.99,
            onCodeSubmitted: (code) {},
            onRemoveCode: () {},
          ),
          const SizedBox(height: 24),
          _buildSectionTitle('Floating Cart Action'),
          const SizedBox(height: 12),
          Center(
            child: FloatingCartAction(
              itemCount: 2,
              storeName: 'Starbucks',
              totalPrice: '12.40',
              onViewCartTap: () {},
              onCheckoutTap: () {},
            ),
          ),
          const SizedBox(height: 24),
          _buildSectionTitle('Price Display'),
          const SizedBox(height: 12),
          GlassPriceTag(
            currentPrice: '14.50',
            originalPrice: '18.00',
            size: GlassPriceTagSize.large,
            showDiscount: true,
            discountPercentage: 20,
          ),
          const SizedBox(height: 16),
          GlassTotalPrice(
            label: 'Total',
            price: '27.30',
            size: GlassPriceTagSize.large,
          ),
          const SizedBox(height: 24),
          _buildSectionTitle('User Home Header'),
          const SizedBox(height: 12),
          GlassCard(
            variant: GlassCardVariant.atom,
            child: Column(
              children: [
                GlassProfileHeader(
                  greeting: 'Good Morning',
                  userName: 'Sarah Jenkins',
                  imageUrl:
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuDrTAbWkngsaWBd_eCoPqKD3VNe9NgtawbK7ttK39xPAlk5EDLkNcoEU_FzatGZaUokwVy1xh9EoeoeiVmGeGogKF_ns6UhnHsJSBoVyEg3LMbpXOSAXRgl7d1d_QmyjMf0lKw5DJN64xiIxrJNX-8B0bcLj78i8IYQHZEmad9NK9_TG118pFB5g4k1WBesBxGuWMEYfg-fw9v345KOsh_TpXa7YNywnsyOG-FUsIOuIiOQkJ2Sslx_1_ifUSFwXyUWMDGgreWk2Vk',
                  status: GlassAvatarStatus.online,
                  onNotificationTap: () {},
                  notificationCount: 3,
                ),
                const SizedBox(height: 16),
                GlassSearchBar(
                  controller: TextEditingController(),
                  hint: 'What are you craving?',
                ),
              ],
            ),
          ),
          const SizedBox(height: 120),
        ],
      ),
    );
  }

  Widget _buildOrganismsTab() {
    final theme = GlassTheme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('User Home Header'),
          const SizedBox(height: 12),
          GlassCard(
            variant: GlassCardVariant.atom,
            child: GlassProfileHeader(
              greeting: 'Good Morning',
              userName: 'Sarah Jenkins',
              imageUrl:
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuDrTAbWkngsaWBd_eCoPqKD3VNe9NgtawbK7ttK39xPAlk5EDLkNcoEU_FzatGZaUokwVy1xh9EoeoeiVmGeGogKF_ns6UhnHsJSBoVyEg3LMbpXOSAXRgl7d1d_QmyjMf0lKw5DJN64xiIxrJNX-8B0bcLj78i8IYQHZEmad9NK9_TG118pFB5g4k1WBesBxGuWMEYfg-fw9v345KOsh_TpXa7YNywnsyOG-FUsIOuIiOQkJ2Sslx_1_ifUSFwXyUWMDGgreWk2Vk',
              status: GlassAvatarStatus.online,
              onNotificationTap: () {},
              notificationCount: 3,
            ),
          ),
          const SizedBox(height: 24),
          _buildSectionTitle('Category Rail'),
          const SizedBox(height: 12),
          CategoryRail(
            categories: const [
              CategoryItem(
                  id: '1', name: 'Burger', icon: Icons.lunch_dining, emoji: '🍔'),
              CategoryItem(
                  id: '2', name: 'Pizza', icon: Icons.local_pizza, emoji: '🍕'),
              CategoryItem(
                  id: '3', name: 'Sushi', icon: Icons.ramen_dining, emoji: '🍣'),
              CategoryItem(
                  id: '4', name: 'Healthy', icon: Icons.eco, emoji: '🥗'),
              CategoryItem(
                  id: '5', name: 'Drinks', icon: Icons.local_drink, emoji: '🥤'),
            ],
            selectedIndex: 0,
            onSelect: (index) {},
          ),
          const SizedBox(height: 24),
          _buildSectionTitle('Featured Item Card'),
          const SizedBox(height: 12),
          Center(
            child: FeaturedItemCard(
              id: '1',
              title: 'Green Goddess Salad',
              subtitle: 'Kale, Avocado, Edamame, House Dressing',
              imageUrl:
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuAIvS-G-S1hzW9_E_KHLC68kiLtWTC_H0R_W8lHCo1dfnFu83fsqULEKDJK8aj_vCjXO3zNbVK60Jv0rJXW6HBUAJglR1AexIpPis_QLz4PTZyPJHxYCBdn3QCOVm2LRL05wnqx_30qCe2c9z_lzvbnJdMxxw2uDY8EMEGJlxQaDVly4z4klJmh4hlLz6pqomjrK_ihIB0HklvWxUugfJMBbMFWuSxP4Bb56-yX_Q6pSNJOJ7UfSWSWmthXKNLlv0Y5UmCxHgcGBW4',
              price: '14.50',
              originalPrice: '18.00',
              rating: 4.9,
              reviewCount: 128,
              isFavorite: false,
              onFavoriteTap: () {},
              onAddTap: () {},
              showDeliveryBadge: true,
            ),
          ),
          const SizedBox(height: 24),
          _buildSectionTitle('Promo Code Section'),
          const SizedBox(height: 12),
          PromoCodeSection(
            appliedCode: 'SAVE2024',
            originalTotal: 32.40,
            discountAmount: 8.09,
            deliveryFee: 2.99,
            onCodeSubmitted: (code) {},
            onRemoveCode: () {},
          ),
          const SizedBox(height: 24),
          _buildSectionTitle('Floating Cart Action'),
          const SizedBox(height: 12),
          Center(
            child: FloatingCartAction(
              itemCount: 2,
              storeName: 'Starbucks',
              totalPrice: '12.40',
              onViewCartTap: () {},
              onCheckoutTap: () {},
            ),
          ),
          const SizedBox(height: 24),
          _buildSectionTitle('Product Detail Header'),
          const SizedBox(height: 12),
          GlassCard(
            variant: GlassCardVariant.atom,
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.network(
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuAIvS-G-S1hzW9_E_KHLC68kiLtWTC_H0R_W8lHCo1dfnFu83fsqULEKDJK8aj_vCjXO3zNbVK60Jv0rJXW6HBUAJglR1AexIpPis_QLz4PTZyPJHxYCBdn3QCOVm2LRL05wnqx_30qCe2c9z_lzvbnJdMxxw2uDY8EMEGJlxQaDVly4z4klJmh4hlLz6pqomjrK_ihIB0HklvWxUugfJMBbMFWuSxP4Bb56-yX_Q6pSNJOJ7UfSWSWmthXKNLlv0Y5UmCxHgcGBW4',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 12,
                        left: 12,
                        child: GlassBadge(
                          text: 'Free Delivery',
                          variant: GlassBadgeVariant.glass,
                          size: GlassBadgeSize.small,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Green Goddess Salad',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: theme.textPrimary,
                        ),
                      ),
                      Text(
                        'Kale, Avocado, Edamame, House Dressing',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: theme.textTertiary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          GlassRatingBadge(
                            rating: 4.9,
                            reviewCount: 128,
                            size: GlassRatingSize.small,
                          ),
                          const Spacer(),
                          GlassPriceTag(
                            currentPrice: '14.50',
                            originalPrice: '18.00',
                            size: GlassPriceTagSize.medium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 120),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: GlassTheme.primary,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: GlassDivider(
            variant: GlassDividerVariant.dashed,
          ),
        ),
      ],
    );
  }

  Widget _buildSubsectionTitle(String title) {
    final theme = GlassTheme.of(context);

    return Text(
      title,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: theme.textSecondary,
      ),
    );
  }
}

/// Main app entry point
class GlassDesignSystemApp extends StatelessWidget {
  const GlassDesignSystemApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Glass Design System',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        extensionTheme: ThemeExtension<GlassTheme>.all(GlassTheme.light),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        extensionTheme: ThemeExtension<GlassTheme>.all(GlassTheme.dark),
      ),
      themeMode: ThemeMode.light,
      home: const GlassDesignShowcase(),
    );
  }
}
