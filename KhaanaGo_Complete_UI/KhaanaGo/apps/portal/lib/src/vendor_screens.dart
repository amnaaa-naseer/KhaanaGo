import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khaana_design/khaana_design.dart';

import 'scope.dart';
import 'session.dart';
import 'vendor_p2_screens.dart';
import 'vendor_p3_screens.dart';

class VendorSignInScreen extends StatefulWidget {
  const VendorSignInScreen({super.key});

  @override
  State<VendorSignInScreen> createState() => _VendorSignInScreenState();
}

class _VendorSignInScreenState extends State<VendorSignInScreen> {
  final _id = TextEditingController();
  final _password = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _id.dispose();
    _password.dispose();
    super.dispose();
  }

  void _enter(PortalRole role, String route) {
    if (_id.text.trim().isEmpty || _password.text.isEmpty) {
      setState(() => _error = 'Enter your credentials.');
      return;
    }
    PortalScope.of(context).signIn(role);
    Navigator.pushReplacementNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E1-US3-UI1',
      title: 'Vendor sign-in',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF242424), Color(0xFF3A2415)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const KhaanaLogo(size: 56, borderRadius: 16),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const KhaanaWordmark(height: 28),
                      const SizedBox(height: 6),
                      Text(
                        'Partner Portal · Kitchen Capacity, Kanban Board & Inventory',
                        style: TextStyle(color: KhaanaColors.cream.withValues(alpha: 0.85), fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Kitchen Partner Login', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800)),
                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            _id.text = 'owner@bakecharm.pk';
                            _password.text = 'kitchen123';
                            _error = null;
                          });
                        },
                        icon: const Icon(Icons.auto_fix_high_rounded, size: 16),
                        label: const Text('Fill demo credentials'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text('Email or staff ID', style: TextStyle(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _id,
                    decoration: const InputDecoration(
                      hintText: 'owner@bakecharm.pk or STAFF-04',
                      prefixIcon: Icon(Icons.badge_outlined),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text('Password', style: TextStyle(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _password,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Enter password',
                      prefixIcon: Icon(Icons.lock_outline_rounded),
                    ),
                  ),
                  if (_error != null) ...[
                    const SizedBox(height: 12),
                    KhaanaInlineBanner(text: _error!),
                  ],
                  const SizedBox(height: 16),
                  KhaanaPrimaryButton(
                    label: 'Continue as owner',
                    icon: Icons.storefront_rounded,
                    onPressed: () => _enter(PortalRole.owner, '/vendor/dashboard'),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: KhaanaSecondaryButton(
                      label: 'Continue as kitchen staff',
                      icon: Icons.kitchen_rounded,
                      onPressed: () => _enter(PortalRole.staff, '/vendor/kitchen'),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                        onPressed: () => Navigator.pushNamed(context, '/vendor/apply-1'),
                        icon: const Icon(Icons.store_mall_directory_outlined, size: 18),
                        label: const Text('Apply as Vendor (E20-US1-UI1)'),
                      ),
                      TextButton.icon(
                        onPressed: () => Navigator.pushNamed(context, '/vendor/locked'),
                        icon: const Icon(Icons.lock_outline_rounded, size: 18),
                        label: const Text('Account locked (E1-US3-UI2)'),
                      ),
                      TextButton.icon(
                        onPressed: () => Navigator.pushNamed(context, '/vendor/reset-password'),
                        icon: const Icon(Icons.password_rounded, size: 18),
                        label: const Text('Reset password (E1-US3-UI4)'),
                      ),
                      TextButton.icon(
                        onPressed: () => Navigator.pushNamed(context, '/admin/sign-in'),
                        icon: const Icon(Icons.admin_panel_settings_outlined, size: 18),
                        label: const Text('Administrator sign-in'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const ProvisionalNote(
            text:
                'Role choice is local mock state. The server still has to reject a real password and enforce permissions.',
          ),
        ],
      ),
    );
  }
}

class OwnerDashboardScreen extends StatelessWidget {
  const OwnerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final session = PortalScope.of(context);
    final band = PrototypeAssumptions.intakeBandLabel(72);
    return KhaanaPage(
      uiId: 'E1-US3-UI5',
      title: 'Owner dashboard',
      maxWidth: 960,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _KpiCard(
                label: "Today's orders",
                value: "Today's orders 18",
                badge: '+14% vs yesterday',
                icon: Icons.shopping_bag_outlined,
                kind: CapacityKind.available,
              ),
              _KpiCard(
                label: 'Gross revenue',
                value: 'Revenue ${formatRupees(42600)}',
                badge: 'Avg ticket Rs 2,366',
                icon: Icons.payments_outlined,
                kind: CapacityKind.info,
              ),
              _KpiCard(
                label: 'Inventory alerts',
                value: 'Low-stock items 2',
                badge: 'Flour & Cream low',
                icon: Icons.inventory_2_outlined,
                kind: CapacityKind.limited,
              ),
              _KpiCard(
                label: 'Custom cake queue',
                value: 'Pending custom orders 1',
                badge: 'Needs quote approval',
                icon: Icons.cake_outlined,
                kind: CapacityKind.limited,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Capacity now $band · 72% of ${session.ordersPerHour} orders an hour',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      SizedBox(
                        width: 280,
                        child: KitchenCapacityMeter(
                          title: 'Now (6:00–7:00 PM)',
                          booked: 5,
                          limit: session.ordersPerHour,
                        ),
                      ),
                      SizedBox(
                        width: 280,
                        child: KitchenCapacityMeter(
                          title: 'Next hour (7:00–8:00 PM)',
                          booked: 9,
                          limit: session.ordersPerHour,
                        ),
                      ),
                      SizedBox(
                        width: 280,
                        child: KitchenCapacityMeter(
                          title: 'Dinner rush (8:00–9:00 PM)',
                          booked: session.ordersPerHour,
                          limit: session.ordersPerHour,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 10,
                    runSpacing: 8,
                    children: [
                      KhaanaSecondaryButton(
                        label: 'Open Kitchen Board',
                        icon: Icons.kitchen_rounded,
                        onPressed: () => Navigator.pushReplacementNamed(context, '/vendor/kitchen'),
                      ),
                      KhaanaSecondaryButton(
                        label: 'Manage Menu',
                        icon: Icons.restaurant_menu_rounded,
                        onPressed: () => Navigator.pushReplacementNamed(context, '/vendor/menu'),
                      ),
                      KhaanaSecondaryButton(
                        label: 'Review Nutrition',
                        icon: Icons.fact_check_outlined,
                        onPressed: () => Navigator.pushNamed(context, '/vendor/nutrition'),
                      ),
                      KhaanaSecondaryButton(
                        label: 'Docked Assistant (E19-US3-UI2)',
                        icon: Icons.smart_toy_outlined,
                        onPressed: () => showVendorAssistantOverlay(context),
                      ),
                      KhaanaSecondaryButton(
                        label: 'Custom Order Review (E4-US3-UI2)',
                        icon: Icons.cake_outlined,
                        onPressed: () => Navigator.pushNamed(context, '/vendor/custom-review'),
                      ),
                      KhaanaSecondaryButton(
                        label: 'Staff & Duties (E1-US4-UI1)',
                        icon: Icons.badge_outlined,
                        onPressed: () => Navigator.pushNamed(context, '/vendor/staff'),
                      ),
                      KhaanaSecondaryButton(
                        label: 'Staff Home (E1-US3-UI6)',
                        icon: Icons.work_outline_rounded,
                        onPressed: () => Navigator.pushNamed(context, '/vendor/staff-home'),
                      ),
                      KhaanaSecondaryButton(
                        label: 'Business Profile (E2-US1-UI1)',
                        icon: Icons.storefront_outlined,
                        onPressed: () => Navigator.pushNamed(context, '/vendor/business-profile'),
                      ),
                      KhaanaSecondaryButton(
                        label: 'Hours & Open/Closed (E2-US3-UI1)',
                        icon: Icons.schedule_rounded,
                        onPressed: () => Navigator.pushNamed(context, '/vendor/hours'),
                      ),
                      KhaanaSecondaryButton(
                        label: 'Delivery & Tariff (E14-US3-UI1 / E15-US1-UI2)',
                        icon: Icons.local_shipping_outlined,
                        onPressed: () => Navigator.pushNamed(context, '/vendor/delivery-settings'),
                      ),
                      KhaanaSecondaryButton(
                        label: 'Bank & Payouts (E1-US3-UI7)',
                        icon: Icons.account_balance_outlined,
                        onPressed: () => Navigator.pushNamed(context, '/vendor/bank'),
                      ),
                      KhaanaSecondaryButton(
                        label: 'Temp Capacity (E5-US1-UI2)',
                        icon: Icons.timelapse_rounded,
                        onPressed: () => showTemporaryCapacityDialog(context),
                      ),
                      KhaanaSecondaryButton(
                        label: 'Buffers & Overrides (E6-US2-UI1)',
                        icon: Icons.thunderstorm_outlined,
                        onPressed: () => Navigator.pushNamed(context, '/vendor/buffers'),
                      ),
                      KhaanaSecondaryButton(
                        label: 'Kitchen Voice (E7-US4-UI1)',
                        icon: Icons.mic_rounded,
                        onPressed: () => showKitchenVoiceCommandsDialog(context),
                      ),
                      KhaanaSecondaryButton(
                        label: 'Recipe List (E8-US1-UI1)',
                        icon: Icons.menu_book_outlined,
                        onPressed: () => Navigator.pushNamed(context, '/vendor/recipe-list'),
                      ),
                      KhaanaSecondaryButton(
                        label: 'Stock / Wastage / Variance / MRP (E9)',
                        icon: Icons.inventory_2_outlined,
                        onPressed: () => Navigator.pushNamed(context, '/vendor/mrp'),
                      ),
                      KhaanaSecondaryButton(
                        label: 'Invoices, Payments, Refunds & COD (E10)',
                        icon: Icons.receipt_long_outlined,
                        onPressed: () => Navigator.pushNamed(context, '/vendor/cod'),
                      ),
                      KhaanaSecondaryButton(
                        label: 'Offers & Combos (E11)',
                        icon: Icons.local_offer_outlined,
                        onPressed: () => Navigator.pushNamed(context, '/vendor/offers'),
                      ),
                      KhaanaSecondaryButton(
                        label: 'Public Store Preview (E2-US1-UI2)',
                        icon: Icons.visibility_outlined,
                        onPressed: () => Navigator.pushNamed(context, '/vendor/public-preview'),
                      ),
                      KhaanaSecondaryButton(
                        label: 'Complaints & Responses (E18-US3-UI4)',
                        icon: Icons.report_problem_outlined,
                        onPressed: () => Navigator.pushNamed(context, '/vendor/complaints'),
                      ),
                      KhaanaSecondaryButton(
                        label: 'Net Profit & Margins (E12-US2-UI1)',
                        icon: Icons.trending_up_rounded,
                        onPressed: () => Navigator.pushNamed(context, '/vendor/net-profit'),
                      ),
                      KhaanaSecondaryButton(
                        label: 'Product Feedback (E18-US2-UI2)',
                        icon: Icons.reviews_outlined,
                        onPressed: () => Navigator.pushNamed(context, '/vendor/feedback'),
                      ),
                      KhaanaSecondaryButton(
                        label: 'Audit Log (E21-US2-UI1)',
                        icon: Icons.policy_outlined,
                        onPressed: () => Navigator.pushNamed(context, '/vendor/audit-log'),
                      ),
                      KhaanaSecondaryButton(
                        label: 'Responsive PWA Layouts (E22-US2-UI1)',
                        icon: Icons.devices_rounded,
                        onPressed: () => Navigator.pushNamed(context, '/vendor/responsive-layouts'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const ProvisionalNote(text: 'These figures are sample data, not a finance calculation.'),
        ],
      ),
    );
  }
}

class _KpiCard extends StatelessWidget {
  const _KpiCard({
    required this.label,
    required this.value,
    required this.badge,
    required this.icon,
    required this.kind,
  });

  final String label;
  final String value;
  final String badge;
  final IconData icon;
  final CapacityKind kind;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(icon, color: KhaanaColors.orangeText),
                  CapacityBadge(kind: kind, label: badge),
                ],
              ),
              const SizedBox(height: 12),
              Text(label, style: const TextStyle(fontSize: 12, color: KhaanaColors.mutedLight, fontWeight: FontWeight.w600)),
              const SizedBox(height: 2),
              Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuListScreen extends StatefulWidget {
  const MenuListScreen({super.key});

  @override
  State<MenuListScreen> createState() => _MenuListScreenState();
}

class _MenuListScreenState extends State<MenuListScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final session = PortalScope.of(context);
    final rows = session.menu.where((row) => row.name.toLowerCase().contains(_query.toLowerCase())).toList();
    return KhaanaPage(
      uiId: 'E2-US2-UI1',
      title: 'Menu',
      footer: KhaanaPrimaryButton(
        label: 'Add item',
        icon: Icons.add_rounded,
        onPressed: () => Navigator.pushNamed(context, '/vendor/menu/edit'),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: const InputDecoration(
              hintText: 'Search menu',
              prefixIcon: Icon(Icons.search_rounded),
            ),
            onChanged: (text) => setState(() => _query = text),
          ),
          const SizedBox(height: 12),
          if (rows.isEmpty)
            KhaanaEmptyState(
              title: 'No menu items match "$_query"',
              message: 'Try another search term or add a new dish to your kitchen menu.',
              actionLabel: 'Clear search',
              onAction: () => setState(() => _query = ''),
            ),
          for (final row in rows)
            Card(
              child: SwitchListTile(
                secondary: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: row.available ? KhaanaColors.orangeTint : KhaanaColors.closedTint,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    row.category == 'Cakes' ? Icons.cake_rounded : Icons.dinner_dining_rounded,
                    color: row.available ? KhaanaColors.onOrangeTint : KhaanaColors.closed,
                  ),
                ),
                title: Row(
                  children: [
                    Expanded(child: Text(row.name, style: const TextStyle(fontWeight: FontWeight.w800))),
                    CapacityBadge(
                      kind: row.available ? CapacityKind.available : CapacityKind.closed,
                      label: row.available ? 'Available' : 'Paused',
                    ),
                  ],
                ),
                subtitle: Text('${row.category} · ${formatRupees(row.price)}'),
                value: row.available,
                onChanged: (_) => session.toggleItem(row),
              ),
            ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              KhaanaSecondaryButton(
                label: 'Customization options (E2-US4-UI1)',
                icon: Icons.tune_rounded,
                onPressed: () => Navigator.pushNamed(context, '/vendor/customization-options'),
              ),
              KhaanaSecondaryButton(
                label: 'Categories & order (E2-US2-UI4)',
                icon: Icons.category_outlined,
                onPressed: () => Navigator.pushNamed(context, '/vendor/categories'),
              ),
              KhaanaSecondaryButton(
                label: 'Dietary & allergen tags (E8-US3-UI1)',
                icon: Icons.eco_outlined,
                onPressed: () => Navigator.pushNamed(context, '/vendor/dietary-tags'),
              ),
              KhaanaSecondaryButton(
                label: 'Delete menu item (E2-US2-UI3)',
                icon: Icons.delete_outline_rounded,
                onPressed: () => showDeleteMenuItemDialog(
                  context,
                  itemName: rows.isNotEmpty ? rows.first.name : 'Chocolate Cake',
                  onConfirmDelete: () {
                    if (rows.isNotEmpty) {
                      session.removeItem(rows.first);
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class EditItemScreen extends StatefulWidget {
  const EditItemScreen({super.key});

  @override
  State<EditItemScreen> createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  final _name = TextEditingController();
  final _price = TextEditingController();
  final _category = TextEditingController(text: 'Cakes');
  String? _error;

  @override
  void dispose() {
    _name.dispose();
    _price.dispose();
    _category.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E2-US2-UI2',
      title: 'Add or edit item',
      footer: KhaanaPrimaryButton(
        label: 'Save item',
        icon: Icons.check_rounded,
        onPressed: () {
          final error = PortalScope.of(context).addItem(
            name: _name.text,
            price: _price.text,
            category: _category.text,
          );
          setState(() => _error = error);
          if (error == null) Navigator.pop(context);
        },
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(controller: _name, decoration: const InputDecoration(labelText: 'Name')),
              const SizedBox(height: 12),
              TextField(
                controller: _price,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              TextField(controller: _category, decoration: const InputDecoration(labelText: 'Category')),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: KhaanaColors.surface2Light,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: KhaanaColors.lineLight),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.image_outlined, color: KhaanaColors.mutedLight),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Photo and add-on editing stay on this form as fields. Only JPG or PNG files up to 5 MB are allowed. No image file is stored in the mock.',
                        style: TextStyle(fontSize: 12, color: KhaanaColors.mutedLight),
                      ),
                    ),
                  ],
                ),
              ),
              if (_error != null) ...[
                const SizedBox(height: 12),
                KhaanaInlineBanner(text: _error!),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class CapacityScreen extends StatefulWidget {
  const CapacityScreen({super.key});

  @override
  State<CapacityScreen> createState() => _CapacityScreenState();
}

class _CapacityScreenState extends State<CapacityScreen> {
  final _orders = TextEditingController(text: '12');

  @override
  void dispose() {
    _orders.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final session = PortalScope.of(context);
    return KhaanaPage(
      uiId: 'E5-US1-UI1',
      title: 'Kitchen capacity',
      footer: KhaanaPrimaryButton(
        label: 'Save capacity',
        icon: Icons.save_outlined,
        onPressed: () => session.saveCapacity(_orders.text),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KitchenCapacityMeter(
            title: 'Current hourly intake meter',
            booked: 9,
            limit: session.ordersPerHour,
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Orders per hour', style: TextStyle(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _orders,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.speed_rounded),
                      suffixText: 'orders / hr',
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Per-item prep times and oven limits are recorded with the recipe and are not a second capacity number.',
                    style: TextStyle(fontSize: 13, color: KhaanaColors.mutedLight),
                  ),
                  if (session.capacityError != null) ...[
                    const SizedBox(height: 10),
                    KhaanaInlineBanner(text: session.capacityError!),
                  ],
                  const SizedBox(height: 14),
                  KhaanaSecondaryButton(
                    label: 'Live utilisation',
                    icon: Icons.analytics_outlined,
                    onPressed: () => Navigator.pushNamed(context, '/vendor/utilisation'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UtilisationScreen extends StatelessWidget {
  const UtilisationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final session = PortalScope.of(context);
    const load = 9;
    final percent = ((load * 100) / session.ordersPerHour).round();
    final band = PrototypeAssumptions.intakeBandLabel(percent);
    return KhaanaPage(
      uiId: 'E5-US1-UI3',
      title: 'Live utilisation',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (session.intakePaused || band == 'Full') const IntakeBanner(),
          KitchenCapacityMeter(
            title: 'Live hourly slot load',
            booked: load,
            limit: session.ordersPerHour,
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$band · $percent% · $load of ${session.ordersPerHour} orders',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 8),
                  const Text('Full is an intake limit, not proof that the kitchen is physically full.'),
                  const SizedBox(height: 4),
                  const Text('Upcoming 7:30 PM is full. 8:30 PM still has places.'),
                ],
              ),
            ),
          ),
          const ProvisionalNote(text: '60% and 85% bands are provisional and awaiting review.'),
        ],
      ),
    );
  }
}

class IntakeBanner extends StatelessWidget {
  const IntakeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final session = PortalScope.of(context);
    return Card(
      color: KhaanaColors.fullTint,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: KhaanaColors.full),
      ),
      child: ListTile(
        leading: const Icon(Icons.pause_circle_filled_rounded, color: KhaanaColors.full),
        title: const Text('Intake paused', style: TextStyle(fontWeight: FontWeight.w800, color: KhaanaColors.full)),
        subtitle: Text(
          'Queue is at the intake limit. ${session.ordersPerHour} orders an hour.',
          style: const TextStyle(color: KhaanaColors.full),
        ),
        trailing: TextButton(
          onPressed: session.resumeIntake,
          child: const Text('Resume', style: TextStyle(fontWeight: FontWeight.w800, color: KhaanaColors.full)),
        ),
      ),
    );
  }
}

class KitchenScreen extends StatefulWidget {
  const KitchenScreen({super.key});

  @override
  State<KitchenScreen> createState() => _KitchenScreenState();
}

class _KitchenScreenState extends State<KitchenScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final session = PortalScope.of(context);
      if (!session.showNewOrder) return;
      SystemChrome.setApplicationSwitcherDescription(
        const ApplicationSwitcherDescription(label: 'New order · KhaanaGo', primaryColor: 0xFFF97316),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final session = PortalScope.of(context);
    const columns = [
      ('new', 'NEW'),
      ('preparing', 'PREPARING'),
      ('ready', 'READY'),
      ('handed', 'HANDED OVER'),
    ];
    return Theme(
      data: khaanaTheme(KhaanaThemeKind.dark),
      child: KhaanaPage(
        uiId: 'E7-US3-UI1',
        title: 'Kitchen board',
        maxWidth: 1080,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (session.showNewOrder) const NewOrderAlert(),
            if (session.intakePaused) const IntakeBanner(),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final col in columns)
                    Container(
                      width: 245,
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: KhaanaColors.surface2Dark,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: KhaanaColors.lineDark),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                col.$1,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 13,
                                  letterSpacing: 0.6,
                                  color: KhaanaColors.mutedDark,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: KhaanaColors.surfaceDark,
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text(
                                  '${session.tickets.where((t) => t.column == col.$1).length}',
                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          if (session.tickets.where((ticket) => ticket.column == col.$1).isEmpty)
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: KhaanaColors.lineDark),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'No tickets in ${col.$2.toLowerCase()}',
                                style: const TextStyle(fontSize: 12, color: KhaanaColors.mutedDark),
                              ),
                            ),
                          for (final ticket in session.tickets.where((ticket) => ticket.column == col.$1))
                            _TicketCard(ticket: ticket),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewOrderAlert extends StatelessWidget {
  const NewOrderAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: KhaanaColors.orangeTintDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: KhaanaColors.orange, width: 1.5),
      ),
      child: ListTile(
        leading: const Icon(Icons.notifications_active_rounded, color: KhaanaColors.orange),
        title: const Text('New order', style: TextStyle(fontWeight: FontWeight.w800)),
        subtitle: const Text(
          'Visual alert. Sound is not played in this mock. The browser tab title is set to New order.',
        ),
        trailing: TextButton(
          onPressed: () {
            PortalScope.of(context).dismissAlert();
            SystemChrome.setApplicationSwitcherDescription(
              const ApplicationSwitcherDescription(label: 'KhaanaGo', primaryColor: 0xFFF97316),
            );
          },
          child: const Text('Dismiss'),
        ),
      ),
    );
  }
}

class _TicketCard extends StatelessWidget {
  const _TicketCard({required this.ticket});

  final KitchenTicket ticket;

  @override
  Widget build(BuildContext context) {
    final session = PortalScope.of(context);
    return Card(
      color: KhaanaColors.surfaceDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: Color(0xFF4A4743)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('#${ticket.number}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                CapacityBadge(
                  kind: switch (ticket.column) {
                    'new' => CapacityKind.info,
                    'preparing' => CapacityKind.limited,
                    'ready' => CapacityKind.info,
                    _ => CapacityKind.available,
                  },
                  label: switch (ticket.column) {
                    'new' => 'Just in',
                    'preparing' => '8:42',
                    'ready' => 'Rider 3 min',
                    _ => 'Done',
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(ticket.summary, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            if (ticket.allergen != null) ...[
              const SizedBox(height: 8),
              KhaanaInlineBanner(
                kind: CapacityKind.full,
                text: ticket.allergen!,
              ),
            ],
            const SizedBox(height: 10),
            if (ticket.column == 'new') ...[
              KhaanaPrimaryButton(
                label: 'Accept',
                onPressed: () => session.moveTicket(ticket, 'preparing'),
              ),
              const SizedBox(height: 4),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () async {
                    final reason = await showDialog<String>(
                      context: context,
                      builder: (context) => const _RejectDialog(),
                    );
                    if (reason != null && reason.trim().isNotEmpty) session.rejectTicket(ticket);
                  },
                  child: const Text('Reject'),
                ),
              ),
            ],
            if (ticket.column == 'preparing') ...[
              Row(
                children: [
                  Icon(
                    ticket.markedEighty ? Icons.check_circle_rounded : Icons.timelapse_rounded,
                    size: 15,
                    color: ticket.markedEighty ? KhaanaColors.availableDark : KhaanaColors.limitedDark,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      ticket.markedEighty ? 'Marked 80% prepared' : 'Not yet at 80%',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Wrap(
                spacing: 4,
                children: [
                  TextButton(
                    onPressed: () => session.markEighty(ticket),
                    child: const Text('Mark 80% prepared'),
                  ),
                  TextButton(
                    onPressed: () => session.moveTicket(ticket, 'ready'),
                    child: const Text('Ready'),
                  ),
                ],
              ),
            ],
            if (ticket.column == 'ready')
              TextButton.icon(
                onPressed: () => session.moveTicket(ticket, 'handed'),
                icon: const Icon(Icons.check_rounded, size: 16),
                label: const Text('Handed over'),
              ),
          ],
        ),
      ),
    );
  }
}

class _RejectDialog extends StatefulWidget {
  const _RejectDialog();

  @override
  State<_RejectDialog> createState() => _RejectDialogState();
}

class _RejectDialogState extends State<_RejectDialog> {
  final _reason = TextEditingController();

  @override
  void dispose() {
    _reason.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: KhaanaColors.orangeTint, borderRadius: BorderRadius.circular(6)),
            child: const Text('E7-US2-UI1', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: KhaanaColors.onOrangeTint)),
          ),
          const SizedBox(width: 8),
          const Expanded(child: Text('Reject order')),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(controller: _reason, decoration: const InputDecoration(labelText: 'Reason *')),
          const SizedBox(height: 10),
          const KhaanaInlineBanner(
            kind: CapacityKind.limited,
            text: 'Prepaid Order Flag (E7-US2 AC2): Rejecting a prepaid order automatically flags the invoice for customer refund on E10-US3-UI2.',
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Keep')),
        TextButton(onPressed: () => Navigator.pop(context, _reason.text), child: const Text('Reject & flag refund')),
      ],
    );
  }
}

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({super.key});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  final _name = TextEditingController();
  final _qty = TextEditingController();
  final _unit = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _name.dispose();
    _qty.dispose();
    _unit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E8-US1-UI2',
      title: 'Recipe editor',
      footer: KhaanaPrimaryButton(
        label: 'Save ingredient',
        icon: Icons.add_task_rounded,
        onPressed: () {
          final error = PortalScope.of(context).saveRecipe(
            name: _name.text,
            qty: _qty.text,
            unit: _unit.text,
          );
          setState(() => _error = error);
          if (error == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Ingredient saved to recipe.')),
            );
          }
        },
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Chocolate cake · Recipe BOM', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
                      TextButton.icon(
                        onPressed: () => Navigator.pushNamed(context, '/vendor/nutrition'),
                        icon: const Icon(Icons.fact_check_outlined, size: 16),
                        label: const Text('Nutrition review'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextField(controller: _name, decoration: const InputDecoration(labelText: 'Ingredient')),
                  const SizedBox(height: 12),
                  TextField(controller: _qty, decoration: const InputDecoration(labelText: 'Quantity')),
                  const SizedBox(height: 12),
                  TextField(controller: _unit, decoration: const InputDecoration(labelText: 'Unit')),
                  if (_error != null) ...[
                    const SizedBox(height: 12),
                    KhaanaInlineBanner(text: _error!),
                  ],
                ],
              ),
            ),
          ),
          const ProvisionalNote(
            text: 'Recipe quantities stay on this owner screen. Kitchen staff are not given this route.',
          ),
        ],
      ),
    );
  }
}

class NutritionScreen extends StatelessWidget {
  const NutritionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final session = PortalScope.of(context);
    return KhaanaPage(
      uiId: 'E8-US2-UI1',
      title: 'Nutrition review',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (session.nutritionApiDown)
            KhaanaErrorState(
              title: 'Nutrition service unreachable',
              message: 'Nutrition values could not be refreshed. Retry when the service answers.',
              onRetry: session.toggleNutritionApi,
            )
          else
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Chocolate cake (per serving)', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
                    SizedBox(height: 12),
                    NutritionStrip(kcal: 420, protein: '6 g', carbs: '52 g', fat: '21 g'),
                    SizedBox(height: 10),
                    Text('Per serving: 420 kcal, 6 g protein, 52 g carbs, 21 g fat. Allergens: eggs, dairy, gluten.'),
                    SizedBox(height: 10),
                    KhaanaInlineBanner(
                      kind: CapacityKind.full,
                      text: 'Contains eggs, dairy and gluten. May contain nuts.',
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 8),
          TextButton.icon(
            onPressed: session.toggleNutritionApi,
            icon: const Icon(Icons.cloud_off_rounded, size: 16),
            label: const Text('Preview unreachable nutrition service'),
          ),
          const ProvisionalNote(text: 'Values are sample data. The nutrition service is not called.'),
        ],
      ),
    );
  }
}

class StockScreen extends StatelessWidget {
  const StockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final session = PortalScope.of(context);
    return KhaanaPage(
      uiId: 'E9-US1-UI1',
      title: 'Stock',
      footer: session.isStaff
          ? null
          : KhaanaPrimaryButton(
              label: 'Dish bill of materials',
              icon: Icons.assignment_outlined,
              onPressed: () => Navigator.pushNamed(context, '/vendor/bom'),
            ),
      child: Column(
        children: [
          for (final item in session.ingredients)
            Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: item.$3 <= item.$4 ? KhaanaColors.limitedTint : KhaanaColors.availableTint,
                  child: Icon(
                    Icons.inventory_2_outlined,
                    color: item.$3 <= item.$4 ? KhaanaColors.limited : KhaanaColors.available,
                    size: 20,
                  ),
                ),
                title: Text(item.$1, style: const TextStyle(fontWeight: FontWeight.w800)),
                subtitle: Text('${item.$2} · on hand ${item.$3} · reorder ${item.$4} · ${item.$5}'),
                trailing: item.$3 <= item.$4
                    ? const CapacityBadge(kind: CapacityKind.limited, label: 'Low')
                    : const CapacityBadge(kind: CapacityKind.available, label: 'OK'),
              ),
            ),
          const ProvisionalNote(text: 'Stock movement from a real order is not posted by this screen.'),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              KhaanaSecondaryButton(
                label: 'Add/edit ingredient (E9-US1-UI2)',
                onPressed: () => Navigator.pushNamed(context, '/vendor/ingredient/edit'),
              ),
              KhaanaSecondaryButton(
                label: 'Stock intake (E9-US1-UI3)',
                onPressed: () => showStockIntakeDialog(context),
              ),
              KhaanaSecondaryButton(
                label: 'Low-stock alerts (E9-US2-UI1)',
                onPressed: () => Navigator.pushNamed(context, '/vendor/low-stock'),
              ),
              KhaanaSecondaryButton(
                label: 'Log wastage (E9-US3-UI1)',
                onPressed: () => showLogWastageDialog(context),
              ),
              KhaanaSecondaryButton(
                label: 'Variance report (E9-US3-UI2)',
                onPressed: () => Navigator.pushNamed(context, '/vendor/variance'),
              ),
              KhaanaSecondaryButton(
                label: 'Material planner (E9-US4-UI1)',
                onPressed: () => Navigator.pushNamed(context, '/vendor/mrp'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BomScreen extends StatelessWidget {
  const BomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E9-US1-UI4',
      title: 'Dish bill of materials',
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Chocolate cake, per serving', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
              Divider(height: 24),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.grass_rounded, color: KhaanaColors.orangeText),
                title: Text('Flour 0.15 kg', style: TextStyle(fontWeight: FontWeight.w700)),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.egg_outlined, color: KhaanaColors.orangeText),
                title: Text('Eggs 1', style: TextStyle(fontWeight: FontWeight.w700)),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.water_drop_outlined, color: KhaanaColors.orangeText),
                title: Text('Cream 0.05 litre', style: TextStyle(fontWeight: FontWeight.w700)),
              ),
              ProvisionalNote(text: 'Quantities are sample data for one dish. Staff are not routed here.'),
            ],
          ),
        ),
      ),
    );
  }
}

class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E10-US1-UI3',
      title: 'Invoice KG-1042',
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Tax & Order Invoice #KG-1042', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                  CapacityBadge(kind: CapacityKind.available, label: 'Paid · JazzCash'),
                ],
              ),
              SizedBox(height: 14),
              PriceLines(
                lines: [
                  ('Chocolate cake', 1850),
                  ('Delivery', 164),
                  ('Pooled discount', -49),
                ],
                total: 1965,
              ),
              SizedBox(height: 14),
            ],
          ),
        ),
      ),
      footer: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          KhaanaSecondaryButton(
            label: 'Invoice list (E10-US1-UI2)',
            onPressed: () => Navigator.pushNamed(context, '/vendor/invoices'),
          ),
          KhaanaSecondaryButton(
            label: 'Payments (E10-US2-UI1)',
            onPressed: () => Navigator.pushNamed(context, '/vendor/payments'),
          ),
          KhaanaSecondaryButton(
            label: 'Refunds (E10-US3-UI2)',
            onPressed: () => Navigator.pushNamed(context, '/vendor/refunds'),
          ),
          KhaanaSecondaryButton(
            label: 'COD Reconciliation (E10-US4-UI1)',
            onPressed: () => Navigator.pushNamed(context, '/vendor/cod'),
          ),
        ],
      ),
    );
  }
}

class FinanceScreen extends StatelessWidget {
  const FinanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E12-US1-UI1',
      title: 'Finance',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Daily Settlement Summary', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                      CapacityBadge(kind: CapacityKind.available, label: 'Today'),
                    ],
                  ),
                  const Divider(height: 24),
                  Text('Revenue ${formatRupees(42600)}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 8),
                  Text('Commission ${formatRupees(4260)}'),
                  const SizedBox(height: 8),
                  Text('Payouts ${formatRupees(36000)}', style: const TextStyle(color: KhaanaColors.available, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),
                  Text('Expenses ${formatRupees(18000)}'),
                  const SizedBox(height: 10),
                  const Text('Date range: today. Sample figures only.', style: TextStyle(fontSize: 12, color: KhaanaColors.mutedLight)),
                ],
              ),
            ),
          ),
          const ProvisionalNote(text: 'Commission rules and exports are not calculated here.'),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              KhaanaSecondaryButton(
                label: 'Commission & payouts (E12-US1-UI2)',
                onPressed: () => Navigator.pushNamed(context, '/vendor/commission'),
              ),
              KhaanaSecondaryButton(
                label: 'Expenses (E12-US1-UI3)',
                onPressed: () => Navigator.pushNamed(context, '/vendor/expenses'),
              ),
              KhaanaSecondaryButton(
                label: 'Add expense (E12-US1-UI4)',
                onPressed: () => showAddExpenseDialog(context),
              ),
              KhaanaSecondaryButton(
                label: 'Net profit & dish margins (E12-US2-UI1)',
                onPressed: () => Navigator.pushNamed(context, '/vendor/net-profit'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
