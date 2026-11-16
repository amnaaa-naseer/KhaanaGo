import 'package:flutter_test/flutter_test.dart';
import 'package:khaana_design/khaana_design.dart';
import 'package:khaanago_portal/main.dart';

void main() {
  setUpAll(disableFontFetchingForTests);

  testWidgets('vendor sign-in offers owner and staff', (tester) async {
    await tester.pumpWidget(const PortalApp());
    expect(find.text('E1-US3-UI1'), findsOneWidget);
    expect(find.text('Continue as kitchen staff'), findsOneWidget);
  });
}
