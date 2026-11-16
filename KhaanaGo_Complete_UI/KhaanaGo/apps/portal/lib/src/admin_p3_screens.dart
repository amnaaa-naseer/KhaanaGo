import 'package:flutter/material.dart';
import 'package:khaana_design/khaana_design.dart';

/// E20-US2-UI2: Confirm commission change (Overlay)
/// Must show: Old rate, new rate, effective time
Future<void> showConfirmCommissionChangeDialog(
  BuildContext context, {
  String oldRate = '10.0%',
  String newRate = '9.5%',
  String effectiveTime = '2026-11-05 00:00 PKT',
}) {
  return showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: KhaanaColors.orangeTint, borderRadius: BorderRadius.circular(6)),
            child: const Text('E20-US2-UI2', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: KhaanaColors.onOrangeTint)),
          ),
          const SizedBox(width: 8),
          const Expanded(child: Text('Confirm commission change')),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• Previous Commission Rate: $oldRate'),
          Text('• New Commission Rate: $newRate (Within 8–12% band)', style: const TextStyle(fontWeight: FontWeight.w800)),
          Text('• Effective Time: $effectiveTime'),
          const SizedBox(height: 10),
          const Text(
            'Orders placed before the effective time keep the previous commission rate (E20-US2 AC2).',
            style: TextStyle(fontSize: 12, color: KhaanaColors.mutedLight),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        FilledButton(onPressed: () => Navigator.pop(context), child: const Text('Confirm rate change')),
      ],
    ),
  );
}

/// E20-US1-UI9: Tax and invoice settings
/// Must show: Tax rate and invoice number prefix
class TaxInvoiceSettingsScreen extends StatefulWidget {
  const TaxInvoiceSettingsScreen({super.key});

  @override
  State<TaxInvoiceSettingsScreen> createState() => _TaxInvoiceSettingsScreenState();
}

class _TaxInvoiceSettingsScreenState extends State<TaxInvoiceSettingsScreen> {
  final _taxRate = TextEditingController(text: '16.0');
  final _prefix = TextEditingController(text: 'INV-2026-');
  bool _saved = false;

  @override
  void dispose() {
    _taxRate.dispose();
    _prefix.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E20-US1-UI9',
      title: 'Tax & invoice settings',
      footer: KhaanaPrimaryButton(
        label: 'Save tax & invoice format',
        icon: Icons.save_outlined,
        onPressed: () => setState(() => _saved = true),
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _taxRate,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Applicable Sales Tax / GST Rate (%) *'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _prefix,
                decoration: const InputDecoration(labelText: 'Sequential Invoice Number Prefix *'),
              ),
              if (_saved) ...[
                const SizedBox(height: 12),
                KhaanaInlineBanner(
                  kind: CapacityKind.available,
                  text: 'Saved: Next generated invoice will use prefix ${_prefix.text} with ${_taxRate.text}% tax.',
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// E13-US4-UI2: Waiting-time threshold and rate
/// Must show: Free waiting minutes and per-minute rate
class WaitingTimeThresholdRateScreen extends StatefulWidget {
  const WaitingTimeThresholdRateScreen({super.key});

  @override
  State<WaitingTimeThresholdRateScreen> createState() => _WaitingTimeThresholdRateScreenState();
}

class _WaitingTimeThresholdRateScreenState extends State<WaitingTimeThresholdRateScreen> {
  final _freeMinutes = TextEditingController(text: '8');
  final _perMinuteRate = TextEditingController(text: '5');
  bool _saved = false;

  @override
  void dispose() {
    _freeMinutes.dispose();
    _perMinuteRate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E13-US4-UI2',
      title: 'Rider waiting-time threshold & rate',
      footer: KhaanaPrimaryButton(
        label: 'Save waiting-time rules',
        icon: Icons.save_outlined,
        onPressed: () => setState(() => _saved = true),
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _freeMinutes,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Free Store Waiting Window (Minutes) *'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _perMinuteRate,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Excess Waiting Compensation Rate (Rs / minute) *'),
              ),
              if (_saved) ...[
                const SizedBox(height: 12),
                KhaanaInlineBanner(
                  kind: CapacityKind.available,
                  text: 'Saved: Riders earn Rs ${_perMinuteRate.text}/min after the first ${_freeMinutes.text} free waiting minutes at the store.',
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// E14-US1-UI3: Pooling rules
/// Must show: Max orders = 2, pickup radius, hold limit, discount %
class PoolingRulesScreen extends StatefulWidget {
  const PoolingRulesScreen({super.key});

  @override
  State<PoolingRulesScreen> createState() => _PoolingRulesScreenState();
}

class _PoolingRulesScreenState extends State<PoolingRulesScreen> {
  final _pickupRadiusKm = TextEditingController(text: '1.0');
  final _holdLimitMin = TextEditingController(text: '10');
  final _discountPercent = TextEditingController(text: '30');
  bool _saved = false;

  @override
  void dispose() {
    _pickupRadiusKm.dispose();
    _holdLimitMin.dispose();
    _discountPercent.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E14-US1-UI3',
      title: 'Order pooling rules',
      footer: KhaanaPrimaryButton(
        label: 'Save pooling parameters',
        icon: Icons.save_outlined,
        onPressed: () => setState(() => _saved = true),
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                readOnly: true,
                controller: TextEditingController(text: '2 orders maximum per pooled trip (Hard architectural cap)'),
                decoration: const InputDecoration(labelText: 'Maximum Orders per Pooled Trip (Read-only)'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _pickupRadiusKm,
                decoration: const InputDecoration(labelText: 'Max Distance Between Pickups (km) *'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _holdLimitMin,
                decoration: const InputDecoration(labelText: 'Second Pickup Maximum Hold Limit (Minutes) *'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _discountPercent,
                decoration: const InputDecoration(labelText: 'Customer Pooled Delivery Fee Discount (%) *'),
              ),
              if (_saved) ...[
                const SizedBox(height: 12),
                const KhaanaInlineBanner(
                  kind: CapacityKind.available,
                  text: 'Pooling rules saved. Fragile cakes and spillable items remain excluded from pooling.',
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// E16-US1-UI4: Safety check-in rules
/// Must show: Stationary minutes and grace period before escalation
class SafetyCheckInRulesScreen extends StatefulWidget {
  const SafetyCheckInRulesScreen({super.key});

  @override
  State<SafetyCheckInRulesScreen> createState() => _SafetyCheckInRulesScreenState();
}

class _SafetyCheckInRulesScreenState extends State<SafetyCheckInRulesScreen> {
  final _stationaryMin = TextEditingController(text: '5');
  final _gracePeriodMin = TextEditingController(text: '3');
  bool _saved = false;

  @override
  void dispose() {
    _stationaryMin.dispose();
    _gracePeriodMin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E16-US1-UI4',
      title: 'Rider safety check-in rules',
      footer: KhaanaPrimaryButton(
        label: 'Save safety check-in thresholds',
        icon: Icons.save_outlined,
        onPressed: () => setState(() => _saved = true),
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _stationaryMin,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Unplanned Stationary Trigger Threshold (Minutes) *'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _gracePeriodMin,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Grace Period After Repeat Prompt Before Escalation (Minutes) *'),
              ),
              if (_saved) ...[
                const SizedBox(height: 12),
                KhaanaInlineBanner(
                  kind: CapacityKind.available,
                  text:
                      'Saved: Voice check-in fires after ${_stationaryMin.text} stationary minutes and escalates to E16-US1-UI3 after a ${_gracePeriodMin.text}-minute grace period.',
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

