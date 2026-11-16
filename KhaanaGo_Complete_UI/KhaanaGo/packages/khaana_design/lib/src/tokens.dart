import 'package:flutter/material.dart';

/// Tokens from KhaanaGo Design System v1.0, Zesty Orange and Charcoal.
class KhaanaColors {
  const KhaanaColors._();

  static const orange = Color(0xFFF97316);
  static const orangePressed = Color(0xFFFB923C);
  static const orangeText = Color(0xFFC2410C);
  static const orangeTint = Color(0xFFFFEDD5);
  static const onOrangeTint = Color(0xFF7C2D12);
  static const charcoal = Color(0xFF242424);
  static const cream = Color(0xFFFFF8EF);
  static const white = Color(0xFFFFFFFF);
  static const pageDark = Color(0xFF1A1A1A);
  static const surfaceDark = Color(0xFF242424);
  static const surface2Light = Color(0xFFFBF0E2);
  static const surface2Dark = Color(0xFF2E2E2E);
  static const mutedLight = Color(0xFF6B635B);
  static const mutedDark = Color(0xFFB8AEA3);
  static const lineLight = Color(0xFFEADBC8);
  static const lineDark = Color(0xFF3A3835);
  static const fieldLight = Color(0xFF8A7F73);
  static const fieldDark = Color(0xFF8C8379);

  static const available = Color(0xFF15803D);
  static const availableTint = Color(0xFFDCFCE7);
  static const limited = Color(0xFF854D0E);
  static const limitedTint = Color(0xFFFEF3C7);
  static const full = Color(0xFFB91C1C);
  static const fullTint = Color(0xFFFEE2E2);
  static const closed = Color(0xFF57534E);
  static const closedTint = Color(0xFFE7E5E4);
  static const info = Color(0xFF0369A1);
  static const infoTint = Color(0xFFE0F2FE);

  static const availableDark = Color(0xFF4ADE80);
  static const availableTintDark = Color(0xFF14301E);
  static const limitedDark = Color(0xFFFACC15);
  static const limitedTintDark = Color(0xFF3A3010);
  static const fullDark = Color(0xFFF87171);
  static const fullTintDark = Color(0xFF3F1A1A);
  static const closedDark = Color(0xFFA8A29E);
  static const closedTintDark = Color(0xFF2E2C2A);
  static const infoDark = Color(0xFF38BDF8);
  static const infoTintDark = Color(0xFF102B3A);
  static const orangeTextDark = Color(0xFFFB923C);
  static const orangeTintDark = Color(0xFF3A2415);
  static const onOrangeTintDark = Color(0xFFFDBA74);
}

String formatRupees(int amount) {
  final negative = amount < 0;
  final digits = amount.abs().toString();
  final buffer = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) buffer.write(',');
    buffer.write(digits[i]);
  }
  return negative ? '− Rs $buffer' : 'Rs $buffer';
}
