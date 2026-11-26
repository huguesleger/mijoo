import 'package:flutter/material.dart';

import 'assets/fonts.gen.dart';

abstract final class DsColors {
  static const ink = Color(0xFF15182F);
  static const primary = Color(0xFF6E4FC2);
  static const lavender = Color(0xFFCDBDF6);
  static const lavenderStrong = Color(0xFF8B6AD8);
  static const peony = Color(0xFFF8BBD0);
  static const peonyStrong = Color(0xFFD45D8A);
  static const apricot = Color(0xFFFFC9B3);
  static const apricotStrong = Color(0xFFE0784F);
  static const secondaryText = Color(0xFF505870);
  static const error = Color(0xFF9F1640);
  static const line = Color(0xFFC4BDE1);
  static const surface = Color(0xFFFDFBFF);
  static const background = Color(0xFFFAF8FD);
  static const heroPink = Color(0xFFFCE3EE);
  static const heroLilac = Color(0xFFEFE6FD);
  static const onInk = Color(0xFFFFFFFF);
  static const field = Color(0xFFF5F2FB);
  static const placeholder = Color(0xFF8A8FA3);
  static const neutralChip = Color(0xFFF1EEF8);
  static const neutralChipIcon = Color(0xFFB9B4CC);
  static const success = Color(0xFF1F6B45);
  static const successSurface = Color(0xFFE6F5EC);
  static const disabled = Color(0xFFDDDBE6);
}

abstract final class DsSpacing {
  static const small = 8.0;
  static const medium = 16.0;
  static const large = 24.0;
  static const extraLarge = 32.0;
  static const logoWidth = 104.0;
  static const sheetLogoWidth = 80.0;
  static const heroImageWidth = 270.0;
  static const buttonHeight = 56.0;
  static const contentWidth = 480.0;
  static const tapTarget = 48.0;
  static const sheetTop = 36.0;
  static const fieldGap = 12.0;
  static const extraSmall = 4.0;
}

abstract final class DsRadius {
  static const card = BorderRadius.all(Radius.circular(28));
  static const input = BorderRadius.all(Radius.circular(16));
  static const pill = BorderRadius.all(Radius.circular(99));
  static const field = BorderRadius.all(Radius.circular(18));
  static const sheet = BorderRadius.vertical(top: Radius.circular(36));
}

abstract final class DsTextStyles {
  static const display = TextStyle(
    color: DsColors.ink,
    fontSize: 34,
    height: 38 / 34,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.8,
  );
  static const title = TextStyle(
    color: DsColors.ink,
    fontSize: 32,
    fontWeight: FontWeight.w700,
  );
  static const body = TextStyle(
    color: DsColors.secondaryText,
    fontSize: 16,
    height: 23 / 16,
    letterSpacing: 0,
  );
  static const headline = TextStyle(
    color: DsColors.ink,
    fontSize: 32,
    height: 36 / 32,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.8,
  );
  static const fieldLabel = TextStyle(
    color: DsColors.ink,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  static const chip = TextStyle(fontSize: 12.5, fontWeight: FontWeight.w500);
  static const caption = TextStyle(
    color: DsColors.secondaryText,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );
  static const button = TextStyle(
    fontFamily: FontFamily.outfit,
    fontSize: 17,
    fontWeight: FontWeight.w600,
  );
}
