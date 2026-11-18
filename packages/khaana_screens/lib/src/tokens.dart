import 'package:flutter/material.dart';

/// Tokens from docs/KhaanaGo_Design_System_v2.html (Zesty Orange and Charcoal).
class KhaanaColors {
  const KhaanaColors._();

  static const brand = Color(0xFFF97316);
  static const brandPress = Color(0xFFFB923C);
  static const brandText = Color(0xFFC2410C);
  static const brandTint = Color(0xFFFFEDD5);
  static const onBrand = Color(0xFF242424);
  static const onBrandTint = Color(0xFF7C2D12);
  static const focus = Color(0xFFC2410C);

  static const charcoal = Color(0xFF242424);
  static const cream = Color(0xFFFFF8EF);
  static const white = Color(0xFFFFFFFF);
  static const pageDark = Color(0xFF1A1A1A);
  static const surfaceDark = Color(0xFF242424);
  static const surface2 = Color(0xFFFBF0E2);
  static const surface2Dark = Color(0xFF2E2E2E);
  static const muted = Color(0xFF6B635B);
  static const mutedDark = Color(0xFFB8AEA3);
  static const line = Color(0xFFEADBC8);
  static const lineStrong = Color(0xFFD9C3A5);
  static const lineDark = Color(0xFF3A3835);
  static const field = Color(0xFF8A7F73);
  static const fieldDark = Color(0xFF8C8379);

  static const ok = Color(0xFF15803D);
  static const okTint = Color(0xFFDCFCE7);
  static const limited = Color(0xFF854D0E);
  static const limitedTint = Color(0xFFFEF3C7);
  static const full = Color(0xFFB91C1C);
  static const fullTint = Color(0xFFFEE2E2);
  static const closed = Color(0xFF57534E);
  static const closedTint = Color(0xFFE7E5E4);
  static const info = Color(0xFF0369A1);
  static const infoTint = Color(0xFFE0F2FE);

  static Color page(bool dark) => dark ? pageDark : cream;
  static Color surface(bool dark) => dark ? surfaceDark : white;
  static Color ink(bool dark) => dark ? cream : charcoal;
  static Color mutedOf(bool dark) => dark ? mutedDark : muted;
  static Color lineOf(bool dark) => dark ? lineDark : line;
}

/// 8 dp grid with a 4 dp half step.
class KhaanaSpace {
  const KhaanaSpace._();

  static const s1 = 4.0;
  static const s2 = 8.0;
  static const s3 = 12.0;
  static const s4 = 16.0;
  static const s5 = 24.0;
  static const s6 = 32.0;
  static const s7 = 48.0;
  static const s8 = 64.0;

  static const EdgeInsets page = EdgeInsets.all(s4);
  static const EdgeInsets card = EdgeInsets.all(s4);
}

class KhaanaRadius {
  const KhaanaRadius._();

  static const button = 12.0;
  static const card = 16.0;
  static const sheet = 24.0;
  static const pill = 999.0;
}

class KhaanaElevation {
  const KhaanaElevation._();

  static const level1 = [
    BoxShadow(color: Color(0x14242424), offset: Offset(0, 1), blurRadius: 2),
    BoxShadow(color: Color(0x0F242424), offset: Offset(0, 4), blurRadius: 12),
  ];
}

class KhaanaMotion {
  const KhaanaMotion._();

  static const tap = Duration(milliseconds: 120);
  static const sheet = Duration(milliseconds: 220);
  static const page = Duration(milliseconds: 300);
  static const Curve ease = Cubic(0.2, 0, 0, 1);
}

class KhaanaType {
  const KhaanaType._();

  static const family = 'Plus Jakarta Sans';

  static const display = TextStyle(fontFamily: family, fontSize: 28, height: 36 / 28, fontWeight: FontWeight.w800);
  static const title = TextStyle(fontFamily: family, fontSize: 22, height: 28 / 22, fontWeight: FontWeight.w700);
  static const heading = TextStyle(fontFamily: family, fontSize: 18, height: 24 / 18, fontWeight: FontWeight.w700);
  static const body = TextStyle(fontFamily: family, fontSize: 16, height: 24 / 16, fontWeight: FontWeight.w500);
  static const bodySmall = TextStyle(fontFamily: family, fontSize: 14, height: 20 / 14, fontWeight: FontWeight.w500);
  static const button = TextStyle(fontFamily: family, fontSize: 16, height: 24 / 16, fontWeight: FontWeight.w700, color: KhaanaColors.onBrand);
  static const price = TextStyle(fontFamily: family, fontSize: 18, height: 24 / 18, fontWeight: FontWeight.w700, fontFeatures: [FontFeature.tabularFigures()]);
  static const caption = TextStyle(fontFamily: family, fontSize: 12, height: 16 / 12, fontWeight: FontWeight.w600, color: KhaanaColors.muted);
  static const eyebrow = TextStyle(fontFamily: family, fontSize: 12, height: 16 / 12, fontWeight: FontWeight.w700, letterSpacing: 0.72, color: KhaanaColors.muted);
  static const riderBody = TextStyle(fontFamily: family, fontSize: 20, height: 28 / 20, fontWeight: FontWeight.w500, color: KhaanaColors.cream);
  static const riderButton = TextStyle(fontFamily: family, fontSize: 20, height: 28 / 20, fontWeight: FontWeight.w800, color: KhaanaColors.onBrand);

  static const control = 56.0;
  static const controlRider = 64.0;
  static const field = 48.0;
}
