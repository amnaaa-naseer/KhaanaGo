import 'package:flutter/material.dart';
import 'package:khaana_design/khaana_design.dart';

import 'scope.dart';
import 'session.dart';

/// E20-US1-UI1: Vendor application 1: business details
/// Must show: Business name, type, address, map pin, contact
class VendorAppStep1Screen extends StatefulWidget {
  const VendorAppStep1Screen({super.key});

  @override
  State<VendorAppStep1Screen> createState() => _VendorAppStep1ScreenState();
}

class _VendorAppStep1ScreenState extends State<VendorAppStep1Screen> {
  final _name = TextEditingController(text: 'BakeCharm Artisan Kitchen');
  String _type = 'Home / Cloud Bakery';
  final _address = TextEditingController(text: 'Shop 14, Street 8, F-11 Markaz, Islamabad');
  final _contact = TextEditingController(text: '0300-5551234 · owner@bakecharm.pk');

  @override
  void dispose() {
    _name.dispose();
    _address.dispose();
    _contact.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E20-US1-UI1',
      title: 'Vendor application 1: Business details',
      footer: KhaanaPrimaryButton(
        label: 'Next: Upload documents (E20-US1-UI2)',
        icon: Icons.arrow_forward_rounded,
        onPressed: () => Navigator.pushNamed(context, '/vendor/apply-2'),
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Step 1 of 3 · Business Identity & Location Pin', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
              const SizedBox(height: 12),
              TextField(controller: _name, decoration: const InputDecoration(labelText: 'Business Name *')),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _type,
                decoration: const InputDecoration(labelText: 'Business Type *'),
                items: const [
                  DropdownMenuItem(value: 'Home / Cloud Bakery', child: Text('Home / Cloud Bakery')),
                  DropdownMenuItem(value: 'Cloud Kitchen', child: Text('Cloud Kitchen')),
                  DropdownMenuItem(value: 'Dine-in & Takeaway Restaurant', child: Text('Dine-in & Takeaway Restaurant')),
                ],
                onChanged: (v) {
                  if (v != null) setState(() => _type = v);
                },
              ),
              const SizedBox(height: 12),
              TextField(controller: _address, decoration: const InputDecoration(labelText: 'Kitchen Address & Map Pin *')),
              const SizedBox(height: 12),
              TextField(controller: _contact, decoration: const InputDecoration(labelText: 'Primary Contact Phone & Email *')),
              const SizedBox(height: 12),
              const SimulatedMap(address: 'Shop 14, F-11 Markaz (Pin Verified: 33.6844° N, 72.9881° E)', restored: true),
            ],
          ),
        ),
      ),
    );
  }
}

/// E20-US1-UI2: Vendor application 2: documents
/// Must show: Food authority licence, CNIC, registration uploads
class VendorAppStep2Screen extends StatefulWidget {
  const VendorAppStep2Screen({super.key});

  @override
  State<VendorAppStep2Screen> createState() => _VendorAppStep2ScreenState();
}

class _VendorAppStep2ScreenState extends State<VendorAppStep2Screen> {
  bool _hasFoodLicence = true;
  bool _hasCnic = true;
  bool _hasRegistration = true;
  String? _error;

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E20-US1-UI2',
      title: 'Vendor application 2: Documents',
      footer: KhaanaPrimaryButton(
        label: 'Next: Bank details (E20-US1-UI3)',
        icon: Icons.arrow_forward_rounded,
        onPressed: () {
          if (!_hasFoodLicence || !_hasCnic || !_hasRegistration) {
            setState(() => _error = 'Upload Food Authority Licence, Owner CNIC, and Business Registration to proceed.');
            return;
          }
          setState(() => _error = null);
          Navigator.pushNamed(context, '/vendor/apply-3');
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
                  const Text('Step 2 of 3 · Regulatory & Identity Documents', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 10),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Food Authority Hygiene Licence (ICT-FA-2026.pdf)'),
                    value: _hasFoodLicence,
                    onChanged: (v) => setState(() => _hasFoodLicence = v),
                  ),
                  const Divider(),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Owner CNIC Scan (Front & Back)'),
                    value: _hasCnic,
                    onChanged: (v) => setState(() => _hasCnic = v),
                  ),
                  const Divider(),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('NTN / Business Registration Certificate'),
                    value: _hasRegistration,
                    onChanged: (v) => setState(() => _hasRegistration = v),
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

/// E20-US1-UI3: Vendor application 3: bank details
/// Must show: Account holder, bank, IBAN, submit
class VendorAppStep3Screen extends StatefulWidget {
  const VendorAppStep3Screen({super.key});

  @override
  State<VendorAppStep3Screen> createState() => _VendorAppStep3ScreenState();
}

class _VendorAppStep3ScreenState extends State<VendorAppStep3Screen> {
  final _holder = TextEditingController(text: 'BakeCharm (Pvt) Ltd');
  final _bank = TextEditingController(text: 'Meezan Bank Limited');
  final _iban = TextEditingController(text: 'PK36MEZN0001080104928172');

  @override
  void dispose() {
    _holder.dispose();
    _bank.dispose();
    _iban.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E20-US1-UI3',
      title: 'Vendor application 3: Bank details',
      footer: KhaanaPrimaryButton(
        label: 'Submit vendor application (E20-US1-UI4)',
        icon: Icons.check_circle_outline,
        onPressed: () => Navigator.pushNamed(context, '/vendor/apply-status'),
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Step 3 of 3 · Settlement Bank Account', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
              const SizedBox(height: 12),
              TextField(controller: _holder, decoration: const InputDecoration(labelText: 'Account Holder Name *')),
              const SizedBox(height: 12),
              TextField(controller: _bank, decoration: const InputDecoration(labelText: 'Bank Name *')),
              const SizedBox(height: 12),
              TextField(controller: _iban, decoration: const InputDecoration(labelText: '24-Character PK IBAN *')),
            ],
          ),
        ),
      ),
    );
  }
}

/// E20-US1-UI4: Application status
/// Must show: Pending, Approved, or Rejected with reason and resubmit (AC2)
class VendorApplicationStatusScreen extends StatefulWidget {
  const VendorApplicationStatusScreen({super.key});

  @override
  State<VendorApplicationStatusScreen> createState() => _VendorApplicationStatusScreenState();
}

class _VendorApplicationStatusScreenState extends State<VendorApplicationStatusScreen> {
  String _status = 'pending'; // 'pending', 'approved', 'rejected'

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E20-US1-UI4',
      title: 'Vendor application status',
      footer: _status == 'rejected'
          ? KhaanaPrimaryButton(
              label: 'Re-upload Food Authority Licence & Resubmit (AC2)',
              icon: Icons.upload_file_rounded,
              onPressed: () => setState(() => _status = 'pending'),
            )
          : KhaanaPrimaryButton(
              label: 'Proceed to Vendor Portal',
              onPressed: () => Navigator.pushReplacementNamed(context, '/vendor/dashboard'),
            ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ChoiceChip(
                label: const Text('Pending review'),
                selected: _status == 'pending',
                onSelected: (_) => setState(() => _status = 'pending'),
              ),
              ChoiceChip(
                label: const Text('Approved (AC1)'),
                selected: _status == 'approved',
                onSelected: (_) => setState(() => _status = 'approved'),
              ),
              ChoiceChip(
                label: const Text('Rejected with reason (AC2)'),
                selected: _status == 'rejected',
                onSelected: (_) => setState(() => _status = 'rejected'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (_status == 'pending')
            const KhaanaInlineBanner(
              kind: CapacityKind.limited,
              text: 'Your vendor application is Pending Verification in the Administrator Queue (E20-US1-UI5). Store remains hidden from customers until approved.',
            )
          else if (_status == 'approved')
            const KhaanaInlineBanner(
              kind: CapacityKind.available,
              text: 'Application Approved! BakeCharm is now active and can configure menus, recipes, and hourly slot capacity.',
            )
          else
            const KhaanaInlineBanner(
              kind: CapacityKind.full,
              text:
                  'Application Rejected / More Info Needed (E20-US1 AC2): "Food Authority Hygiene Licence scan expired last month. Please upload your renewed 2026 certificate and resubmit."',
            ),
        ],
      ),
    );
  }
}

/// E1-US3-UI2: Account locked
/// Must show: Locked after five failed attempts; owner informed (AC2)
class VendorAccountLockedScreen extends StatelessWidget {
  const VendorAccountLockedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E1-US3-UI2',
      title: 'Account locked',
      footer: KhaanaSecondaryButton(
        label: 'Return to Vendor Sign-in',
        onPressed: () => Navigator.pushReplacementNamed(context, '/vendor/sign-in'),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          KhaanaInlineBanner(
            kind: CapacityKind.full,
            icon: Icons.lock_person_outlined,
            text:
                'Account temporarily locked after 5 consecutive failed sign-in attempts (E1-US3 AC2). A security alert has been sent to the vendor owner (owner@bakecharm.pk).',
          ),
          SizedBox(height: 12),
          Card(
            child: Padding(
              padding: EdgeInsets.all(18),
              child: Text(
                'Why this happened: To protect kitchen recipes, payout bank accounts, and live order queues from brute-force access, logins are suspended after 5 failed attempts. Contact the store owner or wait for the lockout window to expire.',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// E1-US3-UI6: Staff home
/// Must show: Kitchen-operation view only: board link and duties assigned
class StaffHomeScreen extends StatelessWidget {
  const StaffHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E1-US3-UI6',
      title: 'Staff home (Kitchen operations only)',
      footer: KhaanaPrimaryButton(
        label: 'Open Kitchen Kanban Board (E7-US3-UI1)',
        icon: Icons.kitchen_rounded,
        onPressed: () => Navigator.pushNamed(context, '/vendor/kitchen'),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const KhaanaInlineBanner(
            kind: CapacityKind.info,
            text:
                'Signed in as Kitchen Staff (STAFF-04 · Usman Ali). Financial reports, secret recipe quantities, bank details, and owner audit logs are restricted (E1-US3 AC3, E21-US1).',
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Assigned Shift Duties · Usman Ali (STAFF-04)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                  SizedBox(height: 10),
                  Text('• Take & accept incoming kitchen orders on Kanban board'),
                  Text('• Mark orders 80% prepared and Ready for rider handover'),
                  Text('• Log ingredient stock intake & kitchen wastage (attributed to STAFF-04)'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// E1-US4-UI1: Staff list
/// Must show: Staff with duties and status
class StaffListScreen extends StatelessWidget {
  const StaffListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final session = PortalScope.of(context);
    return KhaanaPage(
      uiId: 'E1-US4-UI1',
      title: 'Kitchen staff accounts',
      footer: KhaanaPrimaryButton(
        label: 'Add or edit staff member (E1-US4-UI2)',
        icon: Icons.person_add_alt_1_rounded,
        onPressed: () => Navigator.pushNamed(context, '/vendor/staff/edit'),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final member in session.staffMembers)
            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                title: Row(
                  children: [
                    Expanded(
                      child: Text('${member.name} (${member.employeeId})', style: const TextStyle(fontWeight: FontWeight.w800)),
                    ),
                    CapacityBadge(
                      kind: member.active ? CapacityKind.available : CapacityKind.closed,
                      label: member.active ? 'Active' : 'Deactivated',
                    ),
                  ],
                ),
                subtitle: Text('Duties: ${member.duties.join(', ')}'),
                trailing: Wrap(
                  spacing: 8,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/vendor/staff/edit', arguments: member),
                      child: const Text('Edit'),
                    ),
                    if (member.active)
                      TextButton(
                        onPressed: () => showDeactivateStaffDialog(context, member),
                        child: const Text('Deactivate', style: TextStyle(color: KhaanaColors.full)),
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

/// E1-US4-UI2: Add or edit staff
/// Must show: Name, employee ID, duty set (take orders, prepare, edit stock)
class AddEditStaffScreen extends StatefulWidget {
  const AddEditStaffScreen({super.key, this.existing});
  final StaffMemberRecord? existing;

  @override
  State<AddEditStaffScreen> createState() => _AddEditStaffScreenState();
}

class _AddEditStaffScreenState extends State<AddEditStaffScreen> {
  late final TextEditingController _name;
  late final TextEditingController _empId;
  final Set<String> _duties = {'Take orders', 'Prepare food', 'Edit stock'};

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.existing?.name ?? 'Zainab Bibi');
    _empId = TextEditingController(text: widget.existing?.employeeId ?? 'STAFF-07');
    if (widget.existing != null) {
      _duties
        ..clear()
        ..addAll(widget.existing!.duties);
    }
  }

  @override
  void dispose() {
    _name.dispose();
    _empId.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final session = PortalScope.of(context);
    return KhaanaPage(
      uiId: 'E1-US4-UI2',
      title: widget.existing == null ? 'Add staff account' : 'Edit staff account',
      footer: KhaanaPrimaryButton(
        label: 'Save staff account',
        icon: Icons.save_outlined,
        onPressed: () {
          session.saveStaffMember(
            name: _name.text.trim(),
            employeeId: _empId.text.trim(),
            duties: _duties.toList(),
          );
          Navigator.pop(context);
        },
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(controller: _name, decoration: const InputDecoration(labelText: 'Employee Full Name *')),
              const SizedBox(height: 12),
              TextField(controller: _empId, decoration: const InputDecoration(labelText: 'Employee ID * (Used in audit logs)')),
              const SizedBox(height: 16),
              const Text('Assigned Operational Duties (Owner-only permissions cannot be granted):', style: TextStyle(fontWeight: FontWeight.w800)),
              const SizedBox(height: 8),
              for (final duty in ['Take orders', 'Prepare food', 'Edit stock'])
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(duty),
                  value: _duties.contains(duty),
                  onChanged: (v) => setState(() {
                    if (v ?? false) {
                      _duties.add(duty);
                    } else {
                      _duties.remove(duty);
                    }
                  }),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// E1-US4-UI3: Deactivate staff (Overlay)
/// Must show: What changes; audit history is kept (AC2)
Future<void> showDeactivateStaffDialog(BuildContext context, StaffMemberRecord member) {
  final session = PortalScope.of(context);
  return showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: KhaanaColors.orangeTint, borderRadius: BorderRadius.circular(6)),
            child: const Text('E1-US4-UI3', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: KhaanaColors.onOrangeTint)),
          ),
          const SizedBox(width: 8),
          const Expanded(child: Text('Deactivate staff account')),
        ],
      ),
      content: Text(
        'Deactivating ${member.name} (${member.employeeId}) immediately revokes their sign-in and active sessions. All historical audit entries attributed to ${member.employeeId} are permanently preserved (E1-US4 AC2).',
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        FilledButton(
          onPressed: () {
            session.deactivateStaff(member);
            Navigator.pop(context);
          },
          child: const Text('Deactivate & keep audit history'),
        ),
      ],
    ),
  );
}

/// E2-US1-UI1: Business profile
/// Must show: Type, service area, cuisine, dietary tags, preferred transport (bike/car)
class VendorBusinessProfileScreen extends StatefulWidget {
  const VendorBusinessProfileScreen({super.key});

  @override
  State<VendorBusinessProfileScreen> createState() => _VendorBusinessProfileScreenState();
}

class _VendorBusinessProfileScreenState extends State<VendorBusinessProfileScreen> {
  String _transport = 'Car preferred for 2+ lb fragile cakes; Bike for standard boxes';
  final Set<String> _tags = {'Halal', 'Eggless options', 'Nut-free customizable'};

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E2-US1-UI1',
      title: 'Business profile',
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('BakeCharm · Home & Cloud Bakery', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
              const SizedBox(height: 6),
              const Text('Service Area: Islamabad F-11, F-10, G-11, E-11 (5.5 km radius)'),
              const Text('Cuisine: Bakery · Custom Celebration Cakes & Brownies'),
              const Divider(height: 24),
              const Text('Dietary Tags:', style: TextStyle(fontWeight: FontWeight.w800)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  for (final tag in ['Halal', 'Eggless options', 'Nut-free customizable', 'Sugar-free'])
                    FilterChip(
                      label: Text(tag),
                      selected: _tags.contains(tag),
                      onSelected: (v) => setState(() => v ? _tags.add(tag) : _tags.remove(tag)),
                    ),
                ],
              ),
              const Divider(height: 24),
              DropdownButtonFormField<String>(
                initialValue: _transport,
                decoration: const InputDecoration(labelText: 'Preferred Rider Transport Mode'),
                items: const [
                  DropdownMenuItem(
                    value: 'Car preferred for 2+ lb fragile cakes; Bike for standard boxes',
                    child: Text('Car preferred for 2+ lb fragile cakes; Bike for standard boxes'),
                  ),
                  DropdownMenuItem(value: 'Motorbike only', child: Text('Motorbike only')),
                  DropdownMenuItem(value: 'Car / Van only', child: Text('Car / Van only')),
                ],
                onChanged: (v) {
                  if (v != null) setState(() => _transport = v);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// E2-US3-UI1: Operating hours and open/closed
/// Must show: Weekly hours, manual close and reopen (AC1, AC2)
class OperatingHoursScreen extends StatefulWidget {
  const OperatingHoursScreen({super.key});

  @override
  State<OperatingHoursScreen> createState() => _OperatingHoursScreenState();
}

class _OperatingHoursScreenState extends State<OperatingHoursScreen> {
  bool _manuallyOpen = true;

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E2-US3-UI1',
      title: 'Operating hours & open/closed',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: SwitchListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(
                _manuallyOpen ? 'Store Status: OPEN FOR ORDERS' : 'Store Status: MANUALLY CLOSED',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              ),
              subtitle: Text(
                _manuallyOpen
                    ? 'Accepting scheduled and express slot bookings within weekly hours (E2-US3 AC1)'
                    : 'Manual close active: New checkout is blocked immediately; existing confirmed orders continue (E2-US3 AC2)',
              ),
              value: _manuallyOpen,
              onChanged: (v) => setState(() => _manuallyOpen = v),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Weekly Operating Schedule', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 10),
                  for (final day in const [
                    ('Monday – Thursday', '11:00 AM – 10:00 PM'),
                    ('Friday', '2:30 PM – 11:00 PM'),
                    ('Saturday – Sunday', '11:00 AM – 11:30 PM'),
                  ])
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(day.$1, style: const TextStyle(fontWeight: FontWeight.w700)),
                      trailing: Text(day.$2, style: const TextStyle(fontWeight: FontWeight.w800)),
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

/// E14-US3-UI1: Delivery settings
/// Must show: Own riders, independent riders, partner fleet; fallback behaviour (AC1, AC2)
class VendorDeliverySettingsScreen extends StatefulWidget {
  const VendorDeliverySettingsScreen({super.key});

  @override
  State<VendorDeliverySettingsScreen> createState() => _VendorDeliverySettingsScreenState();
}

class _VendorDeliverySettingsScreenState extends State<VendorDeliverySettingsScreen> {
  String _primary = 'Independent KhaanaGo Riders';
  bool _partnerFallback = true;

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E14-US3-UI1',
      title: 'Delivery fleet & fallback settings',
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Primary Delivery Channel (E14-US3 AC1)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
              const SizedBox(height: 10),
              RadioGroup<String>(
                groupValue: _primary,
                onChanged: (v) {
                  if (v != null) setState(() => _primary = v);
                },
                child: const Column(
                  children: [
                    RadioListTile<String>(
                      value: 'Own Fleet Riders',
                      title: Text('Vendor\'s Own Riders'),
                      subtitle: Text('Dispatch first to BakeCharm in-house riders'),
                    ),
                    RadioListTile<String>(
                      value: 'Independent KhaanaGo Riders',
                      title: Text('Independent KhaanaGo Riders'),
                      subtitle: Text('Dispatch at 80% prep to nearest verified platform rider'),
                    ),
                    RadioListTile<String>(
                      value: 'External Partner Fleet',
                      title: Text('Partner Fleet API (Bykea / TCS Express)'),
                      subtitle: Text('Use external partner fleet webhook & IVR integration'),
                    ),
                  ],
                ),
              ),
              const Divider(height: 24),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Automatic Fallback on Timeout (E14-US3 AC2)', style: TextStyle(fontWeight: FontWeight.w800)),
                subtitle: const Text(
                  'If no primary rider accepts within 90 seconds at 80% prep, automatically fall back to Independent Riders and then Partner Fleet so food never sits cold.',
                ),
                value: _partnerFallback,
                onChanged: (v) => setState(() => _partnerFallback = v),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// E15-US1-UI2: Tariff settings
/// Must show: Base fare and per-km rate, negative-rate validation; routed road distance; maps fallback
class VendorTariffSettingsScreen extends StatefulWidget {
  const VendorTariffSettingsScreen({super.key});

  @override
  State<VendorTariffSettingsScreen> createState() => _VendorTariffSettingsScreenState();
}

class _VendorTariffSettingsScreenState extends State<VendorTariffSettingsScreen> {
  final _base = TextEditingController(text: '60');
  final _perKm = TextEditingController(text: '20');
  String? _error;
  bool _mapsFallback = false;

  @override
  void dispose() {
    _base.dispose();
    _perKm.dispose();
    super.dispose();
  }

  void _save() {
    final b = double.tryParse(_base.text.trim());
    final k = double.tryParse(_perKm.text.trim());
    if (b == null || k == null || b < 0 || k < 0) {
      setState(() => _error = 'Tariff error: Base fare and per-km rate cannot be negative (E15-US1-TC3).');
      return;
    }
    setState(() => _error = null);
  }

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E15-US1-UI2',
      title: 'Vendor delivery tariff settings',
      footer: KhaanaPrimaryButton(label: 'Save tariff', icon: Icons.save_outlined, onPressed: _save),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            children: [
              ActionChip(
                label: const Text('Test negative base −50 (TC3)'),
                onPressed: () {
                  _base.text = '-50';
                  _save();
                },
              ),
              FilterChip(
                label: const Text('Simulate maps routing service outage (TC4)'),
                selected: _mapsFallback,
                onSelected: (v) => setState(() => _mapsFallback = v),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (_error != null) ...[
            KhaanaInlineBanner(text: _error!),
            const SizedBox(height: 12),
          ],
          if (_mapsFallback) ...[
            const KhaanaInlineBanner(
              kind: CapacityKind.limited,
              text:
                  'Maps routing API failed (E15-US1-TC4): Using sector-corridor fallback road distance (3.2 km) and flagging order #KG-1042 for tariff review.',
            ),
            const SizedBox(height: 12),
          ],
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(controller: _base, decoration: const InputDecoration(labelText: 'Customer Delivery Base Fare (Rs) *')),
                  const SizedBox(height: 12),
                  TextField(controller: _perKm, decoration: const InputDecoration(labelText: 'Per-km Routed Road Rate (Rs/km) *')),
                  const SizedBox(height: 12),
                  const Text(
                    'Calculated using routed road distance (3.2 km = Rs 64), never straight-line distance (E15-US1 AC2).',
                    style: TextStyle(fontSize: 13, color: KhaanaColors.mutedLight),
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

/// E1-US3-UI7: Bank details and payout account
/// Must show: Owner-only account and payout schedule
class VendorBankDetailsScreen extends StatelessWidget {
  const VendorBankDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E1-US3-UI7',
      title: 'Bank details & payout account (Owner only)',
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Meezan Bank Limited · Verified Settlement Account', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                  CapacityBadge(kind: CapacityKind.available, label: 'Owner Only'),
                ],
              ),
              Divider(height: 24),
              Text('Account Title: BakeCharm (Pvt) Ltd'),
              SizedBox(height: 4),
              Text('IBAN: PK36MEZN0001080104928172'),
              SizedBox(height: 4),
              Text('Payout Schedule: Weekly every Tuesday (Net of 10% platform commission)'),
            ],
          ),
        ),
      ),
    );
  }
}

/// E2-US4-UI1: Customization options
/// Must show: Sizes, flavours, text and image fields with price differences, lead time, fragile flag
class VendorCustomizationOptionsScreen extends StatefulWidget {
  const VendorCustomizationOptionsScreen({super.key});

  @override
  State<VendorCustomizationOptionsScreen> createState() => _VendorCustomizationOptionsScreenState();
}

class _VendorCustomizationOptionsScreenState extends State<VendorCustomizationOptionsScreen> {
  bool _fragile = true;
  bool _allowReferenceImage = true;

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E2-US4-UI1',
      title: 'Customization options (Chocolate Cake)',
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Size & Lead-Time Rules', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
              const SizedBox(height: 8),
              const Text('• 1 lb Base (+Rs 0 · Prep lead time: 50 min)'),
              const Text('• 2 lb Celebration (+Rs 400 · Prep lead time: 70 min)'),
              const Text('• 4 lb 2-Tier Fondant (+Rs 2,200 · Minimum lead time: 24 hours)'),
              const Divider(height: 24),
              const Text('Flavours & Allergen Exclusions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
              const SizedBox(height: 8),
              const Text('• Belgian Dark Chocolate (+Rs 0) · French Vanilla Bean (+Rs 0) · Lotus Biscoff (+Rs 250)'),
              const Text('• Allowed exclusion chip: "No nuts" (verified against recipe BOM)'),
              const Divider(height: 24),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Allow customer reference image & 500-char cake inscription (E4-US2)'),
                value: _allowReferenceImage,
                onChanged: (v) => setState(() => _allowReferenceImage = v),
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Fragile Item Flag (Blocks Pooled Delivery · Express Only)'),
                value: _fragile,
                onChanged: (v) => setState(() => _fragile = v),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// E5-US1-UI2: Temporary capacity change (Overlay)
/// Must show: New limit, duration, automatic return to default (AC3, AC4)
Future<void> showTemporaryCapacityDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (context) => const _TempCapacityDialog(),
  );
}

class _TempCapacityDialog extends StatefulWidget {
  const _TempCapacityDialog();

  @override
  State<_TempCapacityDialog> createState() => _TempCapacityDialogState();
}

class _TempCapacityDialogState extends State<_TempCapacityDialog> {
  final _limit = TextEditingController(text: '8');
  String _duration = '2 hours (Auto-reverts at 9:00 PM)';

  @override
  void dispose() {
    _limit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final session = PortalScope.of(context);
    return AlertDialog(
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: KhaanaColors.orangeTint, borderRadius: BorderRadius.circular(6)),
            child: const Text('E5-US1-UI2', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: KhaanaColors.onOrangeTint)),
          ),
          const SizedBox(width: 8),
          const Expanded(child: Text('Temporary capacity change')),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _limit,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Temporary Orders / Hour Limit *'),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: _duration,
            decoration: const InputDecoration(labelText: 'Override Duration (AC3, AC4)'),
            items: const [
              DropdownMenuItem(value: '1 hour (Auto-reverts at 8:00 PM)', child: Text('1 hour (Auto-reverts at 8:00 PM)')),
              DropdownMenuItem(value: '2 hours (Auto-reverts at 9:00 PM)', child: Text('2 hours (Auto-reverts at 9:00 PM)')),
              DropdownMenuItem(value: 'Until close tonight', child: Text('Until close tonight')),
            ],
            onChanged: (v) {
              if (v != null) setState(() => _duration = v);
            },
          ),
          const SizedBox(height: 10),
          const Text(
            'When the timer expires, hourly slot capacity automatically reverts to your default 12 orders/hour (E5-US1 AC4).',
            style: TextStyle(fontSize: 12, color: KhaanaColors.mutedLight),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        FilledButton(
          onPressed: () {
            session.saveCapacity(_limit.text);
            Navigator.pop(context);
          },
          child: const Text('Apply temporary limit'),
        ),
      ],
    ),
  );
}

/// E6-US2-UI1: Buffers and overrides
/// Must show: Weather and peak buffers in force, vendor override with audit note (AC4).
/// Include weather-service failure fallback so ETA calculation continues.
class VendorBuffersOverridesScreen extends StatefulWidget {
  const VendorBuffersOverridesScreen({super.key});

  @override
  State<VendorBuffersOverridesScreen> createState() => _VendorBuffersOverridesScreenState();
}

class _VendorBuffersOverridesScreenState extends State<VendorBuffersOverridesScreen> {
  bool _weatherApiDown = false;
  final _overrideMinutes = TextEditingController(text: '20');
  final _auditNote = TextEditingController(text: 'Main deck oven preheating recovery during storm');
  bool _overrideSaved = false;

  @override
  void dispose() {
    _overrideMinutes.dispose();
    _auditNote.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E6-US2-UI1',
      title: 'Buffers & kitchen ETA overrides',
      footer: KhaanaPrimaryButton(
        label: 'Apply vendor buffer override (Logged to Audit Trail)',
        icon: Icons.tune_rounded,
        onPressed: () => setState(() => _overrideSaved = true),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Simulate weather API outage (Fallback mode · E6-US2-TC3)', style: TextStyle(fontWeight: FontWeight.w700)),
            value: _weatherApiDown,
            onChanged: (v) => setState(() => _weatherApiDown = v),
          ),
          if (_weatherApiDown) ...[
            const KhaanaInlineBanner(
              kind: CapacityKind.limited,
              text:
                  'Weather service unreachable (E6-US2-TC3): Falling back to last cached sector buffer (+10% peak) so customer ETA calculation continues without crashing.',
            ),
            const SizedBox(height: 12),
          ],
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Platform Buffers Currently in Force', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 8),
                  const Text('• Rain Buffer (Islamabad F-11): +15% (+15 mins)'),
                  const Text('• Dinner Peak Buffer (7:00–9:00 PM): +10% (+10 mins)'),
                  const Divider(height: 24),
                  const Text('Vendor Override with Mandatory Audit Note (E6-US2 AC4)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _overrideMinutes,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Override Prep Buffer (Minutes) *'),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _auditNote,
                    decoration: const InputDecoration(labelText: 'Mandatory Audit Reason *'),
                  ),
                  if (_overrideSaved) ...[
                    const SizedBox(height: 12),
                    const KhaanaInlineBanner(
                      kind: CapacityKind.available,
                      text: 'Override (+20 min) active and recorded in immutable Audit Log (E21-US2-UI1).',
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

/// E7-US4-UI1: Voice commands (Overlay)
/// Must show: Heard command, confirmation, "repeat" prompt (AC1, AC2)
Future<void> showKitchenVoiceCommandsDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (context) => const _KitchenVoiceOverlay(),
  );
}

class _KitchenVoiceOverlay extends StatefulWidget {
  const _KitchenVoiceOverlay();

  @override
  State<_KitchenVoiceOverlay> createState() => _KitchenVoiceOverlayState();
}

class _KitchenVoiceOverlayState extends State<_KitchenVoiceOverlay> {
  String _state = 'heard'; // 'heard', 'repeat', 'confirmed'

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: KhaanaColors.orangeTint, borderRadius: BorderRadius.circular(6)),
            child: const Text('E7-US4-UI1', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: KhaanaColors.onOrangeTint)),
          ),
          const SizedBox(width: 8),
          const Expanded(child: Text('Hands-free kitchen voice command')),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            children: [
              ChoiceChip(
                label: const Text('Recognized command (AC1)'),
                selected: _state == 'heard',
                onSelected: (_) => setState(() => _state = 'heard'),
              ),
              ChoiceChip(
                label: const Text('Noisy kitchen -> Repeat prompt (AC2)'),
                selected: _state == 'repeat',
                onSelected: (_) => setState(() => _state = 'repeat'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (_state == 'repeat')
            const KhaanaInlineBanner(
              kind: CapacityKind.limited,
              text: 'Could not clearly hear order number over kitchen noise. Please repeat: Say "Order 123 Ready" or "Order 123 Eighty Percent" (E7-US4 AC2).',
            )
          else
            const KhaanaInlineBanner(
              kind: CapacityKind.available,
              text: 'Heard command: "Mark Order #123 as 80% Prepared".Rider dispatch trigger armed (E7-US4 AC1).',
            ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
      ],
    );
  }
}

/// E4-US3-UI2: Custom order review
/// Must show: Accept, propose new price or time, or decline with a reason (AC1)
class CustomOrderReviewScreen extends StatefulWidget {
  const CustomOrderReviewScreen({super.key});

  @override
  State<CustomOrderReviewScreen> createState() => _CustomOrderReviewScreenState();
}

class _CustomOrderReviewScreenState extends State<CustomOrderReviewScreen> {
  final _revisedPrice = TextEditingController(text: '5500');
  final _revisedTime = TextEditingController(text: '24 hours (Tomorrow 6:30 PM)');
  final _reason = TextEditingController(text: 'Hand-sculpted fondant roses and edible gold leaf require 24h curing.');
  String _decision = 'none';

  @override
  void dispose() {
    _revisedPrice.dispose();
    _revisedTime.dispose();
    _reason.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E4-US3-UI2',
      title: 'Custom order review (#KG-1042)',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Customer Request · Ayesha Khan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 6),
                  const Text('Item: Chocolate Cake (2 lb · No nuts) · Original Estimate: Rs 2,250'),
                  const Text('Reference Image: birthday_cake_reference.jpg (Attached)'),
                  const Text('Special Instructions: "Pastel pink buttercream with Happy 5th Birthday Hira in gold script."'),
                  const Divider(height: 24),
                  TextField(controller: _revisedPrice, decoration: const InputDecoration(labelText: 'Proposed Revised Price (Rs)')),
                  const SizedBox(height: 12),
                  TextField(controller: _revisedTime, decoration: const InputDecoration(labelText: 'Proposed Revised Lead Time')),
                  const SizedBox(height: 12),
                  TextField(controller: _reason, decoration: const InputDecoration(labelText: 'Vendor Quote Note / Decline Reason *')),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      KhaanaPrimaryButton(
                        label: 'Accept as requested (Rs 2,250)',
                        onPressed: () => setState(() => _decision = 'accepted'),
                      ),
                      KhaanaSecondaryButton(
                        label: 'Send revised quote (Rs ${_revisedPrice.text})',
                        onPressed: () => setState(() => _decision = 'revised'),
                      ),
                      KhaanaSecondaryButton(
                        label: 'Decline with reason',
                        onPressed: () => setState(() => _decision = 'declined'),
                      ),
                    ],
                  ),
                  if (_decision != 'none') ...[
                    const SizedBox(height: 12),
                    KhaanaInlineBanner(
                      kind: _decision == 'declined' ? CapacityKind.full : CapacityKind.available,
                      text: switch (_decision) {
                        'accepted' => 'Custom order accepted at original price Rs 2,250.',
                        'revised' => 'Revised quote (Rs ${_revisedPrice.text}, ${_revisedTime.text}) sent to customer on E4-US3-UI1 (AC1).',
                        _ => 'Custom order declined with reason: "${_reason.text}". Customer notified.',
                      },
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

/// E8-US1-UI1: Recipe list
/// Must show: Dishes with recipe status; hidden from staff (AC4)
class RecipeListScreen extends StatelessWidget {
  const RecipeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E8-US1-UI1',
      title: 'Recipe list (Owner only)',
      footer: KhaanaPrimaryButton(
        label: 'Open Recipe Editor (E8-US1-UI2)',
        icon: Icons.edit_note_rounded,
        onPressed: () => Navigator.pushNamed(context, '/vendor/recipe'),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const KhaanaInlineBanner(
            kind: CapacityKind.info,
            text: 'Proprietary recipe quantities are strictly owner-only and hidden from kitchen staff accounts (E8-US1 AC4, E21-US1).',
          ),
          const SizedBox(height: 12),
          for (final item in const [
            ('Chocolate cake (1 lb)', 'Complete · 5 ingredients · 420 kcal/slice', CapacityKind.available),
            ('Brownie box (×6)', 'Complete · 4 ingredients · 390 kcal/piece', CapacityKind.available),
            ('Chicken karahi', 'Complete · 6 ingredients · 680 kcal/serving', CapacityKind.available),
          ])
            Card(
              child: ListTile(
                title: Text(item.$1, style: const TextStyle(fontWeight: FontWeight.w800)),
                subtitle: Text(item.$2),
                trailing: Wrap(
                  spacing: 8,
                  children: [
                    CapacityBadge(kind: item.$3, label: 'BOM Linked'),
                    TextButton(
                      onPressed: () => showRecipeChangeImpactDialog(context),
                      child: const Text('Impact (E8-US4-UI1)'),
                    ),
                  ],
                ),
                onTap: () => Navigator.pushNamed(context, '/vendor/recipe'),
              ),
            ),
        ],
      ),
    );
  }
}

/// E8-US4-UI1: Recipe change impact (Overlay)
/// Must show: Nutrition and BOM will refresh; active orders keep old recipe (AC1, AC2).
/// Include failed recalculation state that leaves values pending review rather than saving bad numbers.
Future<void> showRecipeChangeImpactDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (context) => const _RecipeChangeImpactDialog(),
  );
}

class _RecipeChangeImpactDialog extends StatefulWidget {
  const _RecipeChangeImpactDialog();

  @override
  State<_RecipeChangeImpactDialog> createState() => _RecipeChangeImpactDialogState();
}

class _RecipeChangeImpactDialogState extends State<_RecipeChangeImpactDialog> {
  bool _recalcFailed = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: KhaanaColors.orangeTint, borderRadius: BorderRadius.circular(6)),
            child: const Text('E8-US4-UI1', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: KhaanaColors.onOrangeTint)),
          ),
          const SizedBox(width: 8),
          const Expanded(child: Text('Recipe change impact')),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Saving this recipe edit will automatically recalculate per-serving Nutrition macros and future Bill-of-Materials (BOM) deductions (E8-US4 AC1). Active orders already in the kitchen (#123, #121) keep their snapshot of the previous recipe (AC2).',
          ),
          const SizedBox(height: 10),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Simulate nutrition recalculation failure (TC3)'),
            value: _recalcFailed,
            onChanged: (v) => setState(() => _recalcFailed = v),
          ),
          if (_recalcFailed)
            const KhaanaInlineBanner(
              kind: CapacityKind.limited,
              text:
                  'Recalculation service failed (E8-US4-TC3): Macros are marked "Pending Owner Review" rather than saving corrupted numbers.',
            ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        FilledButton(onPressed: () => Navigator.pop(context), child: const Text('Confirm recipe update')),
      ],
    ),
  );
}

/// E9-US1-UI2: Add or edit ingredient
/// Must show: Name, unit, opening stock, reorder level, perishable/non-perishable type.
/// Include batch expiry date for perishable stock so expired batches can be flagged (E9-US4-TC7).
class AddEditIngredientScreen extends StatefulWidget {
  const AddEditIngredientScreen({super.key});

  @override
  State<AddEditIngredientScreen> createState() => _AddEditIngredientScreenState();
}

class _AddEditIngredientScreenState extends State<AddEditIngredientScreen> {
  final _name = TextEditingController(text: 'Whipping Cream (35% Dairy)');
  String _unit = 'litre';
  final _opening = TextEditingController(text: '6');
  final _reorder = TextEditingController(text: '3');
  String _type = 'Perishable';
  final _expiry = TextEditingController(text: '2026-11-03 (Expired batch flagged · E9-US4-TC7)');
  bool _expiredBatch = true;

  @override
  void dispose() {
    _name.dispose();
    _opening.dispose();
    _reorder.dispose();
    _expiry.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E9-US1-UI2',
      title: 'Add or edit ingredient',
      footer: KhaanaPrimaryButton(
        label: 'Save ingredient & batch rules',
        icon: Icons.save_outlined,
        onPressed: () => Navigator.pop(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_type == 'Perishable' && _expiredBatch) ...[
            const KhaanaInlineBanner(
              kind: CapacityKind.full,
              text:
                  'Expired Perishable Batch Flagged (E9-US4-TC7): Batch #CRM-102 expired on 2026-11-03 and is excluded from usable stock in the Material Requirements Planner.',
            ),
            const SizedBox(height: 12),
          ],
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(controller: _name, decoration: const InputDecoration(labelText: 'Ingredient Name *')),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    initialValue: _unit,
                    decoration: const InputDecoration(labelText: 'Measurement Unit *'),
                    items: const [
                      DropdownMenuItem(value: 'kg', child: Text('kg')),
                      DropdownMenuItem(value: 'g', child: Text('g')),
                      DropdownMenuItem(value: 'litre', child: Text('litre')),
                      DropdownMenuItem(value: 'dozen', child: Text('dozen')),
                    ],
                    onChanged: (v) {
                      if (v != null) setState(() => _unit = v);
                    },
                  ),
                  const SizedBox(height: 12),
                  TextField(controller: _opening, decoration: const InputDecoration(labelText: 'Opening Stock Quantity *')),
                  const SizedBox(height: 12),
                  TextField(controller: _reorder, decoration: const InputDecoration(labelText: 'Low-Stock Reorder Level *')),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    initialValue: _type,
                    decoration: const InputDecoration(labelText: 'Shelf-Life Classification *'),
                    items: const [
                      DropdownMenuItem(value: 'Perishable', child: Text('Perishable (Demand-driven from confirmed slots)')),
                      DropdownMenuItem(value: 'Non-perishable', child: Text('Non-perishable (Forecast from historical sales + buffer)')),
                    ],
                    onChanged: (v) {
                      if (v != null) setState(() => _type = v);
                    },
                  ),
                  if (_type == 'Perishable') ...[
                    const SizedBox(height: 12),
                    TextField(
                      controller: _expiry,
                      decoration: const InputDecoration(labelText: 'Perishable Batch Expiry Date * (E9-US4-TC7)'),
                    ),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Simulate expired perishable batch'),
                      value: _expiredBatch,
                      onChanged: (v) => setState(() => _expiredBatch = v),
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

/// E9-US1-UI3: Stock intake (Overlay)
/// Must show: Purchase quantity; entry logged with user's name (AC2)
Future<void> showStockIntakeDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: KhaanaColors.orangeTint, borderRadius: BorderRadius.circular(6)),
            child: const Text('E9-US1-UI3', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: KhaanaColors.onOrangeTint)),
          ),
          const SizedBox(width: 8),
          const Expanded(child: Text('Record stock intake')),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: TextEditingController(text: '10'),
            decoration: const InputDecoration(labelText: 'Purchased Quantity (+10 kg Flour) *'),
          ),
          const SizedBox(height: 10),
          const KhaanaInlineBanner(
            kind: CapacityKind.info,
            text: 'Audit attribution: Logged under named employee "Usman Ali (STAFF-04)" at 6:48 PM (E9-US1 AC2).',
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        FilledButton(onPressed: () => Navigator.pop(context), child: const Text('Record intake')),
      ],
    ),
  );
}

/// E9-US2-UI1: Low-stock alerts
/// Must show: Ingredients under reorder level, dishes made unavailable at zero stock (AC3, AC4)
class LowStockAlertsScreen extends StatelessWidget {
  const LowStockAlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E9-US2-UI1',
      title: 'Low-stock alerts & auto-paused dishes',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const KhaanaInlineBanner(
            kind: CapacityKind.full,
            text:
                'Zero-Stock Protection Active (E9-US2 AC4): Belgian Dark Cocoa reached 0.0 kg after Order #121, so "Brownie box" was automatically marked Unavailable on the customer menu.',
          ),
          const SizedBox(height: 12),
          for (final alert in const [
            ('Belgian Dark Cocoa', '0.0 kg remaining (Reorder level: 2.0 kg)', 'Auto-paused: Brownie box', CapacityKind.full),
            ('Flour', '4.0 kg remaining (Reorder level: 5.0 kg)', 'Low stock warning (AC3)', CapacityKind.limited),
            ('Cream', '1.0 litre remaining (Reorder level: 2.0 litres)', 'Low stock warning (AC3)', CapacityKind.limited),
          ])
            Card(
              child: ListTile(
                title: Text(alert.$1, style: const TextStyle(fontWeight: FontWeight.w800)),
                subtitle: Text(alert.$2),
                trailing: CapacityBadge(kind: alert.$4, label: alert.$3),
              ),
            ),
        ],
      ),
    );
  }
}

/// E9-US3-UI1: Log wastage (Overlay)
/// Must show: Ingredient, quantity, reason; over-stock quantity rejected (AC2)
Future<void> showLogWastageDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (context) => const _LogWastageOverlay(),
  );
}

class _LogWastageOverlay extends StatefulWidget {
  const _LogWastageOverlay();

  @override
  State<_LogWastageOverlay> createState() => _LogWastageOverlayState();
}

class _LogWastageOverlayState extends State<_LogWastageOverlay> {
  final _qty = TextEditingController(text: '5');
  String? _error = 'Rejected: Wastage quantity (5.0 litres) exceeds current available stock of Cream (1.0 litre) (E9-US3 AC2 / TC2).';

  @override
  void dispose() {
    _qty.dispose();
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
            child: const Text('E9-US3-UI1', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: KhaanaColors.onOrangeTint)),
          ),
          const SizedBox(width: 8),
          const Expanded(child: Text('Log ingredient wastage')),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Ingredient: Cream (Available stock: 1.0 litre)'),
          const SizedBox(height: 10),
          TextField(
            controller: _qty,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Wastage Quantity (litre) *'),
            onChanged: (v) {
              final val = double.tryParse(v) ?? 0;
              setState(() {
                _error = val > 1.0
                    ? 'Rejected: Wastage quantity ($val litres) exceeds current available stock (1.0 litre) (E9-US3 AC2).'
                    : null;
              });
            },
          ),
          const SizedBox(height: 10),
          TextField(
            controller: TextEditingController(text: 'Spilled during whipping'),
            decoration: const InputDecoration(labelText: 'Wastage Reason * (Logged to Audit Trail)'),
          ),
          if (_error != null) ...[
            const SizedBox(height: 10),
            KhaanaInlineBanner(text: _error!),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            _qty.text = '0.5';
            setState(() => _error = null);
          },
          child: const Text('Set valid 0.5 L'),
        ),
        FilledButton(
          onPressed: _error != null ? null : () => Navigator.pop(context),
          child: const Text('Log wastage'),
        ),
      ],
    ),
  );
}

/// E9-US3-UI2: Variance report
/// Must show: Expected, actual, variance per ingredient (AC3, AC4).
/// Include physical count input and configurable threshold; show below, equal and above-threshold states.
class VarianceReportScreen extends StatefulWidget {
  const VarianceReportScreen({super.key});

  @override
  State<VarianceReportScreen> createState() => _VarianceReportScreenState();
}

class _VarianceReportScreenState extends State<VarianceReportScreen> {
  final _threshold = TextEditingController(text: '5.0');
  final _flourActual = TextEditingController(text: '3.4');

  @override
  void dispose() {
    _threshold.dispose();
    _flourActual.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E9-US3-UI2',
      title: 'Stock variance report (Expected vs Physical)',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _threshold,
                      decoration: const InputDecoration(labelText: 'Configurable Variance Alert Threshold (%)'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _flourActual,
                      decoration: const InputDecoration(labelText: 'Physical Count Input: Flour (kg)'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          for (final row in const [
            ('Flour', 'Expected: 4.0 kg', 'Actual: 3.4 kg', 'Variance: −15.0% (Above 5% threshold · Flagged)', CapacityKind.full),
            ('Cream', 'Expected: 1.00 L', 'Actual: 0.95 L', 'Variance: −5.0% (Equal to 5% boundary)', CapacityKind.limited),
            ('Eggs', 'Expected: 2.0 doz', 'Actual: 1.98 doz', 'Variance: −1.0% (Below threshold · Normal)', CapacityKind.available),
          ])
            Card(
              child: ListTile(
                title: Text(row.$1, style: const TextStyle(fontWeight: FontWeight.w800)),
                subtitle: Text('${row.$2} · ${row.$3}'),
                trailing: CapacityBadge(kind: row.$5, label: row.$4),
              ),
            ),
        ],
      ),
    );
  }
}

/// E9-US4-UI1: Material requirements planner
/// Must show: Look-back period, requirements, current stock, shortfall; insufficient-history state (AC1–AC4).
/// Distinguish perishable demand from confirmed orders vs non-perishable from historical sales and buffer.
class MaterialRequirementsPlannerScreen extends StatefulWidget {
  const MaterialRequirementsPlannerScreen({super.key});

  @override
  State<MaterialRequirementsPlannerScreen> createState() => _MaterialRequirementsPlannerScreenState();
}

class _MaterialRequirementsPlannerScreenState extends State<MaterialRequirementsPlannerScreen> {
  String _lookback = 'Last 14 days';
  bool _insufficientHistory = false;

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E9-US4-UI1',
      title: 'Material requirements planner (MRP)',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  initialValue: _lookback,
                  decoration: const InputDecoration(labelText: 'Historical Look-back Period'),
                  items: const [
                    DropdownMenuItem(value: 'Last 7 days', child: Text('Last 7 days')),
                    DropdownMenuItem(value: 'Last 14 days', child: Text('Last 14 days')),
                    DropdownMenuItem(value: 'Last 30 days', child: Text('Last 30 days')),
                  ],
                  onChanged: (v) {
                    if (v != null) setState(() => _lookback = v);
                  },
                ),
              ),
              const SizedBox(width: 12),
              FilterChip(
                label: const Text('Preview insufficient-history state (AC4)'),
                selected: _insufficientHistory,
                onSelected: (v) => setState(() => _insufficientHistory = v),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (_insufficientHistory)
            const KhaanaInlineBanner(
              kind: CapacityKind.limited,
              text:
                  'Insufficient Sales History (E9-US4 AC4): Fewer than 7 days of completed orders exist for non-perishable forecasting. Showing confirmed-slot BOM requirements only until sufficient history accumulates.',
            )
          else ...[
            const KhaanaInlineBanner(
              kind: CapacityKind.info,
              text:
                  'Perishable ingredients are calculated strictly from confirmed upcoming slot orders (AC1). Non-perishable ingredients use historical sales velocity + 15% safety buffer (AC2).',
            ),
            const SizedBox(height: 12),
            for (final item in const [
              (
                'Cream (Perishable · Confirmed Slot Orders)',
                'Required: 3.5 L · Usable Stock: 1.0 L (excludes 0.5 L expired batch)',
                'Shortfall: 2.5 L',
                CapacityKind.full,
              ),
              (
                'Eggs (Perishable · Confirmed Slot Orders)',
                'Required: 3.0 doz · Usable Stock: 2.0 doz',
                'Shortfall: 1.0 doz',
                CapacityKind.limited,
              ),
              (
                'Flour (Non-Perishable · 14-day History + 15% Buffer)',
                'Required: 12.0 kg · Usable Stock: 4.0 kg',
                'Shortfall: 8.0 kg',
                CapacityKind.full,
              ),
            ])
              Card(
                child: ListTile(
                  title: Text(item.$1, style: const TextStyle(fontWeight: FontWeight.w800)),
                  subtitle: Text(item.$2),
                  trailing: CapacityBadge(kind: item.$4, label: item.$3),
                ),
              ),
          ],
        ],
      ),
    );
  }
}

/// E10-US1-UI2: Invoice list
/// Must show: Invoice number, order, total, payment state, date filter
class VendorInvoiceListScreen extends StatefulWidget {
  const VendorInvoiceListScreen({super.key});

  @override
  State<VendorInvoiceListScreen> createState() => _VendorInvoiceListScreenState();
}

class _VendorInvoiceListScreenState extends State<VendorInvoiceListScreen> {
  String _dateFilter = 'All dates';

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E10-US1-UI2',
      title: 'Invoice list',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            children: [
              for (final f in ['All dates', 'Today', 'Last 7 days'])
                ChoiceChip(
                  label: Text(f),
                  selected: _dateFilter == f,
                  onSelected: (_) => setState(() => _dateFilter = f),
                ),
            ],
          ),
          const SizedBox(height: 12),
          for (final inv in const [
            ('INV-2026-1042', 'Order #KG-1042 · Today', 2014, 'Paid (JazzCash)', CapacityKind.available),
            ('INV-2026-1038', 'Order #KG-1038 · Yesterday', 1974, 'Paid (COD Collected)', CapacityKind.available),
            ('INV-2026-1029', 'Order #KG-1029 · 2 days ago', 1414, 'Refunded (Rejected Prepaid)', CapacityKind.limited),
          ])
            Card(
              child: ListTile(
                title: Text('${inv.$1} · ${inv.$2}', style: const TextStyle(fontWeight: FontWeight.w800)),
                subtitle: Text('Total: ${formatRupees(inv.$3)}'),
                trailing: CapacityBadge(kind: inv.$5, label: inv.$4),
                onTap: () => Navigator.pushNamed(context, '/vendor/invoice'),
              ),
            ),
        ],
      ),
    );
  }
}

/// E10-US2-UI1: Payments
/// Must show: Online and COD payments against invoices; method and reference.
/// Show partial, exact and excess-payment outcomes; duplicate reference numbers do not record a second payment.
class VendorPaymentsScreen extends StatefulWidget {
  const VendorPaymentsScreen({super.key});

  @override
  State<VendorPaymentsScreen> createState() => _VendorPaymentsScreenState();
}

class _VendorPaymentsScreenState extends State<VendorPaymentsScreen> {
  String _outcome = 'exact'; // 'partial', 'exact', 'excess', 'duplicate'

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E10-US2-UI1',
      title: 'Invoice payments & reference reconciliation',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ChoiceChip(
                label: const Text('Exact payment Rs 2,014 (Paid)'),
                selected: _outcome == 'exact',
                onSelected: (_) => setState(() => _outcome = 'exact'),
              ),
              ChoiceChip(
                label: const Text('Partial payment Rs 1,000 (Partially Paid · TC4)'),
                selected: _outcome == 'partial',
                onSelected: (_) => setState(() => _outcome = 'partial'),
              ),
              ChoiceChip(
                label: const Text('Excess payment Rs 2,500 (Rejected / Credit Flagged · TC5)'),
                selected: _outcome == 'excess',
                onSelected: (_) => setState(() => _outcome = 'excess'),
              ),
              ChoiceChip(
                label: const Text('Duplicate Ref TX-98412 (Idempotent Block · TC3)'),
                selected: _outcome == 'duplicate',
                onSelected: (_) => setState(() => _outcome = 'duplicate'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          KhaanaInlineBanner(
            kind: switch (_outcome) {
              'exact' => CapacityKind.available,
              'partial' => CapacityKind.limited,
              _ => CapacityKind.full,
            },
            text: switch (_outcome) {
              'exact' => 'Exact payment (Rs 2,014 vs Rs 2,014 due · Ref TX-98412): Invoice INV-2026-1042 marked PAID.',
              'partial' =>
                'Partial payment (Rs 1,000 received vs Rs 2,014 due): Invoice marked PARTIALLY PAID with Rs 1,014 remaining balance (E10-US2-TC4).',
              'excess' =>
                'Excess payment (Rs 2,500 submitted vs Rs 2,014 due): Overpayment of Rs 486 is rejected / flagged for reconciliation (E10-US2-TC5).',
              _ =>
                'Duplicate reference number TX-98412 detected! Second payment entry was blocked so the invoice is not double-credited (E10-US2-TC3).',
            },
          ),
          const SizedBox(height: 12),
          Card(
            child: Column(
              children: const [
                ListTile(
                  title: Text('TX-98412 · JazzCash Online · INV-2026-1042', style: TextStyle(fontWeight: FontWeight.w800)),
                  subtitle: Text('Recorded 6:42 PM · Linked to Order #KG-1042'),
                  trailing: Text('Rs 2,014', style: TextStyle(fontWeight: FontWeight.w800)),
                ),
                Divider(height: 1),
                ListTile(
                  title: Text('COD-7710 · Rider Cash Collection · INV-2026-1038', style: TextStyle(fontWeight: FontWeight.w800)),
                  subtitle: Text('Rider: Bilal Ahmed · Verified by 6-digit PIN'),
                  trailing: Text('Rs 1,974', style: TextStyle(fontWeight: FontWeight.w800)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// E10-US3-UI2: Refunds
/// Must show: Rejected prepaid orders flagged for refund and their status
class VendorRefundsScreen extends StatelessWidget {
  const VendorRefundsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E10-US3-UI2',
      title: 'Prepaid order refunds',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final r in const [
            ('INV-2026-1029 · Order #KG-1029', 'Rejected by kitchen (Oven batch full)', 'Rs 1,414 · Refunded to Card', CapacityKind.available),
            ('INV-2026-1049 · Order #KG-1049', 'Custom cake declined (48h lead time needed)', 'Rs 3,200 · Refund Queued', CapacityKind.limited),
          ])
            Card(
              child: ListTile(
                title: Text(r.$1, style: const TextStyle(fontWeight: FontWeight.w800)),
                subtitle: Text(r.$2),
                trailing: CapacityBadge(kind: r.$4, label: r.$3),
              ),
            ),
        ],
      ),
    );
  }
}

/// E10-US4-UI1: COD reconciliation
/// Must show: Cash collected per rider against COD invoices, unmatched differences (AC1)
class CodReconciliationScreen extends StatelessWidget {
  const CodReconciliationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E10-US4-UI1',
      title: 'COD reconciliation',
      footer: KhaanaPrimaryButton(
        label: 'Flag discrepancy to administrator (E10-US4-UI2)',
        icon: Icons.flag_outlined,
        onPressed: () => showFlagDiscrepancyDialog(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final row in const [
            ('Rider: Bilal Ahmed (3 COD invoices)', 'Expected: Rs 5,420 · Remitted: Rs 5,420', 'Matched (Rs 0 diff)', CapacityKind.available),
            ('Rider: Kamran Shah (2 COD invoices)', 'Expected: Rs 3,180 · Remitted: Rs 2,680', 'Shortfall: −Rs 500', CapacityKind.full),
          ])
            Card(
              child: ListTile(
                title: Text(row.$1, style: const TextStyle(fontWeight: FontWeight.w800)),
                subtitle: Text(row.$2),
                trailing: CapacityBadge(kind: row.$4, label: row.$3),
              ),
            ),
        ],
      ),
    );
  }
}

/// E10-US4-UI2: Flag discrepancy (Overlay)
/// Must show: Note sent to administrator (AC2)
Future<void> showFlagDiscrepancyDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: KhaanaColors.orangeTint, borderRadius: BorderRadius.circular(6)),
            child: const Text('E10-US4-UI2', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: KhaanaColors.onOrangeTint)),
          ),
          const SizedBox(width: 8),
          const Expanded(child: Text('Flag COD discrepancy')),
        ],
      ),
      content: TextField(
        maxLines: 3,
        controller: TextEditingController(
          text: 'Rider Kamran Shah remitted Rs 2,680 against Rs 3,180 COD invoice total (−Rs 500 difference on INV-2026-1033). Escalating to Admin.',
        ),
        decoration: const InputDecoration(labelText: 'Discrepancy Note Sent to Administrator (E10-US4 AC2) *'),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        FilledButton(onPressed: () => Navigator.pop(context), child: const Text('Send to Administrator')),
      ],
    ),
  );
}

/// E12-US1-UI2: Commission and payouts
/// Must show: Deductions per order and payout history
class CommissionPayoutsScreen extends StatelessWidget {
  const CommissionPayoutsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E12-US1-UI2',
      title: 'Commission deductions & payouts',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const KhaanaInlineBanner(
            kind: CapacityKind.info,
            text: 'Active Platform Commission Rate: 10.0% (within 8–12% transparent band · E20-US2).',
          ),
          const SizedBox(height: 12),
          for (final p in const [
            ('Order #KG-1042 · Gross Rs 1,850', '10% Commission: −Rs 185', 'Net Payable: Rs 1,665'),
            ('Order #KG-1038 · Gross Rs 1,810', '10% Commission: −Rs 181', 'Net Payable: Rs 1,629'),
            ('Weekly Settlement #PAY-88 · Meezan Bank', 'Gross Rs 42,600 · Commission −Rs 4,260', 'Paid Out: Rs 38,340'),
          ])
            Card(
              child: ListTile(
                title: Text(p.$1, style: const TextStyle(fontWeight: FontWeight.w800)),
                subtitle: Text(p.$2),
                trailing: Text(p.$3, style: const TextStyle(fontWeight: FontWeight.w800, color: KhaanaColors.available)),
              ),
            ),
        ],
      ),
    );
  }
}

/// E12-US1-UI3: Expenses
/// Must show: Expense list by category and date
class VendorExpensesScreen extends StatelessWidget {
  const VendorExpensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E12-US1-UI3',
      title: 'Kitchen expenses',
      footer: KhaanaPrimaryButton(
        label: 'Add expense (E12-US1-UI4)',
        icon: Icons.add_rounded,
        onPressed: () => showAddExpenseDialog(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final exp in const [
            ('Packaging · Cake Boxes & Ribbons', 'Today · 04 Nov 2026', 4200),
            ('Utilities · Commercial Oven Gas & Electricity', '02 Nov 2026', 6500),
            ('Ingredients · Belgian Dark Chocolate Bulk', '01 Nov 2026', 8400),
          ])
            Card(
              child: ListTile(
                title: Text(exp.$1, style: const TextStyle(fontWeight: FontWeight.w800)),
                subtitle: Text(exp.$2),
                trailing: Text(formatRupees(exp.$3), style: const TextStyle(fontWeight: FontWeight.w800)),
              ),
            ),
        ],
      ),
    );
  }
}

/// E12-US1-UI4: Add expense (Overlay)
/// Must show: Category, amount, date (AC1)
Future<void> showAddExpenseDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: KhaanaColors.orangeTint, borderRadius: BorderRadius.circular(6)),
            child: const Text('E12-US1-UI4', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: KhaanaColors.onOrangeTint)),
          ),
          const SizedBox(width: 8),
          const Expanded(child: Text('Add kitchen expense')),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(controller: TextEditingController(text: 'Packaging & Cold Packs'), decoration: const InputDecoration(labelText: 'Category *')),
          const SizedBox(height: 10),
          TextField(controller: TextEditingController(text: '1850'), decoration: const InputDecoration(labelText: 'Amount (Rs) *')),
          const SizedBox(height: 10),
          TextField(controller: TextEditingController(text: '2026-11-04'), decoration: const InputDecoration(labelText: 'Date *')),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        FilledButton(onPressed: () => Navigator.pop(context), child: const Text('Save expense')),
      ],
    ),
  );
}

/// E12-US2-UI1: Net profit and dish margins
/// Must show: Revenue minus commission and costs; margin per dish.
/// Show margin unavailable when BOM cost is missing; support negative, zero and positive net-profit states.
class NetProfitDishMarginsScreen extends StatefulWidget {
  const NetProfitDishMarginsScreen({super.key});

  @override
  State<NetProfitDishMarginsScreen> createState() => _NetProfitDishMarginsScreenState();
}

class _NetProfitDishMarginsScreenState extends State<NetProfitDishMarginsScreen> {
  String _profitMode = 'positive'; // 'positive', 'zero', 'negative'

  @override
  Widget build(BuildContext context) {
    final (rev, comm, costs, net, kind) = switch (_profitMode) {
      'zero' => (42600, 4260, 38340, 0, CapacityKind.limited),
      'negative' => (42600, 4260, 44900, -6560, CapacityKind.full),
      _ => (42600, 4260, 14200, 24140, CapacityKind.available),
    };
    return KhaanaPage(
      uiId: 'E12-US2-UI1',
      title: 'Net profit & per-dish margins',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            children: [
              ChoiceChip(
                label: const Text('Positive Net Profit (+Rs 24,140)'),
                selected: _profitMode == 'positive',
                onSelected: (_) => setState(() => _profitMode = 'positive'),
              ),
              ChoiceChip(
                label: const Text('Zero Break-Even (Rs 0 · TC3)'),
                selected: _profitMode == 'zero',
                onSelected: (_) => setState(() => _profitMode = 'zero'),
              ),
              ChoiceChip(
                label: const Text('Negative Net Loss (−Rs 6,560 · TC2)'),
                selected: _profitMode == 'negative',
                onSelected: (_) => setState(() => _profitMode = 'negative'),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Net Profit Summary (Revenue − Commission − Costs)', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
                      CapacityBadge(kind: kind, label: 'Net: ${formatRupees(net)}'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  PriceLines(
                    lines: [
                      ('Gross Food Revenue', rev),
                      ('Platform Commission (10%)', -comm),
                      ('BOM Ingredient + Operating Expenses', -costs),
                    ],
                    total: net,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text('Per-Dish Contribution Margins:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          for (final m in const [
            ('Chocolate Cake (1 lb)', 'Price Rs 1,850 · BOM Cost Rs 620 · Comm Rs 185', 'Margin: Rs 1,045 (56.5%)', CapacityKind.available),
            ('Chicken Karahi', 'Price Rs 1,450 · BOM Cost Rs 590 · Comm Rs 145', 'Margin: Rs 715 (49.3%)', CapacityKind.available),
            ('Seasonal Mango Tart', 'Price Rs 1,100 · Missing BOM ingredient cost (E12-US2-TC4)', 'Margin Unavailable (BOM Incomplete)', CapacityKind.limited),
          ])
            Card(
              child: ListTile(
                title: Text(m.$1, style: const TextStyle(fontWeight: FontWeight.w800)),
                subtitle: Text(m.$2),
                trailing: CapacityBadge(kind: m.$4, label: m.$3),
              ),
            ),
        ],
      ),
    );
  }
}

/// E11-US1-UI1: Offers list
/// Must show: Active, scheduled and expired offers and vouchers
class VendorOffersListScreen extends StatelessWidget {
  const VendorOffersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E11-US1-UI1',
      title: 'Offers & vouchers list',
      footer: Wrap(
        spacing: 10,
        children: [
          KhaanaPrimaryButton(
            label: 'Create or edit offer (E11-US1-UI2)',
            icon: Icons.add_rounded,
            onPressed: () => Navigator.pushNamed(context, '/vendor/offers/edit'),
          ),
          KhaanaSecondaryButton(
            label: 'Combo builder (E11-US2-UI1)',
            onPressed: () => Navigator.pushNamed(context, '/vendor/combos'),
          ),
          KhaanaSecondaryButton(
            label: 'Offer performance (E11-US3-UI1)',
            onPressed: () => Navigator.pushNamed(context, '/vendor/offers/performance'),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final o in const [
            ('KHAANA15 · 15% Off Celebration Cakes', 'Min order Rs 1,500 · Limit 100 uses', 'Active', CapacityKind.available),
            ('WEEKEND300 · Rs 300 Fixed Discount', 'Starts Saturday 11:00 AM · Min order Rs 2,500', 'Scheduled', CapacityKind.info),
            ('RAMADAN20 · 20% Iftar Platter', 'Ended 30 Apr 2026 · 84/100 uses', 'Expired', CapacityKind.closed),
          ])
            Card(
              child: ListTile(
                title: Text(o.$1, style: const TextStyle(fontWeight: FontWeight.w800)),
                subtitle: Text(o.$2),
                trailing: CapacityBadge(kind: o.$4, label: o.$3),
              ),
            ),
        ],
      ),
    );
  }
}

/// E11-US1-UI2: Create or edit offer
/// Must show: Percentage or fixed, code, minimum order, usage limit, schedule; end-before-start error (AC2)
class CreateEditOfferScreen extends StatefulWidget {
  const CreateEditOfferScreen({super.key});

  @override
  State<CreateEditOfferScreen> createState() => _CreateEditOfferScreenState();
}

class _CreateEditOfferScreenState extends State<CreateEditOfferScreen> {
  String _type = 'Percentage (15%)';
  final _code = TextEditingController(text: 'KHAANA15');
  final _minOrder = TextEditingController(text: '1500');
  final _limit = TextEditingController(text: '100');
  final _start = TextEditingController(text: '2026-11-10');
  final _end = TextEditingController(text: '2026-11-05');
  String? _error = 'Schedule error: End date (2026-11-05) cannot be earlier than Start date (2026-11-10) (E11-US1 AC2 / TC2).';

  @override
  void dispose() {
    _code.dispose();
    _minOrder.dispose();
    _limit.dispose();
    _start.dispose();
    _end.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E11-US1-UI2',
      title: 'Create or edit offer',
      footer: KhaanaPrimaryButton(
        label: 'Save offer',
        icon: Icons.save_outlined,
        onPressed: _error != null ? null : () => Navigator.pop(context),
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
                  DropdownButtonFormField<String>(
                    initialValue: _type,
                    decoration: const InputDecoration(labelText: 'Discount Type *'),
                    items: const [
                      DropdownMenuItem(value: 'Percentage (15%)', child: Text('Percentage (15%)')),
                      DropdownMenuItem(value: 'Fixed Rupee (Rs 300)', child: Text('Fixed Rupee (Rs 300)')),
                    ],
                    onChanged: (v) {
                      if (v != null) setState(() => _type = v);
                    },
                  ),
                  const SizedBox(height: 12),
                  TextField(controller: _code, decoration: const InputDecoration(labelText: 'Voucher Code *')),
                  const SizedBox(height: 12),
                  TextField(controller: _minOrder, decoration: const InputDecoration(labelText: 'Minimum Order Subtotal (Rs) *')),
                  const SizedBox(height: 12),
                  TextField(controller: _limit, decoration: const InputDecoration(labelText: 'Maximum Redemption Limit *')),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(child: TextField(controller: _start, decoration: const InputDecoration(labelText: 'Start Date *'))),
                      const SizedBox(width: 12),
                      Expanded(child: TextField(controller: _end, decoration: const InputDecoration(labelText: 'End Date *'))),
                    ],
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () => setState(() {
                      _end.text = '2026-11-25';
                      _error = null;
                    }),
                    child: const Text('Fix end date to 2026-11-25 (Valid schedule)'),
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

/// E11-US2-UI1: Combo builder
/// Must show: Choose items, set bundle price, availability follows items (AC1, AC2)
class ComboBuilderScreen extends StatefulWidget {
  const ComboBuilderScreen({super.key});

  @override
  State<ComboBuilderScreen> createState() => _ComboBuilderScreenState();
}

class _ComboBuilderScreenState extends State<ComboBuilderScreen> {
  bool _includeBrownie = true;

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E11-US2-UI1',
      title: 'Combo deal builder',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_includeBrownie)
            const KhaanaInlineBanner(
              kind: CapacityKind.full,
              text:
                  'Combo Availability Rule (E11-US2 AC2): Because constituent item "Brownie box" is currently Sold Out / Paused, the "Celebration Party Bundle" automatically becomes Unavailable.',
            )
          else
            const KhaanaInlineBanner(
              kind: CapacityKind.available,
              text: 'All constituent items are in stock. Combo bundle is Available at Rs 2,750 (saves Rs 350 · E11-US2 AC1).',
            ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Celebration Party Bundle · Bundle Price: Rs 2,750', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 10),
                  const CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    value: true,
                    onChanged: null,
                    title: Text('1× Chocolate Cake (1 lb · Rs 1,850 · Available)'),
                  ),
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    value: _includeBrownie,
                    onChanged: (v) => setState(() => _includeBrownie = v ?? false),
                    title: const Text('1× Brownie Box (Rs 950 · Currently Sold Out)'),
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

/// E11-US3-UI1: Offer performance
/// Must show: Uses, discount given and sales per offer; zero values not errors (AC1, AC2)
class OfferPerformanceScreen extends StatelessWidget {
  const OfferPerformanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E11-US3-UI1',
      title: 'Offer & voucher performance',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const KhaanaInlineBanner(
            kind: CapacityKind.info,
            text: 'Newly created offers with 0 uses display Rs 0 discount and Rs 0 sales cleanly without division-by-zero errors (E11-US3 AC2).',
          ),
          const SizedBox(height: 12),
          for (final perf in const [
            ('KHAANA15 (Active)', 'Uses: 28 · Discount given: Rs 7,420 · Driven sales: Rs 49,460'),
            ('WEEKEND300 (New / Unused · AC2)', 'Uses: 0 · Discount given: Rs 0 · Driven sales: Rs 0'),
          ])
            Card(
              child: ListTile(
                title: Text(perf.$1, style: const TextStyle(fontWeight: FontWeight.w800)),
                subtitle: Text(perf.$2),
              ),
            ),
        ],
      ),
    );
  }
}

/// E18-US2-UI2: Product feedback
/// Must show: Average, count and recent comments per item; date filter (AC3, AC4)
class ProductFeedbackScreen extends StatefulWidget {
  const ProductFeedbackScreen({super.key});

  @override
  State<ProductFeedbackScreen> createState() => _ProductFeedbackScreenState();
}

class _ProductFeedbackScreenState extends State<ProductFeedbackScreen> {
  String _range = 'Last 30 days';

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E18-US2-UI2',
      title: 'Per-dish product feedback',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            children: [
              for (final r in ['Last 7 days', 'Last 30 days', 'All time'])
                ChoiceChip(
                  label: Text(r),
                  selected: _range == r,
                  onSelected: (_) => setState(() => _range = r),
                ),
            ],
          ),
          const SizedBox(height: 12),
          for (final item in const [
            ('Chocolate Cake (1 lb)', '4.9 ★ (86 reviews)', '"Moist Belgian ganache and nut-free exclusion respected!"'),
            ('Lotus Biscoff Bento Cake', '4.7 ★ (41 reviews)', '"Great portion for two; arrived intact in Express box."'),
            ('Brownie Box (×6)', '4.5 ★ (29 reviews)', '"Rich fudge texture, would love slightly less sea salt."'),
          ])
            Card(
              child: ListTile(
                title: Text('${item.$1} · ${item.$2}', style: const TextStyle(fontWeight: FontWeight.w800)),
                subtitle: Text(item.$3),
              ),
            ),
        ],
      ),
    );
  }
}

/// E19-US3-UI2: Vendor assistant (Overlay)
/// Must show: Docked chat: pending orders, stock, capacity; refuses owner-only data for staff (AC1, AC2)
Future<void> showVendorAssistantOverlay(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (context) => const _VendorAssistantSheet(),
  );
}

class _VendorAssistantSheet extends StatefulWidget {
  const _VendorAssistantSheet();

  @override
  State<_VendorAssistantSheet> createState() => _VendorAssistantSheetState();
}

class _VendorAssistantSheetState extends State<_VendorAssistantSheet> {
  String _topic = 'ops';

  @override
  Widget build(BuildContext context) {
    final session = PortalScope.of(context);
    final isStaff = session.isStaff;
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
                decoration: BoxDecoration(color: KhaanaColors.orangeTint, borderRadius: BorderRadius.circular(6)),
                child: const Text('E19-US3-UI2', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: KhaanaColors.onOrangeTint)),
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text('Docked Vendor Operational Assistant', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ChoiceChip(
                label: const Text('Pending orders, stock & capacity (AC1)'),
                selected: _topic == 'ops',
                onSelected: (_) => setState(() => _topic = 'ops'),
              ),
              ChoiceChip(
                label: const Text('Query owner-only net profit & recipes (AC2)'),
                selected: _topic == 'owner_only',
                onSelected: (_) => setState(() => _topic = 'owner_only'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (_topic == 'ops')
            const KhaanaInlineBanner(
              kind: CapacityKind.available,
              text:
                  'Live Kitchen Summary (E19-US3 AC1): 2 active tickets (#123 New custom cake, #121 Preparing cupcakes). Hourly slot load is 72% (9/12 booked · Limited band). Low-stock alerts on Flour (4/5 kg) and Cream (1/2 L).',
            )
          else if (isStaff)
            const KhaanaInlineBanner(
              kind: CapacityKind.full,
              text:
                  'Refused for Staff Role (E19-US3 AC2 / E19-US4-TC2): Kitchen staff accounts cannot query net profit, bank payouts, or proprietary recipe quantities.',
            )
          else
            const KhaanaInlineBanner(
              kind: CapacityKind.info,
              text:
                  'Owner Verified: Net profit today is Rs 24,140 (56.5% margin on Chocolate Cake). Switch to a Staff session to test the AC2 role refusal.',
            ),
          const SizedBox(height: 12),
          KhaanaPrimaryButton(label: 'Close assistant', onPressed: () => Navigator.pop(context)),
        ],
      ),
    );
  }
}

/// E21-US2-UI1: Audit log (owner only)
/// Must show: Read-only entries with timestamp, named employee, task and reason (AC1–AC3).
/// Include employee/date filters and no-results state; staff access is denied and no edit/delete controls exist.
class VendorAuditLogScreen extends StatefulWidget {
  const VendorAuditLogScreen({super.key});

  @override
  State<VendorAuditLogScreen> createState() => _VendorAuditLogScreenState();
}

class _VendorAuditLogScreenState extends State<VendorAuditLogScreen> {
  String _employeeFilter = 'All employees';

  @override
  Widget build(BuildContext context) {
    final session = PortalScope.of(context);
    if (session.isStaff) {
      return const AccessDenied(uiId: 'E1-US3-UI3');
    }
    const entries = [
      ('2026-11-04 18:48', 'Usman Ali (STAFF-04)', 'Stock Intake (+10 kg Flour)', 'Supplier invoice #SUP-441'),
      ('2026-11-04 18:35', 'Usman Ali (STAFF-04)', 'Logged Wastage (0.5 L Cream)', 'Spilled during whipping'),
      ('2026-11-04 18:10', 'Hina Tariq (OWNER)', 'ETA Buffer Override (+20 min)', 'Main deck oven preheating recovery'),
    ];
    final filtered = entries.where((e) {
      if (_employeeFilter == 'All employees') return true;
      return e.$2.contains(_employeeFilter);
    }).toList();

    return KhaanaPage(
      uiId: 'E21-US2-UI1',
      title: 'Immutable audit log (Owner only · Read-only)',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const KhaanaInlineBanner(
            kind: CapacityKind.info,
            icon: Icons.verified_user_outlined,
            text:
                'Append-only Audit Trail (E21-US2 AC1–AC3): Every kitchen action is attributed to a named employee with timestamp and reason. No edit or delete controls exist.',
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: [
              for (final f in ['All employees', 'STAFF-04', 'OWNER', 'STAFF-99 (No results · TC4)'])
                ChoiceChip(
                  label: Text(f),
                  selected: _employeeFilter == f,
                  onSelected: (_) => setState(() => _employeeFilter = f),
                ),
            ],
          ),
          const SizedBox(height: 12),
          if (filtered.isEmpty)
            const KhaanaEmptyState(
              title: 'No audit entries match that filter',
              message: 'No actions were recorded for the selected employee/date filter (E21-US2-TC4).',
            )
          else
            for (final e in filtered)
              Card(
                child: ListTile(
                  leading: const Icon(Icons.lock_clock_outlined, color: KhaanaColors.orangeText),
                  title: Text('${e.$3} · ${e.$2}', style: const TextStyle(fontWeight: FontWeight.w800)),
                  subtitle: Text('${e.$1} · Reason: ${e.$4}'),
                  trailing: const CapacityBadge(kind: CapacityKind.closed, label: 'Read-only'),
                ),
              ),
        ],
      ),
    );
  }
}

/// E22-US2-UI1: Responsive portal layouts (Layout set)
/// Must show: Dashboard, board and tables on phone, tablet and laptop.
/// Include PWA standalone launch view as well as browser layouts.
class ResponsivePortalLayoutsScreen extends StatefulWidget {
  const ResponsivePortalLayoutsScreen({super.key});

  @override
  State<ResponsivePortalLayoutsScreen> createState() => _ResponsivePortalLayoutsScreenState();
}

class _ResponsivePortalLayoutsScreenState extends State<ResponsivePortalLayoutsScreen> {
  String _mode = 'laptop_1280';

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E22-US2-UI1',
      title: 'Responsive portal & PWA standalone layouts',
      maxWidth: 1280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ChoiceChip(
                label: const Text('Phone (360 px · Top Nav + Stacked Kanban)'),
                selected: _mode == 'phone_360',
                onSelected: (_) => setState(() => _mode = 'phone_360'),
              ),
              ChoiceChip(
                label: const Text('Kitchen Tablet (768 px · PWA Standalone)'),
                selected: _mode == 'tablet_768',
                onSelected: (_) => setState(() => _mode = 'tablet_768'),
              ),
              ChoiceChip(
                label: const Text('Owner Laptop (1280 px · Left Rail + 4-Col Kanban)'),
                selected: _mode == 'laptop_1280',
                onSelected: (_) => setState(() => _mode = 'laptop_1280'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const OfflineSyncBanner(),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Active Layout Mode: $_mode', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                      const CapacityBadge(kind: CapacityKind.available, label: 'PWA Standalone Ready'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text('• Dashboard KPI grid, 4-column Kitchen Kanban board, and Stock/Audit tables adapt cleanly across 360px, 768px, and 1280px viewports.'),
                  const Text('• Installed PWA launches in standalone window mode without browser chrome (E22-US2).'),
                  const SizedBox(height: 12),
                  KhaanaSecondaryButton(
                    label: 'Preview Sync Conflict Resolution Dialog (E22-US3-UI2)',
                    icon: Icons.sync_problem_rounded,
                    onPressed: () => showSyncConflictDialog(context),
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

