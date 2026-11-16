import 'package:flutter_test/flutter_test.dart';
import 'package:khaana_design/khaana_design.dart';
import 'package:khaanago_customer/main.dart';

void main() {
  setUpAll(disableFontFetchingForTests);

  testWidgets('customer login is the first screen', (tester) async {
    await tester.pumpWidget(const CustomerApp());
    expect(find.text('E1-US1-UI3'), findsOneWidget);
    expect(find.text('Forgot password?'), findsOneWidget);
  });
}
