import 'package:flutter_test/flutter_test.dart';
import 'package:khaana_screens/khaana_screens.dart';

void main() {
  testWidgets('customer opens on login', (tester) async {
    await tester.pumpWidget(KhaanaApp(role: 'customer', api: MemoryKhaanaApi(), homeId: 'E1-US1-UI3'));
    await tester.pump();
    expect(find.text('E1-US1-UI3'), findsWidgets);
    expect(find.text('Login'), findsWidgets);
  });
}
