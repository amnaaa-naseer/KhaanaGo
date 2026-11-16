import 'package:flutter/material.dart';
import 'package:khaana_design/khaana_design.dart';

import 'scope.dart';
import 'session.dart';

class AdminSignInScreen extends StatefulWidget {
  const AdminSignInScreen({super.key});

  @override
  State<AdminSignInScreen> createState() => _AdminSignInScreenState();
}

class _AdminSignInScreenState extends State<AdminSignInScreen> {
  final _id = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _id.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final session = PortalScope.of(context);
    return KhaanaPage(
      uiId: 'E1-US3-UI8',
      title: 'Admin sign-in',
      footer: KhaanaPrimaryButton(
        label: 'Sign in',
        icon: Icons.admin_panel_settings_rounded,
        onPressed: session.adminLocked
            ? null
            : () {
                if (_id.text.trim().isEmpty || _password.text.isEmpty) return;
                final ok = session.tryAdmin(_password.text);
                if (ok) Navigator.pushReplacementNamed(context, '/admin/dashboard');
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
                    children: [
                      const KhaanaLogo(size: 44, borderRadius: 12),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Platform Operations Console', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                            Text('Monitor regional slot capacity, delays & ETA buffers', style: TextStyle(fontSize: 12, color: KhaanaColors.mutedLight)),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _id.text = 'admin@khaanago.pk';
                            _password.text = 'admin123';
                          });
                        },
                        child: const Text('Demo fill'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextField(controller: _id, decoration: const InputDecoration(labelText: 'Email')),
                  const SizedBox(height: 12),
                  TextField(controller: _password, obscureText: true, decoration: const InputDecoration(labelText: 'Password')),
                  if (session.adminLocked) ...[
                    const SizedBox(height: 12),
                    const KhaanaInlineBanner(
                      kind: CapacityKind.full,
                      text: 'This account is temporarily locked. The owner notice is not sent by this mock.',
                    ),
                  ],
                ],
              ),
            ),
          ),
          const ProvisionalNote(
            text: 'Type the password wrong six times to preview the lockout message. The lock duration is not a Chapter 2 number.',
          ),
        ],
      ),
    );
  }
}

class BufferListScreen extends StatelessWidget {
  const BufferListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final session = PortalScope.of(context);
    return KhaanaPage(
      uiId: 'E6-US3-UI1',
      title: 'Buffer rules',
      footer: KhaanaPrimaryButton(
        label: 'Add rule',
        icon: Icons.add_rounded,
        onPressed: () => Navigator.pushNamed(context, '/admin/buffers/edit'),
      ),
      child: Column(
        children: [
          for (final rule in session.rules)
            Card(
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: KhaanaColors.orangeTint,
                  child: Icon(Icons.tune_rounded, color: KhaanaColors.onOrangeTint),
                ),
                title: Text(rule.name, style: const TextStyle(fontWeight: FontWeight.w800)),
                subtitle: Text('${rule.period} · ${rule.area} · ${rule.percent}%'),
                trailing: CapacityBadge(kind: CapacityKind.info, label: '+${rule.percent}% ETA'),
                onTap: () => Navigator.pushNamed(context, '/admin/buffers/edit', arguments: rule),
              ),
            ),
        ],
      ),
    );
  }
}

class BufferEditorScreen extends StatefulWidget {
  const BufferEditorScreen({super.key, this.existing});

  final BufferRule? existing;

  @override
  State<BufferEditorScreen> createState() => _BufferEditorScreenState();
}

class _BufferEditorScreenState extends State<BufferEditorScreen> {
  late final TextEditingController _name;
  late final TextEditingController _period;
  late final TextEditingController _area;
  late final TextEditingController _percent;

  @override
  void initState() {
    super.initState();
    final rule = widget.existing;
    _name = TextEditingController(text: rule?.name ?? '');
    _period = TextEditingController(text: rule?.period ?? '');
    _area = TextEditingController(text: rule?.area ?? '');
    _percent = TextEditingController(text: rule == null ? '' : '${rule.percent}');
  }

  @override
  void dispose() {
    _name.dispose();
    _period.dispose();
    _area.dispose();
    _percent.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E6-US3-UI2',
      title: 'Buffer rule',
      footer: KhaanaPrimaryButton(
        label: 'Save rule',
        icon: Icons.save_outlined,
        onPressed: () {
          final percent = int.tryParse(_percent.text);
          if (_name.text.trim().isEmpty || _period.text.trim().isEmpty || _area.text.trim().isEmpty || percent == null) {
            return;
          }
          final session = PortalScope.of(context);
          final rule = widget.existing;
          if (rule == null) {
            session.saveRule(
              BufferRule(
                name: _name.text.trim(),
                period: _period.text.trim(),
                area: _area.text.trim(),
                percent: percent,
              ),
            );
          } else {
            rule.name = _name.text.trim();
            rule.period = _period.text.trim();
            rule.area = _area.text.trim();
            rule.percent = percent;
            session.saveRule(rule);
          }
          Navigator.pop(context);
        },
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(controller: _name, decoration: const InputDecoration(labelText: 'Name')),
              const SizedBox(height: 12),
              TextField(controller: _period, decoration: const InputDecoration(labelText: 'Period')),
              const SizedBox(height: 12),
              TextField(controller: _area, decoration: const InputDecoration(labelText: 'Area')),
              const SizedBox(height: 12),
              TextField(
                controller: _percent,
                decoration: const InputDecoration(labelText: 'Percentage'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E20-US4-UI1',
      title: 'Platform monitor',
      maxWidth: 960,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Islamabad Live Operations', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                      CapacityBadge(kind: CapacityKind.limited, label: 'Rain Buffer Active'),
                    ],
                  ),
                  Divider(height: 24),
                  Text('Active orders 18', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                  SizedBox(height: 6),
                  Text('Delayed orders 3', style: TextStyle(fontSize: 15, color: KhaanaColors.full, fontWeight: FontWeight.w700)),
                  SizedBox(height: 6),
                  Text('Riders online 7', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                  SizedBox(height: 6),
                  Text('Slot utilisation 72% · Limited intake', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          const KitchenCapacityMeter(
            title: 'F-11 Markaz Sector Aggregate Slot Load',
            booked: 9,
            limit: 12,
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              KhaanaSecondaryButton(
                label: 'Verification Queue (E20-US1-UI5)',
                icon: Icons.verified_user_outlined,
                onPressed: () => Navigator.pushNamed(context, '/admin/verification-queue'),
              ),
              KhaanaSecondaryButton(
                label: 'Partner Fleets & IVR (E14-US4-UI1)',
                icon: Icons.local_shipping_outlined,
                onPressed: () => Navigator.pushNamed(context, '/admin/fleets'),
              ),
              KhaanaSecondaryButton(
                label: 'Commission 8–12% (E20-US2-UI1)',
                icon: Icons.percent_rounded,
                onPressed: () => Navigator.pushNamed(context, '/admin/commission'),
              ),
              KhaanaSecondaryButton(
                label: 'Users & Suspension (E20-US3-UI1)',
                icon: Icons.people_outline_rounded,
                onPressed: () => Navigator.pushNamed(context, '/admin/users'),
              ),
              KhaanaSecondaryButton(
                label: 'Complaints Queue (E20-US3-UI4)',
                icon: Icons.support_agent_rounded,
                onPressed: () => Navigator.pushNamed(context, '/admin/complaints'),
              ),
              KhaanaSecondaryButton(
                label: 'Reports & Export (E20-US4-UI2)',
                icon: Icons.assessment_outlined,
                onPressed: () => Navigator.pushNamed(context, '/admin/reports'),
              ),
              KhaanaSecondaryButton(
                label: 'Safety Escalations (E16-US1-UI3)',
                icon: Icons.health_and_safety_outlined,
                onPressed: () => Navigator.pushNamed(context, '/admin/safety'),
              ),
              KhaanaSecondaryButton(
                label: 'Audit Investigation (E21-US3-UI1)',
                icon: Icons.policy_outlined,
                onPressed: () => Navigator.pushNamed(context, '/admin/audit-investigation'),
              ),
              KhaanaSecondaryButton(
                label: 'Tax & Invoice Settings (E20-US1-UI9)',
                icon: Icons.receipt_long_outlined,
                onPressed: () => Navigator.pushNamed(context, '/admin/tax-settings'),
              ),
              KhaanaSecondaryButton(
                label: 'Waiting-Time Rules (E13-US4-UI2)',
                icon: Icons.timer_outlined,
                onPressed: () => Navigator.pushNamed(context, '/admin/waiting-rules'),
              ),
              KhaanaSecondaryButton(
                label: 'Pooling Rules (E14-US1-UI3)',
                icon: Icons.merge_type_rounded,
                onPressed: () => Navigator.pushNamed(context, '/admin/pooling-rules'),
              ),
              KhaanaSecondaryButton(
                label: 'Safety Check-in Rules (E16-US1-UI4)',
                icon: Icons.shield_outlined,
                onPressed: () => Navigator.pushNamed(context, '/admin/safety-rules'),
              ),
            ],
          ),
          const ProvisionalNote(text: 'Counts are sample data. They are not a live platform feed.'),
        ],
      ),
    );
  }
}
