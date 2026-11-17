import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:khaana_screens/khaana_screens.dart';

void main() {
  testWidgets('home is a searchable kitchen list without a page title', (tester) async {
    await tester.pumpWidget(KhaanaApp(role: 'customer', api: MemoryKhaanaApi(), homeId: 'E3-US1-UI1'));
    await tester.pump();
    await tester.pump();

    expect(find.descendant(of: find.byType(AppBar), matching: find.text('Home')), findsNothing);
    expect(find.text('Browse open kitchens'), findsNothing);
    expect(find.text('Open now'), findsOneWidget);
    expect(find.text('Busy'), findsOneWidget);
    expect(find.text('Quiet'), findsOneWidget);
    expect(find.text('Opens at 12:00 pm'), findsOneWidget);
    expect(find.text('Next 6:30 pm'), findsOneWidget);

    await tester.tap(find.text('Open now'));
    await tester.pump();
    expect(find.text('Margalla Grill'), findsNothing);
    expect(find.text('BakeCharm'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'karahi');
    await tester.pump();
    expect(find.text('Lazeez Karahi'), findsOneWidget);
    expect(find.text('BakeCharm'), findsNothing);
  });

  testWidgets('tracking stays on one screen and follows kitchen status', (tester) async {
    final api = MemoryKhaanaApi();
    final session = CheckoutSession();
    final placedAt = DateTime.utc(2026, 11, 17, 14).toIso8601String();
    api.orders.add({
      'id': 'KG-1042',
      'status': 'new',
      'slotLabel': '7:40 PM',
      'total': 2030,
      'payment': 'Cash on delivery',
      'vendorName': 'BakeCharm',
      'code': '482100',
      'lines': [
        {'name': 'Chocolate fudge cake', 'qty': 1},
      ],
      'events': {'placed': placedAt},
      'createdAt': placedAt,
    });
    session.rememberOrder(api.orders.first);

    await tester.pumpWidget(KhaanaApp(role: 'customer', api: api, homeId: 'E3-US1-UI1', session: session));
    await tester.pump();
    await tester.pump();

    expect(find.byKey(const Key('track-banner')), findsOneWidget);
    await tester.tap(find.byKey(const Key('track-banner')));
    await tester.pump();
    await tester.pump();

    expect(find.text('Ready by 7:40 pm'), findsOneWidget);
    expect(find.text('Hamza Ali'), findsNothing);
    expect(tester.widget<Text>(find.byKey(const Key('step-current'))).data, 'Placed');
    expect(find.text('Order KG-1042'), findsOneWidget);

    await api.advance('KG-1042', 'accept');
    await tester.pump(const Duration(seconds: 3));
    await tester.pump();
    expect(tester.widget<Text>(find.byKey(const Key('step-current'))).data, 'Preparing');

    await api.advance('KG-1042', 'ready');
    await api.advance('KG-1042', 'pickup');
    await tester.pump(const Duration(seconds: 3));
    await tester.pump();
    expect(find.text('On the way'), findsWidgets);
    expect(find.text('Hamza Ali'), findsOneWidget);
    expect(find.text('Code 482100'), findsOneWidget);

    await tester.tap(find.text('Help'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    await tester.tap(find.text('Report a problem'));
    await tester.pump();
    await tester.pump();
    expect(find.text('Complaint form'), findsWidgets);

    await tester.tap(find.byTooltip('Back'));
    await tester.pump();
    expect(find.text('On the way'), findsWidgets);
    expect(find.text('Hamza Ali'), findsOneWidget);

    await tester.tap(find.byTooltip('Back'));
    await tester.pump();
    await tester.pump();
    expect(find.text('Search kitchens'), findsOneWidget);
  });
}
