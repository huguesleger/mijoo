import 'package:mijoo/core_ui/foundation/mj_colors.dart';
import 'package:mijoo/core_ui/gen/fonts.gen.dart';
import 'package:flutter/painting.dart';

abstract final class MjTextStyles {
  static const display = TextStyle(
    fontFamily: FontFamily.fredoka,
    color: MjColors.ink,
    fontSize: 34,
    height: 38 / 34,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.2,
  );
  static const title = TextStyle(
    fontFamily: FontFamily.fredoka,
    color: MjColors.ink,
    fontSize: 32,
    fontWeight: FontWeight.w500,
  );
  static const body = TextStyle(
    color: MjColors.secondaryText,
    fontSize: 16,
    height: 23 / 16,
    letterSpacing: 0,
  );
  static const headline = TextStyle(
    fontFamily: FontFamily.fredoka,
    color: MjColors.ink,
    fontSize: 32,
    height: 36 / 32,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.2,
  );
  static const sheetTitle = TextStyle(
    fontFamily: FontFamily.fredoka,
    color: MjColors.ink,
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );
  static const fieldLabel = TextStyle(
    color: MjColors.ink,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  static const navigation = TextStyle(fontSize: 12);
  static const counter = TextStyle(
    color: MjColors.ink,
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );
  static const choice = TextStyle(
    color: MjColors.ink,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );
  static const sectionTitle = TextStyle(
    color: MjColors.ink,
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );
  static const chip = TextStyle(fontSize: 12.5, fontWeight: FontWeight.w500);
  static const caption = TextStyle(
    color: MjColors.secondaryText,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );
  static const button = TextStyle(
    fontFamily: FontFamily.comfortaa,
    fontSize: 17,
    fontWeight: FontWeight.w600,
  );
}
