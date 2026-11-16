import 'package:flutter_test/flutter_test.dart';
import 'package:khaana_design/khaana_design.dart';
import 'package:khaanago_rider/main.dart';

void main() {
  setUpAll(disableFontFetchingForTests);

  testWidgets('rider sign-in is the first screen', (tester) async {
    await tester.pumpWidget(const RiderApp());
    expect(find.text('E1-US2-UI2'), findsOneWidget);
  });
}
