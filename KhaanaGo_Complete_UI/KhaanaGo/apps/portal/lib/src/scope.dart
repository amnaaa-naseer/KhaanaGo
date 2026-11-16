import 'package:flutter/material.dart';

import 'session.dart';

class PortalScope extends InheritedNotifier<PortalSession> {
  const PortalScope({super.key, required PortalSession session, required super.child}) : super(notifier: session);

  static PortalSession of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<PortalScope>();
    assert(scope != null, 'PortalScope is missing');
    return scope!.notifier!;
  }
}
