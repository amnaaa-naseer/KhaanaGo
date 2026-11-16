import 'package:flutter/material.dart';

import 'session.dart';

class RiderScope extends InheritedNotifier<RiderSession> {
  const RiderScope({super.key, required RiderSession session, required super.child}) : super(notifier: session);

  static RiderSession of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<RiderScope>();
    assert(scope != null, 'RiderScope is missing');
    return scope!.notifier!;
  }
}
