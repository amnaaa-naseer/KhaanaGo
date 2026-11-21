import 'package:flutter/material.dart';

import 'components.dart';
import 'tokens.dart';

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
            child: const Text('F-11, Islamabad', style: KhaanaType.body),
          ),
        ),
        if (widget.devTools)
          IconButton(tooltip: 'Screen list', onPressed: widget.onOpenCatalog, icon: const Icon(Icons.menu)),
      ]),
      const SizedBox(height: KhaanaSpace.s4),
      TextField(
        controller: _search,
        onChanged: (_) => setState(() {}),
        decoration: InputDecoration(
          hintText: 'Search kitchens',
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: KhaanaColors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: KhaanaSpace.s4, vertical: KhaanaSpace.s2),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(KhaanaRadius.button), borderSide: const BorderSide(color: KhaanaColors.line)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(KhaanaRadius.button), borderSide: const BorderSide(color: KhaanaColors.line)),
        ),
      ),
      const SizedBox(height: KhaanaSpace.s4),
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
      const SizedBox(height: KhaanaSpace.s4),
      if (visible.isEmpty) const KhaanaEmptyState(message: 'No kitchens match.'),
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
        const SizedBox(height: KhaanaSpace.s4),
      ],
    ]);
  }

  Widget _filterChip(String label, bool selected, VoidCallback onTap) {
    return KhaanaChip(label: label, selected: selected, onSelected: (_) => onTap());
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
        color: KhaanaColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(KhaanaRadius.card), side: const BorderSide(color: KhaanaColors.line)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Container(
              height: 96,
              color: KhaanaColors.brandTint,
              child: const Icon(Icons.restaurant, color: KhaanaColors.brand, size: KhaanaSpace.s6),
            ),
            Padding(
              padding: KhaanaSpace.card,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Expanded(child: Text('${vendor['name']}', style: KhaanaType.heading)),
                  if (ratingText.isNotEmpty) ...[
                    const Icon(Icons.star, size: KhaanaSpace.s4, color: KhaanaColors.brand),
                    const SizedBox(width: KhaanaSpace.s2),
                    Text(ratingText, style: const TextStyle(fontWeight: FontWeight.w700)),
                  ],
                ]),
                const SizedBox(height: KhaanaSpace.s2),
                Text('${vendor['cuisine']}', style: KhaanaType.body.copyWith(color: KhaanaColors.muted)),
                const SizedBox(height: KhaanaSpace.s2),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Expanded(
                    child: Text(
                      open ? '$min–$max min' : opensAtLabel(vendor['opensAt']),
                      style: KhaanaType.body.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                  if (open)
                    Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                      KhaanaStatusBadge(label: pace, tone: pace == 'Fully booked' ? 'full' : pace == 'Busy' ? 'limited' : 'available'),
                      if (nextSlot != null) ...[
                        const SizedBox(height: KhaanaSpace.s2),
                        Text('Next $nextSlot', style: KhaanaType.caption),
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
        const Text('No active order', style: KhaanaType.display),
        const SizedBox(height: KhaanaSpace.s2),
        Text('When you place an order, progress shows up here.', style: KhaanaType.body.copyWith(color: KhaanaColors.muted)),
        const SizedBox(height: KhaanaSpace.s4),
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
            child: Text(trackingHeadline(current), key: const Key('track-eta'), style: KhaanaType.display),
          ),
        ),
        TextButton(onPressed: () => _help(context), child: const Text('Help')),
        if (devTools) IconButton(tooltip: 'Screen list', onPressed: onOpenCatalog, icon: const Icon(Icons.menu)),
      ]),
      if (kitchen.isNotEmpty) ...[
        const SizedBox(height: KhaanaSpace.s2),
        Text(kitchen, style: KhaanaType.body.copyWith(color: KhaanaColors.muted)),
      ],
      const SizedBox(height: KhaanaSpace.s5),
      _Stepper(order: current),
      if (rider != null) ...[
        const SizedBox(height: KhaanaSpace.s4),
        _RiderCard(rider: rider, code: current['code']?.toString()),
      ],
      const SizedBox(height: KhaanaSpace.s4),
      Material(
        color: KhaanaColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(KhaanaRadius.card), side: const BorderSide(color: KhaanaColors.line)),
        clipBehavior: Clip.antiAlias,
        child: ExpansionTile(
          title: Text('Order ${current['id']}', style: KhaanaType.heading),
          subtitle: Text('Rs ${current['total'] ?? ''}', style: KhaanaType.bodySmall),
          childrenPadding: const EdgeInsets.fromLTRB(KhaanaSpace.s4, 0, KhaanaSpace.s4, KhaanaSpace.s4),
          children: [
            for (final line in lines)
              Padding(
                padding: const EdgeInsets.only(bottom: KhaanaSpace.s2),
                child: Text('${line['qty']} × ${line['name']}', style: KhaanaType.body),
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
      backgroundColor: KhaanaColors.cream,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(KhaanaSpace.s2),
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
    return KhaanaStepper(
      current: current,
      finished: finished,
      currentKey: const Key('step-current'),
      steps: [
        for (var index = 0; index < _steps.length; index++)
          KhaanaStep(
            label: _steps[index],
            time: index < current || (finished && events[_eventKeys[index]] != null) ? clockLabel(events[_eventKeys[index]] ?? (index == 0 ? order['createdAt'] : null)) : '',
          ),
      ],
    );
  }
}

class _RiderCard extends StatelessWidget {
  const _RiderCard({required this.rider, this.code});

  final Map rider;
  final String? code;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: KhaanaColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(KhaanaRadius.card), side: const BorderSide(color: KhaanaColors.line)),
      child: Padding(
        padding: KhaanaSpace.card,
        child: Row(children: [
          const CircleAvatar(backgroundColor: KhaanaColors.brandTint, child: Icon(Icons.two_wheeler, color: KhaanaColors.brand)),
          const SizedBox(width: KhaanaSpace.s4),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('${rider['name']}', style: KhaanaType.body.copyWith(fontWeight: FontWeight.w800)),
              const SizedBox(height: KhaanaSpace.s2),
              Text('${rider['vehicle'] ?? 'Rider'}', style: KhaanaType.body.copyWith(color: KhaanaColors.muted)),
              if (code != null && code!.isNotEmpty) ...[
                const SizedBox(height: KhaanaSpace.s2),
                Text('Code $code', style: KhaanaType.body.copyWith(fontWeight: FontWeight.w700)),
              ],
            ]),
          ),
        ]),
      ),
    );
  }
}
