import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:khaana_screens/khaana_screens.dart';

void main() {
  test('inventory counts stay exact', () {
    expect(kScreenCatalog.length, 189);
    expect(kScreenCatalog.map((s) => s.id).toSet().length, 189);
    expect(kScreenCatalog.where((s) => s.role == 'customer').length, 48);
    expect(kScreenCatalog.where((s) => s.role == 'rider').length, 43);
    expect(kScreenCatalog.where((s) => s.role == 'vendor').length, 69);
    expect(kScreenCatalog.where((s) => s.role == 'admin').length, 25);
    expect(kScreenCatalog.where((s) => s.role == 'shared').length, 4);
    expect(kScreenCatalog.where((s) => s.kind == 'Screen').length, 139);
    expect(kScreenCatalog.where((s) => s.kind == 'Overlay').length, 47);
    expect(kScreenCatalog.where((s) => s.kind == 'Layout set').length, 3);
  });

  testWidgets('every design renders its id, title, and a primary action', (tester) async {
    final api = MemoryKhaanaApi();
    for (final spec in kScreenCatalog) {
      await tester.pumpWidget(MaterialApp(home: ScreenPage(spec: spec, api: api, role: spec.role == 'shared' ? 'customer' : spec.role, onOpen: (_) {})));
      await tester.pump();
      expect(find.text(spec.id), findsWidgets, reason: spec.id);
      expect(find.text(spec.title), findsWidgets, reason: spec.title);
      expect(find.byKey(Key('primary-${spec.id}')), findsOneWidget, reason: spec.id);
    }
  });
}
