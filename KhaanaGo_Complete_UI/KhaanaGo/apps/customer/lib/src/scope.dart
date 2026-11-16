import 'package:flutter/material.dart';

import 'session.dart';

class CustomerScope extends InheritedNotifier<CustomerSession> {
  const CustomerScope({super.key, required CustomerSession session, required super.child})
      : super(notifier: session);

  static CustomerSession of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<CustomerScope>();
    assert(scope != null, 'CustomerScope is missing');
    return scope!.notifier!;
  }
}
