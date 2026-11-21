import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Brand tokens. Orange is for primary actions and active states.
class KhaanaColors {
  const KhaanaColors._();

  static const brand = Color(0xFFCF4C21);
  static const brandPress = Color(0xFFB53F18);
  static const brandText = Color(0xFFB53F18);
  static const onBrand = Color(0xFFFFFFFF);
  static const ink = Color(0xFF1C1917);
  static const muted = Color(0xFF6B625B);
  static const cream = Color(0xFFF7EBD6);
  static const background = Color(0xFFFBF6EC);
  static const white = Color(0xFFFFFFFF);
  static const ok = Color(0xFF2E7D4F);
  static const limited = Color(0xFFB7791F);
  static const full = Color(0xFFB3261E);
  static const info = Color(0xFF2F6DB5);
  static const closed = Color(0xFF57534E);

  static const brandTint = cream;
  static const surface2 = cream;
  static const okTint = cream;
  static const limitedTint = cream;
  static const fullTint = cream;
  static const closedTint = cream;
  static const infoTint = cream;
  static const onBrandTint = ink;
  static const focus = brand;
  static const charcoal = ink;
  static const line = Color(0xFFDAD9D8);

  static Color page(bool _) => background;
  static Color surface(bool _) => white;
  static Color mutedOf(bool _) => muted;
  static Color lineOf(bool _) => line;
}

const kBrandSplashIds = {'E1-US1-UI3', 'E1-US2-UI2', 'E1-US1-UI6', 'E1-US2-UI1'};

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
    BoxShadow(color: Color(0x141C1917), offset: Offset(0, 1), blurRadius: 2),
    BoxShadow(color: Color(0x0F1C1917), offset: Offset(0, 4), blurRadius: 12),
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

  static const display = TextStyle(fontSize: 28, height: 36 / 28, fontWeight: FontWeight.w800);
  static const title = TextStyle(fontSize: 22, height: 28 / 22, fontWeight: FontWeight.w700);
  static const heading = TextStyle(fontSize: 18, height: 24 / 18, fontWeight: FontWeight.w700);
  static const body = TextStyle(fontSize: 16, height: 24 / 16, fontWeight: FontWeight.w500);
  static const bodySmall = TextStyle(fontSize: 14, height: 20 / 14, fontWeight: FontWeight.w500);
  static const button = TextStyle(fontSize: 16, height: 24 / 16, fontWeight: FontWeight.w700, color: KhaanaColors.onBrand);
  static const price = TextStyle(fontSize: 18, height: 24 / 18, fontWeight: FontWeight.w700, fontFeatures: [FontFeature.tabularFigures()]);
  static const caption = TextStyle(fontSize: 12, height: 16 / 12, fontWeight: FontWeight.w600, color: KhaanaColors.muted);
  static const eyebrow = TextStyle(fontSize: 12, height: 16 / 12, fontWeight: FontWeight.w700, letterSpacing: 0.72, color: KhaanaColors.muted);
  static const riderBody = TextStyle(fontSize: 20, height: 28 / 20, fontWeight: FontWeight.w500, color: KhaanaColors.ink);
  static const riderButton = TextStyle(fontSize: 20, height: 28 / 20, fontWeight: FontWeight.w800, color: KhaanaColors.onBrand);

  static const control = 56.0;
  static const controlRider = 64.0;
  static const field = 48.0;
}

ThemeData khaanaTheme() {
  final base = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: KhaanaColors.background,
    colorScheme: const ColorScheme.light(
      primary: KhaanaColors.brand,
      onPrimary: KhaanaColors.onBrand,
      secondary: KhaanaColors.brand,
      onSecondary: KhaanaColors.onBrand,
      surface: KhaanaColors.white,
      onSurface: KhaanaColors.ink,
      error: KhaanaColors.full,
      onError: KhaanaColors.onBrand,
    ),
  );
  final text = GoogleFonts.plusJakartaSansTextTheme(base.textTheme).apply(bodyColor: KhaanaColors.ink, displayColor: KhaanaColors.ink);
  final border = OutlineInputBorder(borderRadius: BorderRadius.circular(KhaanaRadius.button), borderSide: const BorderSide(color: KhaanaColors.line));
  return base.copyWith(
    textTheme: text,
    primaryTextTheme: GoogleFonts.plusJakartaSansTextTheme(base.primaryTextTheme),
    appBarTheme: const AppBarTheme(
      backgroundColor: KhaanaColors.white,
      foregroundColor: KhaanaColors.ink,
      elevation: 0,
      surfaceTintColor: KhaanaColors.white,
    ),
    inputDecorationTheme: InputDecorationTheme(filled: true, fillColor: KhaanaColors.white, border: border, enabledBorder: border, focusedBorder: border.copyWith(borderSide: const BorderSide(color: KhaanaColors.brand, width: 1.5))),
  );
}
