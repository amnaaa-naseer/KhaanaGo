import 'package:flutter/material.dart';
import 'package:khaana_design/khaana_design.dart';

import 'scope.dart';
import 'session.dart';

class PortalShell extends StatelessWidget {
  const PortalShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final session = PortalScope.of(context);
    final role = session.role;
    if (role == null) return child;
    final items = role == PortalRole.admin ? _admin : (role == PortalRole.staff ? _staff : _owner);
    final currentRoute = ModalRoute.of(context)?.settings.name ?? '';
    var selectedIndex = items.indexWhere((item) => currentRoute.startsWith(item.route));
    if (selectedIndex < 0) selectedIndex = 0;

    final wide = MediaQuery.sizeOf(context).width >= 900;
    if (!wide) {
      return Column(
        children: [
          Material(
            color: KhaanaColors.charcoal,
            child: SafeArea(
              bottom: false,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Row(
                  children: [
                    const KhaanaLogo(size: 28, borderRadius: 8),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: KhaanaColors.orange,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        role.name.toUpperCase(),
                        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: KhaanaColors.charcoal),
                      ),
                    ),
                    const SizedBox(width: 8),
                    for (var i = 0; i < items.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: TextButton.icon(
                          style: TextButton.styleFrom(
                            backgroundColor: selectedIndex == i ? KhaanaColors.orange : Colors.transparent,
                            foregroundColor: selectedIndex == i ? KhaanaColors.charcoal : KhaanaColors.cream,
                          ),
                          onPressed: () => Navigator.pushReplacementNamed(context, items[i].route),
                          icon: Icon(items[i].icon, size: 16),
                          label: Text(items[i].label, style: const TextStyle(fontWeight: FontWeight.w700)),
                        ),
                      ),
                    TextButton.icon(
                      style: TextButton.styleFrom(foregroundColor: const Color(0xFFFDBA74)),
                      onPressed: () {
                        session.signOut();
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          role == PortalRole.admin ? '/admin/sign-in' : '/vendor/sign-in',
                          (_) => false,
                        );
                      },
                      icon: const Icon(Icons.logout_rounded, size: 16),
                      label: const Text('Sign out'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(child: child),
        ],
      );
    }

    return Row(
      children: [
        NavigationRail(
          backgroundColor: Colors.white,
          selectedIndex: selectedIndex,
          indicatorColor: KhaanaColors.orange,
          selectedIconTheme: const IconThemeData(color: KhaanaColors.charcoal),
          selectedLabelTextStyle: const TextStyle(
            fontWeight: FontWeight.w800,
            color: KhaanaColors.charcoal,
            fontSize: 12,
          ),
          unselectedLabelTextStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            color: KhaanaColors.mutedLight,
            fontSize: 12,
          ),
          labelType: NavigationRailLabelType.all,
          leading: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: Column(
              children: [
                const KhaanaLogo(size: 40, borderRadius: 12),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: KhaanaColors.orangeTint,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: KhaanaColors.orange),
                  ),
                  child: Text(
                    role.name,
                    style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 11, color: KhaanaColors.onOrangeTint),
                  ),
                ),
              ],
            ),
          ),
          trailing: Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: TextButton.icon(
                  onPressed: () {
                    session.signOut();
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      role == PortalRole.admin ? '/admin/sign-in' : '/vendor/sign-in',
                      (_) => false,
                    );
                  },
                  icon: const Icon(Icons.logout_rounded, size: 16),
                  label: const Text('Sign out'),
                ),
              ),
            ),
          ),
          destinations: [
            for (final item in items)
              NavigationRailDestination(
                icon: Icon(item.icon),
                label: Text(item.label),
              ),
          ],
          onDestinationSelected: (index) => Navigator.pushReplacementNamed(context, items[index].route),
        ),
        const VerticalDivider(width: 1),
        Expanded(child: child),
      ],
    );
  }
}

class _Nav {
  const _Nav(this.label, this.route, this.icon);
  final String label;
  final String route;
  final IconData icon;
}

const _owner = [
  _Nav('Dashboard', '/vendor/dashboard', Icons.dashboard_outlined),
  _Nav('Menu', '/vendor/menu', Icons.restaurant_menu),
  _Nav('Capacity', '/vendor/capacity', Icons.speed),
  _Nav('Kitchen', '/vendor/kitchen', Icons.kitchen),
  _Nav('Recipes', '/vendor/recipe', Icons.menu_book_outlined),
  _Nav('Stock', '/vendor/stock', Icons.inventory_2_outlined),
  _Nav('Invoice', '/vendor/invoice', Icons.receipt_long),
  _Nav('Finance', '/vendor/finance', Icons.payments_outlined),
];

const _staff = [
  _Nav('Kitchen', '/vendor/kitchen', Icons.kitchen),
  _Nav('Menu', '/vendor/menu', Icons.restaurant_menu),
  _Nav('Capacity', '/vendor/capacity', Icons.speed),
  _Nav('Stock', '/vendor/stock', Icons.inventory_2_outlined),
  _Nav('Invoice', '/vendor/invoice', Icons.receipt_long),
];

const _admin = [
  _Nav('Monitor', '/admin/dashboard', Icons.monitor_heart_outlined),
  _Nav('Buffers', '/admin/buffers', Icons.tune),
];
