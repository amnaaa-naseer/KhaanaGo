import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:khaana_screens/khaana_screens.dart';

void main() {
  testWidgets('rider home shows the pickup alert and then the delivery step', (tester) async {
    final api = MemoryKhaanaApi();
    api.orders.add({
      'id': 'KG-1042',
      'status': 'ready',
      'slotLabel': '7:40 PM',
      'vendorName': 'BakeCharm',
      'code': '482100',
      'riderId': 'rider',
      'rider': {'id': 'rider', 'name': 'Hamza Ali', 'vehicle': 'Motorbike'},
    });
    api.alerts.add({
      'id': 'ALERT-KG-1042',
      'type': 'pickup',
      'orderId': 'KG-1042',
      'riderId': 'rider',
      'status': 'open',
      'vendorName': 'BakeCharm',
      'slotLabel': '7:40 PM',
    });

    await tester.pumpWidget(KhaanaApp(role: 'rider', api: api, homeId: 'E13-US2-UI2'));
    await tester.pump();
    await tester.pump();

    expect(find.text('Pickup alert'), findsOneWidget);
    expect(find.textContaining('KG-1042'), findsOneWidget);
    expect(find.text('Pick up'), findsOneWidget);
    expect(find.text('Deliver'), findsNothing);

    await tester.tap(find.text('Pick up'));
    await tester.pump();
    await tester.pump();

    expect(find.text('Pick up'), findsNothing);
    expect(find.text('Out for delivery'), findsOneWidget);
    expect(find.text('6-digit delivery code'), findsOneWidget);
    expect(find.text('Deliver'), findsOneWidget);
    expect(find.text('Picked up KG-1042. Enter the delivery code when you arrive.'), findsOneWidget);
    expect(find.textContaining('409'), findsNothing);

    await tester.tap(find.text('Deliver'));
    await tester.pump();
    await tester.pump();
    expect(find.text('That code does not match. The delivery stays incomplete.'), findsOneWidget);
  });
}
