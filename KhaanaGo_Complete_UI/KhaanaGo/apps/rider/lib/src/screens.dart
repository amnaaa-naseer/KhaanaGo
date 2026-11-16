import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khaana_design/khaana_design.dart';

import 'p2_screens.dart';
import 'scope.dart';
import 'session.dart';

class RiderSignInScreen extends StatefulWidget {
  const RiderSignInScreen({super.key});

  @override
  State<RiderSignInScreen> createState() => _RiderSignInScreenState();
}

class _RiderSignInScreenState extends State<RiderSignInScreen> {
  final _mobile = TextEditingController();
  final _password = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _mobile.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E1-US2-UI2',
      title: 'Sign in',
      footer: KhaanaPrimaryButton(
        label: 'Sign in',
        icon: Icons.two_wheeler_rounded,
        onPressed: () {
          if (_mobile.text.trim().isEmpty || _password.text.isEmpty) {
            setState(() => _error = 'Enter your mobile number and password.');
            return;
          }
          Navigator.pushReplacementNamed(context, '/home');
        },
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF141414),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: KhaanaColors.lineDark),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const KhaanaLogo(size: 56, borderRadius: 16),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const KhaanaWordmark(height: 28),
                          const SizedBox(height: 6),
                          const Text(
                            'RIDER HIGH-CONTRAST EDITION',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.8,
                              color: KhaanaColors.onOrangeTintDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Rider Fleet Login', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                    TextButton.icon(
                      onPressed: () {
                        setState(() {
                          _mobile.text = '03129876543';
                          _password.text = 'rider123';
                          _error = null;
                        });
                      },
                      icon: const Icon(Icons.auto_fix_high_rounded, size: 18),
                      label: const Text('Demo fill'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text('Mobile', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 6),
                TextField(
                  controller: _mobile,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    hintText: '03129876543',
                    prefixIcon: Icon(Icons.phone_android_rounded),
                  ),
                ),
                const SizedBox(height: 14),
                const Text('Password', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 6),
                TextField(
                  controller: _password,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: '••••••••',
                    prefixIcon: Icon(Icons.lock_outline_rounded),
                  ),
                ),
                if (_error != null) ...[
                  const SizedBox(height: 12),
                  KhaanaInlineBanner(text: _error!),
                ],
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/reg-1'),
                      child: const Text('Apply as Rider (E1-US2-UI3)'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/pending-verification'),
                      child: const Text('Pending review (E1-US2-UI6)'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/application-rejected'),
                      child: const Text('Rejected / Resubmit (E1-US2-UI7)'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/reset-request'),
                      child: const Text('Reset password (E1-US2-UI8)'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/launch'),
                      child: const Text('App launch (E1-US2-UI1)'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const ProvisionalNote(
            text: 'This sign-in does not verify a rider account. Approval state stays a backend check.',
          ),
        ],
      ),
    );
  }
}

class RiderHomeScreen extends StatelessWidget {
  const RiderHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final session = RiderScope.of(context);
    final earnings = session.deliveriesToday * (RiderSession.basePay + RiderSession.distancePay);
    return KhaanaPage(
      uiId: 'E13-US2-UI2',
      title: 'Home',
      footer: KhaanaPrimaryButton(
        label: 'View offer',
        icon: Icons.notifications_active_rounded,
        onPressed: session.online ? () => Navigator.pushNamed(context, '/offer') : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFF141414),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: session.online ? KhaanaColors.availableDark : KhaanaColors.lineDark,
                width: 2,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    session.online ? 'Online' : 'Offline',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: session.online ? KhaanaColors.availableDark : KhaanaColors.cream,
                    ),
                  ),
                  subtitle: Text(
                    session.online
                        ? 'Ready for kitchen-timed dispatch offers'
                        : 'Switch online to receive orders at 80% prep',
                    style: const TextStyle(fontSize: 15, color: KhaanaColors.mutedDark),
                  ),
                  value: session.online,
                  onChanged: session.goOnline,
                ),
                const Divider(height: 24),
                Wrap(
                  spacing: 12,
                  runSpacing: 10,
                  children: [
                    CapacityBadge(kind: CapacityKind.info, label: 'Vehicle ${session.vehicle}'),
                    CapacityBadge(
                      kind: CapacityKind.available,
                      label: "Today's deliveries ${session.deliveriesToday}",
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Earnings so far ${formatRupees(earnings)}',
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          if (!session.online)
            KhaanaEmptyState(
              title: 'Go online to receive an offer.',
              message: 'Toggle your shift status above when your motorbike is ready.',
              icon: Icons.two_wheeler_rounded,
              actionLabel: 'Go online now',
              onAction: () => session.goOnline(true),
            )
          else
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: KhaanaColors.orangeTintDark,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: KhaanaColors.orange, width: 2),
              ),
              child: const Row(
                children: [
                  Icon(Icons.bolt_rounded, color: KhaanaColors.orange, size: 32),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('1 Delivery Offer Ready', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                        Text('BakeCharm · F-11 Markaz · 3.2 km', style: TextStyle(fontSize: 15)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          const ProvisionalNote(
            text: 'Earnings figures are sample data. The waiting-pay rate is not decided.',
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ActionChip(
                label: const Text('Location permission (E13-US2-UI1)'),
                onPressed: () => showLocationPermissionDialog(context),
              ),
              ActionChip(
                label: const Text('Outside area (E13-US2-UI3)'),
                onPressed: () => showOutsideServiceAreaDialog(context),
              ),
              ActionChip(
                label: const Text('Pooled offer (E14-US1-UI1)'),
                onPressed: () => Navigator.pushNamed(context, '/pooled-offer'),
              ),
              ActionChip(
                label: const Text('Offer expired (E13-US2-UI5)'),
                onPressed: () => showOfferExpiredDialog(context),
              ),
              ActionChip(
                label: const Text('Voice assistant (E19-US3-UI1)'),
                onPressed: () => showRiderVoiceAssistantSheet(context),
              ),
              ActionChip(
                label: const Text('Shift summary (E13-US2-UI6)'),
                onPressed: () => Navigator.pushNamed(context, '/shift-summary'),
              ),
              ActionChip(
                label: const Text('History (E1-US2-UI10)'),
                onPressed: () => Navigator.pushNamed(context, '/history'),
              ),
              ActionChip(
                label: const Text('Ratings (E18-US2-UI1)'),
                onPressed: () => Navigator.pushNamed(context, '/ratings'),
              ),
              ActionChip(
                label: const Text('Profile & settings (E1-US2-UI11)'),
                onPressed: () => Navigator.pushNamed(context, '/profile'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OfferScreen extends StatefulWidget {
  const OfferScreen({super.key});

  @override
  State<OfferScreen> createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  static const _seconds = 45;
  late int _left = _seconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_left == 0) {
        timer.cancel();
      } else {
        setState(() => _left -= 1);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final session = RiderScope.of(context);
    final open = _left > 0;
    final totalPay = RiderSession.basePay + RiderSession.distancePay + RiderSession.rainPay;
    return KhaanaPage(
      uiId: 'E13-US2-UI4',
      title: 'Delivery offer',
      footer: Row(
        children: [
          Expanded(
            child: KhaanaSecondaryButton(
              label: 'Decline',
              onPressed: () {
                session.declineOffer();
                Navigator.pop(context);
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: KhaanaPrimaryButton(
              label: 'Accept',
              onPressed: open
                  ? () {
                      session.acceptOffer();
                      Navigator.pushReplacementNamed(context, '/pickup');
                    }
                  : null,
            ),
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF141414),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: KhaanaColors.lineDark),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CapacityBadge(
                  kind: open ? CapacityKind.limited : CapacityKind.full,
                  label: open ? 'Offer closes in $_left s' : 'This offer has closed.',
                ),
                const CapacityBadge(kind: CapacityKind.info, label: 'Express · 1 stop'),
              ],
            ),
            const SizedBox(height: 14),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: _left / _seconds,
                minHeight: 8,
                backgroundColor: KhaanaColors.lineDark,
                valueColor: const AlwaysStoppedAnimation<Color>(KhaanaColors.orange),
              ),
            ),
            const SizedBox(height: 16),
            const Text('BakeCharm', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
            const SizedBox(height: 4),
            const Text('Drop-off F-11 Markaz · 3.2 km', style: TextStyle(fontSize: 20, color: Color(0xFFC9BFB3))),
            const Divider(height: 28),
            Text(
              'Pay ${formatRupees(totalPay)}',
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: KhaanaColors.availableDark),
            ),
            const SizedBox(height: 4),
            Text(
              'Includes Base Rs ${RiderSession.basePay} + Distance Rs ${RiderSession.distancePay} + Rain Rs ${RiderSession.rainPay}',
              style: const TextStyle(fontSize: 14, color: KhaanaColors.mutedDark),
            ),
            const ProvisionalNote(text: 'The pay amount is sample data for the offer card.'),
          ],
        ),
      ),
    );
  }
}

class PickupScreen extends StatelessWidget {
  const PickupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final session = RiderScope.of(context);
    final ready = session.prepPercent >= 80;
    return KhaanaPage(
      uiId: 'E13-US1-UI1',
      title: 'Head to pickup',
      footer: KhaanaPrimaryButton(
        label: 'Kitchen is ready',
        icon: Icons.storefront_rounded,
        onPressed: ready ? () => Navigator.pushNamed(context, '/ready') : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF141414),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: KhaanaColors.lineDark),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'PICKUP IN 4 MIN',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, letterSpacing: 0.8, color: Color(0xFFC9BFB3)),
                ),
                const SizedBox(height: 4),
                Text(
                  'BakeCharm · preparation ${session.prepPercent}%',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 4),
                Text(session.vendorAddress, style: const TextStyle(fontSize: 18, color: Color(0xFFC9BFB3))),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: session.prepPercent / 100,
                    minHeight: 10,
                    backgroundColor: KhaanaColors.lineDark,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      ready ? KhaanaColors.availableDark : KhaanaColors.orange,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Dispatch waits until the kitchen reaches 80% or Ready. No early assignment.',
                  style: TextStyle(fontSize: 15),
                ),
                if (!ready) ...[
                  const SizedBox(height: 10),
                  KhaanaSecondaryButton(
                    label: 'Mock kitchen: mark 80% prepared',
                    icon: Icons.check_circle_outline_rounded,
                    onPressed: session.markKitchenReady,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 12),
          SimulatedMap(address: session.vendorAddress, restored: session.mapVisible, onRetry: session.toggleMap),
          const ProvisionalNote(
            text: 'The kitchen signal is local mock state. Nearest-rider assignment is not calculated here.',
          ),
        ],
      ),
    );
  }
}

class ReadyAlertScreen extends StatelessWidget {
  const ReadyAlertScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E13-US1-UI2',
      title: 'Order ready',
      footer: KhaanaPrimaryButton(
        label: 'I am at the store',
        icon: Icons.pin_drop_rounded,
        onPressed: () {
          RiderScope.of(context).arriveAtStore();
          Navigator.pushReplacementNamed(context, '/at-store');
        },
      ),
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: const Color(0xFF141414),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: KhaanaColors.availableDark, width: 2),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CapacityBadge(kind: CapacityKind.available, label: '80% PREP REACHED'),
            SizedBox(height: 12),
            Text('Order ready for pickup', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
            SizedBox(height: 8),
            Text('BakeCharm · chocolate cake', style: TextStyle(fontSize: 20, color: Color(0xFFC9BFB3))),
            SizedBox(height: 12),
            Text(
              'Sound and vibration are device signals. This mock shows the text alert only.',
              style: TextStyle(fontSize: 15, color: KhaanaColors.mutedDark),
            ),
          ],
        ),
      ),
    );
  }
}

class AtStoreScreen extends StatefulWidget {
  const AtStoreScreen({super.key});

  @override
  State<AtStoreScreen> createState() => _AtStoreScreenState();
}

class _AtStoreScreenState extends State<AtStoreScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final session = RiderScope.of(context);
    final waited = session.waited;
    final clock = '${waited.inMinutes}:${(waited.inSeconds % 60).toString().padLeft(2, '0')}';
    final arrived = session.arrivedAt;
    return KhaanaPage(
      uiId: 'E13-US4-UI1',
      title: 'At the store',
      footer: KhaanaPrimaryButton(
        label: 'Check the order',
        icon: Icons.inventory_rounded,
        onPressed: () => Navigator.pushNamed(context, '/handover'),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF141414),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: KhaanaColors.lineDark),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              arrived == null
                  ? 'Arrival not recorded'
                  : 'Arrived ${arrived.hour}:${arrived.minute.toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 15, color: Color(0xFFC9BFB3)),
            ),
            const SizedBox(height: 6),
            Text(
              'Waiting $clock',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                fontFeatures: [FontFeature.tabularFigures()],
              ),
            ),
            const SizedBox(height: 8),
            const Text('Free waiting is 8 minutes. Pay is only for time after that.'),
            const SizedBox(height: 6),
            Text(
              session.excessWaitingSeconds == 0
                  ? 'No waiting pay yet. The rate per minute has not been decided.'
                  : 'Excess ${session.excessWaitingSeconds ~/ 60} min. The rupee rate has not been decided.',
              style: const TextStyle(color: KhaanaColors.onOrangeTintDark, fontWeight: FontWeight.w700),
            ),
            const ProvisionalNote(
              text: 'The 8-minute threshold is provisional. Do not show a rupee waiting amount.',
            ),
          ],
        ),
      ),
    );
  }
}

class HandoverScreen extends StatelessWidget {
  const HandoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final session = RiderScope.of(context);
    return KhaanaPage(
      uiId: 'E13-US1-UI3',
      title: 'Pickup',
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF141414),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: KhaanaColors.lineDark),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CapacityBadge(kind: CapacityKind.limited, label: 'FRAGILE CAKE BOX'),
            const SizedBox(height: 10),
            Text('Order ${session.code}', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
            const SizedBox(height: 4),
            const Text('Chocolate cake, 1 lb', style: TextStyle(fontSize: 20, color: Color(0xFFC9BFB3))),
            const SizedBox(height: 8),
            const Text('Check the parcel before confirming.'),
            const SizedBox(height: 20),
            HoldButton(
              label: 'Hold to confirm picked up',
              doneLabel: 'Picked up',
              onConfirmed: () {
                session.confirmPickup();
                Navigator.pushNamed(context, '/dropoff');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DropOffScreen extends StatelessWidget {
  const DropOffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final session = RiderScope.of(context);
    return KhaanaPage(
      uiId: 'E13-US3-UI1',
      title: 'Head to drop-off',
      footer: KhaanaPrimaryButton(
        label: 'Enter delivery code',
        icon: Icons.dialpad_rounded,
        onPressed: () => Navigator.pushNamed(context, '/code'),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF141414),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: KhaanaColors.lineDark),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ACTIVE DROP-OFF',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, letterSpacing: 0.8, color: Color(0xFFC9BFB3)),
                ),
                const SizedBox(height: 4),
                const Text('Customer area F-11 Markaz', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ActionChip(
                      label: const Text("I'm outside"),
                      onPressed: () => _message(context, "Preset queued: I'm outside"),
                    ),
                    ActionChip(
                      label: const Text('Running late'),
                      onPressed: () => _message(context, 'Preset queued: Running late'),
                    ),
                    ActionChip(
                      label: const Text('Quick messages (E16-US4-UI2)'),
                      onPressed: () => showQuickMessagesSheet(context),
                    ),
                    ActionChip(
                      label: const Text('Request pin fix (E16-US4-UI3)'),
                      onPressed: () => showRequestCorrectedPinDialog(context),
                    ),
                    ActionChip(
                      label: const Text('Voice check-in (E16-US1-UI1)'),
                      onPressed: () => showVoiceCheckInDialog(context),
                    ),
                    ActionChip(
                      label: const Text('Collect COD (E10-US2-UI2)'),
                      onPressed: () => Navigator.pushNamed(context, '/collect-cash'),
                    ),
                    ActionChip(
                      label: const Text('Out-of-seq (E13-US3-UI3)'),
                      onPressed: () => showOutOfSequenceDialog(context),
                    ),
                    ActionChip(
                      label: const Text('Report problem (E18-US3-UI3)'),
                      onPressed: () => Navigator.pushNamed(context, '/report-problem'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SimulatedMap(address: session.address, restored: session.mapVisible, onRetry: session.toggleMap),
        ],
      ),
    );
  }

  void _message(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}

class CodeScreen extends StatefulWidget {
  const CodeScreen({super.key});

  @override
  State<CodeScreen> createState() => _CodeScreenState();
}

class _CodeScreenState extends State<CodeScreen> {
  final _code = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final session = RiderScope.of(context);
    return KhaanaPage(
      uiId: 'E13-US3-UI2',
      title: 'Delivery code',
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF141414),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: KhaanaColors.lineDark),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Text(
                    'Ask the customer for the 6-digit code.',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    _code.text = session.code;
                    session.setCode(session.code);
                    setState(() => _error = null);
                  },
                  child: Text('Demo: ${session.code}'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _code,
              keyboardType: TextInputType.number,
              maxLength: PrototypeAssumptions.deliveryCodeLength,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                letterSpacing: 6,
                fontFeatures: [FontFeature.tabularFigures()],
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: session.setCode,
            ),
            if (_error != null) ...[
              const SizedBox(height: 8),
              KhaanaInlineBanner(text: _error!),
            ],
            const SizedBox(height: 12),
            KhaanaSecondaryButton(
              label: 'Check code',
              icon: Icons.verified_user_outlined,
              onPressed: () {
                final ok = session.submitCode();
                setState(() => _error = ok ? null : 'That code is wrong. Delivery stays incomplete.');
              },
            ),
            if (_error != null)
              TextButton(
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Contact support is not connected in this mock.')),
                ),
                child: const Text('Contact support'),
              ),
            const SizedBox(height: 16),
            if (session.codeAccepted)
              HoldButton(
                label: 'Hold to confirm delivered',
                doneLabel: 'Delivered',
                onConfirmed: () {
                  session.confirmDelivered();
                  Navigator.pushNamed(context, '/delivered');
                },
              ),
            const ProvisionalNote(text: 'The 6-digit code is a provisional format awaiting review.'),
          ],
        ),
      ),
    );
  }
}

class DeliveredScreen extends StatelessWidget {
  const DeliveredScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final session = RiderScope.of(context);
    final lines = <(String, int)>[
      ('Base', RiderSession.basePay),
      ('Distance', RiderSession.distancePay),
      ('Rain surcharge', RiderSession.rainPay),
    ];
    return KhaanaPage(
      uiId: 'E13-US3-UI4',
      title: 'Delivered',
      footer: KhaanaPrimaryButton(
        label: 'Back to Rider Home',
        icon: Icons.home_rounded,
        onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF141414),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: KhaanaColors.availableDark, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.check_circle_rounded, color: KhaanaColors.availableDark, size: 32),
                SizedBox(width: 10),
                Text('Trip Completed!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
              ],
            ),
            const Divider(height: 24),
            PriceLines(lines: lines, total: RiderSession.basePay + RiderSession.distancePay + RiderSession.rainPay),
            const SizedBox(height: 12),
            Text(
              session.excessWaitingSeconds == 0
                  ? 'Waiting pay: none. Time is inside the 8-minute threshold.'
                  : 'Waiting pay: ${session.excessWaitingSeconds ~/ 60} excess minutes. Rate not decided, so no rupee amount is shown.',
              style: const TextStyle(fontSize: 15, color: Color(0xFFC9BFB3)),
            ),
          ],
        ),
      ),
    );
  }
}
