import 'package:flutter/material.dart';

const _orange = Color(0xFFF97316);
const _charcoal = Color(0xFF242424);
const _white = Color(0xFFFFFFFF);
const _muted = Color(0xFF6B635B);
const _line = Color(0xFFEADBC8);
const _orangeTint = Color(0xFFFFEDD5);
const _available = Color(0xFF15803D);
const _availableTint = Color(0xFFDCFCE7);
const _limited = Color(0xFF854D0E);
const _limitedTint = Color(0xFFFEF3C7);
const _full = Color(0xFFB91C1C);
const _fullTint = Color(0xFFFEE2E2);

const _steps = ['Placed', 'Accepted', 'Preparing', 'Ready', 'On the way', 'Delivered'];
const _eventKeys = ['placed', 'accepted', 'preparing', 'ready', 'onTheWay', 'delivered'];

String bookingPace(Object? percent) {
  final value = percent is num ? percent.toDouble() : double.tryParse('${percent ?? ''}') ?? 0;
  if (value >= 85) return 'Fully booked';
  if (value >= 60) return 'Busy';
  return 'Quiet';
}

String orderStage(Object? status) {
  return switch ('$status') {
    'accepted' => 'Accepted',
    'preparing' => 'Preparing',
    'ready' || 'ready_for_pickup' => 'Ready',
    'picked_up' => 'On the way',
    'delivered' => 'Delivered',
    'cancelled' => 'Cancelled',
    _ => 'Placed',
  };
}

String friendlyClock(Object? raw) {
  return '${raw ?? ''}'.replaceAll('PM', 'pm').replaceAll('AM', 'am').trim();
}

String trackingHeadline(Map? order) {
  if (order == null) return 'Ready soon';
  final status = '${order['status']}';
  if (status == 'delivered') return 'Delivered';
  if (status == 'picked_up') return 'On the way';
  if (status == 'ready' || status == 'ready_for_pickup') return 'Ready now';
  if (status == 'cancelled') return 'Cancelled';
  final slot = friendlyClock(order['slotLabel']);
  if (slot.isEmpty) return 'Ready soon';
  return 'Ready by $slot';
}

String opensAtLabel(Object? raw) {
  final text = '${raw ?? ''}'.trim();
  if (text.isEmpty) return 'Closed';
  final match = RegExp(r'^(\d{1,2}):(\d{2})').firstMatch(text);
  if (match == null) return 'Opens at $text';
  var hour = int.parse(match.group(1)!);
  final minute = match.group(2)!;
  final suffix = hour >= 12 ? 'pm' : 'am';
  hour = hour % 12;
  if (hour == 0) hour = 12;
  return 'Opens at $hour:$minute $suffix';
}

String clockLabel(Object? raw) {
  final time = DateTime.tryParse('${raw ?? ''}')?.toLocal();
  if (time == null) return '';
  final hour = time.hour % 12 == 0 ? 12 : time.hour % 12;
  final minute = time.minute.toString().padLeft(2, '0');
  final suffix = time.hour >= 12 ? 'pm' : 'am';
  return '$hour:$minute $suffix';
}

int trackingIndex(Object? status) {
  return switch ('$status') {
    'accepted' => 1,
    'preparing' => 2,
    'ready' || 'ready_for_pickup' => 3,
    'picked_up' => 4,
    'delivered' => 5,
    _ => 0,
  };
}

class CustomerHome extends StatefulWidget {
  const CustomerHome({super.key, required this.data, required this.onOpen, required this.onVendor, this.onDevToggle, this.onOpenCatalog, this.devTools = false});

  final Map<String, dynamic> data;
  final void Function(String id) onOpen;
  final void Function(Map vendor) onVendor;
  final VoidCallback? onDevToggle;
  final VoidCallback? onOpenCatalog;
  final bool devTools;

  @override
  State<CustomerHome> createState() => _CustomerHomeState();
}

class _CustomerHomeState extends State<CustomerHome> {
  final _search = TextEditingController();
  var _openNow = false;
  String? _cuisine;
  String? _dietary;

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vendors = ((widget.data['vendors'] as List?) ?? []).whereType<Map>().toList();
    final cuisines = vendors.map((vendor) => '${vendor['cuisine']}').where((item) => item.isNotEmpty).toSet().toList();
    final diets = vendors.expand((vendor) => ((vendor['dietary'] as List?) ?? []).map((item) => '$item')).where((item) => item.isNotEmpty).toSet().toList();
    final query = _search.text.trim().toLowerCase();
    final visible = vendors.where((vendor) {
      final haystack = '${vendor['name']} ${vendor['cuisine']} ${vendor['area']}'.toLowerCase();
      if (query.isNotEmpty && !haystack.contains(query)) return false;
      if (_openNow && vendor['open'] != true) return false;
      if (_cuisine != null && vendor['cuisine'] != _cuisine) return false;
      if (_dietary != null && !((vendor['dietary'] as List?) ?? []).map((item) => '$item').contains(_dietary)) return false;
      return true;
    }).toList();

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Row(children: [
        Expanded(
          child: GestureDetector(
            onLongPress: widget.onDevToggle,
            child: const Text('F-11, Islamabad', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _charcoal)),
          ),
        ),
        if (widget.devTools)
          IconButton(tooltip: 'Screen list', onPressed: widget.onOpenCatalog, icon: const Icon(Icons.menu)),
      ]),
      const SizedBox(height: 16),
      TextField(
        controller: _search,
        onChanged: (_) => setState(() {}),
        decoration: InputDecoration(
          hintText: 'Search kitchens',
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: _white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: _line)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: _line)),
        ),
      ),
      const SizedBox(height: 16),
      SizedBox(
        height: 48,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            _filterChip('Open now', _openNow, () => setState(() => _openNow = !_openNow)),
            for (final cuisine in cuisines) ...[
              const SizedBox(width: 8),
              _filterChip(cuisine, _cuisine == cuisine, () => setState(() => _cuisine = _cuisine == cuisine ? null : cuisine)),
            ],
            for (final diet in diets) ...[
              const SizedBox(width: 8),
              _filterChip(diet, _dietary == diet, () => setState(() => _dietary = _dietary == diet ? null : diet)),
            ],
          ],
        ),
      ),
      const SizedBox(height: 16),
      if (visible.isEmpty) const Text('No kitchens match.'),
      for (final vendor in visible) ...[
        _VendorCard(
          vendor: vendor,
          nextSlot: _nextSlot(vendor),
          onTap: vendor['open'] == true
              ? () {
                  widget.onVendor(vendor);
                  widget.onOpen('E3-US1-UI2');
                }
              : null,
        ),
        const SizedBox(height: 16),
      ],
    ]);
  }

  Widget _filterChip(String label, bool selected, VoidCallback onTap) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      showCheckmark: false,
      selectedColor: _orangeTint,
      backgroundColor: _white,
      side: BorderSide(color: selected ? _orange : _line),
      labelStyle: TextStyle(color: selected ? _charcoal : _muted, fontWeight: FontWeight.w700),
      onSelected: (_) => onTap(),
    );
  }

  String? _nextSlot(Map vendor) {
    final slots = ((widget.data['slots'] as List?) ?? []).whereType<Map>().where((slot) {
      return '${slot['vendorId']}' == '${vendor['id']}' && slot['bookable'] != false;
    });
    if (slots.isEmpty) return null;
    final label = friendlyClock(slots.first['label']);
    return label.isEmpty ? null : label;
  }
}

class _VendorCard extends StatelessWidget {
  const _VendorCard({required this.vendor, required this.nextSlot, required this.onTap});

  final Map vendor;
  final String? nextSlot;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final open = vendor['open'] == true;
    final pace = bookingPace(vendor['intakePercent']);
    final rating = vendor['rating'];
    final ratingText = rating is num ? rating.toStringAsFixed(1) : '${rating ?? ''}';
    final min = vendor['etaMin'] ?? 30;
    final max = vendor['etaMax'] ?? 45;
    return Opacity(
      opacity: open ? 1 : 0.72,
      child: Material(
        color: _white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: const BorderSide(color: _line)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Container(
              height: 96,
              color: _orangeTint,
              child: const Icon(Icons.restaurant, color: _orange, size: 32),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Expanded(child: Text('${vendor['name']}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: _charcoal))),
                  if (ratingText.isNotEmpty) ...[
                    const Icon(Icons.star, size: 16, color: _orange),
                    const SizedBox(width: 8),
                    Text(ratingText, style: const TextStyle(fontWeight: FontWeight.w700)),
                  ],
                ]),
                const SizedBox(height: 8),
                Text('${vendor['cuisine']}', style: const TextStyle(color: _muted)),
                const SizedBox(height: 8),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Expanded(
                    child: Text(
                      open ? '$min–$max min' : opensAtLabel(vendor['opensAt']),
                      style: const TextStyle(fontWeight: FontWeight.w700, color: _charcoal),
                    ),
                  ),
                  if (open)
                    Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                      _CapacityChip(label: pace),
                      if (nextSlot != null) ...[
                        const SizedBox(height: 8),
                        Text('Next $nextSlot', style: const TextStyle(fontSize: 12, color: _muted)),
                      ],
                    ]),
                ]),
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}

class _CapacityChip extends StatelessWidget {
  const _CapacityChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final full = label == 'Fully booked';
    final busy = label == 'Busy';
    final color = full ? _full : busy ? _limited : _available;
    final tint = full ? _fullTint : busy ? _limitedTint : _availableTint;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(color: tint, borderRadius: BorderRadius.circular(8)),
      child: Text(label, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w800)),
    );
  }
}

class CustomerTracking extends StatelessWidget {
  const CustomerTracking({super.key, required this.order, required this.onOpen, this.vendorName = '', this.onBack, this.onDevToggle, this.devTools = false, this.onOpenCatalog});

  final Map<String, dynamic>? order;
  final void Function(String id) onOpen;
  final String vendorName;
  final VoidCallback? onBack;
  final VoidCallback? onDevToggle;
  final bool devTools;
  final VoidCallback? onOpenCatalog;

  @override
  Widget build(BuildContext context) {
    final current = order;
    if (current == null) {
      return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const Text('No active order', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        const Text('When you place an order, progress shows up here.'),
        const SizedBox(height: 16),
        Align(alignment: Alignment.centerLeft, child: TextButton(onPressed: () => _help(context), child: const Text('Help'))),
      ]);
    }
    final rider = current['rider'] is Map ? Map<String, dynamic>.from(current['rider'] as Map) : null;
    final lines = ((current['lines'] as List?) ?? []).whereType<Map>().toList();
    final kitchen = '${current['vendorName'] ?? vendorName}';
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        if (onBack != null)
          IconButton(tooltip: 'Back', onPressed: onBack, icon: const Icon(Icons.arrow_back), padding: EdgeInsets.zero, constraints: const BoxConstraints(minWidth: 40, minHeight: 40)),
        Expanded(
          child: GestureDetector(
            onLongPress: onDevToggle,
            child: Text(trackingHeadline(current), key: const Key('track-eta'), style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: _charcoal, height: 1.15)),
          ),
        ),
        TextButton(onPressed: () => _help(context), child: const Text('Help')),
        if (devTools) IconButton(tooltip: 'Screen list', onPressed: onOpenCatalog, icon: const Icon(Icons.menu)),
      ]),
      if (kitchen.isNotEmpty) ...[
        const SizedBox(height: 8),
        Text(kitchen, style: const TextStyle(color: _muted, fontSize: 16)),
      ],
      const SizedBox(height: 24),
      _Stepper(order: current),
      if (rider != null) ...[
        const SizedBox(height: 16),
        _RiderCard(rider: rider, code: current['code']?.toString()),
      ],
      const SizedBox(height: 16),
      Material(
        color: _white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: const BorderSide(color: _line)),
        clipBehavior: Clip.antiAlias,
        child: ExpansionTile(
          title: Text('Order ${current['id']}', style: const TextStyle(fontWeight: FontWeight.w800)),
          subtitle: Text('Rs ${current['total'] ?? ''}'),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          children: [
            for (final line in lines)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text('${line['qty']} × ${line['name']}'),
              ),
            Text('${current['payment'] ?? ''}'),
          ],
        ),
      ),
    ]);
  }

  void _help(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xFFFFF8EF),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            title: const Text('Report a problem'),
            onTap: () {
              Navigator.pop(context);
              onOpen('E18-US3-UI1');
            },
          ),
        ),
      ),
    );
  }
}

class _Stepper extends StatelessWidget {
  const _Stepper({required this.order});

  final Map order;

  @override
  Widget build(BuildContext context) {
    final status = '${order['status']}';
    final current = trackingIndex(status);
    final finished = status == 'delivered';
    final events = (order['events'] as Map?) ?? {};
    return Column(children: [
      for (var index = 0; index < _steps.length; index++)
        _Step(
          label: _steps[index],
          time: index < current || (finished && events[_eventKeys[index]] != null) ? clockLabel(events[_eventKeys[index]] ?? (index == 0 ? order['createdAt'] : null)) : '',
          highlighted: index == current,
          done: index < current || finished,
          last: index == _steps.length - 1,
        ),
    ]);
  }
}

class _Step extends StatelessWidget {
  const _Step({required this.label, required this.time, required this.highlighted, required this.done, required this.last});

  final String label;
  final String time;
  final bool highlighted;
  final bool done;
  final bool last;

  @override
  Widget build(BuildContext context) {
    final color = highlighted || done ? _charcoal : _muted;
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        width: 16,
        child: Column(children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: done || highlighted ? _orange : _white,
              shape: BoxShape.circle,
              border: Border.all(color: done || highlighted ? _orange : _line, width: 2),
            ),
          ),
          if (!last) Container(width: 2, height: 32, color: done ? _orange : _line),
        ]),
      ),
      const SizedBox(width: 16),
      Expanded(
        child: Padding(
          padding: EdgeInsets.only(bottom: last ? 0 : 16),
          child: Row(children: [
            Expanded(
              child: Text(
                label,
                key: highlighted ? const Key('step-current') : null,
                style: TextStyle(fontSize: 16, fontWeight: highlighted ? FontWeight.w800 : FontWeight.w600, color: color),
              ),
            ),
            if (time.isNotEmpty) Text(time, style: const TextStyle(color: _muted, fontSize: 12)),
          ]),
        ),
      ),
    ]);
  }
}

class _RiderCard extends StatelessWidget {
  const _RiderCard({required this.rider, this.code});

  final Map rider;
  final String? code;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: const BorderSide(color: _line)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          const CircleAvatar(backgroundColor: _orangeTint, child: Icon(Icons.two_wheeler, color: _orange)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('${rider['name']}', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
              const SizedBox(height: 8),
              Text('${rider['vehicle'] ?? 'Rider'}', style: const TextStyle(color: _muted)),
              if (code != null && code!.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text('Code $code', style: const TextStyle(fontWeight: FontWeight.w700)),
              ],
            ]),
          ),
        ]),
      ),
    );
  }
}
