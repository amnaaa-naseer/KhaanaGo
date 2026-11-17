import 'dart:async';

import 'package:flutter/material.dart';

import 'api.dart';
import 'catalog.g.dart';
import 'checkout_session.dart';
import 'customer_experience.dart';
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
  final List<String> _stack = [];
  String _query = '';
  var _showCatalog = false;
  var _lastTab = 0;
  Timer? _poll;
  late bool _devTools = Uri.base.queryParameters['dev'] == '1';

  static const _customerTabs = ['E3-US1-UI1', 'E17-US2-UI1', 'E19-US1-UI1', 'E1-US5-UI1'];
  static const _checkoutIds = {'E3-US1-UI3', 'E4-US1-UI1', 'E3-US2-UI1', 'E14-US2-UI1', 'E5-US3-UI1', 'E3-US3-UI1', 'E3-US2-UI2', 'E3-US4-UI2'};

  @override
  void initState() {
    super.initState();
    _stack.add(widget.homeId);
    _session.addListener(_onSession);
    _ensurePoll();
  }

  @override
  void dispose() {
    _poll?.cancel();
    _session.removeListener(_onSession);
    super.dispose();
  }

  void _onSession() {
    if (!mounted) return;
    setState(_ensurePoll);
  }

  void _ensurePoll() {
    final active = widget.role == 'customer' && _session.orderId != null && _session.orderStatus != 'delivered' && _session.orderStatus != 'cancelled';
    if (active && _poll == null) {
      _poll = Timer.periodic(const Duration(seconds: 3), (_) => _refreshOrder());
    } else if (!active) {
      _poll?.cancel();
      _poll = null;
    }
  }

  Future<void> _refreshOrder() async {
    try {
      final data = await widget.api.state(role: widget.role);
      if (!mounted) return;
      final match = ((data['orders'] as List?) ?? []).whereType<Map>().where((order) => '${order['id']}' == _session.orderId).firstOrNull;
      if (match != null) _session.rememberOrder(match);
    } catch (_) {}
  }

  void _open(String id) {
    setState(() {
      final tab = _customerTabs.indexOf(id);
      if (tab >= 0) {
        _lastTab = tab;
        _stack
          ..clear()
          ..add(id);
      } else if (id == 'E17-US1-UI1' && _stack.any(_checkoutIds.contains)) {
        _stack
          ..clear()
          ..add('E3-US1-UI1')
          ..add(id);
      } else if (_stack.isEmpty || _stack.last != id) {
        _stack.add(id);
      }
      _id = _stack.last;
    });
  }

  void _back() {
    if (_stack.length <= 1) return;
    setState(() {
      _stack.removeLast();
      _id = _stack.last;
    });
  }

  void _goTab(int index) {
    setState(() {
      _lastTab = index;
      _stack
        ..clear()
        ..add(_customerTabs[index]);
      _id = _stack.last;
    });
  }

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
    final customer = widget.role == 'customer';
    final bare = customer && (_id == 'E3-US1-UI1' || _id == 'E17-US1-UI1');
    final showBack = _stack.length > 1;
    final tabIndex = _customerTabs.indexOf(_id);
    return MaterialApp(
      title: 'KhaanaGo',
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: Builder(builder: (context) {
        return PopScope(
          canPop: _stack.length <= 1,
          onPopInvokedWithResult: (didPop, _) {
            if (!didPop) _back();
          },
          child: Scaffold(
            appBar: bare ? null : AppBar(
              backgroundColor: dark ? const Color(0xFF242424) : Colors.white,
              foregroundColor: dark ? const Color(0xFFFFF8EF) : const Color(0xFF242424),
              automaticallyImplyLeading: _showCatalog && !showBack,
              leading: showBack ? IconButton(tooltip: 'Back', onPressed: _back, icon: const Icon(Icons.arrow_back)) : null,
              title: GestureDetector(
                onLongPress: () => setState(() => _devTools = !_devTools),
                child: Text(spec.title),
              ),
              actions: [
                if (_devTools)
                  IconButton(
                    tooltip: 'Screen list',
                    onPressed: () => setState(() => _showCatalog = !_showCatalog),
                    icon: const Icon(Icons.menu),
                  ),
              ],
            ),
            bottomNavigationBar: customer ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_trackBanner() case final banner?) banner,
                NavigationBar(
                  selectedIndex: tabIndex >= 0 ? tabIndex : _lastTab,
                  onDestinationSelected: _goTab,
                  destinations: const [
                    NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
                    NavigationDestination(icon: Icon(Icons.receipt_long_outlined), label: 'Orders'),
                    NavigationDestination(icon: Icon(Icons.chat_bubble_outline), label: 'Assistant'),
                    NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profile'),
                  ],
                ),
              ],
            ) : null,
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
                                onTap: () { _open(item.id); Navigator.pop(context); },
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
            body: SafeArea(
              top: bare,
              bottom: false,
              child: ScreenPage(
                key: ValueKey(spec.id),
                spec: spec,
                api: widget.api,
                role: widget.role,
                embedded: true,
                session: _session,
                devTools: _devTools,
                onBack: customer && _id == 'E17-US1-UI1' && showBack ? _back : null,
                onDevToggle: () => setState(() => _devTools = !_devTools),
                onOpenCatalog: () => setState(() => _showCatalog = !_showCatalog),
                onOpen: _open,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget? _trackBanner() {
    final status = _session.orderStatus;
    final active = _session.orderId != null && status != 'delivered' && status != 'cancelled';
    if (!active || _id == 'E17-US1-UI1') return null;
    return Material(
      color: const Color(0xFFF97316),
      child: InkWell(
        key: const Key('track-banner'),
        onTap: () => _open('E17-US1-UI1'),
        child: SizedBox(
          height: 48,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(children: [
              const Text('Track order', style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF242424))),
              const Spacer(),
              Flexible(child: Text(trackingHeadline(_session.activeOrder), overflow: TextOverflow.ellipsis, style: const TextStyle(color: Color(0xFF242424)))),
              const SizedBox(width: 8),
              const Icon(Icons.chevron_right, color: Color(0xFF242424)),
            ]),
          ),
        ),
      ),
    );
  }
}
