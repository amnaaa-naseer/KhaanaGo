import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';

import 'api.dart';
import 'catalog.g.dart';
import 'checkout_session.dart';
import 'screen_spec.dart';
import 'screen_view.dart';

class KhaanaApp extends StatefulWidget {
  const KhaanaApp({super.key, required this.role, required this.api, required this.homeId, this.session});

  final String role;
  final KhaanaApi api;
  final String homeId;
  final CheckoutSession? session;

  @override
  State<KhaanaApp> createState() => _KhaanaAppState();
}

class _KhaanaAppState extends State<KhaanaApp> {
  late String _id = widget.homeId;
  late final CheckoutSession _session = widget.session ?? CheckoutSession();
  String _query = '';
  var _showCatalog = false;

  static const _customerTabs = ['E3-US1-UI1', 'E17-US2-UI1', 'E19-US1-UI1', 'E1-US5-UI1'];

  @override
  Widget build(BuildContext context) {
    final dark = widget.role == 'rider';
    final screens = kScreenCatalog.where((item) => item.role == widget.role || item.role == 'shared').toList();
    final spec = kScreenCatalog.where((item) => item.id == _id).firstOrNull ?? screens.first;
    final needle = _query.trim().toLowerCase();
    final visible = screens.where((item) => needle.isEmpty || '${item.title} ${item.id} ${item.module}'.toLowerCase().contains(needle)).toList();
    final groups = <String, List<ScreenSpec>>{};
    for (final item in visible) {
      groups.putIfAbsent(item.module.isEmpty ? 'Shared' : item.module, () => []).add(item);
    }
    final theme = ThemeData(
      useMaterial3: true,
      brightness: dark ? Brightness.dark : Brightness.light,
      scaffoldBackgroundColor: dark ? const Color(0xFF1A1A1A) : const Color(0xFFFFF8EF),
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF97316), brightness: dark ? Brightness.dark : Brightness.light),
    );
    return MaterialApp(
      title: 'KhaanaGo',
      theme: theme,
      home: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: dark ? const Color(0xFF242424) : Colors.white,
            foregroundColor: dark ? const Color(0xFFFFF8EF) : const Color(0xFF242424),
            automaticallyImplyLeading: _showCatalog,
            title: Text(spec.title),
            actions: [
              if (kDebugMode)
                IconButton(
                  tooltip: 'Developer screen catalog',
                  onPressed: () => setState(() => _showCatalog = !_showCatalog),
                  icon: const Icon(Icons.developer_mode),
                ),
            ],
          ),
          bottomNavigationBar: widget.role == 'customer'
              ? NavigationBar(
                  selectedIndex: _customerTabs.contains(_id) ? _customerTabs.indexOf(_id) : 0,
                  onDestinationSelected: (index) => setState(() => _id = _customerTabs[index]),
                  destinations: const [
                    NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
                    NavigationDestination(icon: Icon(Icons.receipt_long_outlined), label: 'Orders'),
                    NavigationDestination(icon: Icon(Icons.chat_bubble_outline), label: 'Assistant'),
                    NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profile'),
                  ],
                )
              : null,
          drawer: _showCatalog ? Drawer(
            child: SafeArea(
              child: Column(
                children: [
                  const ListTile(title: Text('KhaanaGo', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800))),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      decoration: const InputDecoration(labelText: 'Find a screen', prefixIcon: Icon(Icons.search)),
                      onChanged: (value) => setState(() => _query = value),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        for (final entry in groups.entries) ...[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                            child: Text(entry.key, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF6B635B))),
                          ),
                          for (final item in entry.value)
                            ListTile(
                              selected: item.id == spec.id,
                              title: Text(item.title),
                              subtitle: Text(item.id),
                              onTap: () { setState(() => _id = item.id); Navigator.pop(context); },
                            ),
                        ],
                        if (visible.isEmpty) const ListTile(title: Text('No screens match.')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ) : null,
          body: ScreenPage(key: ValueKey(spec.id), spec: spec, api: widget.api, role: widget.role, embedded: true, session: _session, onOpen: (id) => setState(() => _id = id)),
        );
      }),
    );
  }
}
