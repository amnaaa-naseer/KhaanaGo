import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:khaana_screens/khaana_screens.dart';

void main() {
  testWidgets('typing in the first sign-in field never changes the password field', (tester) async {
    for (final home in ['E1-US1-UI3', 'E1-US2-UI2']) {
      final role = home == 'E1-US2-UI2' ? 'rider' : 'customer';
      await tester.pumpWidget(KhaanaApp(key: ValueKey(home), role: role, api: MemoryKhaanaApi(), homeId: home));
      await tester.pump();
      await tester.pump();

      final identifier = find.byKey(const Key('sign-in-identifier'));
      final password = find.byKey(const Key('sign-in-password'));
      expect(identifier, findsOneWidget, reason: home);
      expect(password, findsOneWidget, reason: home);
      expect(find.byType(AutofillGroup), findsOneWidget, reason: home);

      final identifierField = tester.widget<TextField>(identifier);
      final passwordField = tester.widget<TextField>(password);
      expect(identifierField.autofillHints, [AutofillHints.username]);
      expect(identifierField.textInputAction, TextInputAction.next);
      expect(identifierField.keyboardType, role == 'rider' ? TextInputType.phone : TextInputType.emailAddress);
      expect(passwordField.obscureText, isTrue);
      expect(passwordField.autofillHints, [AutofillHints.password]);
      expect(passwordField.textInputAction, TextInputAction.done);
      expect(identifierField.controller, isNot(same(passwordField.controller)));

      await tester.enterText(identifier, '03001234567');
      await tester.pump();

      expect(identifierField.controller!.text, '03001234567');
      expect(passwordField.controller!.text, isEmpty);
    }
  });

  testWidgets('a failed sign-in keeps the identifier and clears only the password', (tester) async {
    await tester.pumpWidget(KhaanaApp(role: 'customer', api: MemoryKhaanaApi(), homeId: 'E1-US1-UI3'));
    await tester.pump();
    await tester.pump();

    await tester.enterText(find.byKey(const Key('sign-in-identifier')), '03001234567');
    await tester.enterText(find.byKey(const Key('sign-in-password')), 'short');
    await tester.tap(find.byKey(const Key('primary-E1-US1-UI3')));
    await tester.pump();
    await tester.pump();

    expect(tester.widget<TextField>(find.byKey(const Key('sign-in-identifier'))).controller!.text, '03001234567');
    expect(tester.widget<TextField>(find.byKey(const Key('sign-in-password'))).controller!.text, isEmpty);
    expect(find.text('Password must be 8 to 128 characters. This check is provisional and awaiting review.'), findsOneWidget);
  });
}
