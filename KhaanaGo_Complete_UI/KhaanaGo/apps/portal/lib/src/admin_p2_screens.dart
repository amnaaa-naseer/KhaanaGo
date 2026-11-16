import 'package:flutter/material.dart';
import 'package:khaana_design/khaana_design.dart';

import 'admin_p3_screens.dart';

/// E20-US1-UI5: Verification queue
/// Must show: Vendors, riders and fleet partners awaiting review, oldest first
class VerificationQueueScreen extends StatelessWidget {
  const VerificationQueueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E20-US1-UI5',
      title: 'Verification queue (Oldest first)',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final item in const [
            ('Vendor · BakeCharm Artisan Kitchen', 'Submitted 2h ago (Oldest) · Food Authority Licence & IBAN', '/admin/verify-vendor'),
            ('Rider · Bilal Ahmed (Motorbike)', 'Submitted 1h 20m ago · Driving Licence & CNIC', '/admin/verify-rider'),
            ('Fleet Partner · Bykea Express API', 'Submitted 45m ago · Webhook & IVR Endpoint Verification', '/admin/fleets'),
          ])
            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                title: Text(item.$1, style: const TextStyle(fontWeight: FontWeight.w800)),
                subtitle: Text(item.$2),
                trailing: KhaanaSecondaryButton(
                  label: 'Review',
                  onPressed: () => Navigator.pushNamed(context, item.$3),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// E20-US1-UI6: Vendor application review
/// Must show: Business details and documents; approve, reject with reason, or request more info (AC1)
class VendorApplicationReviewScreen extends StatefulWidget {
  const VendorApplicationReviewScreen({super.key});

  @override
  State<VendorApplicationReviewScreen> createState() => _VendorApplicationReviewScreenState();
}

class _VendorApplicationReviewScreenState extends State<VendorApplicationReviewScreen> {
  String _decision = 'Pending review';

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E20-US1-UI6',
      title: 'Vendor application review',
      footer: Wrap(
        spacing: 10,
        children: [
          KhaanaPrimaryButton(
            label: 'Approve vendor (AC1)',
            icon: Icons.check_circle_outline,
            onPressed: () => setState(() => _decision = 'Approved — Vendor store unlocked'),
          ),
          KhaanaSecondaryButton(
            label: 'Reject / Request more info (E20-US1-UI8)',
            icon: Icons.gavel_rounded,
            onPressed: () async {
              final reason = await showAdminDecisionDialog(context, applicantName: 'BakeCharm Artisan Kitchen');
              if (reason != null && reason.isNotEmpty) {
                setState(() => _decision = 'Rejected / Info Requested: $reason');
              }
            },
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KhaanaInlineBanner(
            kind: _decision.startsWith('Approved') ? CapacityKind.available : CapacityKind.info,
            text: 'Current Decision State: $_decision',
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('BakeCharm Artisan Kitchen · Shop 14, F-11 Markaz', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                  SizedBox(height: 8),
                  Text('• Business Type: Home / Cloud Bakery · Contact: 0300-5551234'),
                  Text('• Document 1: Food Authority Licence (ICT-FA-2026.pdf · Verified)'),
                  Text('• Document 2: Owner CNIC Scan (37405-1122334-2 · Verified)'),
                  Text('• Settlement IBAN: PK36MEZN0001080104928172 (Meezan Bank)'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// E20-US1-UI7: Rider verification review
/// Must show: Documents, vehicle type; approve or reject (AC3, AC4)
class RiderVerificationReviewScreen extends StatefulWidget {
  const RiderVerificationReviewScreen({super.key});

  @override
  State<RiderVerificationReviewScreen> createState() => _RiderVerificationReviewScreenState();
}

class _RiderVerificationReviewScreenState extends State<RiderVerificationReviewScreen> {
  String _decision = 'Pending review (Cannot go online until approved · AC3)';

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E20-US1-UI7',
      title: 'Rider verification review',
      footer: Wrap(
        spacing: 10,
        children: [
          KhaanaPrimaryButton(
            label: 'Approve rider (Unlocks Go Online · AC3)',
            icon: Icons.verified_user_outlined,
            onPressed: () => setState(() => _decision = 'Approved — Rider can now go online'),
          ),
          KhaanaSecondaryButton(
            label: 'Reject with reason (E20-US1-UI8 · AC4)',
            onPressed: () async {
              final reason = await showAdminDecisionDialog(context, applicantName: 'Bilal Ahmed (Rider)');
              if (reason != null && reason.isNotEmpty) {
                setState(() => _decision = 'Rejected: $reason');
              }
            },
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KhaanaInlineBanner(
            kind: _decision.startsWith('Approved') ? CapacityKind.available : CapacityKind.limited,
            text: _decision,
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Bilal Ahmed · 0312-9876543', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                  SizedBox(height: 8),
                  Text('• Vehicle Type: Motorbike (Honda CD-70 · Reg #ICT-4821)'),
                  Text('• Phone OS: Android 14 (Supports hands-free voice check-ins)'),
                  Text('• Driving Licence Scan: driving_licence_bilal.jpg'),
                  Text('• CNIC Front & Back: cnic_bilal_37405.jpg'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// E20-US1-UI8: Decision dialog (Overlay)
/// Must show: Required reason on rejection; message sent to applicant
Future<String?> showAdminDecisionDialog(BuildContext context, {required String applicantName}) {
  return showDialog<String>(
    context: context,
    builder: (context) => _AdminDecisionDialog(applicantName: applicantName),
  );
}

class _AdminDecisionDialog extends StatefulWidget {
  const _AdminDecisionDialog({required this.applicantName});
  final String applicantName;

  @override
  State<_AdminDecisionDialog> createState() => _AdminDecisionDialogState();
}

class _AdminDecisionDialogState extends State<_AdminDecisionDialog> {
  final _reason = TextEditingController(text: 'Driving licence expiry date is cropped out; please upload a full scan.');
  String? _error;

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
            child: const Text('E20-US1-UI8', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: KhaanaColors.onOrangeTint)),
          ),
          const SizedBox(width: 8),
          const Expanded(child: Text('Rejection / Resubmission Decision')),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Applicant: ${widget.applicantName}'),
          const SizedBox(height: 10),
          TextField(
            controller: _reason,
            maxLines: 3,
            decoration: const InputDecoration(labelText: 'Mandatory Reason Sent to Applicant *'),
          ),
          if (_error != null) ...[
            const SizedBox(height: 8),
            KhaanaInlineBanner(text: _error!),
          ],
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        FilledButton(
          onPressed: () {
            if (_reason.text.trim().isEmpty) {
              setState(() => _error = 'A rejection reason is required before notifying the applicant.');
              return;
            }
            Navigator.pop(context, _reason.text.trim());
          },
          child: const Text('Send decision to applicant'),
        ),
      ],
    );
  }
}

/// E14-US4-UI1: Partner fleets
/// Must show: Partners, API connection status, active deliveries
class PartnerFleetsScreen extends StatelessWidget {
  const PartnerFleetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E14-US4-UI1',
      title: 'External partner fleets',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final p in const [
            ('Bykea Express Logistics API', 'Connected · Webhook latency 140 ms · 4 active fallback deliveries', CapacityKind.available),
            ('TCS Urban Couriers', 'Connected · IVR callback enabled · 1 active delivery', CapacityKind.available),
          ])
            Card(
              child: ListTile(
                title: Text(p.$1, style: const TextStyle(fontWeight: FontWeight.w800)),
                subtitle: Text(p.$2),
                trailing: CapacityBadge(kind: p.$3, label: 'Online'),
                onTap: () => Navigator.pushNamed(context, '/admin/fleet-detail'),
              ),
            ),
        ],
      ),
    );
  }
}

/// E14-US4-UI2: Partner details and status log
/// Must show: Acknowledgements, status updates and IVR confirmations per delivery (AC1, AC2)
class PartnerDetailsStatusLogScreen extends StatelessWidget {
  const PartnerDetailsStatusLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E14-US4-UI2',
      title: 'Partner fleet details & IVR status log',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const KhaanaInlineBanner(
            kind: CapacityKind.info,
            text:
                'External Partner Integration (E14-US4 AC1, AC2): Logs dispatch webhook acknowledgements, live status transitions, and automated IVR keypad/voice confirmations.',
          ),
          const SizedBox(height: 12),
          for (final log in const [
            ('18:41:02 · Webhook ACK', 'Order #KG-1048 accepted by Bykea Partner Rider #BYK-902 (AC1)'),
            ('18:49:15 · Status Update', 'Partner rider arrived at Lazeez Cloud Kitchen & confirmed parcel pickup'),
            ('19:04:40 · IVR Confirmation (AC2)', 'Automated IVR call verified customer delivery PIN 619044 at drop-off'),
          ])
            Card(
              child: ListTile(
                leading: const Icon(Icons.hub_outlined, color: KhaanaColors.orangeText),
                title: Text(log.$1, style: const TextStyle(fontWeight: FontWeight.w800)),
                subtitle: Text(log.$2),
              ),
            ),
        ],
      ),
    );
  }
}

/// E20-US2-UI1: Commission settings
/// Must show: Global and per-vendor rate within 8–12% range; out-of-range error (AC1, AC2).
/// Include effective date/time and preserve the previous rate on existing orders.
class CommissionSettingsScreen extends StatefulWidget {
  const CommissionSettingsScreen({super.key});

  @override
  State<CommissionSettingsScreen> createState() => _CommissionSettingsScreenState();
}

class _CommissionSettingsScreenState extends State<CommissionSettingsScreen> {
  final _globalRate = TextEditingController(text: '10.0');
  final _vendorOverride = TextEditingController(text: '9.5');
  final _effectiveDate = TextEditingController(text: '2026-11-05 00:00 PKT');
  String? _error;
  bool _saved = false;

  @override
  void dispose() {
    _globalRate.dispose();
    _vendorOverride.dispose();
    _effectiveDate.dispose();
    super.dispose();
  }

  void _validateAndSave() {
    final g = double.tryParse(_globalRate.text.trim());
    final v = double.tryParse(_vendorOverride.text.trim());
    if (g == null || g < 8.0 || g > 12.0 || v == null || v < 8.0 || v > 12.0) {
      setState(() {
        _saved = false;
        _error =
            'Out-of-range error (E20-US2 AC1 / TC3–TC6): Platform commission rate must stay strictly within the 8.0% – 12.0% band (7.9% and 12.1% are rejected).';
      });
      return;
    }
    setState(() {
      _error = null;
      _saved = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E20-US2-UI1',
      title: 'Commission settings (8–12% band)',
      footer: KhaanaPrimaryButton(
        label: 'Save commission rate',
        icon: Icons.save_outlined,
        onPressed: _validateAndSave,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ActionChip(
                label: const Text('Test 7.9% below minimum (TC3)'),
                onPressed: () {
                  _globalRate.text = '7.9';
                  _validateAndSave();
                },
              ),
              ActionChip(
                label: const Text('Test 12.1% above maximum (TC6)'),
                onPressed: () {
                  _globalRate.text = '12.1';
                  _validateAndSave();
                },
              ),
              ActionChip(
                label: const Text('Test valid 8.0% boundary (TC4)'),
                onPressed: () {
                  _globalRate.text = '8.0';
                  _validateAndSave();
                },
              ),
              ActionChip(
                label: const Text('Test valid 12.0% boundary (TC5)'),
                onPressed: () {
                  _globalRate.text = '12.0';
                  _validateAndSave();
                },
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (_error != null) ...[
            KhaanaInlineBanner(text: _error!),
            const SizedBox(height: 12),
          ],
          if (_saved) ...[
            KhaanaInlineBanner(
              kind: CapacityKind.available,
              text:
                  'Saved! Global rate ${_globalRate.text}% and BakeCharm rate ${_vendorOverride.text}% take effect at ${_effectiveDate.text}. Existing orders (#KG-1042) preserve their snapshot rate of 10.0% (E20-US2 AC2).',
            ),
            const SizedBox(height: 12),
          ],
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _globalRate,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Global Platform Commission Rate (8.0% – 12.0%) *'),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _vendorOverride,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Per-Vendor Rate: BakeCharm (8.0% – 12.0%) *'),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _effectiveDate,
                    decoration: const InputDecoration(labelText: 'Effective Date & Time (Existing orders keep old rate · AC2) *'),
                  ),
                  const SizedBox(height: 12),
                  KhaanaSecondaryButton(
                    label: 'Confirm commission change dialog (E20-US2-UI2)',
                    icon: Icons.verified_outlined,
                    onPressed: () async {
                      final ok = await showConfirmCommissionChangeDialog(
                        context,
                        oldRate: '10.0%',
                        newRate: '${_globalRate.text}%',
                        effectiveDate: _effectiveDate.text,
                      );
                      if (ok == true) {
                        _validateAndSave();
                      }
                    },
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

/// E20-US3-UI1: Users
/// Must show: Search across customers, vendors, riders and staff
class AdminUsersScreen extends StatefulWidget {
  const AdminUsersScreen({super.key});

  @override
  State<AdminUsersScreen> createState() => _AdminUsersScreenState();
}

class _AdminUsersScreenState extends State<AdminUsersScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    const users = [
      ('Ayesha Khan', 'Customer · 0300-1234567', 'Active'),
      ('BakeCharm (Hina Tariq)', 'Vendor Owner · owner@bakecharm.pk', 'Active'),
      ('Bilal Ahmed', 'Rider · 0312-9876543', 'Active'),
      ('Usman Ali (STAFF-04)', 'Kitchen Staff · BakeCharm', 'Active'),
    ];
    final filtered = users.where((u) => u.$1.toLowerCase().contains(_query.toLowerCase()) || u.$2.toLowerCase().contains(_query.toLowerCase())).toList();
    return KhaanaPage(
      uiId: 'E20-US3-UI1',
      title: 'Platform users directory',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: const InputDecoration(
              hintText: 'Search customers, vendors, riders or kitchen staff…',
              prefixIcon: Icon(Icons.search_rounded),
            ),
            onChanged: (v) => setState(() => _query = v),
          ),
          const SizedBox(height: 12),
          for (final u in filtered)
            Card(
              child: ListTile(
                title: Text(u.$1, style: const TextStyle(fontWeight: FontWeight.w800)),
                subtitle: Text(u.$2),
                trailing: const CapacityBadge(kind: CapacityKind.available, label: 'Active'),
                onTap: () => Navigator.pushNamed(context, '/admin/user-detail', arguments: u.$1),
              ),
            ),
        ],
      ),
    );
  }
}

/// E20-US3-UI2: User detail
/// Must show: Profile, status, history, Suspend or Reactivate (AC1, AC2)
class AdminUserDetailScreen extends StatefulWidget {
  const AdminUserDetailScreen({super.key, this.userName});
  final String? userName;

  @override
  State<AdminUserDetailScreen> createState() => _AdminUserDetailScreenState();
}

class _AdminUserDetailScreenState extends State<AdminUserDetailScreen> {
  bool _suspended = false;

  @override
  Widget build(BuildContext context) {
    final name = widget.userName ?? 'Bilal Ahmed (Rider)';
    return KhaanaPage(
      uiId: 'E20-US3-UI2',
      title: 'User detail & account control',
      footer: _suspended
          ? KhaanaPrimaryButton(
              label: 'Reactivate account (AC2)',
              icon: Icons.lock_open_rounded,
              onPressed: () => setState(() => _suspended = false),
            )
          : KhaanaSecondaryButton(
              label: 'Suspend user account (E20-US3-UI3)',
              icon: Icons.block_rounded,
              onPressed: () async {
                final ok = await showSuspendUserDialog(context, userName: name);
                if (ok ?? false) setState(() => _suspended = true);
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                      CapacityBadge(
                        kind: _suspended ? CapacityKind.full : CapacityKind.available,
                        label: _suspended ? 'Suspended (Sessions Terminated)' : 'Active',
                      ),
                    ],
                  ),
                  const Divider(height: 24),
                  const Text('Account History & Activity:', style: TextStyle(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 6),
                  const Text('• 142 completed orders / deliveries · Average rating 4.8 ★'),
                  const Text('• Last active session: Today 6:50 PM (Islamabad F-11)'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// E20-US3-UI3: Suspend user (Overlay)
/// Must show: Consequence — sessions end — and confirm
Future<bool?> showSuspendUserDialog(BuildContext context, {required String userName}) {
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: KhaanaColors.orangeTint, borderRadius: BorderRadius.circular(6)),
            child: const Text('E20-US3-UI3', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: KhaanaColors.onOrangeTint)),
          ),
          const SizedBox(width: 8),
          const Expanded(child: Text('Suspend user account')),
        ],
      ),
      content: Text(
        'Suspending $userName will immediately terminate all active web/mobile sessions and block new sign-ins until reactivated (E20-US3 AC1). Historical order and audit records remain intact.',
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Confirm suspension'),
        ),
      ],
    ),
  );
}

/// E20-US3-UI4: Complaints queue
/// Must show: Open tickets by age and parties
class ComplaintsQueueScreen extends StatelessWidget {
  const ComplaintsQueueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E20-US3-UI4',
      title: 'Complaints queue (By ticket age)',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final t in const [
            ('#CMP-204 · Age: 35m · Order #KG-1042', 'Parties: Ayesha Khan (Customer) vs BakeCharm & Rider Bilal Ahmed', 'Open · High Priority'),
            ('#CMP-199 · Age: 3h 10m · Order #KG-1033', 'Parties: BakeCharm (Vendor) vs Rider Kamran Shah (COD shortfall)', 'Under Investigation'),
          ])
            Card(
              child: ListTile(
                title: Text(t.$1, style: const TextStyle(fontWeight: FontWeight.w800)),
                subtitle: Text(t.$2),
                trailing: CapacityBadge(kind: CapacityKind.limited, label: t.$3),
                onTap: () => Navigator.pushNamed(context, '/admin/complaint-detail'),
              ),
            ),
        ],
      ),
    );
  }
}

/// E20-US3-UI5: Complaint detail
/// Must show: Order, timeline and parties involved (AC3)
class ComplaintDetailScreen extends StatefulWidget {
  const ComplaintDetailScreen({super.key});

  @override
  State<ComplaintDetailScreen> createState() => _ComplaintDetailScreenState();
}

class _ComplaintDetailScreenState extends State<ComplaintDetailScreen> {
  String? _resolution;

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E20-US3-UI5',
      title: 'Complaint detail (#CMP-204)',
      footer: KhaanaPrimaryButton(
        label: 'Resolve complaint & notify all parties (E20-US3-UI6)',
        icon: Icons.check_circle_outline,
        onPressed: () async {
          final res = await showResolveComplaintDialog(context);
          if (res != null && res.isNotEmpty) {
            setState(() => _resolution = res);
          }
        },
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_resolution != null) ...[
            KhaanaInlineBanner(
              kind: CapacityKind.available,
              text: 'Case #CMP-204 Closed · All parties notified (E20-US3 AC4): "$_resolution"',
            ),
            const SizedBox(height: 12),
          ],
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Ticket #CMP-204 · Linked Order #KG-1042', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                  SizedBox(height: 8),
                  Text('• Customer: Ayesha Khan (0300-1234567)'),
                  Text('• Vendor: BakeCharm Artisan Kitchen (F-11 Markaz)'),
                  Text('• Rider: Bilal Ahmed (Motorbike)'),
                  Divider(height: 24),
                  Text('Event Timeline (E20-US3 AC3):', style: TextStyle(fontWeight: FontWeight.w800)),
                  SizedBox(height: 6),
                  Text('• 6:42 PM — Order confirmed for 6:30–7:10 PM slot'),
                  Text('• 7:05 PM — Rain buffer (+15 min) applied; customer notified'),
                  Text('• 7:22 PM — Customer attached photo (damaged_box_photo.jpg) reporting corner dent'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// E20-US3-UI6: Resolve complaint (Overlay)
/// Must show: Outcome text; all parties notified, case closed (AC4)
Future<String?> showResolveComplaintDialog(BuildContext context) {
  final ctrl = TextEditingController(
    text: 'Partial credit of Rs 400 issued to customer wallet; packaging guidance shared with BakeCharm. Case closed.',
  );
  return showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: KhaanaColors.orangeTint, borderRadius: BorderRadius.circular(6)),
            child: const Text('E20-US3-UI6', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: KhaanaColors.onOrangeTint)),
          ),
          const SizedBox(width: 8),
          const Expanded(child: Text('Resolve complaint (#CMP-204)')),
        ],
      ),
      content: TextField(
        controller: ctrl,
        maxLines: 3,
        decoration: const InputDecoration(
          labelText: 'Resolution Outcome (Sent to Customer, Vendor & Rider · AC4) *',
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        FilledButton(
          onPressed: () => Navigator.pop(context, ctrl.text.trim()),
          child: const Text('Notify all parties & close case'),
        ),
      ],
    ),
  );
}

/// E20-US4-UI2: Reports
/// Must show: Orders, revenue, commission, slot utilisation for a date range (AC1).
/// Include report export with private-field exclusion, plus valid, empty and invalid date-range states.
class AdminReportsScreen extends StatefulWidget {
  const AdminReportsScreen({super.key});

  @override
  State<AdminReportsScreen> createState() => _AdminReportsScreenState();
}

class _AdminReportsScreenState extends State<AdminReportsScreen> {
  String _rangeState = 'valid'; // 'valid', 'empty', 'invalid'
  bool _exported = false;

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E20-US4-UI2',
      title: 'Platform analytics & export reports',
      footer: KhaanaPrimaryButton(
        label: 'Export CSV Report (Excludes private recipe & card fields · TC4)',
        icon: Icons.download_rounded,
        onPressed: _rangeState != 'valid' ? null : () => setState(() => _exported = true),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ChoiceChip(
                label: const Text('Valid range: 01–04 Nov 2026 (TC1)'),
                selected: _rangeState == 'valid',
                onSelected: (_) => setState(() => _rangeState = 'valid'),
              ),
              ChoiceChip(
                label: const Text('Empty period: Jan 2024 (0 orders · TC2)'),
                selected: _rangeState == 'empty',
                onSelected: (_) => setState(() {
                  _rangeState = 'empty';
                  _exported = false;
                }),
              ),
              ChoiceChip(
                label: const Text('Invalid range: End before Start (TC3)'),
                selected: _rangeState == 'invalid',
                onSelected: (_) => setState(() {
                  _rangeState = 'invalid';
                  _exported = false;
                }),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (_rangeState == 'invalid')
            const KhaanaInlineBanner(
              kind: CapacityKind.full,
              text: 'Invalid Date Range (E20-US4-TC3): End date (2026-11-01) is earlier than Start date (2026-11-04). Correct the range to run the report.',
            )
          else if (_rangeState == 'empty')
            const KhaanaEmptyState(
              title: '0 orders in selected date range (E20-US4-TC2)',
              message: 'Gross revenue: Rs 0 · Commission: Rs 0 · Slot utilisation: 0%. No calculation errors.',
            )
          else ...[
            if (_exported) ...[
              const KhaanaInlineBanner(
                kind: CapacityKind.available,
                text:
                    'Exported khaanago_report_nov2026.csv (E20-US4-TC4): Private vendor recipe quantities, staff password hashes, and customer payment tokens were strictly excluded.',
              ),
              const SizedBox(height: 12),
            ],
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Aggregate Platform Metrics (01 Nov – 04 Nov 2026)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                    Divider(height: 24),
                    Text('• Completed Orders: 412 orders across 14 active kitchens'),
                    Text('• Gross Platform Merchandise Value (GMV): Rs 842,500'),
                    Text('• Platform Commission Earned (10% avg): Rs 84,250'),
                    Text('• Average Hourly Slot Utilisation: 68.4%'),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// E16-US1-UI3: Safety escalations
/// Must show: Missed rider check-ins past the grace period, with rider and order (AC6)
class SafetyEscalationsScreen extends StatelessWidget {
  const SafetyEscalationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E16-US1-UI3',
      title: 'Rider safety escalations',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const KhaanaInlineBanner(
            kind: CapacityKind.full,
            icon: Icons.health_and_safety_outlined,
            text:
                'Safety Escalation Rule (E16-US1 AC6): When a rider misses both the initial voice check-in and the 1-time repeat prompt past the grace period, an alert is raised here with last known GPS coordinates.',
          ),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: const Icon(Icons.warning_amber_rounded, color: KhaanaColors.full, size: 36),
              title: const Text('Rider: Kamran Shah (0315-4433221) · Order #KG-1039', style: TextStyle(fontWeight: FontWeight.w800)),
              subtitle: const Text('Missed 2 voice check-in prompts + 5-min grace period · Last GPS: Street 10, G-9/2'),
              trailing: const CapacityBadge(kind: CapacityKind.full, label: 'Unanswered Check-in'),
            ),
          ),
        ],
      ),
    );
  }
}

/// E21-US3-UI1: Audit investigation
/// Must show: Cross-vendor log for a dispute, recipe quantities hidden (AC1)
class AuditInvestigationScreen extends StatelessWidget {
  const AuditInvestigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E21-US3-UI1',
      title: 'Cross-vendor audit investigation (Dispute #CMP-204)',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const KhaanaInlineBanner(
            kind: CapacityKind.info,
            icon: Icons.security_rounded,
            text:
                'Proprietary Recipe Privacy Enforced (E21-US3 AC1): Administrators can inspect operational timestamps and named actors for dispute resolution, but proprietary recipe ingredient quantities remain [REDACTED].',
          ),
          const SizedBox(height: 12),
          for (final entry in const [
            ('18:42:10 · BakeCharm (STAFF-04 Usman Ali)', 'Accepted Order #KG-1042 (Chocolate Cake 1 lb · No nuts)'),
            ('18:43:00 · BakeCharm Recipe Snapshot', 'Recipe linked to Order #KG-1042 · Ingredient quantities: [HIDDEN — PROPRIETARY VENDOR SECRET · E21-US3 AC1]'),
            ('19:02:14 · BakeCharm (STAFF-04 Usman Ali)', 'Marked Order #KG-1042 as 80% Prepared -> Dispatched Rider Bilal Ahmed'),
          ])
            Card(
              child: ListTile(
                title: Text(entry.$1, style: const TextStyle(fontWeight: FontWeight.w800)),
                subtitle: Text(entry.$2),
              ),
            ),
        ],
      ),
    );
  }
}

