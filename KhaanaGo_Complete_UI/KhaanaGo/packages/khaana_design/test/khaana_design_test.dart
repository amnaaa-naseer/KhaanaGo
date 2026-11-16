import 'package:flutter_test/flutter_test.dart';
import 'package:khaana_design/khaana_design.dart';

void main() {
  test('intake bands follow the provisional thresholds', () {
    expect(PrototypeAssumptions.intakeBandLabel(59), 'Available');
    expect(PrototypeAssumptions.intakeBandLabel(60), 'Limited');
    expect(PrototypeAssumptions.intakeBandLabel(84), 'Limited');
    expect(PrototypeAssumptions.intakeBandLabel(85), 'Full');
    expect(PrototypeAssumptions.waitingPayRatePerMinute, isNull);
  });
}
