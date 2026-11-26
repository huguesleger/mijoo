import 'package:flutter/material.dart';

import 'package:mijoo/core_ui/core_ui.dart';

abstract final class DsTheme {
  static ThemeData light() => ThemeData(
    useMaterial3: true,
    fontFamily: FontFamily.comfortaa,
    scaffoldBackgroundColor: DsColors.background,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(letterSpacing: 0),
      bodyMedium: TextStyle(letterSpacing: 0),
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: DsColors.lavenderStrong).copyWith(
      primary: DsColors.primary,
      primaryContainer: DsColors.lavender,
      onPrimaryContainer: DsColors.ink,
      secondary: DsColors.peonyStrong,
      secondaryContainer: DsColors.peony,
      onSecondaryContainer: DsColors.ink,
      tertiary: DsColors.apricotStrong,
      tertiaryContainer: DsColors.apricot,
      onTertiaryContainer: DsColors.ink,
      surface: DsColors.surface,
      onSurface: DsColors.ink,
      error: DsColors.error,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: DsColors.ink,
        foregroundColor: DsColors.onInk,
        disabledBackgroundColor: DsColors.disabled,
        disabledForegroundColor: DsColors.placeholder,
        textStyle: DsTextStyles.button,
        minimumSize: const Size.fromHeight(DsSpacing.buttonHeight),
        shape: const RoundedRectangleBorder(borderRadius: DsRadius.pill),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: DsColors.ink,
        textStyle: DsTextStyles.button,
        minimumSize: const Size.fromHeight(DsSpacing.tapTarget),
        shape: const RoundedRectangleBorder(borderRadius: DsRadius.pill),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: DsColors.ink,
        backgroundColor: DsColors.surface,
        side: const BorderSide(color: DsColors.lavenderStrong),
        textStyle: DsTextStyles.button,
        minimumSize: const Size.fromHeight(DsSpacing.buttonHeight),
        shape: const RoundedRectangleBorder(borderRadius: DsRadius.pill),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: DsColors.field,
      hintStyle: TextStyle(color: DsColors.placeholder, letterSpacing: 0),
      prefixIconColor: DsColors.lavenderStrong,
      suffixIconColor: DsColors.placeholder,
      contentPadding: EdgeInsets.symmetric(
        horizontal: DsSpacing.medium,
        vertical: DsSpacing.medium,
      ),
      border: OutlineInputBorder(
        borderRadius: DsRadius.field,
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: DsRadius.field,
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: DsRadius.field,
        borderSide: BorderSide(color: DsColors.lavenderStrong, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: DsRadius.field,
        borderSide: BorderSide(color: DsColors.error, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: DsRadius.field,
        borderSide: BorderSide(color: DsColors.error, width: 1.5),
      ),
    ),
  );
}
