import 'package:flutter/material.dart';

import 'package:mijoo/core_ui/core_ui.dart';

abstract final class MjTheme {
  static ThemeData light() => ThemeData(
    useMaterial3: true,
    fontFamily: FontFamily.comfortaa,
    scaffoldBackgroundColor: MjColors.background,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(letterSpacing: 0),
      bodyMedium: TextStyle(letterSpacing: 0),
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: MjColors.lavenderStrong).copyWith(
      primary: MjColors.primary,
      primaryContainer: MjColors.lavender,
      onPrimaryContainer: MjColors.ink,
      secondary: MjColors.peonyStrong,
      secondaryContainer: MjColors.peony,
      onSecondaryContainer: MjColors.ink,
      tertiary: MjColors.apricotStrong,
      tertiaryContainer: MjColors.apricot,
      onTertiaryContainer: MjColors.ink,
      surface: MjColors.surface,
      onSurface: MjColors.ink,
      error: MjColors.error,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: MjColors.ink,
        foregroundColor: MjColors.onInk,
        disabledBackgroundColor: MjColors.disabled,
        disabledForegroundColor: MjColors.placeholder,
        textStyle: MjTextStyles.button,
        minimumSize: const Size.fromHeight(MjSpacing.buttonHeight),
        shape: const RoundedRectangleBorder(borderRadius: MjRadius.pill),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: MjColors.ink,
        textStyle: MjTextStyles.button,
        minimumSize: const Size.fromHeight(MjSpacing.tapTarget),
        shape: const RoundedRectangleBorder(borderRadius: MjRadius.pill),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: MjColors.ink,
        backgroundColor: MjColors.surface,
        side: const BorderSide(color: MjColors.lavenderStrong),
        textStyle: MjTextStyles.button,
        minimumSize: const Size.fromHeight(MjSpacing.buttonHeight),
        shape: const RoundedRectangleBorder(borderRadius: MjRadius.pill),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: MjColors.field,
      hintStyle: TextStyle(color: MjColors.placeholder, letterSpacing: 0),
      prefixIconColor: MjColors.lavenderStrong,
      suffixIconColor: MjColors.placeholder,
      contentPadding: EdgeInsets.symmetric(
        horizontal: MjSpacing.medium,
        vertical: MjSpacing.medium,
      ),
      border: OutlineInputBorder(
        borderRadius: MjRadius.field,
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: MjRadius.field,
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: MjRadius.field,
        borderSide: BorderSide(color: MjColors.lavenderStrong, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: MjRadius.field,
        borderSide: BorderSide(color: MjColors.error, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: MjRadius.field,
        borderSide: BorderSide(color: MjColors.error, width: 1.5),
      ),
    ),
  );
}
