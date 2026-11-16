// KhaanaGo UI tokens and Material 3 theme for customer / rider apps.
// Place in lib/theme/khaanago_theme.dart during the Flutter development phase.
import 'package:flutter/material.dart';

abstract final class KgColors {
  static const cream = Color(0xFFFFF8EF);
  static const surface = Color(0xFFFFFFFF);
  static const orange = Color(0xFFF97316);
  static const orangeText = Color(0xFFC2410C);
  static const orangeTint = Color(0xFFFFEDD5);
  static const charcoal = Color(0xFF242424);
  static const muted = Color(0xFF6B635B);
  static const border = Color(0xFFEADBC8);
  static const available = Color(0xFF15803D);
  static const limited = Color(0xFF854D0E);
  static const full = Color(0xFFB91C1C);
  static const information = Color(0xFF0369A1);
}

abstract final class KhaanaGoTheme {
  static ThemeData get customer => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: KgColors.cream,
    colorScheme: ColorScheme.fromSeed(
      seedColor: KgColors.orange,
      primary: KgColors.orange,
      onPrimary: KgColors.charcoal,
      surface: KgColors.surface,
      onSurface: KgColors.charcoal,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: KgColors.cream,
      foregroundColor: KgColors.charcoal,
      elevation: 0,
      centerTitle: false,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: KgColors.orange,
        foregroundColor: KgColors.charcoal,
        minimumSize: const Size(0, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: KgColors.surface,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    ),
    cardTheme: CardThemeData(
      color: KgColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );

  static ThemeData get rider => customer.copyWith(
    textTheme: customer.textTheme.apply(fontSizeFactor: 1.14),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: KgColors.orange,
        foregroundColor: KgColors.charcoal,
        minimumSize: const Size(0, 64),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),
  );
}

class KgCapacityBadge extends StatelessWidget {
  const KgCapacityBadge({required this.state, super.key});
  final String state;
  @override
  Widget build(BuildContext context) {
    final foreground = switch (state) {
      'Available' => KgColors.available,
      'Limited' => KgColors.limited,
      'Full' => KgColors.full,
      _ => KgColors.muted,
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: foreground.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(state, style: TextStyle(color: foreground, fontWeight: FontWeight.w700)),
    );
  }
}
