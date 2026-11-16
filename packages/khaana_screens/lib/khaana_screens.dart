export 'src/app_shell.dart';
export 'src/api.dart';
export 'src/checkout_session.dart';
export 'src/catalog.g.dart';
export 'src/screen_spec.dart';
export 'src/screen_view.dart';

import 'src/catalog.g.dart';
import 'src/screen_spec.dart';

List<ScreenSpec> screensFor(String role) {
  return kScreenCatalog.where((spec) => spec.role == role || spec.role == 'shared').toList();
}

ScreenSpec? screenById(String id) {
  for (final spec in kScreenCatalog) {
    if (spec.id == id) return spec;
  }
  return null;
}
