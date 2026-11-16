import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'tokens.dart';

enum KhaanaThemeKind { light, dark, rider }

/// Widget tests must not download fonts.
void disableFontFetchingForTests() {
  GoogleFonts.config.allowRuntimeFetching = false;
}

ThemeData khaanaTheme(KhaanaThemeKind kind) {
  final dark = kind != KhaanaThemeKind.light;
  final isRider = kind == KhaanaThemeKind.rider;
  final scheme = ColorScheme(
    brightness: dark ? Brightness.dark : Brightness.light,
    primary: KhaanaColors.orange,
    onPrimary: KhaanaColors.charcoal,
    primaryContainer: dark ? KhaanaColors.orangeTintDark : KhaanaColors.orangeTint,
    onPrimaryContainer: dark ? KhaanaColors.onOrangeTintDark : KhaanaColors.onOrangeTint,
    secondary: dark ? KhaanaColors.cream : KhaanaColors.charcoal,
    onSecondary: dark ? KhaanaColors.charcoal : KhaanaColors.cream,
    error: dark ? KhaanaColors.fullDark : KhaanaColors.full,
    onError: dark ? KhaanaColors.charcoal : KhaanaColors.white,
    surface: dark ? KhaanaColors.surfaceDark : KhaanaColors.white,
    onSurface: dark ? KhaanaColors.cream : KhaanaColors.charcoal,
    outline: dark ? KhaanaColors.fieldDark : KhaanaColors.fieldLight,
    outlineVariant: dark ? KhaanaColors.lineDark : KhaanaColors.lineLight,
  );
  final base = ThemeData(useMaterial3: true, colorScheme: scheme);
  final text = GoogleFonts.plusJakartaSansTextTheme(base.textTheme).apply(
    bodyColor: dark ? KhaanaColors.cream : KhaanaColors.charcoal,
    displayColor: dark ? KhaanaColors.cream : KhaanaColors.charcoal,
  );
  final scaled = isRider
      ? text.copyWith(
          bodyLarge: text.bodyLarge?.copyWith(fontSize: 20, height: 28 / 20, fontWeight: FontWeight.w500),
          bodyMedium: text.bodyMedium?.copyWith(fontSize: 18, height: 26 / 18, fontWeight: FontWeight.w500),
          titleLarge: text.titleLarge?.copyWith(fontSize: 28, height: 34 / 28, fontWeight: FontWeight.w800),
          titleMedium: text.titleMedium?.copyWith(fontSize: 20, height: 26 / 20, fontWeight: FontWeight.w700),
        )
      : text.copyWith(
          headlineMedium: text.headlineMedium?.copyWith(fontSize: 28, height: 36 / 28, fontWeight: FontWeight.w800),
          titleLarge: text.titleLarge?.copyWith(fontSize: 22, height: 28 / 22, fontWeight: FontWeight.w700),
          titleMedium: text.titleMedium?.copyWith(fontSize: 18, height: 24 / 18, fontWeight: FontWeight.w700),
          bodyLarge: text.bodyLarge?.copyWith(fontSize: 16, height: 24 / 16, fontWeight: FontWeight.w500),
          bodyMedium: text.bodyMedium?.copyWith(fontSize: 14, height: 20 / 14, fontWeight: FontWeight.w500),
        );
  return base.copyWith(
    scaffoldBackgroundColor: dark ? KhaanaColors.pageDark : KhaanaColors.cream,
    textTheme: scaled,
    appBarTheme: AppBarTheme(
      backgroundColor: dark ? KhaanaColors.surfaceDark : KhaanaColors.cream,
      foregroundColor: dark ? KhaanaColors.cream : KhaanaColors.charcoal,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: scaled.titleLarge?.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w800,
        color: dark ? KhaanaColors.cream : KhaanaColors.charcoal,
      ),
    ),
    dividerColor: scheme.outlineVariant,
    cardTheme: CardThemeData(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 6),
      color: scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: scheme.outlineVariant),
      ),
    ),
    chipTheme: base.chipTheme.copyWith(
      backgroundColor: scheme.surface,
      selectedColor: dark ? KhaanaColors.orangeTintDark : KhaanaColors.orangeTint,
      disabledColor: dark ? KhaanaColors.surface2Dark : KhaanaColors.surface2Light,
      side: BorderSide(color: scheme.outline, width: 1.5),
      shape: const StadiumBorder(),
      labelStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        color: dark ? KhaanaColors.cream : KhaanaColors.charcoal,
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: KhaanaColors.charcoal,
      contentTextStyle: const TextStyle(
        color: KhaanaColors.cream,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFF4A4743)),
      ),
      behavior: SnackBarBehavior.floating,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: scheme.surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: scheme.outline, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: scheme.outline, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: dark ? KhaanaColors.orange : KhaanaColors.orangeText,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: scheme.error, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: scheme.error, width: 2),
      ),
    ),
  );
}
