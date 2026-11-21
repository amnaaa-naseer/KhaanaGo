import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'api.dart';
import 'checkout_session.dart';
import 'components.dart';
import 'customer_experience.dart';
import 'screen_spec.dart';
import 'tokens.dart';

class ScreenPage extends StatefulWidget {
  const ScreenPage({super.key, required this.spec, required this.api, required this.onOpen, this.role = 'customer', this.embedded = false, this.session, this.devTools = false, this.onBack, this.onDevToggle, this.onOpenCatalog});

  final ScreenSpec spec;
  final KhaanaApi api;
  final void Function(String id) onOpen;
  final String role;
  final bool embedded;
  final CheckoutSession? session;
  final bool devTools;
  final VoidCallback? onBack;
  final VoidCallback? onDevToggle;
  final VoidCallback? onOpenCatalog;

  @override
  State<ScreenPage> createState() => _ScreenPageState();
}

class _ScreenPageState extends State<ScreenPage> {
  Map<String, dynamic>? _data;
  Object? _error;
  var _loading = true;
  var _preview = 'ready';
  final _fields = <String, TextEditingController>{};
  String? _notice;
  String _delivery = 'express';
  String _slot = '1830';
  String _payment = 'Cash on delivery';
  var _qty = 1;
  final _deliveryCode = TextEditingController();
  final _identifier = TextEditingController();
  final _password = TextEditingController();
  late final CheckoutSession _ownedSession = CheckoutSession();
  CheckoutSession get _session => widget.session ?? _ownedSession;

  @override
  void initState() {
    super.initState();
    _session.addListener(_onSession);
    for (final clause in widget.spec.clauses) {
      _fields[clause] = TextEditingController();
    }
    _load();
  }

  void _onSession() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _session.removeListener(_onSession);
    for (final controller in _fields.values) {
      controller.dispose();
    }
    _deliveryCode.dispose();
    _identifier.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    if (_loading) {
      _error = null;
    } else if (mounted) {
      setState(() { _loading = true; _error = null; });
    }
    try {
      final data = await widget.api.state(role: widget.role);
      if (!mounted) return;
      setState(() { _data = data; _loading = false; });
      _captureOrder(data);
    } catch (err) {
      if (!mounted) return;
      setState(() { _error = err; _loading = false; });
    }
  }

  Future<void> _save() async {
    try {
      final saved = await widget.api.submit(widget.spec.id, {for (final e in _fields.entries) e.key: e.value.text}, role: widget.role);
      setState(() => _notice = 'Saved.');
      _data = await widget.api.state(role: widget.role);
      if (saved['saved'] is Map) setState(() {});
    } on ApiException catch (err) {
      setState(() => _notice = err.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final splash = kBrandSplashIds.contains(widget.spec.id);
    final theme = khaanaTheme();
    if (widget.embedded) {
      return Theme(data: theme, child: _body());
    }
    return Theme(
      data: theme,
      child: Scaffold(
        backgroundColor: splash ? KhaanaColors.brand : KhaanaColors.background,
        appBar: splash ? null : AppBar(
          title: BrandAppBarTitle(title: widget.spec.title, onLongPress: widget.onDevToggle),
          actions: [
            IconButton(tooltip: 'Reload', onPressed: _load, icon: const Icon(Icons.refresh)),
          ],
        ),
        body: _body(),
      ),
    );
  }

  void _captureOrder(Map<String, dynamic> data) {
    if (widget.role != 'customer') return;
    final orders = ((data['orders'] as List?) ?? []).whereType<Map>();
    Map? current;
    if (_session.orderId != null) {
      current = orders.where((order) => '${order['id']}' == _session.orderId).firstOrNull;
    }
    current ??= orders.where((order) => order['status'] != 'delivered' && order['status'] != 'cancelled').firstOrNull;
    if (current != null) _session.rememberOrder(current);
  }

  Widget _body() {
    final Widget content;
    final trackingReady = widget.spec.id == 'E17-US1-UI1' && _session.activeOrder != null;
    if (_preview == 'loading' || (_loading && !trackingReady)) {
      content = Center(child: Column(mainAxisSize: MainAxisSize.min, children: [const KhaanaSkeleton(), const SizedBox(height: KhaanaSpace.s3), Text('Loading', style: KhaanaType.body.copyWith(color: kBrandSplashIds.contains(widget.spec.id) ? KhaanaColors.onBrand : null))]));
    } else if (_preview == 'error' || _error != null) {
      content = KhaanaErrorState(title: 'Something went wrong', message: 'We could not load this page. Please try again.', actionLabel: 'Try again', onRetry: _load);
    } else if (_preview == 'empty') {
      content = Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text(widget.spec.title, style: KhaanaType.title),
        KhaanaEmptyState(message: 'Nothing to show yet.', action: KhaanaButton(label: 'Refresh', onPressed: _load)),
      ]);
    } else if (widget.spec.ownerOnly && widget.role == 'vendor_staff') {
      content = _message(widget.spec.title, 'You do not have access to this page.', 'Back', () => widget.onOpen('E7-US3-UI1'));
    } else {
      content = ListView(
        padding: KhaanaSpace.page,
        children: [
          if (_notice != null) Padding(padding: const EdgeInsets.only(bottom: KhaanaSpace.s3), child: Text(_notice!, style: KhaanaType.body.copyWith(color: kBrandSplashIds.contains(widget.spec.id) ? KhaanaColors.onBrand : null))),
          _familyBody(),
        ],
      );
    }
    if (!widget.devTools) return content;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(KhaanaSpace.s4, KhaanaSpace.s3, KhaanaSpace.s4, 0),
        child: Wrap(spacing: KhaanaSpace.s2, children: [
          for (final state in ['ready', 'loading', 'empty', 'error'])
            ChoiceChip(label: Text(state), selected: _preview == state, onSelected: (_) => setState(() => _preview = state)),
        ]),
      ),
      Expanded(child: content),
    ]);
  }

  Widget _message(String title, String detail, String action, VoidCallback onPressed) {
    return Center(child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 420),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text(title, style: KhaanaType.title),
        const SizedBox(height: KhaanaSpace.s2),
        Text(detail, textAlign: TextAlign.center, style: KhaanaType.body.copyWith(color: KhaanaColors.muted)),
        const SizedBox(height: KhaanaSpace.s4),
        KhaanaButton(label: action, onPressed: onPressed),
      ]),
    ));
  }

  Widget _familyBody() {
    final data = _data ?? {};
    final journey = _journey(data);
    if (journey != null) return journey;
    switch (widget.spec.family) {
      case 'auth':
        return _auth();
      case 'dashboard':
        return _dashboard(data);
      case 'board':
        return _board(data);
      case 'map':
        return _map(data);
      case 'list':
        return _list(data);
      case 'finance':
        return _finance(data);
      case 'chat':
        return _chat();
      case 'overlay':
        return _overlay();
      case 'layout':
        return _layout();
      default:
        return _form();
    }
  }

  bool get _isSignIn => widget.spec.id == 'E1-US1-UI3' || widget.spec.id == 'E1-US2-UI2';

  Future<void> _submitSignIn() async {
    try {
      final signedIn = await widget.api.login(role: widget.spec.role == 'shared' ? widget.role : widget.spec.role, identifier: _identifier.text, password: _password.text);
      TextInput.finishAutofillContext(shouldSave: true);
      _session.signIn('${signedIn['token'] ?? ''}', '${(signedIn['user'] as Map?)?['name'] ?? ''}');
      final home = switch (widget.spec.role) { 'rider' => 'E13-US2-UI2', 'vendor' => 'E1-US3-UI5', 'admin' => 'E20-US4-UI1', _ => 'E3-US1-UI1' };
      widget.onOpen(home);
    } on ApiException catch (err) {
      _password.clear();
      if (mounted) setState(() => _notice = err.message);
    }
  }

  Widget _auth() {
    final Widget form;
    if (_isSignIn) {
      form = AutofillGroup(
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          TextField(
            key: const Key('sign-in-identifier'),
            controller: _identifier,
            keyboardType: widget.spec.role == 'rider' ? TextInputType.phone : TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.username],
            autocorrect: false,
            decoration: const InputDecoration(labelText: 'Mobile or email'),
          ),
          const SizedBox(height: 8),
          TextField(
            key: const Key('sign-in-password'),
            controller: _password,
            obscureText: true,
            textInputAction: TextInputAction.done,
            autofillHints: const [AutofillHints.password],
            autocorrect: false,
            enableSuggestions: false,
            onSubmitted: (_) => _submitSignIn(),
            decoration: const InputDecoration(labelText: 'Password'),
          ),
          const SizedBox(height: 16),
          _primary('Continue', _submitSignIn),
        ]),
      );
    } else {
      form = Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      TextField(controller: _fields.values.first, decoration: const InputDecoration(labelText: 'Mobile or email')),
      const SizedBox(height: 8),
      TextField(controller: _fields.values.elementAt(_fields.length > 1 ? 1 : 0), obscureText: true, decoration: const InputDecoration(labelText: 'Password')),
      const SizedBox(height: 16),
      _primary('Continue', () async {
        try {
          final signedIn = await widget.api.login(role: widget.spec.role == 'shared' ? widget.role : widget.spec.role, identifier: _fields.values.first.text, password: _fields.values.elementAt(_fields.length > 1 ? 1 : 0).text);
          _session.signIn('${signedIn['token'] ?? ''}', '${(signedIn['user'] as Map?)?['name'] ?? ''}');
          final home = switch (widget.spec.role) { 'rider' => 'E13-US2-UI2', 'vendor' => 'E1-US3-UI5', 'admin' => 'E20-US4-UI1', _ => 'E3-US1-UI1' };
          widget.onOpen(home);
        } on ApiException catch (err) {
          setState(() => _notice = err.message);
        }
      }),
    ]);
    }
    if (!kBrandSplashIds.contains(widget.spec.id)) return form;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      const Center(child: BrandLogo()),
      const SizedBox(height: KhaanaSpace.s5),
      KhaanaCard(child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text(widget.spec.title, style: KhaanaType.title),
        const SizedBox(height: KhaanaSpace.s4),
        form,
      ])),
    ]);
  }

  Widget _dashboard(Map<String, dynamic> data) {
    final orders = (data['orders'] as List?) ?? [];
    final finance = (data['finance'] as Map?) ?? {};
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      if (widget.spec.role == 'rider') ..._riderAlerts(data),
      Wrap(spacing: 8, runSpacing: 8, children: [
        _stat('Orders', '${orders.length}'),
        _stat('Revenue', 'Rs ${finance['revenue'] ?? 0}'),
        _stat('Kitchen', kitchenPace(((data['vendors'] as List?)?.isNotEmpty ?? false) ? (data['vendors'] as List).first['intakePercent'] : 0)),
      ]),
      const SizedBox(height: 12),
      ..._vendorCards(data),
      _primary('Save ${widget.spec.title}', _save),
    ]);
  }

  List<Widget> _riderAlerts(Map<String, dynamic> data) {
    final orders = ((data['orders'] as List?) ?? []).whereType<Map>().map(Map<String, dynamic>.from).where((order) {
      final status = '${order['status']}';
      return status == 'ready' || status == 'ready_for_pickup' || status == 'picked_up';
    });
    if (orders.isEmpty) return const [];
    return [
      for (final order in orders) _riderAlertCard(order),
      const SizedBox(height: 12),
    ];
  }

  Widget _riderAlertCard(Map<String, dynamic> order) {
    final id = '${order['id']}';
    final status = '${order['status']}';
    final pickup = status == 'ready' || status == 'ready_for_pickup';
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(KhaanaSpace.s3),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text(pickup ? 'Pickup alert' : 'Out for delivery', style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          Text('$id · ${order['vendorName'] ?? 'Kitchen'} · ${order['slotLabel'] ?? ''}'),
          if (pickup)
            Align(
              alignment: Alignment.centerLeft,
              child: KhaanaButton(label: 'Pick up', onPressed: () => _advance(id, 'pickup', role: 'rider')),
            ),
          if (!pickup) ...[
            TextField(
              controller: _deliveryCode,
              decoration: const InputDecoration(labelText: '6-digit delivery code'),
              onSubmitted: (code) => _advance(id, 'deliver', role: 'rider', code: code),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: KhaanaButton(label: 'Deliver', onPressed: () => _advance(id, 'deliver', role: 'rider', code: _deliveryCode.text)),
            ),
          ],
        ]),
      ),
    );
  }

  Widget _board(Map<String, dynamic> data) {
    final orders = ((data['orders'] as List?) ?? []).cast<Map>();
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      for (final status in ['new', 'preparing', 'ready', 'picked_up', 'delivered'])
        _card(status, [
          for (final order in orders.where((o) => o['status'] == status || (status == 'ready' && o['status'] == 'ready_for_pickup')))
            ListTile(
              title: Text('${order['id']}'),
              subtitle: Text('Code ${order['code'] ?? ''}'),
              trailing: Wrap(spacing: 4, children: [
                if (status == 'new') TextButton(onPressed: () => _advance('${order['id']}', 'accept'), child: const Text('Accept')),
                if (status == 'preparing') TextButton(onPressed: () => _advance('${order['id']}', 'ready'), child: const Text('Ready')),
                if (status == 'ready' && order['status'] != 'picked_up') TextButton(onPressed: () => _advance('${order['id']}', 'pickup', role: 'rider'), child: const Text('Pick up')),
              ]),
            ),
          if (orders.every((o) => o['status'] != status && !(status == 'ready' && o['status'] == 'ready_for_pickup'))) const Text('No orders in this column.'),
        ]),
      _primary('Refresh board', () => _load()),
    ]);
  }

  Future<void> _advance(String id, String action, {String role = 'vendor_staff', String? code}) async {
    try {
      final updated = await widget.api.advance(id, action, role: role, code: code);
      await _load();
      final status = '${updated['status']}';
      final notice = switch (action) {
        'pickup' => 'Picked up $id. Enter the delivery code when you arrive.',
        'deliver' when status == 'delivered' => '$id is delivered.',
        _ => '$id is now $action.',
      };
      setState(() => _notice = notice);
    } on ApiException catch (err) {
      setState(() => _notice = _friendlyActionNotice(action, err.message));
    }
  }

  String _friendlyActionNotice(String action, String message) {
    final lower = message.toLowerCase();
    if (action == 'pickup' && (lower.contains('picked') || lower.contains('not ready'))) {
      return lower.contains('not ready') ? 'This order is not ready for pickup yet.' : 'This order is already picked up. Enter the delivery code.';
    }
    if (action == 'deliver' && lower.contains('already delivered')) return 'This order is already delivered.';
    return message;
  }

  Widget _map(Map<String, dynamic> data) {
    final orders = ((data['orders'] as List?) ?? []).cast<Map>();
    final current = orders.isEmpty ? null : orders.first;
    final status = '${current?['status'] ?? ''}';
    final riderScreen = widget.spec.role == 'rider';
    final awaitingPickup = status == 'ready' || status == 'ready_for_pickup';
    final outForDelivery = status == 'picked_up';
    final id = '${current?['id'] ?? ''}';
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Container(
        height: 140,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: KhaanaColors.cream, borderRadius: BorderRadius.circular(KhaanaRadius.card)),
        child: Text('Delivery area', style: KhaanaType.body.copyWith(color: KhaanaColors.ink)),
      ),
      const SizedBox(height: 8),
      Text(current == null ? 'F-11 Markaz, Islamabad' : '$id · $status · ${current['slotLabel'] ?? ''}'),
      const SizedBox(height: 8),
      if (current != null && riderScreen && outForDelivery)
        TextField(
          controller: _deliveryCode,
          decoration: const InputDecoration(labelText: '6-digit delivery code'),
          onSubmitted: (code) => _advance(id, 'deliver', role: 'rider', code: code),
        ),
      if (current == null)
        _primary('Waiting for an order', () { _load(); })
      else if (riderScreen && outForDelivery)
        _primary('Deliver', () => _advance(id, 'deliver', role: 'rider', code: _deliveryCode.text))
      else if (riderScreen && awaitingPickup)
        _primary('Pick up', () => _advance(id, 'pickup', role: 'rider'))
      else if (riderScreen && status == 'delivered')
        _primary('Delivered', () {})
      else
        _primary('Update $id', () => _advance(id, 'pickup', role: 'rider')),
    ]);
  }

  Widget _list(Map<String, dynamic> data) {
    final menu = ((data['menu'] as List?) ?? []).cast<Map>();
    final query = _fields.values.first;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      TextField(controller: query, decoration: const InputDecoration(labelText: 'Search'), onChanged: (_) => setState(() {})),
      const SizedBox(height: 8),
      for (final item in menu.where((item) => item['name'].toString().toLowerCase().contains(query.text.toLowerCase())))
        ListTile(
          title: Text('${item['name']}'),
          subtitle: Text(item['available'] == false ? 'Unavailable' : 'Rs ${item['price']} · ${item['allergens']}'),
          enabled: item['available'] != false,
          onTap: () => widget.onOpen(widget.spec.role == 'customer' ? 'E3-US1-UI3' : widget.spec.id),
        ),
      if (menu.isEmpty) const Text('No items match.'),
      _primary('Save filters', _save),
    ]);
  }

  Widget _finance(Map<String, dynamic> data) {
    final finance = (data['finance'] as Map?) ?? {};
    final invoices = ((data['invoices'] as List?) ?? []).cast<Map>();
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      _stat('Revenue', 'Rs ${finance['revenue'] ?? 0}'),
      _stat('Commission', 'Rs ${finance['commission'] ?? 0}'),
      const SizedBox(height: 8),
      for (final invoice in invoices) Text('${invoice['id']} · Rs ${invoice['total']} · ${invoice['status']}'),
      if (invoices.isEmpty) const Text('No invoices yet. A delivered order creates one.'),
      _primary('Record note', _save),
    ]);
  }

  Widget _chat() {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      TextField(controller: _fields.values.first, decoration: const InputDecoration(labelText: 'Ask about an order, menu, or delivery')),
      _primary('Send', () => setState(() => _notice = 'I can open your latest order or the kitchen board.')),
    ]);
  }

  Widget _overlay() {
    return _card(widget.spec.title, [
      _primary('Confirm', _save),
      TextButton(onPressed: () => widget.onOpen(_homeFor(widget.role)), child: const Text('Close')),
    ]);
  }

  Widget _layout() {
    return Column(children: [
      Row(children: [
        Expanded(child: _card('Phone', const [Text('A single column for a phone.')])),
        const SizedBox(width: 8),
        Expanded(child: _card('Desktop', const [Text('A side menu and a wider table.')])),
      ]),
      _primary('Save layout note', _save),
    ]);
  }

  Widget _form() {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      if (widget.spec.id == 'E14-US2-UI1')
        RadioGroup<String>(
          groupValue: _delivery,
          onChanged: (value) { if (value != null) setState(() => _delivery = value); },
          child: const Column(children: [
            RadioListTile(value: 'express', title: Text('Express')),
            RadioListTile(value: 'pooled', title: Text('Pooled · 30% off the delivery fee, extra 10–15 min, not guaranteed')),
          ]),
        ),
      if (widget.spec.id == 'E5-US3-UI1')
        for (final slot in (((_data?['slots'] as List?) ?? []).cast<Map>()))
          ListTile(
            title: Text('${slot['label']}'),
            subtitle: Text(kitchenPace(slot['percent'], slot['band'])),
            selected: _slot == slot['id'],
            enabled: slot['bookable'] == true,
            onTap: () => setState(() => _slot = '${slot['id']}'),
          ),
      if (widget.spec.id == 'E3-US3-UI1')
        RadioGroup<String>(
          groupValue: _payment,
          onChanged: (value) { if (value != null) setState(() => _payment = value); },
          child: Column(children: [
            for (final method in ['Cash on delivery', 'JazzCash', 'Easypaisa', 'Card'])
              RadioListTile<String>(value: method, title: Text(method)),
          ]),
        ),
      if (widget.spec.id == 'E3-US2-UI2' || widget.spec.id == 'E4-US1-UI1')
        Row(children: [
          const Text('Quantity'),
          IconButton(onPressed: () => setState(() => _qty = (_qty - 1).clamp(1, 20)), icon: const Icon(Icons.remove)),
          Text('$_qty'),
          IconButton(onPressed: () => setState(() => _qty += 1), icon: const Icon(Icons.add)),
        ]),
      ..._clauseFields(),
      _primary(widget.spec.id == 'E3-US2-UI2' ? 'Place order' : 'Save', widget.spec.id == 'E3-US2-UI2' ? _place : _save),
    ]);
  }

  Future<void> _place() async {
    try {
      final order = await widget.api.placeOrder(_session.orderBody());
      _session.rememberOrder(order);
      widget.onOpen('E17-US1-UI1');
    } on ApiException catch (err) {
      setState(() => _notice = err.message);
    }
  }

  Widget? _journey(Map<String, dynamic> data) {
    switch (widget.spec.id) {
      case 'E3-US1-UI1':
        return CustomerHome(data: data, onOpen: widget.onOpen, onVendor: _session.selectVendor, onDevToggle: widget.onDevToggle, onOpenCatalog: widget.onOpenCatalog, devTools: widget.devTools);
      case 'E17-US1-UI1':
        return CustomerTracking(order: _trackedOrder(data), vendorName: _session.vendorName, onOpen: widget.onOpen, onBack: widget.onBack, onDevToggle: widget.onDevToggle, onOpenCatalog: widget.onOpenCatalog, devTools: widget.devTools);
      case 'E3-US1-UI2':
        return _menuList(data);
      case 'E3-US1-UI3':
        return _itemDetail(data);
      case 'E4-US1-UI1':
        return _customize();
      case 'E3-US2-UI1':
        return _cart();
      case 'E14-US2-UI1':
        return _deliveryChoice();
      case 'E5-US3-UI1':
        return _slotChoice(data);
      case 'E3-US3-UI1':
        return _paymentChoice();
      case 'E3-US2-UI2':
        return _review();
      case 'E3-US4-UI2':
        return _placed();
      case 'E17-US2-UI1':
        return _orderList(data);
      default:
        return null;
    }
  }

  Map<String, dynamic>? _trackedOrder(Map<String, dynamic> data) {
    final live = _session.activeOrder;
    if (live != null && (_session.orderId == null || '${live['id']}' == _session.orderId)) return live;
    final orders = ((data['orders'] as List?) ?? []).whereType<Map>();
    if (_session.orderId != null) {
      final match = orders.where((order) => '${order['id']}' == _session.orderId).firstOrNull;
      if (match != null) return Map<String, dynamic>.from(match);
    }
    final active = orders.where((order) => order['status'] != 'delivered' && order['status'] != 'cancelled').firstOrNull;
    return active == null ? null : Map<String, dynamic>.from(active);
  }

  Widget _menuList(Map<String, dynamic> data) {
    final menu = ((data['menu'] as List?) ?? []).cast<Map>().where((item) => item['vendorId'] == null || item['vendorId'] == _session.vendorId);
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Text(_session.vendorName, style: KhaanaType.heading),
      for (final item in menu)
        ListTile(
          title: Text('${item['name']}'),
          subtitle: Text(item['available'] == false ? 'Sold out' : 'Rs ${item['price']} · ${item['allergens'] ?? ''}'),
          enabled: item['available'] != false,
          onTap: item['available'] == false ? null : () { _session.selectItem(item); widget.onOpen('E3-US1-UI3'); },
        ),
      _primary('Open cart', () => widget.onOpen('E3-US2-UI1')),
    ]);
  }

  Widget _itemDetail(Map<String, dynamic> data) {
    final item = ((data['menu'] as List?) ?? []).cast<Map>().where((entry) => entry['id'] == _session.itemId).firstOrNull;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Text(_session.itemName, style: KhaanaType.title),
      Text('Rs ${_session.price} · ${_session.fragile ? 'Fragile · express only' : 'Can be pooled'}'),
      if (item != null) Text('Allergens: ${item['allergens'] ?? 'None listed'}', style: KhaanaType.body.copyWith(color: KhaanaColors.full)),
      Text(_session.available ? 'Available' : 'Sold out'),
      Row(children: [
        const Text('Quantity'),
        IconButton(onPressed: () => _session.setQty(_session.qty - 1), icon: const Icon(Icons.remove)),
        Text('${_session.qty}'),
        IconButton(onPressed: () => _session.setQty(_session.qty + 1), icon: const Icon(Icons.add)),
      ]),
      _primary(_session.available ? 'Add to cart' : 'Sold out', _session.available ? () => widget.onOpen('E4-US1-UI1') : () {}),
    ]);
  }

  Widget _customize() {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Text('${_session.itemName} · qty ${_session.qty}'),
      TextField(
        maxLength: 500,
        decoration: const InputDecoration(labelText: 'Instructions for the kitchen'),
        onChanged: _session.setNote,
      ),
      Text('${_session.note.length}/500'),
      _primary('Save customization', () => widget.onOpen('E3-US2-UI1')),
    ]);
  }

  Widget _cart() {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Text('${_session.qty} × ${_session.itemName}', style: const TextStyle(fontWeight: FontWeight.w800)),
      Text(_session.note.isEmpty ? 'No kitchen note' : _session.note),
      Text('Food Rs ${_session.food}'),
      Text('One kitchen per order: ${_session.vendorName}'),
      _primary('Choose delivery', () => widget.onOpen('E14-US2-UI1')),
    ]);
  }

  Widget _deliveryChoice() {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      RadioGroup<String>(
        groupValue: _session.delivery,
        onChanged: (value) {
          if (value == null) return;
          if (value == 'pooled' && _session.fragile) {
            setState(() => _notice = 'A fragile item must use express delivery.');
            return;
          }
          _session.setDelivery(value);
        },
        child: Column(children: [
          const RadioListTile(value: 'express', title: Text('Express'), subtitle: Text('Rs 180')),
          RadioListTile(value: 'pooled', title: const Text('Pooled'), subtitle: Text(_session.fragile ? 'Not available for fragile items' : '30% off the delivery fee, extra 10–15 min, not guaranteed'), enabled: !_session.fragile),
        ]),
      ),
      _primary('Choose a slot', () => widget.onOpen('E5-US3-UI1')),
    ]);
  }

  Widget _slotChoice(Map<String, dynamic> data) {
    final slots = ((data['slots'] as List?) ?? []).cast<Map>().where((slot) => slot['vendorId'] == null || slot['vendorId'] == _session.vendorId);
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      for (final slot in slots)
        ListTile(
          title: Text('${slot['label']}'),
          subtitle: Text(kitchenPace(slot['percent'], slot['band'])),
          selected: _session.slotId == slot['id'],
          enabled: slot['bookable'] == true,
          onTap: slot['bookable'] == true ? () => _session.selectSlot(slot) : null,
        ),
      _primary('Hold this slot', () async {
        try {
          await widget.api.holdSlot(_session.slotId);
          setState(() => _notice = 'Slot held for 5 minutes.');
          widget.onOpen('E3-US3-UI1');
        } on ApiException catch (err) {
          setState(() => _notice = err.message);
        }
      }),
    ]);
  }

  Widget _paymentChoice() {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      RadioGroup<String>(
        groupValue: _session.payment,
        onChanged: (value) { if (value != null) _session.setPayment(value); },
        child: Column(children: [
          for (final method in ['Cash on delivery', 'JazzCash', 'Easypaisa', 'Card'])
            RadioListTile<String>(value: method, title: Text(method)),
        ]),
      ),
      if (widget.devTools) SwitchListTile(
        contentPadding: EdgeInsets.zero,
        title: const Text('Simulate a failed card payment'),
        value: _session.simulatePaymentFailure,
        onChanged: _session.setPaymentFailure,
      ),
      _primary('Review order', () => widget.onOpen('E3-US2-UI2')),
    ]);
  }

  Widget _review() {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Text('${_session.qty} × ${_session.itemName} · ${_session.vendorName}'),
      Text('Slot ${_session.slotLabel} · ${_session.delivery} · ${_session.payment}'),
      Text('Food Rs ${_session.food}'),
      Text('Delivery Rs ${_session.deliveryFee}'),
      if (_session.discount > 0) Text('Discount − Rs ${_session.discount}', style: KhaanaType.body.copyWith(color: KhaanaColors.ok)),
      Text('Total Rs ${_session.total}', style: KhaanaType.title),
      _primary('Place order', _place),
    ]);
  }

  Widget _placed() {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Text(_session.orderId == null ? 'No order has been placed from this session.' : 'Order ${_session.orderId}'),
      if (_session.orderCode != null) Text('Delivery code ${_session.orderCode}'),
      Text('Total Rs ${_session.total} · ${_session.payment}'),
      _primary('Track order', () => widget.onOpen('E17-US1-UI1')),
    ]);
  }

  Widget _orderList(Map<String, dynamic> data) {
    final orders = ((data['orders'] as List?) ?? []).whereType<Map>().toList();
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      if (orders.isEmpty) const Text('No orders yet.'),
      for (final order in orders)
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text('${order['id']}'),
          subtitle: Text('${orderStage(order['status'])} · Rs ${order['total']}'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            _session.rememberOrder(order);
            widget.onOpen('E17-US1-UI1');
          },
        ),
      _primary('Refresh orders', _load),
    ]);
  }

  List<Widget> _vendorCards(Map<String, dynamic> data) {
    final vendors = ((data['vendors'] as List?) ?? []).cast<Map>();
    return [
      for (final vendor in vendors)
        ListTile(
          title: Text('${vendor['name']}'),
          subtitle: Text('${vendor['cuisine']} · ${vendor['area']} · ${vendor['open'] == true ? 'Open' : 'Closed'} · ${kitchenPace(vendor['intakePercent'])}'),
          onTap: vendor['open'] == true ? () => widget.onOpen('E3-US1-UI2') : null,
        ),
    ];
  }

  List<Widget> _clauseFields() {
    return [
      for (final clause in widget.spec.clauses)
        if (plainCopy(clause).isNotEmpty)
          Padding(
                padding: const EdgeInsets.only(bottom: KhaanaSpace.s2),
            child: TextField(controller: _fields[clause], decoration: InputDecoration(labelText: plainCopy(clause))),
          ),
    ];
  }

  Widget _card(String title, List<Widget> children) {
    return KhaanaCard(padding: const EdgeInsets.all(KhaanaSpace.s3), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: KhaanaType.heading), ...children]));
  }

  Widget _stat(String label, String value) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(KhaanaSpace.s3),
      decoration: BoxDecoration(color: KhaanaColors.white, borderRadius: BorderRadius.circular(KhaanaRadius.button), border: Border.all(color: KhaanaColors.line)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: KhaanaType.caption), Text(value, style: KhaanaType.price)]),
    );
  }

  Widget _primary(String label, FutureOr<void> Function() onPressed) {
    final tall = widget.spec.role == 'rider';
    return Padding(
      padding: const EdgeInsets.only(top: KhaanaSpace.s3),
      child: KhaanaButton(
        key: Key('primary-${widget.spec.id}'),
        label: label,
        tall: tall,
        onPressed: () { onPressed(); },
      ),
    );
  }
}

String _homeFor(String role) {
  return switch (role) { 'rider' => 'E13-US2-UI2', 'vendor' => 'E7-US3-UI1', 'admin' => 'E20-US4-UI1', _ => 'E3-US1-UI1' };
}

String kitchenPace(Object? percent, [Object? band]) {
  final named = band?.toString().toLowerCase();
  if (named == 'full') return 'Full';
  if (named == 'limited' || named == 'busy') return 'Busy';
  if (named == 'available' || named == 'quiet') return 'Quiet';
  final value = percent is num ? percent.toDouble() : double.tryParse('${percent ?? ''}') ?? 0;
  if (value >= 85) return 'Full';
  if (value >= 60) return 'Busy';
  return 'Quiet';
}

String plainCopy(String raw) {
  return raw
      .replaceAll(RegExp(r'\s*\([^)]*\b(?:AC\d+|E\d+-US\d+(?:-UI\d+)?)[^)]*\)'), '')
      .replaceAll(RegExp(r'\bE\d+-US\d+(?:-UI\d+)?\b'), '')
      .replaceAll(RegExp(r'\bAC\d+\b'), '')
      .replaceAll(RegExp(r'\s+'), ' ')
      .replaceAll(RegExp(r'\s+([,.;:])'), '')
      .trim();
}
