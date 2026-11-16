import 'dart:async';

import 'package:flutter/material.dart';

import 'api.dart';
import 'checkout_session.dart';
import 'screen_spec.dart';

class ScreenPage extends StatefulWidget {
  const ScreenPage({super.key, required this.spec, required this.api, required this.onOpen, this.role = 'customer', this.embedded = false, this.session});

  final ScreenSpec spec;
  final KhaanaApi api;
  final void Function(String id) onOpen;
  final String role;
  final bool embedded;
  final CheckoutSession? session;

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
    } catch (err) {
      if (!mounted) return;
      setState(() { _error = err; _loading = false; });
    }
  }

  Future<void> _save() async {
    try {
      final saved = await widget.api.submit(widget.spec.id, {for (final e in _fields.entries) e.key: e.value.text}, role: widget.role);
      setState(() => _notice = 'Saved ${widget.spec.id}. Demo mode does not write a production database.');
      _data = await widget.api.state(role: widget.role);
      if (saved['saved'] is Map) setState(() {});
    } on ApiException catch (err) {
      setState(() => _notice = err.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = widget.spec.role == 'rider';
    final theme = ThemeData(
      useMaterial3: true,
      brightness: dark ? Brightness.dark : Brightness.light,
      scaffoldBackgroundColor: dark ? const Color(0xFF1A1A1A) : const Color(0xFFFFF8EF),
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF97316), brightness: dark ? Brightness.dark : Brightness.light),
    );
    if (widget.embedded) {
      return Theme(data: theme, child: _body());
    }
    return Theme(
      data: theme,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: dark ? const Color(0xFF242424) : Colors.white,
          foregroundColor: dark ? const Color(0xFFFFF8EF) : const Color(0xFF242424),
          title: Text(widget.spec.title),
          actions: [
            IconButton(tooltip: 'Reload', onPressed: _load, icon: const Icon(Icons.refresh)),
          ],
        ),
        body: _body(),
      ),
    );
  }

  Widget _body() {
    if (_preview == 'loading' || _loading) {
      return const Center(child: Column(mainAxisSize: MainAxisSize.min, children: [CircularProgressIndicator(), SizedBox(height: 12), Text('Loading')]));
    }
    if (_preview == 'error' || _error != null) {
      return _message('Something went wrong', _error?.toString() ?? 'The server did not respond.', 'Try again', _load);
    }
    if (_preview == 'empty') return _message(widget.spec.title, 'Nothing to show yet.', 'Refresh', _load);
    if (widget.spec.ownerOnly && widget.role == 'vendor_staff') {
      return _message(widget.spec.id, 'You do not have access to this page.', 'Back', () => widget.onOpen('E7-US3-UI1'));
    }
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(widget.spec.id, style: const TextStyle(fontWeight: FontWeight.w800, color: Color(0xFFC2410C))),
        Text('${widget.spec.priority} · ${widget.spec.kind} · ${widget.spec.module}', style: const TextStyle(color: Color(0xFF6B635B))),
        const SizedBox(height: 8),
        Wrap(spacing: 8, children: [
          for (final state in ['ready', 'loading', 'empty', 'error'])
            ChoiceChip(label: Text(state), selected: _preview == state, onSelected: (_) => setState(() => _preview = state)),
        ]),
        if (_notice != null) Padding(padding: const EdgeInsets.only(top: 12), child: Text(_notice!)),
        const SizedBox(height: 12),
        _familyBody(),
      ],
    );
  }

  Widget _message(String title, String detail, String action, VoidCallback onPressed) {
    return Center(child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 420),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text(widget.spec.id),
        Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        Text(detail, textAlign: TextAlign.center),
        const SizedBox(height: 16),
        FilledButton(onPressed: onPressed, style: FilledButton.styleFrom(backgroundColor: const Color(0xFFF97316), foregroundColor: const Color(0xFF242424), minimumSize: const Size.fromHeight(56)), child: Text(action)),
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

  Widget _auth() {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      const Text('Demo sign-in. Passwords are not hashed.', style: TextStyle(color: Color(0xFF6B635B))),
      const SizedBox(height: 12),
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
      const SizedBox(height: 12),
      ..._clauseCards(),
    ]);
  }

  Widget _dashboard(Map<String, dynamic> data) {
    final orders = (data['orders'] as List?) ?? [];
    final finance = (data['finance'] as Map?) ?? {};
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Wrap(spacing: 8, runSpacing: 8, children: [
        _stat('Orders', '${orders.length}'),
        _stat('Revenue', 'Rs ${finance['revenue'] ?? 0}'),
        _stat('Intake', '${((data['vendors'] as List?)?.isNotEmpty ?? false) ? (data['vendors'] as List).first['intakePercent'] : 0}%'),
      ]),
      const SizedBox(height: 12),
      ..._vendorCards(data),
      ..._clauseCards(),
      _primary('Save ${widget.spec.title}', _save),
    ]);
  }

  Widget _board(Map<String, dynamic> data) {
    final orders = ((data['orders'] as List?) ?? []).cast<Map>();
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      for (final status in ['new', 'preparing', 'ready', 'picked_up', 'delivered'])
        _card(status, [
          for (final order in orders.where((o) => o['status'] == status))
            ListTile(
              title: Text('${order['id']}'),
              subtitle: Text('Code ${order['code'] ?? ''}'),
              trailing: Wrap(spacing: 4, children: [
                if (status == 'new') TextButton(onPressed: () => _advance('${order['id']}', 'accept'), child: const Text('Accept')),
                if (status == 'preparing') TextButton(onPressed: () => _advance('${order['id']}', 'ready'), child: const Text('Ready')),
                if (status == 'ready') TextButton(onPressed: () => _advance('${order['id']}', 'pickup', role: 'rider'), child: const Text('Pick up')),
              ]),
            ),
          if (orders.every((o) => o['status'] != status)) const Text('No orders in this column.'),
        ]),
      _primary('Refresh board', () => _load()),
    ]);
  }

  Future<void> _advance(String id, String action, {String role = 'vendor_staff', String? code}) async {
    try {
      await widget.api.advance(id, action, role: role, code: code);
      await _load();
      setState(() => _notice = '$id is now $action.');
    } on ApiException catch (err) {
      setState(() => _notice = err.message);
    }
  }

  Widget _map(Map<String, dynamic> data) {
    final orders = ((data['orders'] as List?) ?? []).cast<Map>();
    final current = orders.isEmpty ? null : orders.first;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Container(
        height: 140,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: const Color(0xFF242424), borderRadius: BorderRadius.circular(16)),
        child: const Text('Simulated map. Text address is the fallback.', style: TextStyle(color: Color(0xFFFFF8EF))),
      ),
      const SizedBox(height: 8),
      Text(current == null ? 'F-11 Markaz, Islamabad' : '${current['id']} · ${current['status']} · ${current['slotLabel'] ?? ''}'),
      const SizedBox(height: 8),
      if (current != null && widget.spec.role == 'rider')
        TextField(
          decoration: const InputDecoration(labelText: '6-digit delivery code'),
          onSubmitted: (code) => _advance('${current['id']}', 'deliver', role: 'rider', code: code),
        ),
      _primary(current == null ? 'Waiting for an order' : 'Update ${current['id']}', current == null ? () { _load(); } : () => _advance('${current['id']}', 'pickup', role: 'rider')),
      ..._clauseCards(),
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
      ..._clauseCards(),
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
      ..._clauseCards(),
      _primary('Record note', _save),
    ]);
  }

  Widget _chat() {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      const Text('Simulated assistant. This is not a live model.'),
      const SizedBox(height: 8),
      TextField(controller: _fields.values.first, decoration: const InputDecoration(labelText: 'Ask about an order, menu, or delivery')),
      _primary('Send', () => setState(() => _notice = 'Demo reply: I can open your latest order or the kitchen board. I do not invent recommendations.')),
      ..._clauseCards(),
    ]);
  }

  Widget _overlay() {
    return _card(widget.spec.title, [
      const Text('This overlay stays attached to the screen that opened it.'),
      ..._clauseCards(),
      _primary('Confirm', _save),
      TextButton(onPressed: () => widget.onOpen(_homeFor(widget.role)), child: const Text('Close')),
    ]);
  }

  Widget _layout() {
    return Column(children: [
      const Text('The same screen at phone and desktop widths.'),
      const SizedBox(height: 8),
      Row(children: [
        Expanded(child: _card('360 px', _clauseCards())),
        const SizedBox(width: 8),
        Expanded(child: _card('1280 px', [const Text('Navigation rail and a wider table.')])),
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
            title: Text('${slot['label']} · ${slot['band']}'),
            subtitle: Text('${slot['percent']}% intake. Full means the intake rule, not a physically full kitchen.'),
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
              RadioListTile<String>(value: method, title: Text(method), subtitle: const Text('Gateway pages are simulated.')),
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
      setState(() => _notice = 'Placed ${order['id']}. The kitchen sees this same order. Code ${order['code']}.');
      widget.onOpen('E3-US4-UI2');
    } on ApiException catch (err) {
      setState(() => _notice = err.message);
    }
  }

  Widget? _journey(Map<String, dynamic> data) {
    switch (widget.spec.id) {
      case 'E3-US1-UI1':
        return _homeMarkets(data);
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
      case 'E17-US1-UI1':
      case 'E17-US2-UI1':
        return _orderList(data);
      default:
        return null;
    }
  }

  Widget _homeMarkets(Map<String, dynamic> data) {
    final vendors = ((data['vendors'] as List?) ?? []).cast<Map>();
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      const Text('Kitchens near F-11, Islamabad', style: TextStyle(fontWeight: FontWeight.w700)),
      for (final vendor in vendors)
        ListTile(
          title: Text('${vendor['name']}'),
          subtitle: Text('${vendor['cuisine']} · ${vendor['area']} · ${vendor['open'] == true ? 'Open' : 'Closed'} · intake ${vendor['intakePercent']}%'),
          enabled: vendor['open'] == true,
          onTap: vendor['open'] == true ? () { _session.selectVendor(vendor); widget.onOpen('E3-US1-UI2'); } : null,
        ),
      _primary('Browse open kitchens', () => widget.onOpen('E3-US1-UI2')),
    ]);
  }

  Widget _menuList(Map<String, dynamic> data) {
    final menu = ((data['menu'] as List?) ?? []).cast<Map>().where((item) => item['vendorId'] == null || item['vendorId'] == _session.vendorId);
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Text(_session.vendorName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
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
      Text(_session.itemName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
      Text('Rs ${_session.price} · ${_session.fragile ? 'Fragile · express only' : 'Can be pooled'}'),
      if (item != null) Text('Allergens: ${item['allergens'] ?? 'None listed'}', style: const TextStyle(color: Color(0xFFB91C1C))),
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
          title: Text('${slot['label']} · ${slot['band']}'),
          subtitle: Text('${slot['percent']}% intake. Full means the intake rule, not a physically full kitchen.'),
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
      const Text('Card and wallet pages are simulated.'),
      RadioGroup<String>(
        groupValue: _session.payment,
        onChanged: (value) { if (value != null) _session.setPayment(value); },
        child: Column(children: [
          for (final method in ['Cash on delivery', 'JazzCash', 'Easypaisa', 'Card'])
            RadioListTile<String>(value: method, title: Text(method)),
        ]),
      ),
      SwitchListTile(
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
      if (_session.discount > 0) Text('Discount − Rs ${_session.discount}', style: const TextStyle(color: Color(0xFF15803D))),
      Text('Total Rs ${_session.total}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
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
    final orders = ((data['orders'] as List?) ?? []).cast<Map>();
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      if (orders.isEmpty && _session.orderId == null) const Text('No orders yet.'),
      if (_session.orderId != null) Text('Latest ${_session.orderId} · ${_session.orderStatus ?? 'new'} · code ${_session.orderCode ?? ''}'),
      for (final order in orders) Text('${order['id']} · ${order['status']} · Rs ${order['total']} · ${order['slotLabel'] ?? ''}'),
      _primary('Refresh orders', _load),
    ]);
  }

  List<Widget> _vendorCards(Map<String, dynamic> data) {
    final vendors = ((data['vendors'] as List?) ?? []).cast<Map>();
    return [
      for (final vendor in vendors)
        ListTile(
          title: Text('${vendor['name']}'),
          subtitle: Text('${vendor['cuisine']} · ${vendor['area']} · ${vendor['open'] == true ? 'Open' : 'Closed'} · intake ${vendor['intakePercent']}%'),
          onTap: vendor['open'] == true ? () => widget.onOpen('E3-US1-UI2') : null,
        ),
    ];
  }

  List<Widget> _clauseCards() => [for (final clause in widget.spec.clauses) Padding(padding: const EdgeInsets.only(top: 8), child: Text('• $clause'))];

  List<Widget> _clauseFields() {
    return [
      for (final clause in widget.spec.clauses)
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: TextField(controller: _fields[clause], decoration: InputDecoration(labelText: clause)),
        ),
    ];
  }

  Widget _card(String title, List<Widget> children) {
    return Card(child: Padding(padding: const EdgeInsets.all(12), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.w800)), ...children])));
  }

  Widget _stat(String label, String value) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFEADBC8))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: const TextStyle(color: Color(0xFF6B635B))), Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800))]),
    );
  }

  Widget _primary(String label, FutureOr<void> Function() onPressed) {
    final tall = widget.spec.role == 'rider';
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: FilledButton(
        key: Key('primary-${widget.spec.id}'),
        onPressed: () { onPressed(); },
        style: FilledButton.styleFrom(backgroundColor: const Color(0xFFF97316), foregroundColor: const Color(0xFF242424), minimumSize: Size.fromHeight(tall ? 64 : 56)),
        child: Text(label),
      ),
    );
  }
}

String _homeFor(String role) {
  return switch (role) { 'rider' => 'E13-US2-UI2', 'vendor' => 'E7-US3-UI1', 'admin' => 'E20-US4-UI1', _ => 'E3-US1-UI1' };
}
