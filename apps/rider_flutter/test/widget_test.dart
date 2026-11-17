import 'package:flutter_test/flutter_test.dart';
import 'package:khaana_screens/khaana_screens.dart';

void main() {
  testWidgets('rider opens on sign-in', (tester) async {
    await tester.pumpWidget(KhaanaApp(role: 'rider', api: MemoryKhaanaApi(), homeId: 'E1-US2-UI2'));
    await tester.pump();
    expect(find.text('E1-US2-UI2'), findsNothing);
    expect(find.text('Sign in'), findsWidgets);
  });
}
