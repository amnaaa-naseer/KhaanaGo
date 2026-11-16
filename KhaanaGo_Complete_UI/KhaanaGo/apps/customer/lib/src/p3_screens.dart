import 'package:flutter/material.dart';
import 'package:khaana_design/khaana_design.dart';

import 'scope.dart';

/// E1-US1-UI6: App launch
/// Must show: KhaanaGo mark while session is checked
class CustomerAppLaunchScreen extends StatelessWidget {
  const CustomerAppLaunchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E1-US1-UI6',
      title: 'App launch',
      footer: KhaanaPrimaryButton(
        label: 'Session verified · Continue to Home',
        icon: Icons.arrow_forward_rounded,
        onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
      ),
      child: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                KhaanaLogo(size: 76, borderRadius: 20),
                SizedBox(height: 16),
                KhaanaWordmark(height: 34),
                SizedBox(height: 12),
                Text(
                  'Checking active customer session & live kitchen slot capacity…',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: KhaanaColors.mutedLight),
                ),
                SizedBox(height: 18),
                LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(KhaanaColors.orange),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// E1-US5-UI6: Location permission (Overlay)
/// Must show: Why location is needed; manual address fallback
Future<void> showCustomerLocationPermissionDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: KhaanaColors.orangeTint, borderRadius: BorderRadius.circular(6)),
            child: const Text('E1-US5-UI6', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: KhaanaColors.onOrangeTint)),
          ),
          const SizedBox(width: 8),
          const Expanded(child: Text('Location permission')),
        ],
      ),
      content: const Text(
        'KhaanaGo uses your device location to show nearby open kitchens, calculate accurate road-distance delivery fees, and check local weather buffers. If you prefer not to share GPS, you can manually select or type a delivery address.',
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/addresses');
          },
          child: const Text('Enter address manually'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Allow location access'),
        ),
      ],
    ),
  );
}

/// E17-US1-UI3: Notification permission (Overlay)
/// Must show: Why order alerts are useful; in-app updates still work if declined
Future<void> showNotificationPermissionDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: KhaanaColors.orangeTint, borderRadius: BorderRadius.circular(6)),
            child: const Text('E17-US1-UI3', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: KhaanaColors.onOrangeTint)),
          ),
          const SizedBox(width: 8),
          const Expanded(child: Text('Order status notifications')),
        ],
      ),
      content: const Text(
        'Enable notifications to receive timely alerts when the kitchen starts preparing your order, if a revised custom cake quote arrives, or if weather delays your delivery slot. If you decline, all live updates still work inside the in-app Notification Centre (E17-US1-UI2).',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Use in-app updates only'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Enable notifications'),
        ),
      ],
    ),
  );
}

/// E1-US5-UI5: Delete address confirmation (Overlay)
/// Must show: Confirm removal
Future<bool?> showDeleteAddressConfirmationDialog(
  BuildContext context, {
  required String addressLabel,
}) {
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: KhaanaColors.orangeTint, borderRadius: BorderRadius.circular(6)),
            child: const Text('E1-US5-UI5', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: KhaanaColors.onOrangeTint)),
          ),
          const SizedBox(width: 8),
          const Expanded(child: Text('Delete saved address?')),
        ],
      ),
      content: Text(
        'Are you sure you want to remove "$addressLabel" from your saved delivery addresses? Past order invoices keep their historical delivery address.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Keep address'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: KhaanaColors.full),
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Confirm removal'),
        ),
      ],
    ),
  );
}

/// E3-US1-UI6: Vendor info and reviews
/// Must show: Address, hours, hygiene note, customer ratings and comments
class VendorInfoReviewsScreen extends StatelessWidget {
  const VendorInfoReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final session = CustomerScope.of(context);
    final vendor = session.vendor ?? session.vendors.first;
    return KhaanaPage(
      uiId: 'E3-US1-UI6',
      title: '${vendor.name} · Info & reviews',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(vendor.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                      CapacityBadge(kind: CapacityKind.available, label: '${vendor.rating} ★ Verified'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('Address: Shop 14, Street 8, ${vendor.area} Markaz, Islamabad'),
                  const Text('Operating Hours: Mon–Sun 11:00 AM – 10:00 PM'),
                  const Divider(height: 24),
                  const KhaanaInlineBanner(
                    kind: CapacityKind.available,
                    icon: Icons.verified_outlined,
                    text: 'Hygiene & Food Safety Note: Verified ICT Food Authority Licence #FA-2026-881. Dedicated nut-free prep surface available on request.',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text('Customer Ratings & Reviews (Isolated from Rider Scores · E18-US1):', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          for (final r in const [
            ('Ayesha K. · 5 ★ · Today', '"Belgian chocolate ganache was rich and the nut-free customization was followed carefully."'),
            ('Hammad R. · 5 ★ · Yesterday', '"Honest 6:30 PM slot capacity — cake arrived freshly frosted right on time."'),
            ('Sana T. · 4 ★ · 3 days ago', '"Bento cake packaging was sturdy and presentation matched my reference photo."'),
          ])
            Card(
              child: ListTile(
                title: Text(r.$1, style: const TextStyle(fontWeight: FontWeight.w800)),
                subtitle: Text(r.$2),
              ),
            ),
        ],
      ),
    );
  }
}

/// E10-US1-UI1: Cancel order (Overlay)
/// Must show: Allowed only before preparation starts; reason; refund note for prepaid
Future<void> showCancelOrderDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (context) => const _CancelOrderOverlay(),
  );
}

class _CancelOrderOverlay extends StatefulWidget {
  const _CancelOrderOverlay();

  @override
  State<_CancelOrderOverlay> createState() => _CancelOrderOverlayState();
}

class _CancelOrderOverlayState extends State<_CancelOrderOverlay> {
  bool _prepStarted = false;
  final _reason = TextEditingController(text: 'Ordered for wrong delivery date');
  bool _cancelled = false;

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
            child: const Text('E10-US1-UI1', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: KhaanaColors.onOrangeTint)),
          ),
          const SizedBox(width: 8),
          const Expanded(child: Text('Cancel order (#KG-1042)')),
        ],
      ),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 440),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Simulate kitchen has already started preparation'),
              value: _prepStarted,
              onChanged: (v) => setState(() {
                _prepStarted = v;
                _cancelled = false;
              }),
            ),
            if (_prepStarted)
              const KhaanaInlineBanner(
                kind: CapacityKind.full,
                text: 'Cancellation blocked: Kitchen preparation has already started for Order #KG-1042. Orders can only be cancelled before preparation begins.',
              )
            else ...[
              TextField(
                controller: _reason,
                decoration: const InputDecoration(labelText: 'Cancellation reason *'),
              ),
              const SizedBox(height: 10),
              const KhaanaInlineBanner(
                kind: CapacityKind.info,
                text: 'Prepaid Refund Note: Because you paid online via JazzCash (Rs 2,014), cancelling before preparation starts automatically queues a full refund and releases your 6:30 PM slot.',
              ),
              if (_cancelled) ...[
                const SizedBox(height: 10),
                const KhaanaInlineBanner(
                  kind: CapacityKind.available,
                  text: 'Order #KG-1042 cancelled. Slot released and Rs 2,014 refund initiated.',
                ),
              ],
            ],
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
        if (!_prepStarted && !_cancelled)
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: KhaanaColors.full),
            onPressed: () => setState(() => _cancelled = true),
            child: const Text('Confirm cancellation'),
          ),
      ],
    ),
  );
}

/// E18-US3-UI2: Complaint status
/// Must show: Submitted, Under review, Resolved with admin outcome
class ComplaintStatusScreen extends StatefulWidget {
  const ComplaintStatusScreen({super.key});

  @override
  State<ComplaintStatusScreen> createState() => _ComplaintStatusScreenState();
}

class _ComplaintStatusScreenState extends State<ComplaintStatusScreen> {
  int _stage = 2; // 0 = Submitted, 1 = Under review, 2 = Resolved

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E18-US3-UI2',
      title: 'Complaint status (#CMP-204)',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            children: [
              ChoiceChip(
                label: const Text('1. Submitted'),
                selected: _stage == 0,
                onSelected: (_) => setState(() => _stage = 0),
              ),
              ChoiceChip(
                label: const Text('2. Under review'),
                selected: _stage == 1,
                onSelected: (_) => setState(() => _stage = 1),
              ),
              ChoiceChip(
                label: const Text('3. Resolved with admin outcome'),
                selected: _stage == 2,
                onSelected: (_) => setState(() => _stage = 2),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Ticket #CMP-204 · Linked Order #KG-1042 (BakeCharm)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 12),
                  OrderStatusTimeline(
                    activeIndex: _stage,
                    steps: const [
                      ('Submitted', '6:55 PM · Complaint & photo evidence attached by customer'),
                      ('Under review', '7:05 PM · Administrator reviewing kitchen & rider timeline'),
                      ('Resolved', '7:20 PM · Administrator decision recorded and parties notified'),
                    ],
                  ),
                  if (_stage == 2) ...[
                    const Divider(height: 24),
                    const KhaanaInlineBanner(
                      kind: CapacityKind.available,
                      text:
                          'Administrator Outcome (E20-US3 AC4): "Partial credit of Rs 400 issued to your KhaanaGo wallet for the dented cake box corner; packaging guidance shared with BakeCharm. Case closed."',
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

