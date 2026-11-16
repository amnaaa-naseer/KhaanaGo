import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:khaana_screens/khaana_screens.dart';

void main() {
  testWidgets('checkout selections survive screen changes and the placed order uses them', (tester) async {
    final api = MemoryKhaanaApi();
    final session = CheckoutSession();
    await tester.pumpWidget(KhaanaApp(role: 'customer', api: api, homeId: 'E3-US1-UI3', session: session));
    await tester.pump();

    Future<void> tapLabel(String label) async {
      final finder = find.text(label);
      await tester.ensureVisible(finder);
      await tester.pump();
      await tester.tap(finder);
      await tester.pump();
      await tester.pump();
    }

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(session.qty, 2);

    await tapLabel('Add to cart');
    expect(find.text('Customization builder'), findsWidgets);

    await tester.enterText(find.byType(TextField), 'No nuts');
    await tester.pump();
    await tapLabel('Save customization');
    expect(session.note, 'No nuts');
    expect(find.text('Cart'), findsWidgets);
    expect(find.textContaining('2 × Chocolate fudge cake'), findsOneWidget);

    await tapLabel('Choose delivery');
    await tapLabel('Choose a slot');
    await tapLabel('Hold this slot');
    await tapLabel('Review order');

    expect(find.textContaining('Total Rs ${session.total}'), findsOneWidget);
    expect(session.total, 1850 * 2 + 180);

    await tester.ensureVisible(find.text('Place order'));
    await tester.pump();
    await tester.tap(find.text('Place order'));
    await tester.pump();
    await tester.pump();

    expect(api.orders, isNotEmpty);
    expect(api.orders.first['lines'][0]['qty'], 2);
    expect(api.orders.first['lines'][0]['price'], 1850);
    expect(api.orders.first['lines'][0]['note'], 'No nuts');
    expect(api.orders.first['total'], 3880);
    expect(find.textContaining(api.orders.first['id'] as String), findsWidgets);
  });

  test('a client price cannot replace the menu price', () async {
    final api = MemoryKhaanaApi();
    await api.holdSlot('1830');
    final order = await api.placeOrder({
      'slotId': '1830',
      'delivery': 'express',
      'payment': 'Cash on delivery',
      'lines': [
        {'id': 'cake', 'qty': 1, 'price': 1},
      ],
    });
    expect(order['food'], 1850);
    expect(order['total'], 2030);
  });
}
