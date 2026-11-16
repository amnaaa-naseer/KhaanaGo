import 'package:flutter/material.dart';
import 'package:khaana_design/khaana_design.dart';

import 'p2_screens.dart';
import 'scope.dart';
import 'session.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _id = TextEditingController();
  final _password = TextEditingController();
  String? _error;
  bool _obscure = true;
  bool _signingIn = false;

  @override
  void dispose() {
    _id.dispose();
    _password.dispose();
    super.dispose();
  }

  void _handleSignIn(CustomerSession session) {
    if (_id.text.trim().isEmpty || _password.text.isEmpty) {
      setState(() => _error = 'Enter your mobile number or email, and your password.');
      return;
    }
    setState(() {
      _error = null;
      _signingIn = true;
    });
    session.signIn();
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    final session = CustomerScope.of(context);
    return KhaanaPage(
      uiId: 'E1-US1-UI3',
      title: 'Login',
      footer: KhaanaPrimaryButton(
        label: _signingIn ? 'Signing in…' : 'Sign in',
        loading: _signingIn,
        icon: Icons.login_rounded,
        onPressed: () => _handleSignIn(session),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF242424), Color(0xFF3A2415)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: KhaanaColors.orange.withValues(alpha: 0.45)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const KhaanaLogo(size: 56, borderRadius: 16),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const KhaanaWordmark(height: 30),
                          const SizedBox(height: 6),
                          Text(
                            'Honest kitchen capacity · Fresh food on time',
                            style: TextStyle(
                              color: KhaanaColors.cream.withValues(alpha: 0.85),
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    CapacityBadge(kind: CapacityKind.available, label: 'Live kitchen slots'),
                    CapacityBadge(kind: CapacityKind.info, label: 'Verified macros & allergens'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          if (session.sessionExpired) ...[
            const KhaanaInlineBanner(
              kind: CapacityKind.limited,
              icon: Icons.lock_clock_outlined,
              text: 'Your session has expired. Sign in again. Protected data is not shown.',
            ),
            const SizedBox(height: 14),
          ],
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Welcome back',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            _id.text = '03001234567';
                            _password.text = 'khaanago123';
                            _error = null;
                          });
                        },
                        icon: const Icon(Icons.auto_fix_high_rounded, size: 16),
                        label: const Text('Fill demo login'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Mobile or email *',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _id,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: '03001234567 or ayesha@example.com',
                      prefixIcon: Icon(Icons.person_outline_rounded),
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Password *',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _password,
                    obscureText: _obscure,
                    decoration: InputDecoration(
                      hintText: 'At least 8 characters',
                      prefixIcon: const Icon(Icons.lock_outline_rounded),
                      suffixIcon: IconButton(
                        tooltip: _obscure ? 'Show password' : 'Hide password',
                        onPressed: () => setState(() => _obscure = !_obscure),
                        icon: Icon(_obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                      ),
                    ),
                  ),
                  if (_error != null) ...[
                    const SizedBox(height: 12),
                    KhaanaInlineBanner(text: _error!),
                  ],
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pushNamed(context, '/reset-request'),
                        child: const Text('Forgot password?'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pushNamed(context, '/register'),
                        child: const Text('Create account (E1-US1-UI1)'),
                      ),
                      TextButton(
                        onPressed: session.showExpired,
                        child: const Text('Preview session-expired message'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const ProvisionalNote(
            text:
                'Sign-in here only checks that the fields are filled. Password hashing, lockout, and the backend policy are not verified by this screen.',
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _navIndex = 0;
  bool _showEmptyOrdersDemo = false;

  @override
  Widget build(BuildContext context) {
    final session = CustomerScope.of(context);
    return KhaanaPage(
      uiId: switch (_navIndex) {
        1 => 'E17-US2-UI1',
        2 => 'E19-US1-UI1',
        3 => 'E1-US5-UI1',
        _ => 'E3-US1-UI1',
      },
      title: switch (_navIndex) {
        1 => 'Order history',
        2 => 'KhaanaGo Assistant',
        3 => 'Customer profile',
        _ => 'Home',
      },
      actions: [
        IconButton(
          tooltip: 'Notifications (E17-US1-UI2)',
          onPressed: () => Navigator.pushNamed(context, '/notifications'),
          icon: const Icon(Icons.notifications_none_rounded),
        ),
        if (session.cart.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: FilledButton.tonalIcon(
              onPressed: () => Navigator.pushNamed(context, '/cart'),
              style: FilledButton.styleFrom(
                backgroundColor: KhaanaColors.orangeTint,
                foregroundColor: KhaanaColors.onOrangeTint,
              ),
              icon: const Icon(Icons.shopping_bag_rounded, size: 18),
              label: Text(
                '${session.cart.length} · ${formatRupees(session.foodTotal)}',
                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
              ),
            ),
          ),
      ],
      bottomNavigationBar: KhaanaBottomNav(
        currentIndex: _navIndex,
        cartCount: session.cart.length,
        onTap: (index) => setState(() => _navIndex = index),
      ),
      child: switch (_navIndex) {
        1 => OrderHistoryBody(
            session: session,
            forceEmpty: _showEmptyOrdersDemo,
            onToggleEmpty: () => setState(() => _showEmptyOrdersDemo = !_showEmptyOrdersDemo),
          ),
        2 => AssistantChatBody(session: session),
        3 => CustomerProfileBody(session: session),
        _ => _HomeFeedView(session: session),
      },
    );
  }
}

class _HomeFeedView extends StatelessWidget {
  const _HomeFeedView({required this.session});

  final CustomerSession session;

  @override
  Widget build(BuildContext context) {
    const categories = ['All', 'Bakery', 'Desi'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Delivery Address & Rain Banner Card
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: KhaanaColors.orangeTint,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.location_on_rounded, color: KhaanaColors.orangeText),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'DELIVERING TO',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.6,
                          color: KhaanaColors.mutedLight,
                        ),
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: session.address,
                          isDense: true,
                          isExpanded: true,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: KhaanaColors.charcoal,
                          ),
                          items: [
                            for (final address in session.addresses)
                              DropdownMenuItem(value: address, child: Text(address)),
                          ],
                          onChanged: (value) {
                            if (value != null) session.setAddress(value);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const CapacityBadge(kind: CapacityKind.info, label: 'Rain +15m'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),

        // Promotional Hero Banner
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF242424), Color(0xFF3E2210)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: KhaanaColors.orange,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: const Text(
                        'HONEST CAPACITY PROMISE',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.6,
                          color: KhaanaColors.charcoal,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'See live kitchen load before you pay.',
                      style: TextStyle(
                        color: KhaanaColors.cream,
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Pool eligible orders to save ${PrototypeAssumptions.pooledDiscountPercent}% on delivery.',
                      style: TextStyle(
                        color: KhaanaColors.cream.withValues(alpha: 0.8),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              const KhaanaLogo(size: 64, borderRadius: 16),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Search input
        TextField(
          decoration: const InputDecoration(
            hintText: 'Search food or restaurants (e.g. BakeCharm, Karahi, Cake)',
            prefixIcon: Icon(Icons.search_rounded),
          ),
          onChanged: session.setSearch,
        ),
        const SizedBox(height: 10),

        // Filter chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              FilterChip(
                label: const Text('Open now'),
                selected: session.openNowOnly,
                onSelected: (_) => session.toggleOpenNow(),
              ),
              const SizedBox(width: 8),
              for (final cat in categories) ...[
                ChoiceChip(
                  label: Text(cat),
                  selected: session.selectedCategory == cat,
                  onSelected: (_) => session.setCategory(cat),
                ),
                const SizedBox(width: 8),
              ],
              ActionChip(
                avatar: const Icon(Icons.tune_rounded, size: 16),
                label: const Text('Filters (E3-US1-UI5)'),
                onPressed: () => showFilterSheet(context),
              ),
              const SizedBox(width: 8),
              ActionChip(
                avatar: const Icon(Icons.manage_search_rounded, size: 16),
                label: const Text('Search results (E3-US1-UI4)'),
                onPressed: () => Navigator.pushNamed(context, '/search'),
              ),
              const SizedBox(width: 8),
              ActionChip(
                avatar: const Icon(Icons.cloud_off_rounded, size: 16),
                label: Text(session.homeNetworkError ? 'Restore feed' : 'Simulate error'),
                onPressed: session.toggleHomeError,
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),

        if (session.homeNetworkError)
          KhaanaErrorState(
            title: 'Could not reach nearby kitchens',
            message: 'Live capacity feed timed out. Check your connection and retry.',
            onRetry: session.toggleHomeError,
          )
        else ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'TOP RATED NEAR YOU',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.7,
                  color: KhaanaColors.mutedLight,
                ),
              ),
              Text(
                '${session.topRated.length} kitchens',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: KhaanaColors.orangeText),
              ),
            ],
          ),
          const ProvisionalNote(
            text: 'Rating highlights use E17-US3. This row is rule-based, not a recommendation engine.',
          ),
          const SizedBox(height: 8),
          for (final vendor in session.topRated) _VendorCard(vendor: vendor),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'ALL RESTAURANTS',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.7,
                  color: KhaanaColors.mutedLight,
                ),
              ),
              if (!session.openNowOnly)
                const Text('Showing closed kitchens too', style: TextStyle(fontSize: 12, color: KhaanaColors.mutedLight)),
            ],
          ),
          const SizedBox(height: 8),
          if (session.visibleVendors.isEmpty)
            KhaanaEmptyState(
              title: 'No restaurants match that search.',
              message: 'Try clearing your search filter or turning off "Open now" to view closed kitchens.',
              icon: Icons.storefront_outlined,
              actionLabel: 'Show all kitchens',
              onAction: () {
                session.setCategory('All');
                if (session.openNowOnly) session.toggleOpenNow();
              },
            ),
          for (final vendor in session.visibleVendors) _VendorCard(vendor: vendor),
        ],
      ],
    );
  }
}

class _VendorCard extends StatelessWidget {
  const _VendorCard({required this.vendor});

  final VendorPlace vendor;

  @override
  Widget build(BuildContext context) {
    final session = CustomerScope.of(context);
    final closed = !vendor.open;
    final badgeKind = closed
        ? CapacityKind.closed
        : switch (vendor.band) {
            'Limited' => CapacityKind.limited,
            'Full' => CapacityKind.full,
            _ => CapacityKind.available,
          };

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: closed
            ? null
            : () {
                session.openVendor(vendor);
                Navigator.pushNamed(context, '/menu');
              },
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 64x64 Monogram Tile from Design System v1.0 (.vcard .ph)
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: closed ? KhaanaColors.closedTint : KhaanaColors.orange,
                  borderRadius: BorderRadius.circular(14),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      vendor.name.substring(0, 1),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: closed ? KhaanaColors.closed : KhaanaColors.charcoal,
                      ),
                    ),
                    Icon(
                      vendor.cuisine.toLowerCase().contains('bakery')
                          ? Icons.cake_rounded
                          : Icons.soup_kitchen_outlined,
                      size: 14,
                      color: closed ? KhaanaColors.closed : KhaanaColors.charcoal,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            vendor.name,
                            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                          ),
                        ),
                        CapacityBadge(
                          kind: badgeKind,
                          label: closed ? 'Closed' : vendor.band,
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      closed ? 'Opens ${vendor.opensAt}' : '${vendor.cuisine} · ${vendor.area}',
                      style: const TextStyle(fontSize: 13, color: KhaanaColors.mutedLight),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      vendor.tagline,
                      style: const TextStyle(fontSize: 12, color: KhaanaColors.mutedLight),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 12,
                      runSpacing: 6,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star_rounded, size: 17, color: Color(0xFFEAB308)),
                            const SizedBox(width: 3),
                            Text(
                              vendor.rating.toStringAsFixed(1),
                              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                        if (!closed) ...[
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.schedule_rounded, size: 15, color: KhaanaColors.mutedLight),
                              const SizedBox(width: 4),
                              Text(vendor.etaRange, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.speed_rounded, size: 15, color: KhaanaColors.mutedLight),
                              const SizedBox(width: 4),
                              Text(
                                '${vendor.bookedHourly}/${vendor.limitHourly} hourly slots',
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final session = CustomerScope.of(context);
    final vendor = session.vendor;
    if (vendor == null) {
      return KhaanaPage(
        uiId: 'E3-US1-UI2',
        title: 'Menu',
        child: KhaanaEmptyState(
          title: 'Choose a restaurant from Home.',
          message: 'Select an open kitchen on the Home screen to inspect its live capacity and menu.',
          actionLabel: 'Go to Home',
          onAction: () => Navigator.pushReplacementNamed(context, '/home'),
        ),
      );
    }
    final dishes = session.dishesFor(vendor.id);
    final categories = dishes.map((dish) => dish.category).toSet();
    return KhaanaPage(
      uiId: 'E3-US1-UI2',
      title: vendor.name,
      footer: session.cart.isEmpty
          ? null
          : KhaanaPrimaryButton(
              label: 'Cart · ${session.cart.length} (${formatRupees(session.foodTotal)})',
              icon: Icons.shopping_bag_rounded,
              onPressed: () => Navigator.pushNamed(context, '/cart'),
            ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Restaurant Hero Banner
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: KhaanaColors.orange,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          vendor.name.substring(0, 1),
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: KhaanaColors.charcoal),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(vendor.cuisine, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                            const SizedBox(height: 2),
                            Text(
                              vendor.open ? 'Open now · ${vendor.band} intake' : 'Closed',
                              style: const TextStyle(fontWeight: FontWeight.w700, color: KhaanaColors.orangeText),
                            ),
                            Text(
                              'Hours today until 10:00 PM · ${vendor.area}',
                              style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.outline),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.star_rounded, color: Color(0xFFEAB308), size: 18),
                              const SizedBox(width: 2),
                              Text('${vendor.rating}', style: const TextStyle(fontWeight: FontWeight.w800)),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(vendor.etaRange, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                          TextButton.icon(
                            onPressed: () => Navigator.pushNamed(context, '/vendor-info'),
                            icon: const Icon(Icons.info_outline_rounded, size: 15),
                            label: const Text('Info & reviews (E3-US1-UI6)', style: TextStyle(fontSize: 11)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  KitchenCapacityMeter(
                    title: 'Kitchen hourly capacity',
                    booked: vendor.bookedHourly,
                    limit: vendor.limitHourly,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          for (final category in categories) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Text(
                category.toUpperCase(),
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.7,
                  color: KhaanaColors.mutedLight,
                ),
              ),
            ),
            for (final dish in dishes.where((dish) => dish.category == category))
              Card(
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: dish.available
                      ? () {
                          session.vendor = vendor;
                          Navigator.pushNamed(context, '/item', arguments: dish.id);
                        }
                      : null,
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 68,
                          height: 68,
                          decoration: BoxDecoration(
                            color: dish.available ? KhaanaColors.orangeTint : KhaanaColors.closedTint,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: dish.available
                                  ? KhaanaColors.orange.withValues(alpha: 0.4)
                                  : KhaanaColors.closed.withValues(alpha: 0.25),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            dish.category == 'Cakes'
                                ? Icons.cake_rounded
                                : dish.category.contains('Sides')
                                    ? Icons.bakery_dining_rounded
                                    : Icons.dinner_dining_rounded,
                            size: 32,
                            color: dish.available ? KhaanaColors.onOrangeTint : KhaanaColors.closed,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      dish.name,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800,
                                        color: dish.available ? null : Theme.of(context).disabledColor,
                                      ),
                                    ),
                                  ),
                                  if (dish.popular && dish.available)
                                    const CapacityBadge(kind: CapacityKind.available, label: 'Popular'),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                dish.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 12, color: KhaanaColors.mutedLight),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                dish.hasNutrition
                                    ? '${dish.kcal} kcal · ${dish.protein} protein · ~${dish.prepMinutes}m prep'
                                    : 'No nutrition data for this dish.',
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: KhaanaColors.mutedLight),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    dish.available ? formatRupees(dish.price) : 'Unavailable',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      color: dish.available ? KhaanaColors.charcoal : KhaanaColors.full,
                                      fontFeatures: const [FontFeature.tabularFigures()],
                                    ),
                                  ),
                                  if (dish.available)
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: KhaanaColors.orange,
                                        borderRadius: BorderRadius.circular(999),
                                      ),
                                      child: Text(
                                        dish.customizable ? 'Customize' : '+ Add',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w800,
                                          color: KhaanaColors.charcoal,
                                        ),
                                      ),
                                    )
                                  else
                                    const CapacityBadge(kind: CapacityKind.closed, label: 'Sold out'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}

class ItemScreen extends StatelessWidget {
  const ItemScreen({super.key, required this.dishId});

  final String dishId;

  @override
  Widget build(BuildContext context) {
    final session = CustomerScope.of(context);
    final dish = session.dishes.firstWhere((dish) => dish.id == dishId, orElse: () => session.dishes.first);
    return KhaanaPage(
      uiId: 'E3-US1-UI3',
      title: dish.name,
      footer: KhaanaPrimaryButton(
        label: dish.customizable ? 'Customize' : 'Add to cart · ${formatRupees(dish.price)}',
        icon: dish.customizable ? Icons.tune_rounded : Icons.add_shopping_cart_rounded,
              onPressed: dish.available
            ? () {
                if (dish.customizable) {
                  Navigator.pushNamed(context, '/customize', arguments: dish.id);
                } else {
                  if (session.cart.isNotEmpty && session.cart.first.dish.vendorId != dish.vendorId) {
                    showDifferentRestaurantDialog(context, newDish: dish);
                    return;
                  }
                  final error = session.addDish(dish);
                  _showResult(context, error);
                }
              }
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: KhaanaColors.orangeTint,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: KhaanaColors.orange.withValues(alpha: 0.4)),
            ),
            child: Column(
              children: [
                Container(
                  width: 84,
                  height: 84,
                  decoration: BoxDecoration(
                    color: KhaanaColors.orange,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Icon(
                    dish.category == 'Cakes' ? Icons.cake_rounded : Icons.dinner_dining_rounded,
                    size: 46,
                    color: KhaanaColors.charcoal,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  formatRupees(dish.price),
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: KhaanaColors.charcoal,
                    fontFeatures: [FontFeature.tabularFigures()],
                  ),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  alignment: WrapAlignment.center,
                  children: [
                    CapacityBadge(kind: CapacityKind.info, label: 'Prep ~${dish.prepMinutes} mins'),
                    if (dish.fragile)
                      const CapacityBadge(kind: CapacityKind.limited, label: 'Fragile · Express only'),
                    if (dish.customizable)
                      const CapacityBadge(kind: CapacityKind.available, label: 'Customizable'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(dish.description, style: const TextStyle(fontSize: 15)),
          const SizedBox(height: 8),
          const Text(
            'Add-ons are chosen in Customize when the vendor allows them.',
            style: TextStyle(fontSize: 13, color: KhaanaColors.mutedLight),
          ),
          if (dish.hasNutrition) ...[
            const SizedBox(height: 16),
            const Text('NUTRITION PER SERVING', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, letterSpacing: 0.6, color: KhaanaColors.mutedLight)),
            const SizedBox(height: 8),
            NutritionStrip(
              kcal: dish.kcal!,
              protein: dish.protein ?? '0 g',
              carbs: dish.carbs ?? '0 g',
              fat: dish.fat ?? '0 g',
            ),
            const SizedBox(height: 6),
            Text(
              '${dish.kcal} kcal · ${dish.protein} protein · ${dish.carbs} carbs · ${dish.fat} fat',
              style: const TextStyle(fontSize: 12, color: KhaanaColors.mutedLight),
            ),
          ],
          if (dish.allergen != null) ...[
            const SizedBox(height: 14),
            KhaanaInlineBanner(
              kind: CapacityKind.full,
              text: dish.allergen!,
            ),
          ],
          if (!dish.available) ...[
            const SizedBox(height: 14),
            const KhaanaInlineBanner(
              kind: CapacityKind.closed,
              text: 'This item is unavailable and cannot be added.',
            ),
          ],
        ],
      ),
    );
  }
}

class CustomizeScreen extends StatefulWidget {
  const CustomizeScreen({super.key, required this.dishId});

  final String dishId;

  @override
  State<CustomizeScreen> createState() => _CustomizeScreenState();
}

class _CustomizeScreenState extends State<CustomizeScreen> {
  String? _size;
  String _flavour = 'Chocolate';
  final _text = TextEditingController();
  var _noNuts = false;
  String? _error;

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final session = CustomerScope.of(context);
    final dish = session.dishes.firstWhere((dish) => dish.id == widget.dishId, orElse: () => session.dishes.first);
    final preview = CartLine(dish: dish, size: _size, flavour: _flavour, customText: _text.text);
    return KhaanaPage(
      uiId: 'E4-US1-UI1',
      title: 'Customize',
      footer: KhaanaPrimaryButton(
        label: 'Add to cart · ${formatRupees(preview.unitPrice)}',
        icon: Icons.add_shopping_cart_rounded,
        onPressed: () {
          final error = session.addDish(dish, size: _size, flavour: _flavour, customText: _text.text);
          if (error != null) {
            setState(() => _error = error);
            return;
          }
          Navigator.popUntil(context, ModalRoute.withName('/menu'));
        },
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_error != null) ...[
            KhaanaInlineBanner(text: _error!),
            const SizedBox(height: 12),
          ],
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Size *', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                      CapacityBadge(kind: CapacityKind.limited, label: 'Required'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    children: [
                      for (final size in ['1 lb', '2 lb'])
                        ChoiceChip(
                          label: Text(size == '2 lb' ? '2 lb (+Rs 400)' : size),
                          selected: _size == size,
                          onSelected: (_) => setState(() {
                            _size = size;
                            _error = null;
                          }),
                        ),
                    ],
                  ),
                  const Divider(height: 28),
                  const Text('Flavour', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    children: [
                      for (final flavour in ['Chocolate', 'Vanilla'])
                        ChoiceChip(
                          label: Text(flavour),
                          selected: _flavour == flavour,
                          onSelected: (_) => setState(() => _flavour = flavour),
                        ),
                    ],
                  ),
                  const Divider(height: 28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Custom text on cake', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                      Text(
                        '${_text.text.length}/${PrototypeAssumptions.instructionMaxCharacters}',
                        style: const TextStyle(fontSize: 12, color: KhaanaColors.mutedLight),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _text,
                    maxLength: PrototypeAssumptions.instructionMaxCharacters,
                    decoration: const InputDecoration(
                      hintText: 'Happy Birthday Hira',
                      prefixIcon: Icon(Icons.edit_note_rounded),
                      counterText: '',
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                  const Divider(height: 28),
                  const Text('Allergen & dietary exclusions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 10,
                    runSpacing: 8,
                    children: [
                      FilterChip(
                        label: const Text('No nuts'),
                        selected: _noNuts,
                        onSelected: (value) => setState(() => _noNuts = value),
                      ),
                      const FilterChip(
                        label: Text('No walnuts'),
                        onSelected: null,
                        selected: false,
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'No walnuts is not offered for this cake.',
                    style: TextStyle(fontSize: 12, color: KhaanaColors.mutedLight),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              KhaanaSecondaryButton(
                label: 'Reference image & instructions (E4-US2-UI1)',
                icon: Icons.add_photo_alternate_outlined,
                onPressed: () => showReferenceImageOverlay(context),
              ),
              KhaanaSecondaryButton(
                label: 'Revised quote approval (E4-US3-UI1)',
                icon: Icons.request_quote_outlined,
                onPressed: () => Navigator.pushNamed(context, '/revised-quote'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  const Icon(Icons.timer_outlined, color: KhaanaColors.orangeText),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Prep time about ${preview.prepMinutes} minutes', style: const TextStyle(fontWeight: FontWeight.w700)),
                        if (dish.fragile)
                          const Text(
                            'This cake is fragile. Pooled delivery will be unavailable.',
                            style: TextStyle(fontSize: 12, color: KhaanaColors.mutedLight),
                          ),
                      ],
                    ),
                  ),
                  Text(
                    formatRupees(preview.unitPrice),
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
          ),
          const ProvisionalNote(
            text: 'The 500-character instruction counter belongs on E4-US2-UI1, which is not in this P1 pass.',
          ),
        ],
      ),
    );
  }
}

void _showResult(BuildContext context, String? error) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error ?? 'Added to cart')));
}
