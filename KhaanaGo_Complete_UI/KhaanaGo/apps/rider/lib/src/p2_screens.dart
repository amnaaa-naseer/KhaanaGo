import 'package:flutter/material.dart';
import 'package:khaana_design/khaana_design.dart';

import 'p3_screens.dart';
import 'scope.dart';
import 'session.dart';

/// E1-US2-UI3: Registration 1: personal details
/// Must show: Name, CNIC, phone, password
class RiderRegStep1Screen extends StatefulWidget {
  const RiderRegStep1Screen({super.key});

  @override
  State<RiderRegStep1Screen> createState() => _RiderRegStep1ScreenState();
}

class _RiderRegStep1ScreenState extends State<RiderRegStep1Screen> {
  final _name = TextEditingController(text: 'Bilal Ahmed');
  final _cnic = TextEditingController(text: '37405-8829104-1');
  final _phone = TextEditingController(text: '0312-9876543');
  final _password = TextEditingController(text: 'Rider@2026');
  String? _error;

  @override
  void dispose() {
    _name.dispose();
    _cnic.dispose();
    _phone.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E1-US2-UI3',
      title: 'Registration 1: Personal details',
      footer: KhaanaPrimaryButton(
        label: 'Next: Vehicle & phone OS (E1-US2-UI4)',
        icon: Icons.arrow_forward_rounded,
        onPressed: () {
          if (_name.text.trim().isEmpty ||
              _cnic.text.trim().isEmpty ||
              _phone.text.trim().isEmpty ||
              _password.text.length < 8) {
            setState(() => _error = 'Complete Name, 13-digit CNIC, phone number, and an 8+ character password.');
            return;
          }
          setState(() => _error = null);
          Navigator.pushNamed(context, '/reg-2');
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
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Step 1 of 3 · Personal Identity', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _name,
                    decoration: const InputDecoration(labelText: 'Full Name *', prefixIcon: Icon(Icons.person_outline)),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _cnic,
                    decoration: const InputDecoration(labelText: 'CNIC Number *', prefixIcon: Icon(Icons.badge_outlined)),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _phone,
                    decoration: const InputDecoration(labelText: 'Mobile Phone *', prefixIcon: Icon(Icons.phone_android)),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _password,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Password (min 8 chars) *', prefixIcon: Icon(Icons.lock_outline)),
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

/// E1-US2-UI4: Registration 2: vehicle and phone
/// Must show: Motorbike, car or van; phone OS
class RiderRegStep2Screen extends StatefulWidget {
  const RiderRegStep2Screen({super.key});

  @override
  State<RiderRegStep2Screen> createState() => _RiderRegStep2ScreenState();
}

class _RiderRegStep2ScreenState extends State<RiderRegStep2Screen> {
  String _vehicle = 'Motorbike';
  String _phoneOs = 'Android 14';

  @override
  Widget build(BuildContext context) {
    final session = RiderScope.of(context);
    return KhaanaPage(
      uiId: 'E1-US2-UI4',
      title: 'Registration 2: Vehicle & phone',
      footer: KhaanaPrimaryButton(
        label: 'Next: Upload documents (E1-US2-UI5)',
        icon: Icons.arrow_forward_rounded,
        onPressed: () {
          session.setVehicle(_vehicle);
          Navigator.pushNamed(context, '/reg-3');
        },
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Step 2 of 3 · Vehicle Type & Phone OS', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 12),
                  const Text('Select Vehicle Type *', style: TextStyle(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final v in ['Motorbike', 'Car', 'Van'])
                        ChoiceChip(
                          label: Text(v),
                          selected: _vehicle == v,
                          onSelected: (_) => setState(() => _vehicle = v),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text('Select Phone Operating System *', style: TextStyle(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final os in ['Android 14', 'iOS 17'])
                        ChoiceChip(
                          label: Text(os),
                          selected: _phoneOs == os,
                          onSelected: (_) => setState(() => _phoneOs = os),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const KhaanaInlineBanner(
                    kind: CapacityKind.info,
                    text: 'Fragile 2-tier cakes are preferentially dispatched to Car or Van riders when requested by the kitchen.',
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

/// E1-US2-UI5: Registration 3: documents
/// Must show: Licence and CNIC upload, field errors for missing items (TC3)
class RiderRegStep3Screen extends StatefulWidget {
  const RiderRegStep3Screen({super.key});

  @override
  State<RiderRegStep3Screen> createState() => _RiderRegStep3ScreenState();
}

class _RiderRegStep3ScreenState extends State<RiderRegStep3Screen> {
  bool _hasLicence = true;
  bool _hasCnicFrontBack = true;
  String? _error;

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E1-US2-UI5',
      title: 'Registration 3: Documents',
      footer: KhaanaPrimaryButton(
        label: 'Submit for verification (E1-US2-UI6)',
        icon: Icons.upload_file_rounded,
        onPressed: () {
          if (!_hasLicence || !_hasCnicFrontBack) {
            setState(() {
              _error =
                  'Missing mandatory documents: Both Driving Licence and CNIC scan are required before submission (E1-US2-TC3).';
            });
            return;
          }
          setState(() => _error = null);
          Navigator.pushNamed(context, '/pending-verification');
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
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Step 3 of 3 · Mandatory Document Uploads', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 12),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Driving Licence Scan (driving_licence_bilal.jpg)', style: TextStyle(fontWeight: FontWeight.w700)),
                    subtitle: Text(_hasLicence ? 'Attached · Valid until 2028' : 'Missing — triggers TC3 field error'),
                    value: _hasLicence,
                    onChanged: (v) => setState(() => _hasLicence = v),
                  ),
                  const Divider(),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('CNIC Front & Back Scan (cnic_bilal_37405.jpg)', style: TextStyle(fontWeight: FontWeight.w700)),
                    subtitle: Text(_hasCnicFrontBack ? 'Attached · Legible' : 'Missing — triggers TC3 field error'),
                    value: _hasCnicFrontBack,
                    onChanged: (v) => setState(() => _hasCnicFrontBack = v),
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

/// E1-US2-UI6: Pending verification
/// Must show: "Under review"; cannot go online until approved (AC1)
class PendingVerificationScreen extends StatelessWidget {
  const PendingVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E1-US2-UI6',
      title: 'Pending verification',
      footer: KhaanaSecondaryButton(
        label: 'Preview rejected / more info needed (E1-US2-UI7)',
        icon: Icons.warning_amber_rounded,
        onPressed: () => Navigator.pushNamed(context, '/application-rejected'),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const KhaanaInlineBanner(
            kind: CapacityKind.limited,
            icon: Icons.hourglass_top_rounded,
            text: 'Application status: Under review. You cannot go online or receive delivery offers until an administrator approves your documents (E1-US2 AC1).',
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('Go Online (Blocked while Under Review)', style: TextStyle(fontWeight: FontWeight.w800)),
                    subtitle: Text('Disabled until document verification completes (E1-US2-TC2).'),
                    value: false,
                    onChanged: null,
                  ),
                  Divider(),
                  Text('Submitted Documents:', style: TextStyle(fontWeight: FontWeight.w800)),
                  SizedBox(height: 6),
                  Text('• Driving Licence: Pending admin review'),
                  Text('• CNIC Front & Back: Pending admin review'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// E1-US2-UI7: Application rejected or more information needed
/// Must show: Reason and what to resubmit (E20-US1 AC3, AC4)
class ApplicationRejectedScreen extends StatefulWidget {
  const ApplicationRejectedScreen({super.key});

  @override
  State<ApplicationRejectedScreen> createState() => _ApplicationRejectedScreenState();
}

class _ApplicationRejectedScreenState extends State<ApplicationRejectedScreen> {
  bool _resubmitted = false;

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E1-US2-UI7',
      title: 'Application rejected / More info needed',
      footer: KhaanaPrimaryButton(
        label: _resubmitted ? 'Resubmitted — Back to Pending Review' : 'Upload replacement Driving Licence & Resubmit',
        icon: Icons.upload_rounded,
        onPressed: () {
          if (_resubmitted) {
            Navigator.pushReplacementNamed(context, '/pending-verification');
          } else {
            setState(() => _resubmitted = true);
          }
        },
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const KhaanaInlineBanner(
            kind: CapacityKind.full,
            text:
                'Administrator Decision (E20-US1 AC3, AC4): "Driving licence photo is blurry and expiry date is cut off. Please upload a clear scan of your valid driving licence."',
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('What to resubmit:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 8),
                  const Text('1. Clear photo of Driving Licence showing license number and expiry date.'),
                  const Text('2. CNIC scan was approved and does not need to be re-uploaded.'),
                  if (_resubmitted) ...[
                    const SizedBox(height: 12),
                    const KhaanaInlineBanner(
                      kind: CapacityKind.available,
                      text: 'Replacement licence (licence_high_res.jpg) uploaded and queued for review.',
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

/// E13-US2-UI1: Location permission (Overlay)
/// Must show: Why location is needed while online, then system prompt
Future<void> showLocationPermissionDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: KhaanaColors.orangeTintDark, borderRadius: BorderRadius.circular(6)),
            child: const Text('E13-US2-UI1', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: KhaanaColors.orange)),
          ),
          const SizedBox(width: 8),
          const Expanded(child: Text('Location permission required')),
        ],
      ),
      content: const Text(
        'KhaanaGo needs live GPS location while you are online to dispatch nearby orders at 80% kitchen prep, verify pickup arrival for waiting-time pay, and share live tracking with the customer.',
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Not now')),
        FilledButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Continue to OS Location Prompt'),
        ),
      ],
    ),
  );
}

/// E13-US2-UI3: Outside service area (Overlay)
/// Must show: Why no offers arrive and where to go (AC3)
Future<void> showOutsideServiceAreaDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: KhaanaColors.orangeTintDark, borderRadius: BorderRadius.circular(6)),
            child: const Text('E13-US2-UI3', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: KhaanaColors.orange)),
          ),
          const SizedBox(width: 8),
          const Expanded(child: Text('Outside active service area')),
        ],
      ),
      content: const Text(
        'You are currently 4.8 km outside the Islamabad F-10 / F-11 dispatch zone. No delivery offers will arrive while outside the zone (E13-US2 AC3). Head back towards F-11 Markaz or G-9 to receive orders.',
      ),
      actions: [
        FilledButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Navigate to F-11 Markaz zone'),
        ),
      ],
    ),
  );
}

/// E14-US1-UI1: Pooled trip offer
/// Must show: Two pickups/drop-offs, max 2 orders, combined pay.
/// Include eligibility distances/corridor and hold limit; exclude fragile or spillable items; never add a third order.
class PooledTripOfferScreen extends StatelessWidget {
  const PooledTripOfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E14-US1-UI1',
      title: 'Pooled trip offer (Max 2 orders)',
      footer: Row(
        children: [
          Expanded(
            child: KhaanaSecondaryButton(
              label: 'Decline',
              onPressed: () => Navigator.pop(context),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: KhaanaPrimaryButton(
              label: 'Accept pooled trip · Rs 245',
              icon: Icons.group_work_outlined,
              onPressed: () => Navigator.pushNamed(context, '/pooled-parcels'),
            ),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const KhaanaInlineBanner(
            kind: CapacityKind.available,
            text:
                'Pooled Eligibility Verified (E14-US1): Max 2 orders per trip (3rd order strictly blocked · TC2). Pickups 0.6 km apart (≤ 1.0 km limit), drop-offs in same F-11 corridor, max 10-min second pickup hold. Neither order contains fragile cakes or spillable items (TC4).',
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Combined Rider Pay: Rs 245', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: KhaanaColors.availableDark)),
                      CapacityBadge(kind: CapacityKind.info, label: '2 Orders · Max Cap Reached'),
                    ],
                  ),
                  Divider(height: 24),
                  Text('Stop 1 Pickup · Lazeez Cloud Kitchen (F-10 Markaz)', style: TextStyle(fontWeight: FontWeight.w800)),
                  Text('Order #KG-1051 · Chicken Karahi (Non-fragile) · Ready in 3 min'),
                  SizedBox(height: 10),
                  Text('Stop 2 Pickup · Tandoori Express (0.6 km away, F-10/3)', style: TextStyle(fontWeight: FontWeight.w800)),
                  Text('Order #KG-1052 · Mutton Pulao Box (Non-fragile) · Hold cap: 10:00 max'),
                  Divider(height: 24),
                  Text('Drop-off 1: Street 14, F-11/2 (2.4 km)', style: TextStyle(fontWeight: FontWeight.w700)),
                  Text('Drop-off 2: Street 22, F-11/1 (0.8 km along same corridor)', style: TextStyle(fontWeight: FontWeight.w700)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// E13-US2-UI5: Offer expired (Overlay)
/// Must show: Offer passed to another rider (AC2)
Future<void> showOfferExpiredDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: KhaanaColors.orangeTintDark, borderRadius: BorderRadius.circular(6)),
            child: const Text('E13-US2-UI5', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: KhaanaColors.orange)),
          ),
          const SizedBox(width: 8),
          const Expanded(child: Text('Offer expired')),
        ],
      ),
      content: const Text(
        'The 45-second acceptance window ended. This offer has been passed to the next nearest online rider (E13-US2 AC2). Stay online for the next order.',
      ),
      actions: [
        FilledButton(onPressed: () => Navigator.pop(context), child: const Text('Back to Home')),
      ],
    ),
  );
}

/// E14-US2-UI2: Pooled parcels and labels
/// Must show: Each parcel's label to match at drop-off, stop order (AC4)
class PooledParcelsScreen extends StatelessWidget {
  const PooledParcelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E14-US2-UI2',
      title: 'Pooled parcels & labels',
      footer: KhaanaPrimaryButton(
        label: 'Preview 2nd pickup hold countdown (E14-US1-UI2)',
        icon: Icons.timer_outlined,
        onPressed: () => showSecondPickupHoldDialog(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const KhaanaInlineBanner(
            kind: CapacityKind.info,
            text: 'Match the physical bag tag code at each doorstep so pooled parcels are never swapped (E14-US2 AC4).',
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('STOP 1 DROP-OFF · BAG LABEL [POOL-A]', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                      CapacityBadge(kind: CapacityKind.available, label: 'Deliver First'),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text('Order #KG-1051 · Lazeez Cloud Kitchen · 1× Chicken Karahi'),
                  Text('Customer: Hammad Raza · Street 14, F-11/2 · PIN: 319402'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('STOP 2 DROP-OFF · BAG LABEL [POOL-B]', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                      CapacityBadge(kind: CapacityKind.info, label: 'Deliver Second'),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text('Order #KG-1052 · Tandoori Express · 1× Mutton Pulao Box'),
                  Text('Customer: Sana Tariq · Street 22, F-11/1 · PIN: 774190'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// E14-US1-UI2: Second pickup hold (Overlay)
/// Must show: Countdown, then "Order uncoupled, continue with the first" (AC3, AC4)
Future<void> showSecondPickupHoldDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (context) => const _SecondPickupHoldOverlay(),
  );
}

class _SecondPickupHoldOverlay extends StatefulWidget {
  const _SecondPickupHoldOverlay();

  @override
  State<_SecondPickupHoldOverlay> createState() => _SecondPickupHoldOverlayState();
}

class _SecondPickupHoldOverlayState extends State<_SecondPickupHoldOverlay> {
  bool _uncoupled = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: KhaanaColors.orangeTintDark, borderRadius: BorderRadius.circular(6)),
            child: const Text('E14-US1-UI2', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: KhaanaColors.orange)),
          ),
          const SizedBox(width: 8),
          const Expanded(child: Text('Second pickup hold')),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!_uncoupled) ...[
            const Text('Waiting for Order #KG-1052 at Stop 2 (Max hold: 10:00 · Remaining: 00:18).'),
            const SizedBox(height: 10),
            const LinearProgressIndicator(value: 0.95),
          ] else
            const KhaanaInlineBanner(
              kind: CapacityKind.limited,
              text:
                  '10-minute hold limit reached! Order #KG-1052 uncoupled and reassigned to another rider. Continue immediately with your first order (#KG-1051) so it stays hot (E14-US1 AC3, AC4).',
            ),
        ],
      ),
      actions: [
        if (!_uncoupled)
          TextButton(
            onPressed: () => setState(() => _uncoupled = true),
            child: const Text('Simulate 10-min hold expiry (TC3)'),
          ),
        FilledButton(
          onPressed: () => Navigator.pop(context),
          child: Text(_uncoupled ? 'Continue with 1st order' : 'Close'),
        ),
      ],
    );
  }
}

/// E13-US3-UI3: Out-of-sequence prompt (Overlay)
/// Must show: Why the tap was blocked and what to do next (AC2)
Future<void> showOutOfSequenceDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: KhaanaColors.orangeTintDark, borderRadius: BorderRadius.circular(6)),
            child: const Text('E13-US3-UI3', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: KhaanaColors.orange)),
          ),
          const SizedBox(width: 8),
          const Expanded(child: Text('Step blocked: Out of sequence')),
        ],
      ),
      content: const Text(
        'You cannot mark this order Delivered before completing "Picked up" and verifying the customer\'s 6-digit delivery PIN (E13-US3 AC2). Next required step: Hold to confirm Picked Up at the store.',
      ),
      actions: [
        FilledButton(onPressed: () => Navigator.pop(context), child: const Text('Got it')),
      ],
    ),
  );
}

/// E10-US2-UI2: Collect cash
/// Must show: Amount due, confirm cash collected (COD AC2)
class CollectCashScreen extends StatefulWidget {
  const CollectCashScreen({super.key});

  @override
  State<CollectCashScreen> createState() => _CollectCashScreenState();
}

class _CollectCashScreenState extends State<CollectCashScreen> {
  bool _collected = false;

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E10-US2-UI2',
      title: 'Collect cash (COD)',
      footer: KhaanaPrimaryButton(
        label: _collected ? 'Cash recorded · Proceed to PIN (E13-US3-UI2)' : 'Confirm Rs 2,014 cash collected',
        icon: Icons.payments_outlined,
        onPressed: () {
          if (!_collected) {
            setState(() => _collected = true);
          } else {
            Navigator.pushNamed(context, '/code');
          }
        },
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CapacityBadge(kind: CapacityKind.limited, label: 'CASH ON DELIVERY · INVOICE #INV-2026-1042'),
                  const SizedBox(height: 12),
                  const Text('Amount due from customer:', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(
                    formatRupees(2014),
                    style: const TextStyle(fontSize: 34, fontWeight: FontWeight.w800, color: KhaanaColors.availableDark),
                  ),
                  const SizedBox(height: 8),
                  const Text('Count the cash before entering the customer\'s 6-digit delivery PIN (E10-US2 AC2).'),
                  if (_collected) ...[
                    const SizedBox(height: 12),
                    const KhaanaInlineBanner(
                      kind: CapacityKind.available,
                      text: 'Rs 2,014 COD collection logged against your shift reconciliation.',
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

/// E16-US4-UI2: Quick messages (Overlay)
/// Must show: Preset messages for arrival and delay, one tap or voice (AC1)
Future<void> showQuickMessagesSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    builder: (context) => Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: KhaanaColors.orangeTintDark, borderRadius: BorderRadius.circular(6)),
                child: const Text('E16-US4-UI2', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: KhaanaColors.orange)),
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text('One-tap & voice quick messages', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          for (final msg in [
            'I have arrived outside your gate.',
            'Delayed 5–10 minutes due to rain & traffic.',
            'Please share or confirm your drop-off pin.',
            'Waiting at reception with your fragile cake box.',
          ])
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.send_rounded, color: KhaanaColors.orange),
              title: Text(msg, style: const TextStyle(fontWeight: FontWeight.w700)),
              subtitle: const Text('Tap once or say preset number via headset (E16-US4 AC1)'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sent preset: "$msg"')));
              },
            ),
        ],
      ),
    ),
  );
}

/// E16-US4-UI3: Request corrected pin (Overlay)
/// Must show: Ask the customer to confirm a new pin (AC2)
Future<void> showRequestCorrectedPinDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: KhaanaColors.orangeTintDark, borderRadius: BorderRadius.circular(6)),
            child: const Text('E16-US4-UI3', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: KhaanaColors.orange)),
          ),
          const SizedBox(width: 8),
          const Expanded(child: Text('Request corrected drop-off pin')),
        ],
      ),
      content: const Text(
        'Send your current GPS coordinates (Gate 2, Street 14, F-11 Markaz) to the customer so they can confirm or adjust the drop-off pin on E16-US4-UI1 (AC2)?',
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        FilledButton(
          onPressed: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Pin correction request sent to customer.')),
            );
          },
          child: const Text('Send pin request'),
        ),
      ],
    ),
  );
}

/// E16-US1-UI1: Voice check-in (Overlay)
/// Must show: "Confirm arrival at customer", say "Confirm" or press headset button; repeats once (AC1, AC2)
Future<void> showVoiceCheckInDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (context) => const _VoiceCheckInOverlay(),
  );
}

class _VoiceCheckInOverlay extends StatefulWidget {
  const _VoiceCheckInOverlay();

  @override
  State<_VoiceCheckInOverlay> createState() => _VoiceCheckInOverlayState();
}

class _VoiceCheckInOverlayState extends State<_VoiceCheckInOverlay> {
  int _promptCount = 1;
  bool _confirmed = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: KhaanaColors.orangeTintDark, borderRadius: BorderRadius.circular(6)),
            child: const Text('E16-US1-UI1', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: KhaanaColors.orange)),
          ),
          const SizedBox(width: 8),
          const Expanded(child: Text('Hands-free safety voice check-in')),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Spoken Prompt ($_promptCount of 2): "Confirm arrival at customer."',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          const Text(
            'Say "Confirm" into your helmet mic or press your headset action button once. If unanswered, the prompt repeats once before escalating to admin after the grace period (E16-US1 AC1, AC2).',
          ),
          if (_confirmed) ...[
            const SizedBox(height: 10),
            const KhaanaInlineBanner(
              kind: CapacityKind.available,
              text: 'Voice check-in confirmed! Arrival logged hands-free.',
            ),
          ],
        ],
      ),
      actions: [
        if (_promptCount < 2 && !_confirmed)
          TextButton(
            onPressed: () => setState(() => _promptCount = 2),
            child: const Text('Simulate no reply -> Repeat once (AC2)'),
          ),
        FilledButton.icon(
          onPressed: () {
            if (_confirmed) {
              Navigator.pop(context);
            } else {
              setState(() => _confirmed = true);
            }
          },
          icon: const Icon(Icons.headset_mic_rounded),
          label: Text(_confirmed ? 'Done' : 'Say "Confirm" / Headset Button'),
        ),
      ],
    );
  }
}

/// E19-US3-UI1: Rider voice assistant (Overlay)
/// Must show: Next pickup, readiness, spoken answer shown as text
Future<void> showRiderVoiceAssistantSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (context) => const _RiderVoiceAssistantSheet(),
  );
}

class _RiderVoiceAssistantSheet extends StatefulWidget {
  const _RiderVoiceAssistantSheet();

  @override
  State<_RiderVoiceAssistantSheet> createState() => _RiderVoiceAssistantSheetState();
}

class _RiderVoiceAssistantSheetState extends State<_RiderVoiceAssistantSheet> {
  String _query = 'next_pickup';

  @override
  Widget build(BuildContext context) {
    final session = RiderScope.of(context);
    final answer = switch (_query) {
      'next_pickup' =>
        'Spoken & Text Reply: "Your next pickup is BakeCharm at ${session.vendorAddress} (1.1 km away). Kitchen preparation is at ${session.prepPercent}%."',
      'readiness' =>
        'Spoken & Text Reply: "Order #KG-1042 at BakeCharm has reached ${session.prepPercent}% prep (80% threshold reached — ready for handover)."',
      _ =>
        'Refused (E19-US3-TC3 / E19-US4): As a rider, you cannot query customer payment cards, vendor net profit, or secret recipe quantities.',
    };
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: KhaanaColors.orangeTintDark, borderRadius: BorderRadius.circular(6)),
                child: const Text('E19-US3-UI1', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: KhaanaColors.orange)),
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text('Rider hands-free voice assistant', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ChoiceChip(
                label: const Text('"What is my next pickup?" (TC1)'),
                selected: _query == 'next_pickup',
                onSelected: (_) => setState(() => _query = 'next_pickup'),
              ),
              ChoiceChip(
                label: const Text('"Is the order ready?"'),
                selected: _query == 'readiness',
                onSelected: (_) => setState(() => _query = 'readiness'),
              ),
              ChoiceChip(
                label: const Text('Unauthorized vendor finance query (TC3)'),
                selected: _query == 'refused',
                onSelected: (_) => setState(() => _query = 'refused'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          KhaanaInlineBanner(
            kind: _query == 'refused' ? CapacityKind.full : CapacityKind.available,
            icon: Icons.volume_up_rounded,
            text: answer,
          ),
          const SizedBox(height: 12),
          KhaanaPrimaryButton(label: 'Close assistant', onPressed: () => Navigator.pop(context)),
        ],
      ),
    );
  }
}

/// E18-US3-UI3: Report a problem
/// Must show: Order, category, description
class RiderReportProblemScreen extends StatefulWidget {
  const RiderReportProblemScreen({super.key});

  @override
  State<RiderReportProblemScreen> createState() => _RiderReportProblemScreenState();
}

class _RiderReportProblemScreenState extends State<RiderReportProblemScreen> {
  String _category = 'Customer unreachable at drop-off';
  final _desc = TextEditingController(text: 'Called twice and rang doorbell at F-11 Markaz; waiting for PIN.');
  bool _submitted = false;

  @override
  void dispose() {
    _desc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E18-US3-UI3',
      title: 'Report a delivery problem',
      footer: KhaanaPrimaryButton(
        label: _submitted ? 'Issue ticket logged' : 'Submit rider problem report',
        icon: Icons.report_problem_outlined,
        onPressed: () => setState(() => _submitted = true),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Order #KG-1042 · BakeCharm -> F-11 Markaz', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    initialValue: _category,
                    decoration: const InputDecoration(labelText: 'Problem category *'),
                    items: const [
                      DropdownMenuItem(value: 'Customer unreachable at drop-off', child: Text('Customer unreachable at drop-off')),
                      DropdownMenuItem(value: 'Wrong map pin / blocked street', child: Text('Wrong map pin / blocked street')),
                      DropdownMenuItem(value: 'Parcel damaged or spilled', child: Text('Parcel damaged or spilled')),
                      DropdownMenuItem(value: 'Excessive kitchen delay', child: Text('Excessive kitchen delay')),
                    ],
                    onChanged: (v) {
                      if (v != null) setState(() => _category = v);
                    },
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _desc,
                    maxLines: 3,
                    decoration: const InputDecoration(labelText: 'Description *'),
                  ),
                  if (_submitted) ...[
                    const SizedBox(height: 12),
                    const KhaanaInlineBanner(
                      kind: CapacityKind.available,
                      text: 'Problem report #RDR-882 submitted and linked to Order #KG-1042.',
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

/// E13-US2-UI6: Shift summary
/// Must show: Deliveries, distance, waiting time, earnings (AC4)
class ShiftSummaryScreen extends StatelessWidget {
  const ShiftSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final session = RiderScope.of(context);
    return KhaanaPage(
      uiId: 'E13-US2-UI6',
      title: 'Shift summary',
      footer: KhaanaPrimaryButton(
        label: 'Open Shift Earnings Invoice (E15-US3-UI1)',
        icon: Icons.receipt_long_rounded,
        onPressed: () => Navigator.pushNamed(context, '/shift-invoice'),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Evening Shift · F-11 / F-10 Zone', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                  const Divider(height: 24),
                  Text('• Completed deliveries: ${session.deliveriesToday} orders', style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 6),
                  const Text('• Total routed distance: 14.8 km', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 6),
                  const Text('• Verified store waiting time: 19 mins (11 mins billable)', style: TextStyle(fontSize: 16)),
                  const Divider(height: 24),
                  Text(
                    'Total Shift Earnings: ${formatRupees(912)}',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: KhaanaColors.availableDark),
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

/// E15-US3-UI1: Shift earnings invoice
/// Must show: Per delivery: base fee, per-km, waiting fee, surcharges, total (AC1)
class ShiftEarningsInvoiceScreen extends StatelessWidget {
  const ShiftEarningsInvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E15-US3-UI1',
      title: 'Shift earnings invoice',
      footer: KhaanaPrimaryButton(
        label: 'Inspect Single & Pooled Delivery Detail (E15-US3-UI2)',
        icon: Icons.analytics_outlined,
        onPressed: () => Navigator.pushNamed(context, '/earnings-detail'),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final item in const [
            ('#KG-1042 · BakeCharm (Express)', 80, 48, 30, 40, 198),
            ('#KG-1051 + #KG-1052 (Pooled 2-stop)', 120, 65, 20, 40, 245),
            ('#KG-1038 · Lazeez Cloud Kitchen', 80, 54, 0, 40, 174),
          ])
            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                title: Text(item.$1, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
                subtitle: Text(
                  'Base Rs ${item.$2} · Per-km Rs ${item.$3} · Waiting Rs ${item.$4} · Rain surcharge Rs ${item.$5}',
                ),
                trailing: Text(
                  formatRupees(item.$6),
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: KhaanaColors.availableDark),
                ),
                onTap: () => Navigator.pushNamed(context, '/earnings-detail'),
              ),
            ),
        ],
      ),
    );
  }
}

/// E15-US3-UI2: Delivery earnings detail
/// Must show: One delivery; pooled orders shown separately (AC2)
class DeliveryEarningsDetailScreen extends StatelessWidget {
  const DeliveryEarningsDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E15-US3-UI2',
      title: 'Delivery earnings detail',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const KhaanaInlineBanner(
            kind: CapacityKind.info,
            text: 'Pooled trip legs are itemized separately so you can verify distance, waiting fee, and surcharges for each order (E15-US3 AC2).',
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Pooled Leg 1 · Order #KG-1051 (Lazeez Cloud Kitchen)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                  SizedBox(height: 8),
                  PriceLines(
                    lines: [
                      ('Base pickup & drop-off fee', 80),
                      ('Routed road distance (2.4 km × Rs 15/km)', 36),
                      ('Excess waiting fee (4 min past free window)', 20),
                      ('Rain weather surcharge', 20),
                    ],
                    total: 156,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Pooled Leg 2 · Order #KG-1052 (Tandoori Express)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                  SizedBox(height: 8),
                  PriceLines(
                    lines: [
                      ('Pooled second-order base fee', 40),
                      ('Corridor road distance (1.9 km × Rs 15/km)', 29),
                      ('Excess waiting fee (0 min)', 0),
                      ('Rain weather surcharge', 20),
                    ],
                    total: 89,
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

/// E1-US2-UI10: Delivery history
/// Must show: Past deliveries, newest first
class RiderDeliveryHistoryScreen extends StatelessWidget {
  const RiderDeliveryHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E1-US2-UI10',
      title: 'Delivery history (Newest first)',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final d in const [
            ('Today · 7:32 PM', '#KG-1042 · BakeCharm -> F-11 Markaz', 'Express · 3.2 km', 'Rs 198'),
            ('Today · 6:48 PM', '#KG-1051 & #KG-1052 · F-10 -> F-11', 'Pooled (2 orders) · 4.3 km', 'Rs 245'),
            ('Yesterday · 9:15 PM', '#KG-1038 · Lazeez Cloud Kitchen -> G-9', 'Express · 3.6 km', 'Rs 174'),
          ])
            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                title: Text(d.$2, style: const TextStyle(fontWeight: FontWeight.w800)),
                subtitle: Text('${d.$1} · ${d.$3}'),
                trailing: Text(d.$4, style: const TextStyle(fontWeight: FontWeight.w800, color: KhaanaColors.availableDark)),
                onTap: () => Navigator.pushNamed(context, '/earnings-detail'),
              ),
            ),
        ],
      ),
    );
  }
}

/// E18-US2-UI1: My ratings
/// Must show: Average and recent comments (AC1)
class RiderRatingsScreen extends StatelessWidget {
  const RiderRatingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E18-US2-UI1',
      title: 'My ratings',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: const [
                  Icon(Icons.star_rounded, size: 48, color: Color(0xFFEAB308)),
                  SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('4.8 ★ Average Rider Score', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                        Text('Based on 142 verified deliveries (isolated from kitchen food ratings · E18-US2 AC1)'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          for (final c in const [
            ('5 ★ · Today', '"Handled the fragile 2-lb chocolate cake carefully in the rain!"'),
            ('5 ★ · Yesterday', '"Polite at the gate and verified PIN quickly."'),
            ('4 ★ · 2 days ago', '"Arrived on time within the revised weather window."'),
          ])
            Card(
              child: ListTile(
                title: Text(c.$1, style: const TextStyle(fontWeight: FontWeight.w800)),
                subtitle: Text(c.$2),
              ),
            ),
        ],
      ),
    );
  }
}

/// E1-US2-UI11: Rider profile
/// Must show: Details, vehicle type, document status
class RiderProfileScreen extends StatelessWidget {
  const RiderProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final session = RiderScope.of(context);
    return KhaanaPage(
      uiId: 'E1-US2-UI11',
      title: 'Rider profile',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Bilal Ahmed', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 4),
                  const Text('Phone: 0312-9876543 · CNIC: 37405-8829104-1'),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Vehicle Type: ${session.vehicle}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                      const CapacityBadge(kind: CapacityKind.available, label: 'Documents Approved'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text('• Driving Licence: Verified (Expires 11/2028)'),
                  const Text('• CNIC Front & Back: Verified'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              KhaanaSecondaryButton(
                label: 'Navigation preference (E13-US5-UI1)',
                icon: Icons.navigation_outlined,
                onPressed: () => Navigator.pushNamed(context, '/navigation-pref'),
              ),
              KhaanaSecondaryButton(
                label: 'Display & alerts (E16-US2-UI1)',
                icon: Icons.contrast_rounded,
                onPressed: () => Navigator.pushNamed(context, '/display-alerts'),
              ),
              KhaanaSecondaryButton(
                label: 'Tariff settings (E15-US1-UI1)',
                icon: Icons.payments_outlined,
                onPressed: () => Navigator.pushNamed(context, '/tariff'),
              ),
              KhaanaSecondaryButton(
                label: 'Audio prompt settings (E16-US3-UI1)',
                icon: Icons.volume_up_outlined,
                onPressed: () => Navigator.pushNamed(context, '/audio-settings'),
              ),
              KhaanaSecondaryButton(
                label: 'Unanswered check-in warning (E16-US1-UI2)',
                icon: Icons.warning_amber_rounded,
                onPressed: () => showUnansweredCheckInWarningDialog(context),
              ),
              KhaanaSecondaryButton(
                label: 'Sign out confirmation (E1-US2-UI12)',
                icon: Icons.logout_rounded,
                onPressed: () => showRiderSignOutConfirmationDialog(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// E13-US5-UI1: Navigation preference
/// Must show: Open external maps, or use in-app map (AC1, AC2).
/// Include location-permission withdrawal recovery prompt; invalid route coordinates are blocked with a clear error.
class NavigationPreferenceScreen extends StatefulWidget {
  const NavigationPreferenceScreen({super.key});

  @override
  State<NavigationPreferenceScreen> createState() => _NavigationPreferenceScreenState();
}

class _NavigationPreferenceScreenState extends State<NavigationPreferenceScreen> {
  String _mode = 'in_app';
  bool _permissionWithdrawn = false;
  bool _invalidCoordinates = false;

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E13-US5-UI1',
      title: 'Navigation preference',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Choose Map Navigation Mode (E13-US5 AC1, AC2)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 10),
                  RadioGroup<String>(
                    groupValue: _mode,
                    onChanged: (v) {
                      if (v != null) setState(() => _mode = v);
                    },
                    child: const Column(
                      children: [
                        RadioListTile<String>(
                          value: 'in_app',
                          title: Text('Use built-in KhaanaGo high-contrast map'),
                          subtitle: Text('Keeps pickup/drop-off cards and voice prompts on screen'),
                        ),
                        RadioListTile<String>(
                          value: 'external',
                          title: Text('Launch external Google Maps / Apple Maps'),
                          subtitle: Text('Hands off turn-by-turn route coordinates to external app'),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 24),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Simulate GPS permission withdrawn mid-trip (TC3)'),
                    value: _permissionWithdrawn,
                    onChanged: (v) => setState(() => _permissionWithdrawn = v),
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Simulate invalid / missing route coordinates (TC4)'),
                    value: _invalidCoordinates,
                    onChanged: (v) => setState(() => _invalidCoordinates = v),
                  ),
                  if (_permissionWithdrawn) ...[
                    const SizedBox(height: 10),
                    const KhaanaInlineBanner(
                      kind: CapacityKind.limited,
                      text:
                          'Location permission was withdrawn! Live route tracking is paused. Tap "Restore GPS Permission" in system settings to resume navigation (E13-US5-TC3).',
                    ),
                  ],
                  if (_invalidCoordinates) ...[
                    const SizedBox(height: 10),
                    const KhaanaInlineBanner(
                      kind: CapacityKind.full,
                      text:
                          'Navigation blocked: Destination coordinates (NaN, 0.000) are invalid or out of bounds. External map handoff was prevented; request a corrected pin from the customer (E13-US5-TC4).',
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

/// E16-US2-UI1: Display and alerts
/// Must show: High-contrast mode, audio mute with vibration fallback (E16-US1 AC4)
class DisplayAndAlertsScreen extends StatefulWidget {
  const DisplayAndAlertsScreen({super.key});

  @override
  State<DisplayAndAlertsScreen> createState() => _DisplayAndAlertsScreenState();
}

class _DisplayAndAlertsScreenState extends State<DisplayAndAlertsScreen> {
  bool _highContrast = true;
  bool _audioMuted = true;

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E16-US2-UI1',
      title: 'Display & alerts',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Glare-resistant High-Contrast Sunlight Mode', style: TextStyle(fontWeight: FontWeight.w800)),
                    subtitle: const Text('64dp minimum touch targets, bold typography, maximum contrast'),
                    value: _highContrast,
                    onChanged: (v) => setState(() => _highContrast = v),
                  ),
                  const Divider(),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Mute spoken audio prompts (Vibration + Visual Banner Fallback)'),
                    subtitle: const Text('When audio is muted, safety check-ins and ready alerts trigger haptic vibration + persistent visual banner (E16-US1 AC4)'),
                    value: _audioMuted,
                    onChanged: (v) => setState(() => _audioMuted = v),
                  ),
                  if (_audioMuted) ...[
                    const SizedBox(height: 10),
                    const KhaanaInlineBanner(
                      kind: CapacityKind.info,
                      icon: Icons.vibration_rounded,
                      text: 'Audio is muted: Haptic vibration pulse + high-contrast visual banner fallback is ACTIVE.',
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

/// E15-US1-UI1: Tariff settings
/// Must show: Base fare and per-km rate, negative-rate validation.
/// Show routed road distance (not straight-line); use a defined fallback flagged for review if the maps service fails.
class RiderTariffSettingsScreen extends StatefulWidget {
  const RiderTariffSettingsScreen({super.key});

  @override
  State<RiderTariffSettingsScreen> createState() => _RiderTariffSettingsScreenState();
}

class _RiderTariffSettingsScreenState extends State<RiderTariffSettingsScreen> {
  final _base = TextEditingController(text: '80');
  final _perKm = TextEditingController(text: '15');
  String? _error;
  bool _mapsServiceDown = false;

  @override
  void dispose() {
    _base.dispose();
    _perKm.dispose();
    super.dispose();
  }

  void _validate() {
    final b = double.tryParse(_base.text.trim());
    final k = double.tryParse(_perKm.text.trim());
    if (b == null || k == null || b < 0 || k < 0) {
      setState(() => _error = 'Negative or non-numeric tariff rates are rejected (E15-US1-TC3). Enter values ≥ 0.');
      return;
    }
    setState(() => _error = null);
  }

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E15-US1-UI1',
      title: 'Tariff settings & road-distance calculation',
      footer: KhaanaPrimaryButton(
        label: 'Validate & save tariff',
        icon: Icons.save_outlined,
        onPressed: _validate,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ActionChip(
                label: const Text('Test negative per-km rate −10 (TC3)'),
                onPressed: () {
                  _perKm.text = '-10';
                  _validate();
                },
              ),
              FilterChip(
                label: const Text('Simulate maps routing service failure (TC4)'),
                selected: _mapsServiceDown,
                onSelected: (v) => setState(() => _mapsServiceDown = v),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (_error != null) ...[
            KhaanaInlineBanner(text: _error!),
            const SizedBox(height: 12),
          ],
          if (_mapsServiceDown) ...[
            const KhaanaInlineBanner(
              kind: CapacityKind.limited,
              text:
                  'Maps routing service unavailable (E15-US1-TC4): Using defined zone-corridor fallback distance (3.2 km) and flagging delivery #KG-1042 for tariff audit review.',
            ),
            const SizedBox(height: 12),
          ],
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Active Delivery Tariff Breakdown', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _base,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Base Fare (Rs) *'),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _perKm,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Per-Kilometre Road Rate (Rs/km) *'),
                  ),
                  const Divider(height: 24),
                  const Text('Distance Method Comparison (BakeCharm -> F-11 Markaz):', style: TextStyle(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 6),
                  const Text('• Straight-line crow-flies distance (NOT used): 2.1 km'),
                  const Text(
                    '• Routed road distance (USED for pay & fee · E15-US1 AC2): 3.2 km (Rs 48)',
                    style: TextStyle(fontWeight: FontWeight.w800, color: KhaanaColors.availableDark),
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

