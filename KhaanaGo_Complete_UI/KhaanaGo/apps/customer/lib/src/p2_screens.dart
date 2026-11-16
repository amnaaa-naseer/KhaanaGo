import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khaana_design/khaana_design.dart';

import 'p3_screens.dart';
import 'scope.dart';
import 'session.dart';

/// E1-US1-UI1: Registration
/// Must show: Name, mobile, email, password strength rules; duplicate email/number,
/// invalid inputs and minimum-password boundary states (E1-US1).
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _name = TextEditingController(text: 'Ayesha Khan');
  final _mobile = TextEditingController(text: '03001234567');
  final _email = TextEditingController(text: 'ayesha@example.com');
  final _password = TextEditingController(text: 'Khaana@2026');
  String? _error;
  bool _duplicateBlocked = false;

  @override
  void dispose() {
    _name.dispose();
    _mobile.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  bool get _hasMinLen => _password.text.length >= PrototypeAssumptions.passwordMinCharacters;
  bool get _hasUpperAndNumber =>
      RegExp(r'[A-Z]').hasMatch(_password.text) && RegExp(r'[0-9]').hasMatch(_password.text);
  bool get _hasSymbol => RegExp(r'[^A-Za-z0-9]').hasMatch(_password.text);

  void _submit() {
    final name = _name.text.trim();
    final mobile = _mobile.text.trim();
    final email = _email.text.trim();
    final pwd = _password.text;

    if (name.isEmpty || mobile.isEmpty || email.isEmpty || pwd.isEmpty) {
      setState(() {
        _duplicateBlocked = false;
        _error = 'All fields (name, mobile number, email and password) are required.';
      });
      return;
    }
    if (!email.contains('@') || !email.contains('.')) {
      setState(() {
        _duplicateBlocked = false;
        _error = 'Enter a valid email address.';
      });
      return;
    }
    if (mobile == '03009999999' || email.toLowerCase() == 'duplicate@example.com') {
      setState(() {
        _duplicateBlocked = true;
        _error = 'Number or email already registered. No duplicate account was created (E1-US1-TC2).';
      });
      return;
    }
    if (pwd.length < PrototypeAssumptions.passwordMinCharacters) {
      setState(() {
        _duplicateBlocked = false;
        _error =
            'Password is ${pwd.length} characters (N−1 boundary). Minimum required is ${PrototypeAssumptions.passwordMinCharacters} characters (E1-US1-TC6).';
      });
      return;
    }
    if (!_hasUpperAndNumber || !_hasSymbol) {
      setState(() {
        _duplicateBlocked = false;
        _error = 'Password must include an uppercase letter, a digit, and a symbol.';
      });
      return;
    }
    setState(() {
      _duplicateBlocked = false;
      _error = null;
    });
    Navigator.pushNamed(context, '/verify');
  }

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E1-US1-UI1',
      title: 'Create customer account',
      footer: KhaanaPrimaryButton(
        label: 'Register & send verification code',
        icon: Icons.person_add_alt_1_rounded,
        onPressed: _submit,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Customer Registration', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 6),
                  const Text(
                    'Register with your name, unique mobile number, email and a strong password.',
                    style: TextStyle(fontSize: 13, color: KhaanaColors.mutedLight),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ActionChip(
                        label: const Text('Valid inputs (TC1)'),
                        onPressed: () => setState(() {
                          _name.text = 'Ayesha Khan';
                          _mobile.text = '03001234567';
                          _email.text = 'ayesha@example.com';
                          _password.text = 'Khaana@2026';
                          _error = null;
                          _duplicateBlocked = false;
                        }),
                      ),
                      ActionChip(
                        label: const Text('Duplicate mobile (TC2)'),
                        onPressed: () => setState(() {
                          _mobile.text = '03009999999';
                          _submit();
                        }),
                      ),
                      ActionChip(
                        label: const Text('Password N−1 = 7 chars (TC6)'),
                        onPressed: () => setState(() {
                          _mobile.text = '03001234567';
                          _password.text = 'Kha@202';
                          _submit();
                        }),
                      ),
                      ActionChip(
                        label: const Text('Password N = 8 chars (TC6)'),
                        onPressed: () => setState(() {
                          _mobile.text = '03001234567';
                          _password.text = 'Kha@2026';
                          _error = null;
                        }),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: _name,
                    decoration: const InputDecoration(
                      labelText: 'Full name *',
                      prefixIcon: Icon(Icons.badge_outlined),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _mobile,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Mobile number (unique) *',
                      prefixIcon: Icon(Icons.phone_android_rounded),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email address (unique) *',
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _password,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      labelText: 'Password (min ${PrototypeAssumptions.passwordMinCharacters} chars) *',
                      prefixIcon: const Icon(Icons.lock_outline_rounded),
                      suffixText: '${_password.text.length} chars',
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text('Password strength rules:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: [
                      CapacityBadge(
                        kind: _hasMinLen ? CapacityKind.available : CapacityKind.full,
                        label: '≥ ${PrototypeAssumptions.passwordMinCharacters} chars (${_password.text.length})',
                      ),
                      CapacityBadge(
                        kind: _hasUpperAndNumber ? CapacityKind.available : CapacityKind.limited,
                        label: 'Uppercase + Digit',
                      ),
                      CapacityBadge(
                        kind: _hasSymbol ? CapacityKind.available : CapacityKind.limited,
                        label: 'Special symbol (@#\$%)',
                      ),
                    ],
                  ),
                  if (_error != null) ...[
                    const SizedBox(height: 12),
                    KhaanaInlineBanner(
                      kind: _duplicateBlocked ? CapacityKind.full : CapacityKind.limited,
                      text: _error!,
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

/// E1-US1-UI2: Verification code
/// Must show: Verification input and resend; wrong, expired and reused code states;
/// no session before successful verification.
class VerificationCodeScreen extends StatefulWidget {
  const VerificationCodeScreen({super.key});

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  final _code = TextEditingController(text: '204819');
  String? _statusError;
  bool _verified = false;

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  void _verify() {
    final val = _code.text.trim();
    if (val == '000000') {
      setState(() {
        _verified = false;
        _statusError = 'Invalid verification code. Account remains unverified; no session created.';
      });
    } else if (val == '111111') {
      setState(() {
        _verified = false;
        _statusError = 'Expired OTP code. Request a new code; no session created (E1-US1-TC5).';
      });
    } else if (val == '222222') {
      setState(() {
        _verified = false;
        _statusError = 'Previously used OTP code rejected. Account remains unverified; no session created (E1-US1-TC5).';
      });
    } else if (val.length < 6) {
      setState(() {
        _verified = false;
        _statusError = 'Enter a 6-digit verification code.';
      });
    } else {
      setState(() {
        _verified = true;
        _statusError = null;
      });
      CustomerScope.of(context).signIn();
      Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E1-US1-UI2',
      title: 'Verification code',
      footer: KhaanaPrimaryButton(
        label: 'Verify & sign in',
        icon: Icons.verified_user_outlined,
        onPressed: _verify,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Verify your mobile & email', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                      CapacityBadge(
                        kind: _verified ? CapacityKind.available : CapacityKind.closed,
                        label: _verified ? 'Session active' : 'No session yet',
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Enter the 6-digit OTP sent to 0300-1234567. No session token is issued until verification succeeds.',
                    style: TextStyle(fontSize: 13, color: KhaanaColors.mutedLight),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ActionChip(
                        label: const Text('Valid code (204819)'),
                        onPressed: () => setState(() {
                          _code.text = '204819';
                          _statusError = null;
                        }),
                      ),
                      ActionChip(
                        label: const Text('Wrong code (000000)'),
                        onPressed: () {
                          _code.text = '000000';
                          _verify();
                        },
                      ),
                      ActionChip(
                        label: const Text('Expired code (111111)'),
                        onPressed: () {
                          _code.text = '111111';
                          _verify();
                        },
                      ),
                      ActionChip(
                        label: const Text('Reused code (222222)'),
                        onPressed: () {
                          _code.text = '222222';
                          _verify();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: _code,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                      labelText: '6-digit verification code',
                      prefixIcon: Icon(Icons.pin_outlined),
                    ),
                  ),
                  if (_statusError != null) ...[
                    const SizedBox(height: 10),
                    KhaanaInlineBanner(kind: CapacityKind.full, text: _statusError!),
                  ],
                  const SizedBox(height: 8),
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        _code.text = '204819';
                        _statusError = null;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Fresh time-limited OTP sent to 0300-1234567.')),
                      );
                    },
                    icon: const Icon(Icons.refresh_rounded, size: 16),
                    label: const Text('Resend verification code'),
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

/// E1-US1-UI4: Reset password: request
/// Must show: Registered email or mobile; confirmation that a code was sent (AC3)
class ResetPasswordRequestScreen extends StatefulWidget {
  const ResetPasswordRequestScreen({super.key});

  @override
  State<ResetPasswordRequestScreen> createState() => _ResetPasswordRequestScreenState();
}

class _ResetPasswordRequestScreenState extends State<ResetPasswordRequestScreen> {
  final _contact = TextEditingController(text: 'ayesha@example.com');
  bool _sent = true;
  String? _error;

  @override
  void dispose() {
    _contact.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E1-US1-UI4',
      title: 'Reset password: request',
      footer: KhaanaPrimaryButton(
        label: 'Enter reset code & new password',
        icon: Icons.arrow_forward_rounded,
        onPressed: () {
          if (_contact.text.trim().isEmpty) {
            setState(() {
              _sent = false;
              _error = 'Enter your registered email or mobile number.';
            });
            return;
          }
          Navigator.pushNamed(context, '/reset-confirm');
        },
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Forgot your password?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 6),
                  const Text(
                    'Enter your registered email or mobile number to receive a time-limited reset code (AC3).',
                    style: TextStyle(fontSize: 13, color: KhaanaColors.mutedLight),
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: _contact,
                    decoration: const InputDecoration(
                      labelText: 'Registered email or mobile number *',
                      prefixIcon: Icon(Icons.contact_mail_outlined),
                    ),
                  ),
                  const SizedBox(height: 12),
                  KhaanaSecondaryButton(
                    label: 'Send time-limited reset code',
                    icon: Icons.send_rounded,
                    onPressed: () {
                      if (_contact.text.trim().isEmpty) {
                        setState(() {
                          _sent = false;
                          _error = 'Enter your registered email or mobile number.';
                        });
                      } else {
                        setState(() {
                          _sent = true;
                          _error = null;
                        });
                      }
                    },
                  ),
                  if (_error != null) ...[
                    const SizedBox(height: 12),
                    KhaanaInlineBanner(text: _error!),
                  ],
                  if (_sent) ...[
                    const SizedBox(height: 12),
                    KhaanaInlineBanner(
                      kind: CapacityKind.available,
                      text:
                          'Confirmation: A time-limited 6-digit reset code has been sent to ${_contact.text.trim()} (valid for 10 minutes).',
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

/// E1-US1-UI5: Reset password: code and new password
/// Must show: Code, new password, rules checklist, success state
class ResetPasswordConfirmScreen extends StatefulWidget {
  const ResetPasswordConfirmScreen({super.key});

  @override
  State<ResetPasswordConfirmScreen> createState() => _ResetPasswordConfirmScreenState();
}

class _ResetPasswordConfirmScreenState extends State<ResetPasswordConfirmScreen> {
  final _code = TextEditingController(text: '849201');
  final _newPass = TextEditingController(text: 'Khaana@2027');
  bool _success = false;
  String? _error;

  @override
  void dispose() {
    _code.dispose();
    _newPass.dispose();
    super.dispose();
  }

  bool get _minLen => _newPass.text.length >= PrototypeAssumptions.passwordMinCharacters;
  bool get _hasUpperDigit =>
      RegExp(r'[A-Z]').hasMatch(_newPass.text) && RegExp(r'[0-9]').hasMatch(_newPass.text);
  bool get _hasSymbol => RegExp(r'[^A-Za-z0-9]').hasMatch(_newPass.text);

  void _applyReset() {
    if (_code.text.trim().length < 6) {
      setState(() {
        _success = false;
        _error = 'Enter the valid 6-digit reset code.';
      });
      return;
    }
    if (!_minLen || !_hasUpperDigit || !_hasSymbol) {
      setState(() {
        _success = false;
        _error = 'New password must meet all strength rules in the checklist.';
      });
      return;
    }
    setState(() {
      _error = null;
      _success = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E1-US1-UI5',
      title: 'Reset password: code & new password',
      footer: KhaanaPrimaryButton(
        label: _success ? 'Back to Login' : 'Set new password',
        icon: _success ? Icons.login_rounded : Icons.lock_reset_rounded,
        onPressed: () {
          if (_success) {
            Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
          } else {
            _applyReset();
          }
        },
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Set New Password', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _code,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Reset code *',
                      prefixIcon: Icon(Icons.pin_outlined),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _newPass,
                    onChanged: (_) => setState(() {}),
                    decoration: const InputDecoration(
                      labelText: 'New password *',
                      prefixIcon: Icon(Icons.lock_outline_rounded),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text('Password rules checklist:', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
                  const SizedBox(height: 6),
                  _RuleRow(
                    met: _minLen,
                    label: 'At least ${PrototypeAssumptions.passwordMinCharacters} characters (${_newPass.text.length})',
                  ),
                  _RuleRow(met: _hasUpperDigit, label: 'Contains uppercase letter and number'),
                  _RuleRow(met: _hasSymbol, label: 'Contains special character (e.g. @, #, \$)'),
                  if (_error != null) ...[
                    const SizedBox(height: 10),
                    KhaanaInlineBanner(text: _error!),
                  ],
                  if (_success) ...[
                    const SizedBox(height: 12),
                    const KhaanaInlineBanner(
                      kind: CapacityKind.available,
                      text:
                          'Password changed to Khaana@2027. Your old password no longer works (E1-US1-TC3).',
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

class _RuleRow extends StatelessWidget {
  const _RuleRow({required this.met, required this.label});
  final bool met;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Icon(
            met ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
            size: 16,
            color: met ? KhaanaColors.available : KhaanaColors.mutedLight,
          ),
          const SizedBox(width: 8),
          Text(label, style: TextStyle(fontSize: 13, fontWeight: met ? FontWeight.w700 : FontWeight.w500)),
        ],
      ),
    );
  }
}

/// E1-US5-UI1: Profile
/// Must show: Name, mobile, email; links to addresses, orders, sign out
class CustomerProfileScreen extends StatelessWidget {
  const CustomerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final session = CustomerScope.of(context);
    return KhaanaPage(
      uiId: 'E1-US5-UI1',
      title: 'Profile',
      child: CustomerProfileBody(session: session),
    );
  }
}

class CustomerProfileBody extends StatelessWidget {
  const CustomerProfileBody({super.key, required this.session});
  final CustomerSession session;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: CircleAvatar(
              radius: 26,
              backgroundColor: KhaanaColors.orange,
              child: Text(
                session.customerName.isNotEmpty ? session.customerName[0] : 'A',
                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 20, color: KhaanaColors.charcoal),
              ),
            ),
            title: Text(session.customerName, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
            subtitle: Text('${session.customerMobile} · ${session.customerEmail}'),
            trailing: IconButton(
              tooltip: 'Edit profile (E1-US5-UI4)',
              onPressed: () => Navigator.pushNamed(context, '/profile/edit'),
              icon: const Icon(Icons.edit_outlined),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Card(
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.edit_note_rounded),
                title: const Text('Edit profile', style: TextStyle(fontWeight: FontWeight.w700)),
                subtitle: const Text('Update name and mobile for order notifications (E1-US5-UI4)'),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () => Navigator.pushNamed(context, '/profile/edit'),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.location_on_outlined),
                title: const Text('Saved addresses', style: TextStyle(fontWeight: FontWeight.w700)),
                subtitle: Text('Default: ${session.address} (${session.addresses.length} saved · E1-US5-UI2)'),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () => Navigator.pushNamed(context, '/addresses'),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.receipt_long_outlined),
                title: const Text('Order history & reorder', style: TextStyle(fontWeight: FontWeight.w700)),
                subtitle: const Text('Past orders, digital invoices, 1-tap reorder (E17-US2-UI1)'),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () => Navigator.pushNamed(context, '/orders'),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.notifications_outlined),
                title: const Text('Notification centre', style: TextStyle(fontWeight: FontWeight.w700)),
                subtitle: const Text('Order stage updates grouped newest first (E17-US1-UI2)'),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () => Navigator.pushNamed(context, '/notifications'),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.smart_toy_outlined),
                title: const Text('Conversational AI Assistant & Voice Order', style: TextStyle(fontWeight: FontWeight.w700)),
                subtitle: const Text('Natural-language search & hands-free voice ordering (E19-US1-UI1)'),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () => Navigator.pushNamed(context, '/assistant'),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.devices_outlined),
                title: const Text('Responsive web layouts (360 / 768 / 1280 px)', style: TextStyle(fontWeight: FontWeight.w700)),
                subtitle: const Text('Cross-platform & breakpoint boundary preview (E22-US1-UI1)'),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () => Navigator.pushNamed(context, '/responsive-web'),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.my_location_rounded),
                title: const Text('Location permission prompt (E1-US5-UI6)'),
                subtitle: const Text('Allow or enter manually'),
                trailing: const Icon(Icons.open_in_new_rounded),
                onTap: () => showCustomerLocationPermissionDialog(context),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.notifications_active_outlined),
                title: const Text('Notification permission prompt (E17-US1-UI3)'),
                subtitle: const Text('Allow or continue with in-app updates'),
                trailing: const Icon(Icons.open_in_new_rounded),
                onTap: () => showNotificationPermissionDialog(context),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.rocket_launch_outlined),
                title: const Text('App launch & session check (E1-US1-UI6)'),
                subtitle: const Text('Logo, loading state, retry / sign in'),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () => Navigator.pushNamed(context, '/launch'),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.error_outline_rounded),
                title: const Text('Shared P3 error states (E22-US3-UI3 & E22-US1-UI2)'),
                subtitle: const Text('Something went wrong & 404 Page not found'),
                trailing: Wrap(
                  spacing: 6,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/error'),
                      child: const Text('Error'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/not-found'),
                      child: const Text('404'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        KhaanaSecondaryButton(
          label: 'Sign out',
          icon: Icons.logout_rounded,
          onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
        ),
      ],
    );
  }
}

/// E1-US5-UI4: Edit profile
/// Must show: Editable name and mobile; change applies to notifications (AC2)
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _name;
  late TextEditingController _mobile;
  bool _initialized = false;
  bool _saved = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final session = CustomerScope.of(context);
      _name = TextEditingController(text: session.customerName);
      _mobile = TextEditingController(text: session.customerMobile);
      _initialized = true;
    }
  }

  @override
  void dispose() {
    if (_initialized) {
      _name.dispose();
      _mobile.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final session = CustomerScope.of(context);
    return KhaanaPage(
      uiId: 'E1-US5-UI4',
      title: 'Edit profile',
      footer: KhaanaPrimaryButton(
        label: 'Save profile changes',
        icon: Icons.save_outlined,
        onPressed: () {
          if (_name.text.trim().isEmpty || _mobile.text.trim().isEmpty) return;
          session.updateProfile(name: _name.text.trim(), mobile: _mobile.text.trim());
          setState(() => _saved = true);
        },
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Personal Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _name,
                    decoration: const InputDecoration(
                      labelText: 'Full Name *',
                      prefixIcon: Icon(Icons.person_outline_rounded),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _mobile,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Mobile Number *',
                      prefixIcon: Icon(Icons.phone_android_rounded),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const KhaanaInlineBanner(
                    kind: CapacityKind.info,
                    text:
                        'Updating your phone number immediately applies the new number to order notifications and rider contact (E1-US5 AC2).',
                  ),
                  if (_saved) ...[
                    const SizedBox(height: 10),
                    KhaanaInlineBanner(
                      kind: CapacityKind.available,
                      text: 'Profile saved. Order notifications and rider contact now use ${session.customerMobile}.',
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

/// E1-US5-UI2: Saved addresses
/// Must show: Address cards with default marker, edit, delete, add (AC1)
class SavedAddressesScreen extends StatelessWidget {
  const SavedAddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final session = CustomerScope.of(context);
    return KhaanaPage(
      uiId: 'E1-US5-UI2',
      title: 'Saved addresses',
      footer: KhaanaPrimaryButton(
        label: 'Add new address',
        icon: Icons.add_location_alt_outlined,
        onPressed: () => Navigator.pushNamed(context, '/addresses/edit'),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final addr in session.addresses)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.place_rounded, color: KhaanaColors.orangeText),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(addr, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                        ),
                        if (session.address == addr)
                          const CapacityBadge(kind: CapacityKind.available, label: 'Default'),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Pin: 33.6844° N, 72.9877° E · Within Islamabad/Rawalpindi service zone',
                      style: TextStyle(fontSize: 12, color: KhaanaColors.mutedLight),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      children: [
                        if (session.address != addr)
                          TextButton.icon(
                            onPressed: () => session.setAddress(addr),
                            icon: const Icon(Icons.check_circle_outline, size: 16),
                            label: const Text('Set as default'),
                          ),
                        TextButton.icon(
                          onPressed: () => Navigator.pushNamed(context, '/addresses/edit', arguments: addr),
                          icon: const Icon(Icons.edit_outlined, size: 16),
                          label: const Text('Edit'),
                        ),
                        if (session.addresses.length > 1)
                          TextButton.icon(
                            onPressed: () async {
                              final confirmed = await showDeleteAddressConfirmationDialog(context, addressLabel: addr);
                              if (confirmed == true) {
                                session.deleteAddress(addr);
                              }
                            },
                            icon: const Icon(Icons.delete_outline_rounded, size: 16, color: KhaanaColors.full),
                            label: const Text('Delete (E1-US5-UI5)', style: TextStyle(color: KhaanaColors.full)),
                          ),
                      ],
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

/// E1-US5-UI3: Add or edit address
/// Must show: Map with draggable pin, search, current location, label, address line
class EditAddressScreen extends StatefulWidget {
  const EditAddressScreen({super.key, this.existingAddress});
  final String? existingAddress;

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  late final TextEditingController _label;
  late final TextEditingController _line;
  late final TextEditingController _search;
  double _pinX = 0.52;
  double _pinY = 0.45;
  bool _outsideServiceArea = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    final existing = widget.existingAddress;
    if (existing != null && existing.contains('·')) {
      final parts = existing.split('·');
      _label = TextEditingController(text: parts.first.trim());
      _line = TextEditingController(text: parts.sublist(1).join('·').trim());
    } else {
      _label = TextEditingController(text: 'Home');
      _line = TextEditingController(text: 'House 12, Bahria Town, Rawalpindi');
    }
    _search = TextEditingController();
  }

  @override
  void dispose() {
    _label.dispose();
    _line.dispose();
    _search.dispose();
    super.dispose();
  }

  void _save(CustomerSession session) {
    if (_outsideServiceArea) {
      setState(() {
        _error = 'Selected map pin is outside the serviceable delivery area. No false delivery quote is generated (E1-US5-TC2).';
      });
      return;
    }
    if (_label.text.trim().isEmpty || _line.text.trim().isEmpty) {
      setState(() => _error = 'Enter both an address label and street address.');
      return;
    }
    final formatted = '${_label.text.trim()} · ${_line.text.trim()}';
    session.saveAddressEntry(formatted, oldAddress: widget.existingAddress);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final session = CustomerScope.of(context);
    return KhaanaPage(
      uiId: 'E1-US5-UI3',
      title: widget.existingAddress == null ? 'Add address' : 'Edit address',
      footer: KhaanaPrimaryButton(
        label: 'Save address & pin',
        icon: Icons.save_outlined,
        onPressed: () => _save(session),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _search,
            decoration: InputDecoration(
              hintText: 'Search area or street (e.g. Bahria Town, F-11 Markaz)',
              prefixIcon: const Icon(Icons.search_rounded),
              suffixIcon: TextButton.icon(
                onPressed: () {
                  setState(() {
                    _pinX = 0.50;
                    _pinY = 0.50;
                    _outsideServiceArea = false;
                    _error = null;
                  });
                },
                icon: const Icon(Icons.my_location_rounded, size: 16),
                label: const Text('Current location'),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onPanUpdate: (details) {
                    setState(() {
                      _pinX = (_pinX + details.delta.dx / 300).clamp(0.1, 0.9);
                      _pinY = (_pinY + details.delta.dy / 180).clamp(0.1, 0.9);
                    });
                  },
                  child: Container(
                    height: 180,
                    width: double.infinity,
                    color: const Color(0xFFF3E8D8),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 12,
                          top: 12,
                          child: CapacityBadge(
                            kind: _outsideServiceArea ? CapacityKind.full : CapacityKind.available,
                            label: _outsideServiceArea ? 'Outside service polygon' : 'Draggable map pin · Serviceable',
                          ),
                        ),
                        Align(
                          alignment: Alignment(_pinX * 2 - 1, _pinY * 2 - 1),
                          child: const Icon(Icons.location_on_rounded, size: 42, color: KhaanaColors.orangeText),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ChoiceChip(
                        label: const Text('Serviceable pin (Rawalpindi / Isb)'),
                        selected: !_outsideServiceArea,
                        onSelected: (_) => setState(() {
                          _outsideServiceArea = false;
                          _error = null;
                        }),
                      ),
                      ChoiceChip(
                        label: const Text('Unserviceable pin outside polygon (TC2)'),
                        selected: _outsideServiceArea,
                        onSelected: (_) => setState(() {
                          _outsideServiceArea = true;
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: _label,
                    decoration: const InputDecoration(
                      labelText: 'Label (e.g. Home, Office) *',
                      prefixIcon: Icon(Icons.label_outline_rounded),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _line,
                    decoration: const InputDecoration(
                      labelText: 'Address line *',
                      prefixIcon: Icon(Icons.home_outlined),
                    ),
                  ),
                  if (_error != null) ...[
                    const SizedBox(height: 12),
                    KhaanaInlineBanner(text: _error!),
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

/// E3-US1-UI4: Search results
/// Must show: Results for typed search and filters; "no match" state with suggestions (AC2)
class SearchResultsScreen extends StatefulWidget {
  const SearchResultsScreen({super.key});

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  late TextEditingController _query;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final session = CustomerScope.of(context);
      _query = TextEditingController(text: session.search);
      _initialized = true;
    }
  }

  @override
  void dispose() {
    if (_initialized) _query.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final session = CustomerScope.of(context);
    final matches = session.visibleVendors;
    return KhaanaPage(
      uiId: 'E3-US1-UI4',
      title: 'Search results',
      actions: [
        TextButton.icon(
          onPressed: () => showFilterSheet(context),
          icon: const Icon(Icons.tune_rounded, size: 18),
          label: const Text('Filters (E3-US1-UI5)'),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _query,
            decoration: InputDecoration(
              hintText: 'Search restaurants, cuisines, or dietary tags…',
              prefixIcon: const Icon(Icons.search_rounded),
              suffixIcon: IconButton(
                onPressed: () {
                  _query.clear();
                  session.setSearch('');
                },
                icon: const Icon(Icons.clear_rounded),
              ),
            ),
            onChanged: session.setSearch,
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              CapacityBadge(kind: CapacityKind.info, label: 'Cuisine: ${session.selectedCategory}'),
              if (session.selectedDietaryTag != 'Any')
                CapacityBadge(kind: CapacityKind.available, label: 'Dietary: ${session.selectedDietaryTag}'),
              if (session.openNowOnly)
                const CapacityBadge(kind: CapacityKind.available, label: 'Open now'),
              ActionChip(
                label: const Text('Simulate "No match" (TC6)'),
                onPressed: () {
                  _query.text = 'Sushi 3 AM';
                  session.setSearch('Sushi 3 AM');
                },
              ),
            ],
          ),
          const SizedBox(height: 14),
          if (matches.isEmpty)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.search_off_rounded, color: KhaanaColors.orangeText, size: 28),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'No restaurants match your search and filters',
                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Suggestions: Try clearing dietary filters or browse these open kitchens serving your area:',
                      style: TextStyle(fontSize: 13, color: KhaanaColors.mutedLight),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ActionChip(
                          label: const Text('BakeCharm (Bakery · Egg-free options)'),
                          onPressed: () {
                            _query.text = 'BakeCharm';
                            session.setSearch('BakeCharm');
                            session.setCategory('All');
                            session.setDietaryTag('Any');
                          },
                        ),
                        ActionChip(
                          label: const Text('Lazeez Cloud Kitchen (Desi · High protein)'),
                          onPressed: () {
                            _query.text = 'Lazeez';
                            session.setSearch('Lazeez');
                            session.setCategory('All');
                            session.setDietaryTag('Any');
                          },
                        ),
                        ActionChip(
                          label: const Text('Reset all filters'),
                          onPressed: () {
                            _query.clear();
                            session.setSearch('');
                            session.setCategory('All');
                            session.setDietaryTag('Any');
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          else
            for (final v in matches)
              Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: KhaanaColors.orange,
                    child: Text(v.name[0], style: const TextStyle(fontWeight: FontWeight.w800, color: KhaanaColors.charcoal)),
                  ),
                  title: Text(v.name, style: const TextStyle(fontWeight: FontWeight.w800)),
                  subtitle: Text('${v.cuisine} · ${v.area} · ★ ${v.rating}'),
                  trailing: CapacityBadge(
                    kind: v.open ? CapacityKind.available : CapacityKind.closed,
                    label: v.open ? v.band : 'Closed',
                  ),
                  onTap: v.open
                      ? () {
                          session.openVendor(v);
                          Navigator.pushNamed(context, '/menu');
                        }
                      : null,
                ),
              ),
        ],
      ),
    );
  }
}

/// E3-US1-UI5: Filter sheet (Overlay)
/// Must show: Cuisine, dietary tags, open now; "Show N restaurants"
Future<void> showFilterSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (context) => const FilterSheetOverlay(),
  );
}

class FilterSheetOverlay extends StatefulWidget {
  const FilterSheetOverlay({super.key});

  @override
  State<FilterSheetOverlay> createState() => _FilterSheetOverlayState();
}

class _FilterSheetOverlayState extends State<FilterSheetOverlay> {
  @override
  Widget build(BuildContext context) {
    final session = CustomerScope.of(context);
    final count = session.visibleVendors.length;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: KhaanaColors.orangeTint,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'E3-US1-UI5',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: KhaanaColors.onOrangeTint),
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text('Filter restaurants', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
              ),
              TextButton(
                onPressed: () {
                  session.setCategory('All');
                  session.setDietaryTag('Any');
                  if (!session.openNowOnly) session.toggleOpenNow();
                  setState(() {});
                },
                child: const Text('Reset'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text('Cuisine', style: TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              for (final c in ['All', 'Bakery', 'Desi'])
                ChoiceChip(
                  label: Text(c),
                  selected: session.selectedCategory == c,
                  onSelected: (_) {
                    session.setCategory(c);
                    setState(() {});
                  },
                ),
            ],
          ),
          const SizedBox(height: 14),
          const Text('Dietary tags (E3-US1-TC2)', style: TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final tag in ['Any', 'Egg-free', 'Nut-free', 'High-protein', 'Halal verified'])
                ChoiceChip(
                  label: Text(tag),
                  selected: session.selectedDietaryTag == tag,
                  onSelected: (_) {
                    session.setDietaryTag(tag);
                    setState(() {});
                  },
                ),
            ],
          ),
          const SizedBox(height: 10),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Open now only', style: TextStyle(fontWeight: FontWeight.w700)),
            value: session.openNowOnly,
            onChanged: (_) {
              session.toggleOpenNow();
              setState(() {});
            },
          ),
          const SizedBox(height: 12),
          KhaanaPrimaryButton(
            label: 'Show $count restaurants',
            icon: Icons.storefront_rounded,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

/// E4-US2-UI1: Reference image and instructions (Overlay)
/// Must show: Camera or gallery, thumbnail, instructions with counter, upload errors
Future<void> showReferenceImageOverlay(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (context) => Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: const ReferenceImageOverlay(),
    ),
  );
}

class ReferenceImageOverlay extends StatefulWidget {
  const ReferenceImageOverlay({super.key});

  @override
  State<ReferenceImageOverlay> createState() => _ReferenceImageOverlayState();
}

class _ReferenceImageOverlayState extends State<ReferenceImageOverlay> {
  final _notes = TextEditingController(text: 'Pink buttercream roses with gold leaf');
  String _selectedFile = 'pink_roses_cake.jpg (1.5 MB · JPG)';
  bool _hasValidThumbnail = true;
  String? _uploadError;

  @override
  void dispose() {
    _notes.dispose();
    super.dispose();
  }

  void _pickSource(String mode) {
    if (mode == 'exe') {
      setState(() {
        _hasValidThumbnail = false;
        _selectedFile = 'cake_virus.exe';
        _uploadError =
            'Rejected: Unsupported file format (.exe). Allowed formats: JPG, JPEG, PNG up to 5 MB (E4-US2-TC2).';
      });
    } else if (mode == 'oversize') {
      setState(() {
        _hasValidThumbnail = false;
        _selectedFile = 'ultra_raw_photo.png (15.0 MB)';
        _uploadError =
            'Rejected: File exceeds maximum size of 5 MB (15.0 MB uploaded). Allowed formats: JPG, PNG ≤ 5 MB (E4-US2-TC2).';
      });
    } else {
      setState(() {
        _hasValidThumbnail = true;
        _selectedFile = mode == 'camera' ? 'camera_capture_cake.jpg (1.2 MB)' : 'pink_roses_cake.jpg (1.5 MB)';
        _uploadError = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final len = _notes.text.length;
    final overLimit = len > PrototypeAssumptions.instructionMaxCharacters;
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: KhaanaColors.orangeTint,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'E4-US2-UI1',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: KhaanaColors.onOrangeTint),
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text('Reference image & instructions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              KhaanaSecondaryButton(
                label: 'Camera (JPG)',
                icon: Icons.camera_alt_outlined,
                onPressed: () => _pickSource('camera'),
              ),
              KhaanaSecondaryButton(
                label: 'Gallery (1.5 MB)',
                icon: Icons.photo_library_outlined,
                onPressed: () => _pickSource('gallery'),
              ),
              ActionChip(
                label: const Text('Test .EXE file (TC2)'),
                onPressed: () => _pickSource('exe'),
              ),
              ActionChip(
                label: const Text('Test 15 MB oversize (TC2)'),
                onPressed: () => _pickSource('oversize'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (_hasValidThumbnail)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: KhaanaColors.surface2Light,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: KhaanaColors.orange),
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: KhaanaColors.orangeTint,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.cake_rounded, color: KhaanaColors.onOrangeTint, size: 32),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Reference thumbnail attached', style: TextStyle(fontWeight: FontWeight.w800)),
                        Text(_selectedFile, style: const TextStyle(fontSize: 12, color: KhaanaColors.mutedLight)),
                      ],
                    ),
                  ),
                  const CapacityBadge(kind: CapacityKind.available, label: 'Verified JPG'),
                ],
              ),
            ),
          if (_uploadError != null) ...[
            const SizedBox(height: 10),
            KhaanaInlineBanner(kind: CapacityKind.full, text: _uploadError!),
          ],
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Special instructions', style: TextStyle(fontWeight: FontWeight.w800)),
              Text(
                '$len / ${PrototypeAssumptions.instructionMaxCharacters} chars',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: overLimit ? KhaanaColors.full : KhaanaColors.mutedLight,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          TextField(
            controller: _notes,
            maxLines: 3,
            onChanged: (_) => setState(() {}),
            decoration: const InputDecoration(
              hintText: 'Describe piping colours, tiers, or allergen notes…',
            ),
          ),
          if (overLimit) ...[
            const SizedBox(height: 8),
            const KhaanaInlineBanner(
              text: 'Special instructions exceed the 500-character limit (E4-US2-TC3). Shorten before saving.',
            ),
          ],
          const SizedBox(height: 14),
          KhaanaPrimaryButton(
            label: 'Attach reference & instructions',
            icon: Icons.check_rounded,
            onPressed: (_uploadError != null || overLimit)
                ? null
                : () {
                    CustomerScope.of(context).attachReferenceImage(_selectedFile, _notes.text.trim());
                    Navigator.pop(context);
                  },
          ),
        ],
      ),
    );
  }
}

/// E4-US3-UI1: Revised quote approval
/// Must show: Original and revised price and lead time, vendor note, Approve or Cancel (AC2); decline reason
class RevisedQuoteApprovalScreen extends StatefulWidget {
  const RevisedQuoteApprovalScreen({super.key});

  @override
  State<RevisedQuoteApprovalScreen> createState() => _RevisedQuoteApprovalScreenState();
}

class _RevisedQuoteApprovalScreenState extends State<RevisedQuoteApprovalScreen> {
  String _state = 'pending'; // 'pending', 'approved', 'cancelled', 'declined'

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E4-US3-UI1',
      title: 'Revised quote approval',
      footer: _state == 'pending'
          ? Row(
              children: [
                Expanded(
                  child: KhaanaSecondaryButton(
                    label: 'Cancel order',
                    onPressed: () => setState(() => _state = 'cancelled'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: KhaanaPrimaryButton(
                    label: 'Approve Rs 5,500',
                    icon: Icons.check_circle_outline,
                    onPressed: () => setState(() => _state = 'approved'),
                  ),
                ),
              ],
            )
          : KhaanaPrimaryButton(
              label: 'Reset to pending quote',
              onPressed: () => setState(() => _state = 'pending'),
            ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ChoiceChip(
                label: const Text('Pending revised quote (TC1)'),
                selected: _state == 'pending',
                onSelected: (_) => setState(() => _state = 'pending'),
              ),
              ChoiceChip(
                label: const Text('Vendor declined state (TC2)'),
                selected: _state == 'declined',
                onSelected: (_) => setState(() => _state = 'declined'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (_state == 'declined')
            const KhaanaInlineBanner(
              kind: CapacityKind.full,
              text:
                  'Vendor declined custom request: "Not available on requested date — 3-tier fondant requires 48h curing." Order closed (E4-US3-TC2).',
            )
          else if (_state == 'approved')
            const KhaanaInlineBanner(
              kind: CapacityKind.available,
              text: 'Revised quote of Rs 5,500 and 24-hour lead time approved. Order moved to confirmed queue.',
            )
          else if (_state == 'cancelled')
            const KhaanaInlineBanner(
              kind: CapacityKind.closed,
              text: 'You cancelled the revised quote. No charge was taken.',
            )
          else
            const KhaanaInlineBanner(
              kind: CapacityKind.limited,
              text: 'Order stays pending until you approve or cancel the vendor\'s revised quote (E4-US3 AC2).',
            ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Custom Cake Order #KG-1042 · BakeCharm', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                  const Divider(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('ORIGINAL ESTIMATE', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: KhaanaColors.mutedLight)),
                            const SizedBox(height: 4),
                            Text(formatRupees(2250), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                            const Text('Lead time: 2 hours', style: TextStyle(fontSize: 13, color: KhaanaColors.mutedLight)),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_rounded, color: KhaanaColors.orangeText),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('REVISED VENDOR QUOTE', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: KhaanaColors.orangeText)),
                            const SizedBox(height: 4),
                            Text(formatRupees(5500), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: KhaanaColors.orangeText)),
                            const Text('Lead time: 24 hours (Tomorrow 6:30 PM)', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 24),
                  const Text('Vendor note:', style: TextStyle(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 4),
                  const Text(
                    '"Hand-sculpted pink roses and edible gold leaf from your uploaded reference image require an extra ganache chill cycle and 24-hour lead time."',
                    style: TextStyle(fontSize: 13),
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

/// E3-US2-UI3: Different-restaurant dialog (Overlay)
/// Must show: "Keep current cart" or "Start new cart" (AC2)
Future<void> showDifferentRestaurantDialog(
  BuildContext context, {
  required Dish newDish,
}) {
  final session = CustomerScope.of(context);
  return showDialog<void>(
    context: context,
    builder: (context) => DifferentRestaurantDialog(
      currentVendorName: 'BakeCharm',
      newVendorName: 'Lazeez Cloud Kitchen',
      onKeepCurrent: () => Navigator.pop(context),
      onStartNew: () {
        session.clearCart();
        session.addDish(newDish);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Started a new cart with ${newDish.name}.')),
        );
      },
    ),
  );
}

class DifferentRestaurantDialog extends StatelessWidget {
  const DifferentRestaurantDialog({
    super.key,
    required this.currentVendorName,
    required this.newVendorName,
    required this.onKeepCurrent,
    required this.onStartNew,
  });

  final String currentVendorName;
  final String newVendorName;
  final VoidCallback onKeepCurrent;
  final VoidCallback onStartNew;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: KhaanaColors.orangeTint,
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text(
              'E3-US2-UI3',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: KhaanaColors.onOrangeTint),
            ),
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Text('Start a new cart?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
          ),
        ],
      ),
      content: Text(
        'Your cart already contains items from $currentVendorName. An order can only come from one kitchen at a time (E3-US2 AC2). Would you like to keep your current cart or start a new cart for $newVendorName?',
      ),
      actions: [
        TextButton(
          onPressed: onKeepCurrent,
          child: const Text('Keep current cart'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: KhaanaColors.orange,
            foregroundColor: KhaanaColors.charcoal,
          ),
          onPressed: onStartNew,
          child: const Text('Start new cart'),
        ),
      ],
    );
  }
}

/// E3-US3-UI2: Payment gateway handoff
/// Must show: Loading and return states around the gateway's own page
class PaymentGatewayHandoffScreen extends StatefulWidget {
  const PaymentGatewayHandoffScreen({super.key});

  @override
  State<PaymentGatewayHandoffScreen> createState() => _PaymentGatewayHandoffScreenState();
}

class _PaymentGatewayHandoffScreenState extends State<PaymentGatewayHandoffScreen> {
  String _gatewayState = 'loading'; // 'loading', 'success', 'declined', 'timeout'

  @override
  Widget build(BuildContext context) {
    final session = CustomerScope.of(context);
    return KhaanaPage(
      uiId: 'E3-US3-UI2',
      title: 'Payment gateway handoff',
      footer: _gatewayState == 'success'
          ? KhaanaPrimaryButton(
              label: 'Continue to Order Placed',
              icon: Icons.check_circle_outline,
              onPressed: () => Navigator.pushReplacementNamed(context, '/placed'),
            )
          : KhaanaSecondaryButton(
              label: 'Open Payment Failed screen (E10-US3-UI1)',
              icon: Icons.error_outline_rounded,
              onPressed: () => Navigator.pushReplacementNamed(context, '/payment-failed'),
            ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ChoiceChip(
                label: const Text('Handoff loading'),
                selected: _gatewayState == 'loading',
                onSelected: (_) => setState(() => _gatewayState = 'loading'),
              ),
              ChoiceChip(
                label: const Text('Confirmed callback (TC1)'),
                selected: _gatewayState == 'success',
                onSelected: (_) => setState(() => _gatewayState = 'success'),
              ),
              ChoiceChip(
                label: const Text('Declined / Timeout (TC3/TC4)'),
                selected: _gatewayState == 'declined',
                onSelected: (_) => setState(() => _gatewayState = 'declined'),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${session.payment} Gateway Session', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                      CapacityBadge(
                        kind: switch (_gatewayState) {
                          'success' => CapacityKind.available,
                          'declined' => CapacityKind.full,
                          _ => CapacityKind.info,
                        },
                        label: _gatewayState.toUpperCase(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (_gatewayState == 'loading') ...[
                    const LinearProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(KhaanaColors.orange),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Waiting for ${session.payment} approval for ${formatRupees(session.total)}… Do not close the app. Duplicate callbacks are deduplicated by idempotency key.',
                      style: const TextStyle(fontSize: 13),
                    ),
                  ] else if (_gatewayState == 'success') ...[
                    const KhaanaInlineBanner(
                      kind: CapacityKind.available,
                      text:
                          'Gateway confirmed payment (Ref: TX-98412). Order is marked Paid. Duplicate callbacks are ignored safely (E3-US3-TC3).',
                    ),
                  ] else ...[
                    const KhaanaInlineBanner(
                      kind: CapacityKind.full,
                      text:
                          'Gateway session timed out or card declined. Order is NOT confirmed and no duplicate charge was made (E3-US3-TC4).',
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

/// E3-US4-UI1: Voucher and offers sheet (Overlay)
/// Must show: Code field, auto-applied offers, rejection reason (AC2)
Future<void> showVoucherOffersSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (context) => Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: const VoucherOffersSheet(),
    ),
  );
}

class VoucherOffersSheet extends StatefulWidget {
  const VoucherOffersSheet({super.key});

  @override
  State<VoucherOffersSheet> createState() => _VoucherOffersSheetState();
}

class _VoucherOffersSheetState extends State<VoucherOffersSheet> {
  final _code = TextEditingController(text: 'RAMADAN20');
  String? _rejection;

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  void _apply(CustomerSession session) {
    final err = session.applyVoucherCode(_code.text);
    setState(() => _rejection = err);
  }

  @override
  Widget build(BuildContext context) {
    final session = CustomerScope.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: KhaanaColors.orangeTint,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'E3-US4-UI1',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: KhaanaColors.onOrangeTint),
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text('Vouchers & automatic offers', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const KhaanaInlineBanner(
            kind: CapacityKind.available,
            icon: Icons.auto_awesome_rounded,
            text: 'Auto-applied offer: 10% BakeCharm Celebration Deal (−Rs 185) is automatically applied to eligible carts (E3-US4 AC1).',
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ActionChip(
                label: const Text('Try expired RAMADAN20 (TC2)'),
                onPressed: () {
                  _code.text = 'RAMADAN20';
                  _apply(session);
                },
              ),
              ActionChip(
                label: const Text('Try below-minimum SAVE500'),
                onPressed: () {
                  _code.text = 'SAVE500';
                  _apply(session);
                },
              ),
              ActionChip(
                label: const Text('Apply valid KHAANA15 (15% off)'),
                onPressed: () {
                  _code.text = 'KHAANA15';
                  _apply(session);
                },
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _code,
                  decoration: const InputDecoration(
                    labelText: 'Voucher code',
                    prefixIcon: Icon(Icons.confirmation_number_outlined),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              KhaanaSecondaryButton(
                label: 'Apply',
                onPressed: () => _apply(session),
              ),
            ],
          ),
          if (_rejection != null) ...[
            const SizedBox(height: 10),
            KhaanaInlineBanner(kind: CapacityKind.full, text: _rejection!),
          ] else if (session.appliedVoucherCode != null) ...[
            const SizedBox(height: 10),
            KhaanaInlineBanner(
              kind: CapacityKind.available,
              text: 'Voucher ${session.appliedVoucherCode} applied! Discount: ${formatRupees(session.voucherDiscount)}.',
            ),
          ],
          const SizedBox(height: 14),
          KhaanaPrimaryButton(
            label: 'Done',
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

/// E10-US3-UI1: Payment failed
/// Must show: "Order not placed", Try again, Choose another method
class PaymentFailedScreen extends StatelessWidget {
  const PaymentFailedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final session = CustomerScope.of(context);
    return KhaanaPage(
      uiId: 'E10-US3-UI1',
      title: 'Payment failed',
      footer: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          KhaanaPrimaryButton(
            label: 'Try again with ${session.payment}',
            icon: Icons.refresh_rounded,
            onPressed: () => Navigator.pushReplacementNamed(context, '/payment-handoff'),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: KhaanaSecondaryButton(
              label: 'Choose another payment method',
              icon: Icons.swap_horiz_rounded,
              onPressed: () => Navigator.pushReplacementNamed(context, '/payment'),
            ),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KhaanaErrorState(
            title: 'Order not placed',
            message:
                'Your ${session.payment} transaction for ${formatRupees(session.total)} was declined or timed out. Your slot hold is still active and you have not been charged (E10-US3 AC1).',
            onRetry: () => Navigator.pushReplacementNamed(context, '/payment-handoff'),
          ),
        ],
      ),
    );
  }
}

/// E16-US4-UI1: Confirm corrected drop-off pin (Overlay)
/// Must show: Map with the rider's proposed pin; confirm or adjust
Future<void> showConfirmCorrectedPinDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (context) => const ConfirmCorrectedPinOverlay(),
  );
}

class ConfirmCorrectedPinOverlay extends StatefulWidget {
  const ConfirmCorrectedPinOverlay({super.key});

  @override
  State<ConfirmCorrectedPinOverlay> createState() => _ConfirmCorrectedPinOverlayState();
}

class _ConfirmCorrectedPinOverlayState extends State<ConfirmCorrectedPinOverlay> {
  bool _adjusted = false;

  @override
  Widget build(BuildContext context) {
    final session = CustomerScope.of(context);
    return AlertDialog(
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: KhaanaColors.orangeTint,
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text(
              'E16-US4-UI1',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: KhaanaColors.onOrangeTint),
            ),
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Text('Confirm corrected drop-off pin', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
          ),
        ],
      ),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 440),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your rider reported that the original pin lands on a blocked back lane and proposed a corrected gate pin 40m east (E16-US4 AC2):',
              style: TextStyle(fontSize: 13),
            ),
            const SizedBox(height: 12),
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFF3E8D8),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: KhaanaColors.orange),
              ),
              child: Stack(
                children: [
                  const Positioned(
                    top: 10,
                    left: 10,
                    child: CapacityBadge(kind: CapacityKind.info, label: 'Rider proposed pin: Gate 2, Street 14'),
                  ),
                  Center(
                    child: Icon(
                      Icons.pin_drop_rounded,
                      size: 42,
                      color: _adjusted ? KhaanaColors.available : KhaanaColors.orangeText,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            TextButton.icon(
              onPressed: () => setState(() => _adjusted = !_adjusted),
              icon: const Icon(Icons.open_with_rounded, size: 16),
              label: Text(_adjusted ? 'Adjusted to front porch pin' : 'Adjust proposed pin slightly'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Keep original pin'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: KhaanaColors.orange,
            foregroundColor: KhaanaColors.charcoal,
          ),
          onPressed: () {
            session.setAddress('Home · Gate 2, Street 14, F-11 Markaz (Confirmed Pin)');
            Navigator.pop(context);
          },
          child: const Text('Confirm corrected pin'),
        ),
      ],
    );
  }
}

/// E17-US1-UI2: Notification centre
/// Must show: Updates grouped by order, newest first (AC6)
class NotificationCentreScreen extends StatelessWidget {
  const NotificationCentreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final session = CustomerScope.of(context);
    return KhaanaPage(
      uiId: 'E17-US1-UI2',
      title: 'Notification centre',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const KhaanaInlineBanner(
            kind: CapacityKind.info,
            icon: Icons.notifications_active_outlined,
            text:
                'All order status updates remain available here grouped by order (newest first), even when device push notifications are disabled (E17-US1 AC6).',
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Order #${session.orderNumber} · BakeCharm', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                      const CapacityBadge(kind: CapacityKind.info, label: 'Active'),
                    ],
                  ),
                  const Divider(height: 20),
                  const ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.thunderstorm_outlined, color: KhaanaColors.limited),
                    title: Text('6:50 PM · Weather delay (+15 mins)', style: TextStyle(fontWeight: FontWeight.w800)),
                    subtitle: Text('Revised arrival window: 7:25–7:45 PM due to rain in F-11.'),
                  ),
                  const ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.soup_kitchen_outlined, color: KhaanaColors.orangeText),
                    title: Text('6:45 PM · Kitchen Preparing', style: TextStyle(fontWeight: FontWeight.w700)),
                    subtitle: Text('Your Chocolate Cake entered the oven batch.'),
                  ),
                  const ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.check_circle_outline, color: KhaanaColors.available),
                    title: Text('6:42 PM · Order Confirmed', style: TextStyle(fontWeight: FontWeight.w700)),
                    subtitle: Text('Slot 6:30 PM reserved and invoice #INV-1042 issued.'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Order #KG-1038 · Lazeez Cloud Kitchen', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                      CapacityBadge(kind: CapacityKind.available, label: 'Delivered'),
                    ],
                  ),
                  Divider(height: 20),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.done_all_rounded, color: KhaanaColors.available),
                    title: Text('Yesterday 8:14 PM · Delivered with 6-digit PIN', style: TextStyle(fontWeight: FontWeight.w700)),
                    subtitle: Text('Chicken Karahi + Garlic Naan delivered. Tap to rate restaurant & rider.'),
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

/// E17-US2-UI1: Order history
/// Must show: Orders newest first; empty state (AC2)
class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  bool _emptyDemo = false;

  @override
  Widget build(BuildContext context) {
    final session = CustomerScope.of(context);
    return KhaanaPage(
      uiId: 'E17-US2-UI1',
      title: 'Order history',
      child: OrderHistoryBody(
        session: session,
        forceEmpty: _emptyDemo,
        onToggleEmpty: () => setState(() => _emptyDemo = !_emptyDemo),
      ),
    );
  }
}

class OrderHistoryBody extends StatelessWidget {
  const OrderHistoryBody({
    super.key,
    required this.session,
    required this.forceEmpty,
    required this.onToggleEmpty,
    this.onBrowse,
  });

  final CustomerSession session;
  final bool forceEmpty;
  final VoidCallback onToggleEmpty;
  final VoidCallback? onBrowse;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Orders (Newest First)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
            TextButton.icon(
              onPressed: onToggleEmpty,
              icon: const Icon(Icons.swap_horiz_rounded, size: 16),
              label: Text(forceEmpty ? 'Show orders' : 'Preview empty state (AC2)'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (forceEmpty)
          KhaanaEmptyState(
            title: 'No orders yet.',
            message: 'Your completed and active orders with digital invoices will appear here newest first.',
            icon: Icons.shopping_bag_outlined,
            actionLabel: 'Browse restaurants',
            onAction: onBrowse ?? () => Navigator.pushReplacementNamed(context, '/home'),
          )
        else ...[
          for (final order in session.orderHistory)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Order #${order.id} · ${order.vendorName}',
                          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                        ),
                        CapacityBadge(
                          kind: order.status == 'Delivered'
                              ? CapacityKind.available
                              : order.status == 'Rejected – Refund Flagged'
                                  ? CapacityKind.full
                                  : CapacityKind.info,
                          label: order.status,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text('${order.dateLabel} · ${order.itemsSummary}'),
                    const SizedBox(height: 4),
                    Text(
                      'Total: ${formatRupees(order.total)} · Invoice ${order.invoiceNumber} (${order.paymentStatus})',
                      style: const TextStyle(fontWeight: FontWeight.w700, color: KhaanaColors.orangeText),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        KhaanaSecondaryButton(
                          label: 'Order detail & invoice',
                          icon: Icons.receipt_long_outlined,
                          onPressed: () => Navigator.pushNamed(context, '/order-detail', arguments: order.id),
                        ),
                        KhaanaSecondaryButton(
                          label: 'Reorder (1-tap)',
                          icon: Icons.replay_rounded,
                          onPressed: () => showReorderSummarySheet(context, orderId: order.id),
                        ),
                        if (order.status == 'Preparing')
                          KhaanaSecondaryButton(
                            label: 'Live tracking',
                            icon: Icons.near_me_rounded,
                            onPressed: () => Navigator.pushNamed(context, '/tracking'),
                          ),
                        if (order.status == 'Delivered')
                          TextButton.icon(
                            onPressed: () => Navigator.pushNamed(context, '/rating', arguments: order.id),
                            icon: const Icon(Icons.star_outline_rounded, size: 18),
                            label: const Text('Rate'),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ],
    );
  }
}

/// E17-US2-UI2: Order detail and invoice
/// Must show: Items and options, bill, payment status, Download invoice, Reorder, Rate, Report a problem
class OrderDetailInvoiceScreen extends StatelessWidget {
  const OrderDetailInvoiceScreen({super.key, this.orderId});
  final String? orderId;

  @override
  Widget build(BuildContext context) {
    final session = CustomerScope.of(context);
    final order = session.orderHistory.firstWhere(
      (o) => o.id == orderId,
      orElse: () => session.orderHistory.first,
    );
    return KhaanaPage(
      uiId: 'E17-US2-UI2',
      title: 'Order #${order.id} & Invoice',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Digital Invoice ${order.invoiceNumber}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                      CapacityBadge(kind: CapacityKind.available, label: order.paymentStatus),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text('${order.vendorName} · ${order.dateLabel}', style: const TextStyle(color: KhaanaColors.mutedLight)),
                  const Divider(height: 24),
                  const Text('Items & Custom Options', style: TextStyle(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 6),
                  Text(order.itemsSummary, style: const TextStyle(fontSize: 14)),
                  const Divider(height: 24),
                  PriceLines(
                    lines: [
                      ('Food subtotal', order.total - 115),
                      ('Delivery (Base Rs 60 + Road distance Rs 64)', 124),
                      ('Rain surcharge', 40),
                      ('Auto-applied discount', -49),
                    ],
                    total: order.total,
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      KhaanaPrimaryButton(
                        label: 'Download invoice PDF (${order.invoiceNumber})',
                        icon: Icons.download_rounded,
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Downloaded ${order.invoiceNumber}.pdf (authenticated owner check passed).')),
                          );
                        },
                      ),
                      KhaanaSecondaryButton(
                        label: 'Reorder',
                        icon: Icons.replay_rounded,
                        onPressed: () => showReorderSummarySheet(context, orderId: order.id),
                      ),
                      KhaanaSecondaryButton(
                        label: 'Rate order',
                        icon: Icons.star_outline_rounded,
                        onPressed: () => Navigator.pushNamed(context, '/rating', arguments: order.id),
                      ),
                      KhaanaSecondaryButton(
                        label: 'Report a problem',
                        icon: Icons.report_problem_outlined,
                        onPressed: () => Navigator.pushNamed(context, '/complaint', arguments: order.id),
                      ),
                    ],
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

/// E17-US2-UI3: Reorder summary (Overlay)
/// Must show: Reorder with original options and current prices; available items added,
/// unavailable items skipped with explanation (E17-US2 AC3, AC4).
Future<void> showReorderSummarySheet(BuildContext context, {String? orderId}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (context) => ReorderSummaryOverlay(orderId: orderId),
  );
}

class ReorderSummaryOverlay extends StatelessWidget {
  const ReorderSummaryOverlay({super.key, this.orderId});
  final String? orderId;

  @override
  Widget build(BuildContext context) {
    final session = CustomerScope.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: KhaanaColors.orangeTint,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'E17-US2-UI3',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: KhaanaColors.onOrangeTint),
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text('One-tap reorder summary', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Items from your past order have been revalidated against live kitchen availability and current menu prices (E17-US2 AC3, AC4):',
            style: TextStyle(fontSize: 13),
          ),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: const Icon(Icons.check_circle_rounded, color: KhaanaColors.available),
              title: const Text('Chocolate cake · 1 lb · Chocolate · "No nuts"', style: TextStyle(fontWeight: FontWeight.w800)),
              subtitle: const Text('Available · Added at current menu price (was Rs 1,750 → now Rs 1,850)'),
              trailing: Text(formatRupees(1850), style: const TextStyle(fontWeight: FontWeight.w800)),
            ),
          ),
          Card(
            color: KhaanaColors.fullTint,
            child: const ListTile(
              leading: Icon(Icons.remove_shopping_cart_rounded, color: KhaanaColors.full),
              title: Text('Brownie box (×1)', style: TextStyle(fontWeight: FontWeight.w800, color: KhaanaColors.full)),
              subtitle: Text(
                'Skipped: Currently marked unavailable (sold out for current oven batch). Not added to cart.',
                style: TextStyle(color: KhaanaColors.full, fontSize: 12),
              ),
            ),
          ),
          const SizedBox(height: 14),
          KhaanaPrimaryButton(
            label: 'Confirm current prices & open Cart',
            icon: Icons.shopping_cart_checkout_rounded,
            onPressed: () {
              session.reorderAvailableItems();
              Navigator.pop(context);
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
      ),
    );
  }
}

/// E18-US1-UI1: Rating
/// Must show: Restaurant, item and rider ratings kept separate
class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key, this.orderId});
  final String? orderId;

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  int _restaurantStars = 5;
  int _itemStars = 5;
  int _riderStars = 2;
  final _foodComment = TextEditingController(text: 'Cake sponge was moist and nut-free exclusion was respected.');
  final _riderComment = TextEditingController(text: 'Arrived slightly late during rain, parcel intact.');
  bool _submitted = false;

  @override
  void dispose() {
    _foodComment.dispose();
    _riderComment.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E18-US1-UI1',
      title: 'Rate restaurant, items & rider',
      footer: KhaanaPrimaryButton(
        label: _submitted ? 'Ratings saved independently' : 'Submit independent ratings',
        icon: Icons.rate_review_outlined,
        onPressed: () => setState(() => _submitted = true),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const KhaanaInlineBanner(
            kind: CapacityKind.info,
            text:
                'Restaurant, item and rider ratings are stored independently. A low rider rating (e.g. 1–2 stars) never lowers the restaurant\'s score (E18-US1 AC3, AC4).',
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('1. Restaurant Rating · BakeCharm', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 8),
                  _StarSelector(value: _restaurantStars, onChanged: (v) => setState(() => _restaurantStars = v)),
                  const Divider(height: 24),
                  const Text('2. Dish Rating · Chocolate Cake (1 lb)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 8),
                  _StarSelector(value: _itemStars, onChanged: (v) => setState(() => _itemStars = v)),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _foodComment,
                    decoration: const InputDecoration(labelText: 'Optional comment for restaurant & dish'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('3. Independent Rider Rating', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                      const CapacityBadge(kind: CapacityKind.available, label: 'Isolated from kitchen score'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _StarSelector(value: _riderStars, onChanged: (v) => setState(() => _riderStars = v)),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _riderComment,
                    decoration: const InputDecoration(labelText: 'Optional comment for delivery rider'),
                  ),
                ],
              ),
            ),
          ),
          if (_submitted) ...[
            const SizedBox(height: 12),
            KhaanaInlineBanner(
              kind: CapacityKind.available,
              text:
                  'Saved: Restaurant $_restaurantStars★, Item $_itemStars★, Rider $_riderStars★. BakeCharm retains its $_restaurantStars★ score unaffected by the $_riderStars★ rider rating.',
            ),
          ],
        ],
      ),
    );
  }
}

class _StarSelector extends StatelessWidget {
  const _StarSelector({required this.value, required this.onChanged});
  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 1; i <= 5; i++)
          IconButton(
            onPressed: () => onChanged(i),
            icon: Icon(
              i <= value ? Icons.star_rounded : Icons.star_outline_rounded,
              color: const Color(0xFFEAB308),
              size: 32,
            ),
          ),
        const SizedBox(width: 8),
        Text('$value / 5 stars', style: const TextStyle(fontWeight: FontWeight.w800)),
      ],
    );
  }
}

/// E18-US3-UI1: Complaint form
/// Must show: Order read-only, category, description. Include optional attachment upload with
/// configured type/size limits; reject unsupported or oversized files and duplicate submission.
class CustomerComplaintFormScreen extends StatefulWidget {
  const CustomerComplaintFormScreen({super.key, this.orderId});
  final String? orderId;

  @override
  State<CustomerComplaintFormScreen> createState() => _CustomerComplaintFormScreenState();
}

class _CustomerComplaintFormScreenState extends State<CustomerComplaintFormScreen> {
  String _category = 'Late delivery';
  final _desc = TextEditingController(text: 'Order arrived 25 minutes past the revised slot window.');
  String _attachment = 'damaged_box_photo.jpg (1.1 MB)';
  String? _fileError;
  bool _submitted = false;
  String? _duplicateError;

  @override
  void dispose() {
    _desc.dispose();
    super.dispose();
  }

  void _submit() {
    if (_submitted) {
      setState(() {
        _duplicateError = 'Duplicate submission blocked: Ticket #CMP-204 is already open for this order (E18-US3-TC3).';
      });
      return;
    }
    if (_fileError != null) return;
    if (_desc.text.trim().isEmpty) return;
    setState(() {
      _submitted = true;
      _duplicateError = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final orderId = widget.orderId ?? 'KG-1042';
    return KhaanaPage(
      uiId: 'E18-US3-UI1',
      title: 'Raise order complaint',
      footer: KhaanaPrimaryButton(
        label: _submitted ? 'Ticket #CMP-204 submitted (Tap to test duplicate block)' : 'Submit complaint ticket',
        icon: Icons.support_agent_rounded,
        onPressed: _fileError != null ? null : _submit,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    readOnly: true,
                    controller: TextEditingController(text: 'Order #$orderId · BakeCharm (Read-only)'),
                    decoration: const InputDecoration(
                      labelText: 'Linked Order (Read-only)',
                      prefixIcon: Icon(Icons.lock_outline_rounded),
                    ),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    initialValue: _category,
                    decoration: const InputDecoration(
                      labelText: 'Complaint category *',
                      prefixIcon: Icon(Icons.category_outlined),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'Late delivery', child: Text('Late delivery')),
                      DropdownMenuItem(value: 'Missing or wrong customization', child: Text('Missing or wrong customization')),
                      DropdownMenuItem(value: 'Damaged fragile item', child: Text('Damaged fragile item')),
                      DropdownMenuItem(value: 'Billing or refund issue', child: Text('Billing or refund issue')),
                    ],
                    onChanged: (v) {
                      if (v != null) setState(() => _category = v);
                    },
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _desc,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Description *',
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text('Optional evidence attachment (JPG / PNG ≤ 5 MB):', style: TextStyle(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ActionChip(
                        label: const Text('Attach valid JPG (1.1 MB)'),
                        onPressed: () => setState(() {
                          _attachment = 'damaged_box_photo.jpg (1.1 MB)';
                          _fileError = null;
                        }),
                      ),
                      ActionChip(
                        label: const Text('Test oversized 12 MB file (TC4)'),
                        onPressed: () => setState(() {
                          _attachment = 'raw_video.mp4 (12.0 MB)';
                          _fileError = 'Attachment rejected: Unsupported format or exceeds 5 MB limit (E18-US3-TC4).';
                        }),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('Current attachment: $_attachment', style: const TextStyle(fontSize: 12, color: KhaanaColors.mutedLight)),
                  if (_fileError != null) ...[
                    const SizedBox(height: 10),
                    KhaanaInlineBanner(text: _fileError!),
                  ],
                  if (_duplicateError != null) ...[
                    const SizedBox(height: 10),
                    KhaanaInlineBanner(text: _duplicateError!),
                  ],
                  if (_submitted) ...[
                    const SizedBox(height: 10),
                    KhaanaInlineBanner(
                      kind: CapacityKind.available,
                      text: 'Complaint ticket #CMP-204 created and linked to Order #$orderId for administrator review.',
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

/// E19-US1-UI1: Assistant chat
/// Must show: Text/mic input, results respecting exclusions, no-match alternatives,
/// current order ETA or no-active-order reply; unsupported and cross-role requests refused (E19-US4).
class AssistantChatScreen extends StatelessWidget {
  const AssistantChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final session = CustomerScope.of(context);
    return KhaanaPage(
      uiId: 'E19-US1-UI1',
      title: 'Assistant chat',
      actions: [
        TextButton.icon(
          onPressed: () => Navigator.pushNamed(context, '/voice-order'),
          icon: const Icon(Icons.mic_rounded, size: 18),
          label: const Text('Voice Order (E19-US2-UI1)'),
        ),
      ],
      child: AssistantChatBody(session: session),
    );
  }
}

class AssistantChatBody extends StatefulWidget {
  const AssistantChatBody({super.key, required this.session});
  final CustomerSession session;

  @override
  State<AssistantChatBody> createState() => _AssistantChatBodyState();
}

class _AssistantChatBodyState extends State<AssistantChatBody> {
  final _input = TextEditingController(text: 'chocolate cake without nuts near me');
  String _intent = 'search_exclusion';
  bool _hasActiveOrder = true;

  @override
  void dispose() {
    _input.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final (replyTitle, replyBody, badgeKind, badgeText) = switch (_intent) {
      'search_exclusion' => (
          'Matching items respecting "without nuts" exclusion (E19-US1-TC1)',
          'BakeCharm · Chocolate Cake (Rs 1,850 · 420 kcal) supports verified "No nuts" customization and has a 6:30 PM slot open.',
          CapacityKind.available,
          'Exclusion verified',
        ),
      'no_match' => (
          'No exact match for "sushi at 3 am" (E19-US1-TC2)',
          'Nothing matched that request right now. Suggested alternatives open in F-11: BakeCharm (Bakery) or Lazeez Cloud Kitchen (Chicken Karahi, Mutton Biryani).',
          CapacityKind.limited,
          'Alternatives suggested',
        ),
      'order_status' => _hasActiveOrder
          ? (
              'Active Order #${widget.session.orderNumber} Status (E19-US1-TC3)',
              'Your order from BakeCharm is currently Preparing (oven batch in progress). Honest arrival window: 7:25–7:45 PM (includes +15m rain buffer).',
              CapacityKind.info,
              'Active ETA',
            )
          : (
              'No active order right now (E19-US1-TC4)',
              'You have no active order in progress. Would you like to reorder from your recent orders (#KG-1038 Chicken Karahi or #KG-1029 Chocolate Cake)?',
              CapacityKind.closed,
              'Recent orders offered',
            ),
      'unsupported' => (
          'Unsupported capability refused (E19-US4-TC1)',
          'I cannot start a live video call with the vendor. My scope is limited to natural-language search, voice ordering, status queries, and check-ins. Please use the Complaint Form (E18-US3-UI1) if you need dispute assistance.',
          CapacityKind.full,
          'Guardrail enforced',
        ),
      _ => (
          'Cross-role / unauthorized data refused (E19-US4-TC2 / E19-US1-TC5)',
          'Refused: As a customer, you cannot access vendor revenue, private recipe quantities, or another customer\'s order status.',
          CapacityKind.full,
          '403 Role Isolated',
        ),
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _input,
                decoration: InputDecoration(
                  hintText: 'Type or speak a food search or order question…',
                  prefixIcon: const Icon(Icons.chat_bubble_outline_rounded),
                  suffixIcon: IconButton(
                    tooltip: 'Voice order screen (E19-US2-UI1)',
                    onPressed: () => Navigator.pushNamed(context, '/voice-order'),
                    icon: const Icon(Icons.mic_rounded, color: KhaanaColors.orangeText),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ChoiceChip(
              label: const Text('"chocolate cake without nuts" (TC1)'),
              selected: _intent == 'search_exclusion',
              onSelected: (_) => setState(() {
                _intent = 'search_exclusion';
                _input.text = 'chocolate cake without nuts near me';
              }),
            ),
            ChoiceChip(
              label: const Text('"sushi at 3 am" (TC2 no match)'),
              selected: _intent == 'no_match',
              onSelected: (_) => setState(() {
                _intent = 'no_match';
                _input.text = 'sushi at 3 am';
              }),
            ),
            ChoiceChip(
              label: const Text('"Where is my order?" (TC3/TC4)'),
              selected: _intent == 'order_status',
              onSelected: (_) => setState(() {
                _intent = 'order_status';
                _input.text = 'Where is my order?';
              }),
            ),
            ChoiceChip(
              label: const Text('Unsupported video call (E19-US4-TC1)'),
              selected: _intent == 'unsupported',
              onSelected: (_) => setState(() {
                _intent = 'unsupported';
                _input.text = 'Start a video call with the vendor';
              }),
            ),
            ChoiceChip(
              label: const Text('Cross-role vendor revenue (E19-US4-TC2)'),
              selected: _intent == 'cross_role',
              onSelected: (_) => setState(() {
                _intent = 'cross_role';
                _input.text = 'Show me BakeCharm net profit and recipe quantities';
              }),
            ),
          ],
        ),
        if (_intent == 'order_status') ...[
          const SizedBox(height: 6),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Simulate customer has active order', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
            value: _hasActiveOrder,
            onChanged: (v) => setState(() => _hasActiveOrder = v),
          ),
        ],
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(replyTitle, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                    ),
                    CapacityBadge(kind: badgeKind, label: badgeText),
                  ],
                ),
                const Divider(height: 20),
                Text(replyBody, style: const TextStyle(fontSize: 14)),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    if (_intent == 'search_exclusion')
                      KhaanaSecondaryButton(
                        label: 'Open Chocolate Cake customization',
                        icon: Icons.cake_outlined,
                        onPressed: () => Navigator.pushNamed(context, '/customize', arguments: 'cake'),
                      ),
                    if (_intent == 'unsupported')
                      KhaanaSecondaryButton(
                        label: 'Open Complaint Form (E18-US3-UI1)',
                        icon: Icons.report_problem_outlined,
                        onPressed: () => Navigator.pushNamed(context, '/complaint'),
                      ),
                    KhaanaSecondaryButton(
                      label: 'Open Voice Ordering (E19-US2-UI1)',
                      icon: Icons.mic_rounded,
                      onPressed: () => Navigator.pushNamed(context, '/voice-order'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// E19-US2-UI1: Voice order
/// Must show: Live transcript, read-back card, Confirm and Cancel.
/// Ambiguous or low-confidence speech asks for clarification; no checkout until explicit confirmation.
class VoiceOrderScreen extends StatefulWidget {
  const VoiceOrderScreen({super.key});

  @override
  State<VoiceOrderScreen> createState() => _VoiceOrderScreenState();
}

class _VoiceOrderScreenState extends State<VoiceOrderScreen> {
  String _mode = 'high_confidence'; // 'high_confidence', 'low_confidence', 'confirmed', 'cancelled'

  @override
  Widget build(BuildContext context) {
    final session = CustomerScope.of(context);
    return KhaanaPage(
      uiId: 'E19-US2-UI1',
      title: 'Voice order',
      footer: _mode == 'high_confidence'
          ? Row(
              children: [
                Expanded(
                  child: KhaanaSecondaryButton(
                    label: 'Say "Cancel"',
                    icon: Icons.close_rounded,
                    onPressed: () => setState(() => _mode = 'cancelled'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: KhaanaPrimaryButton(
                    label: 'Confirm & place order',
                    icon: Icons.check_circle_outline,
                    onPressed: () {
                      session.addDish(session.dishes.firstWhere((d) => d.id == 'karahi'));
                      setState(() => _mode = 'confirmed');
                    },
                  ),
                ),
              ],
            )
          : KhaanaPrimaryButton(
              label: 'Speak another voice order',
              icon: Icons.mic_rounded,
              onPressed: () => setState(() => _mode = 'high_confidence'),
            ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ChoiceChip(
                label: const Text('High-confidence transcript (TC1)'),
                selected: _mode == 'high_confidence',
                onSelected: (_) => setState(() => _mode = 'high_confidence'),
              ),
              ChoiceChip(
                label: const Text('Low-confidence / ambiguous speech (TC4)'),
                selected: _mode == 'low_confidence',
                onSelected: (_) => setState(() => _mode = 'low_confidence'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.graphic_eq_rounded, color: KhaanaColors.orangeText),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text('Live Voice Transcript', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                      ),
                      CapacityBadge(
                        kind: _mode == 'low_confidence' ? CapacityKind.limited : CapacityKind.available,
                        label: _mode == 'low_confidence' ? 'Confidence 54% (Clarify)' : 'Confidence 94%',
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _mode == 'low_confidence'
                        ? '"Order one... [muffled] cake or karahi... for tonight"'
                        : '"Order 1 Chicken Karahi and 1 Garlic Butter Naan Basket from Lazeez Cloud Kitchen for the 6:30 PM slot using Cash on Delivery."',
                    style: const TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          if (_mode == 'low_confidence')
            const KhaanaInlineBanner(
              kind: CapacityKind.limited,
              text:
                  'Ambiguous or low-confidence speech detected: Please clarify whether you meant "Chocolate Cake" (BakeCharm) or "Chicken Karahi" (Lazeez Cloud Kitchen). No order is assembled or placed without clarification (E19-US2-TC4).',
            )
          else ...[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Assistant Read-Back Summary Card (E19-US2 AC1)', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
                    Divider(height: 20),
                    Text('• Kitchen: Lazeez Cloud Kitchen (Available intake · 5/12 hourly slots)'),
                    SizedBox(height: 4),
                    Text('• Items: 1× Chicken Karahi (Rs 1,450) + 1× Garlic Butter Naan Basket (Rs 360)'),
                    SizedBox(height: 4),
                    Text('• Delivery slot: Today 6:30 PM · Express · Payment: Cash on Delivery'),
                    SizedBox(height: 8),
                    Text('Total: Rs 1,974 (requires explicit confirmation before placing)', style: TextStyle(fontWeight: FontWeight.w800)),
                  ],
                ),
              ),
            ),
            if (_mode == 'confirmed') ...[
              const SizedBox(height: 10),
              const KhaanaInlineBanner(
                kind: CapacityKind.available,
                text: 'Explicit confirmation received. Voice order placed and added to your active orders!',
              ),
            ] else if (_mode == 'cancelled') ...[
              const SizedBox(height: 10),
              const KhaanaInlineBanner(
                kind: CapacityKind.closed,
                text: 'You said "Cancel" while awaiting confirmation. No order or payment was created (E19-US2-TC2).',
              ),
            ],
          ],
        ],
      ),
    );
  }
}

/// E22-US1-UI1: Responsive web layouts (Layout set)
/// Must show: Home, Menu with cart panel and Checkout at 360, 768 and 1280 px.
/// Include graceful unsupported-device guidance and breakpoint boundary layouts;
/// verify rider Android/iOS layouts as well as customer web.
class ResponsiveWebLayoutsScreen extends StatefulWidget {
  const ResponsiveWebLayoutsScreen({super.key});

  @override
  State<ResponsiveWebLayoutsScreen> createState() => _ResponsiveWebLayoutsScreenState();
}

class _ResponsiveWebLayoutsScreenState extends State<ResponsiveWebLayoutsScreen> {
  int _widthPx = 1280;
  bool _showUnsupportedDevice = false;

  @override
  Widget build(BuildContext context) {
    final session = CustomerScope.of(context);
    return KhaanaPage(
      uiId: 'E22-US1-UI1',
      title: 'Responsive web & cross-platform layouts',
      maxWidth: 1280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final bp in [
                (360, '360 px (Mobile Web / Android & iOS)'),
                (768, '768 px (Tablet Breakpoint)'),
                (1280, '1280 px (Desktop Web with Cart Panel)'),
              ])
                ChoiceChip(
                  label: Text(bp.$2),
                  selected: _widthPx == bp.$1 && !_showUnsupportedDevice,
                  onSelected: (_) => setState(() {
                    _widthPx = bp.$1;
                    _showUnsupportedDevice = false;
                  }),
                ),
              ChoiceChip(
                label: const Text('Unsupported OS / Browser Guidance (E22-US1-TC5)'),
                selected: _showUnsupportedDevice,
                onSelected: (_) => setState(() => _showUnsupportedDevice = true),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const OfflineSyncBanner(),
          const SizedBox(height: 12),
          if (_showUnsupportedDevice)
            const KhaanaInlineBanner(
              kind: CapacityKind.full,
              text:
                  'Compatibility Notice (E22-US1-TC5): Your mobile OS or browser version is below the minimum supported specification or blocks required HTTPS storage. Please use a modern mobile/desktop browser (Chrome, Safari, Firefox, Edge) or a supported Android/iOS device.',
            )
          else
            Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: _widthPx.toDouble()),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Viewport Preview: $_widthPx px (${_widthPx >= 1280 ? '3-Column Desktop + Side Cart' : _widthPx >= 768 ? '2-Column Tablet Split' : 'Single-Column Phone Stack'})',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                            ),
                            const CapacityBadge(kind: CapacityKind.available, label: 'No clipped controls'),
                          ],
                        ),
                        const Divider(height: 24),
                        if (_widthPx >= 768)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('1. Home & Vendor Menu (BakeCharm)', style: TextStyle(fontWeight: FontWeight.w800)),
                                    const SizedBox(height: 8),
                                    const KitchenCapacityMeter(title: 'BakeCharm Live Slot Load', booked: 9, limit: 12),
                                    const SizedBox(height: 8),
                                    ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: const Text('Chocolate Cake (Rs 1,850 · 420 kcal)', style: TextStyle(fontWeight: FontWeight.w700)),
                                      subtitle: const Text('Fragile · Express only · Custom text & no-nuts chip'),
                                      trailing: KhaanaSecondaryButton(
                                        label: 'Customize',
                                        onPressed: () => Navigator.pushNamed(context, '/customize', arguments: 'cake'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  padding: const EdgeInsets.all(14),
                                  decoration: BoxDecoration(
                                    color: KhaanaColors.surface2Light,
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(color: KhaanaColors.lineLight),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('2. Docked Cart & Slot Checkout Panel', style: TextStyle(fontWeight: FontWeight.w800)),
                                      const SizedBox(height: 8),
                                      Text('Selected Slot: ${session.selectedSlot ?? '6:30 PM'} (Held 04:59)'),
                                      const SizedBox(height: 8),
                                      const PriceLines(
                                        lines: [
                                          ('Food subtotal', 1850),
                                          ('Delivery base + road distance', 124),
                                          ('Rain surcharge', 40),
                                        ],
                                        total: 2014,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        else
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('360 px Mobile Web & Android/iOS Stack', style: TextStyle(fontWeight: FontWeight.w800)),
                              const SizedBox(height: 8),
                              const KitchenCapacityMeter(title: 'BakeCharm Live Slot Load', booked: 9, limit: 12),
                              const SizedBox(height: 8),
                              const Text('• Menu card stacks cleanly with sticky bottom cart bar.'),
                              const Text('• Rider Android/iOS high-contrast 64dp buttons remain unclipped.'),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
