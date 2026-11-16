import 'package:flutter/material.dart';
import 'package:khaana_design/khaana_design.dart';

import 'scope.dart';
import 'session.dart';

/// E1-US2-UI1: App launch
/// Must show: KhaanaGo Rider mark while session and approval are checked
class RiderAppLaunchScreen extends StatelessWidget {
  const RiderAppLaunchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E1-US2-UI1',
      title: 'Rider app launch',
      footer: KhaanaPrimaryButton(
        label: 'Session & approval verified · Open Home',
        icon: Icons.two_wheeler_rounded,
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
                SizedBox(height: 10),
                CapacityBadge(kind: CapacityKind.available, label: 'RIDER HIGH-CONTRAST EDITION'),
                SizedBox(height: 12),
                Text(
                  'Checking rider session token & administrator document approval status…',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, color: KhaanaColors.mutedDark),
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

/// E1-US2-UI8: Reset password: request
/// Must show: Mobile number
class RiderResetPasswordRequestScreen extends StatefulWidget {
  const RiderResetPasswordRequestScreen({super.key});

  @override
  State<RiderResetPasswordRequestScreen> createState() => _RiderResetPasswordRequestScreenState();
}

class _RiderResetPasswordRequestScreenState extends State<RiderResetPasswordRequestScreen> {
  final _mobile = TextEditingController(text: '0312-9876543');

  @override
  void dispose() {
    _mobile.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E1-US2-UI8',
      title: 'Reset password: Request',
      footer: KhaanaPrimaryButton(
        label: 'Send OTP code (E1-US2-UI9)',
        icon: Icons.sms_outlined,
        onPressed: () => Navigator.pushNamed(context, '/reset-confirm'),
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Enter your registered rider mobile number to receive a 6-digit reset code:', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 12),
              TextField(
                controller: _mobile,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Rider Mobile Number *',
                  prefixIcon: Icon(Icons.phone_android_rounded),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// E1-US2-UI9: Reset password: code and new password
/// Must show: Code and new password
class RiderResetPasswordConfirmScreen extends StatefulWidget {
  const RiderResetPasswordConfirmScreen({super.key});

  @override
  State<RiderResetPasswordConfirmScreen> createState() => _RiderResetPasswordConfirmScreenState();
}

class _RiderResetPasswordConfirmScreenState extends State<RiderResetPasswordConfirmScreen> {
  final _code = TextEditingController(text: '641920');
  final _newPass = TextEditingController(text: 'Rider@2026');
  bool _saved = false;

  @override
  void dispose() {
    _code.dispose();
    _newPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E1-US2-UI9',
      title: 'Reset password: Code & new password',
      footer: KhaanaPrimaryButton(
        label: _saved ? 'Return to Rider Sign-in' : 'Save new password',
        icon: Icons.lock_reset_rounded,
        onPressed: () {
          if (_saved) {
            Navigator.pushReplacementNamed(context, '/sign-in');
          } else {
            setState(() => _saved = true);
          }
        },
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _code,
                decoration: const InputDecoration(labelText: '6-Digit SMS Reset Code *'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _newPass,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'New Password (min 8 chars) *'),
              ),
              if (_saved) ...[
                const SizedBox(height: 12),
                const KhaanaInlineBanner(
                  kind: CapacityKind.available,
                  text: 'Rider password updated! Previous sessions have been invalidated.',
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// E16-US1-UI2: Unanswered check-in warning (Overlay)
/// Must show: Grace-period countdown before support is alerted (AC5, AC6)
Future<void> showUnansweredCheckInWarningDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: KhaanaColors.orangeTintDark, borderRadius: BorderRadius.circular(6)),
            child: const Text('E16-US1-UI2', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: KhaanaColors.orange)),
          ),
          const SizedBox(width: 8),
          const Expanded(child: Text('Unanswered check-in warning')),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          KhaanaInlineBanner(
            kind: CapacityKind.full,
            icon: Icons.warning_amber_rounded,
            text:
                'Grace-Period Countdown: 01:42 remaining before Platform Safety Support is alerted (E16-US1 AC5, AC6).',
          ),
          SizedBox(height: 10),
          Text(
            'You missed the initial voice check-in and the repeat prompt. Tap below or press your headset button now to confirm you are safe.',
          ),
        ],
      ),
      actions: [
        FilledButton.icon(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.check_circle_outline),
          label: const Text('I am safe · Cancel escalation'),
        ),
      ],
    ),
  );
}

/// E16-US3-UI1: Audio prompt settings
/// Must show: Language and speech speed
class AudioPromptSettingsScreen extends StatefulWidget {
  const AudioPromptSettingsScreen({super.key});

  @override
  State<AudioPromptSettingsScreen> createState() => _AudioPromptSettingsScreenState();
}

class _AudioPromptSettingsScreenState extends State<AudioPromptSettingsScreen> {
  String _language = 'Urdu & English (Bilingual)';
  double _speechSpeed = 1.0;

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E16-US3-UI1',
      title: 'Audio prompt settings',
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Hands-Free Voice Prompt Language', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                initialValue: _language,
                decoration: const InputDecoration(labelText: 'Prompt Language *'),
                items: const [
                  DropdownMenuItem(value: 'Urdu & English (Bilingual)', child: Text('Urdu & English (Bilingual)')),
                  DropdownMenuItem(value: 'English (Pakistan)', child: Text('English (Pakistan)')),
                  DropdownMenuItem(value: 'Urdu', child: Text('Urdu')),
                ],
                onChanged: (v) {
                  if (v != null) setState(() => _language = v);
                },
              ),
              const Divider(height: 28),
              Text('Speech Playback Speed: ${_speechSpeed.toStringAsFixed(2)}×', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
              Slider(
                value: _speechSpeed,
                min: 0.75,
                max: 1.5,
                divisions: 3,
                label: '${_speechSpeed.toStringAsFixed(2)}×',
                onChanged: (v) => setState(() => _speechSpeed = v),
              ),
              const Text('Used for 80% prep ready alerts, turn-by-turn cues, and safety voice check-ins.'),
            ],
          ),
        ),
      ),
    );
  }
}

/// E1-US2-UI12: Sign out confirmation (Overlay)
/// Must show: Blocked if a delivery is active
Future<void> showRiderSignOutConfirmationDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (context) => const _RiderSignOutDialog(),
  );
}

class _RiderSignOutDialog extends StatefulWidget {
  const _RiderSignOutDialog();

  @override
  State<_RiderSignOutDialog> createState() => _RiderSignOutDialogState();
}

class _RiderSignOutDialogState extends State<_RiderSignOutDialog> {
  bool _hasActiveDelivery = true;

  @override
  Widget build(BuildContext context) {
    final session = RiderScope.of(context);
    return AlertDialog(
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: KhaanaColors.orangeTintDark, borderRadius: BorderRadius.circular(6)),
            child: const Text('E1-US2-UI12', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: KhaanaColors.orange)),
          ),
          const SizedBox(width: 8),
          const Expanded(child: Text('Sign out confirmation')),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Simulate active delivery in progress'),
            value: _hasActiveDelivery,
            onChanged: (v) => setState(() => _hasActiveDelivery = v),
          ),
          if (_hasActiveDelivery)
            const KhaanaInlineBanner(
              kind: CapacityKind.full,
              text:
                  'Sign-out blocked: You have an active delivery (#KG-1042 · BakeCharm) in progress. Complete handover and 6-digit PIN verification before signing out.',
            )
          else
            const Text('You have no active deliveries. Signing out will take you offline and end your current shift.'),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Stay signed in')),
        FilledButton(
          onPressed: _hasActiveDelivery
              ? null
              : () {
                  session.goOnline(false);
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, '/sign-in');
                },
          child: const Text('Sign out'),
        ),
      ],
    );
  }
}

