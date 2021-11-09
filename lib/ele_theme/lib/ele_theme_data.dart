library ele_theme;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../ele_border_theme_data.dart';
import 'ele_button_theme_data.dart';

class EleThemeData with Diagnosticable {
  const EleThemeData.raw({
    required this.primaryColor,
    required this.successColor,
    required this.warningColor,
    required this.dangerColor,
    required this.infoColor,
    required this.primaryTextColor,
    required this.backgroundColorBase,
    required this.borderColorBase,
    required this.borderColorLight,
    required this.borderColorLighter,
    required this.borderColorExtraLight,
    required this.borderThemeData,
    required this.buttonThemeData,
  })  : assert(primaryColor != null),
        assert(successColor != null),
        assert(warningColor != null),
        assert(dangerColor != null),
        assert(infoColor != null),
        assert(primaryTextColor != null),
        assert(backgroundColorBase != null),
        assert(borderColorBase != null),
        assert(borderColorLight != null),
        assert(borderColorLighter != null),
        assert(borderColorExtraLight != null),
        assert(borderThemeData != null),
        assert(buttonThemeData != null);

  factory EleThemeData({
    Color? primaryColor,
    Color? successColor,
    Color? warningColor,
    Color? dangerColor,
    Color? infoColor,
    Color? primaryTextColor,
    Color? backgroundColorBase,
    Color? borderColorBase,
    Color? borderColorLight,
    Color? borderColorLighter,
    Color? borderColorExtraLight,
    EleBorderThemeData? borderThemeData,
    EleButtonThemeData? buttonThemeData,
  }) {
    primaryColor ??= const Color(0xFF409EFF);
    successColor ??= const Color(0xFF67C23A);
    warningColor ??= const Color(0xFFE6A23C);
    dangerColor ??= const Color(0xFFF56C6C);
    infoColor ??= const Color(0xFF909399);
    primaryTextColor ??= const Color(0xFF303133);
    backgroundColorBase ??= const Color(0xFFF5F7FA);
    borderColorBase ??= const Color(0xFFDCDFE6);
    borderColorLight ??= const Color(0xFFE4E7ED);
    borderColorLighter ??= const Color(0xFFEBEEF5);
    borderColorExtraLight ??= const Color(0xFFF2F6FC);
    borderThemeData ??= const EleBorderThemeData();
    buttonThemeData ??= const EleButtonThemeData();

    return EleThemeData.raw(
        primaryColor: primaryColor,
        successColor: successColor,
        warningColor: warningColor,
        dangerColor: dangerColor,
        infoColor: infoColor,
        primaryTextColor: primaryTextColor,
        backgroundColorBase: backgroundColorBase,
        borderColorBase: borderColorBase,
        borderColorLight: borderColorLight,
        borderColorLighter: borderColorLighter,
        borderColorExtraLight: borderColorExtraLight,
        borderThemeData: borderThemeData,
        buttonThemeData: buttonThemeData);
  }

  /// primary color
  ///
  /// if is null,value is theme primaryColor
  final Color? primaryColor;

  /// success color
  final Color? successColor;

  /// warning color
  final Color? warningColor;

  /// danger color
  final Color? dangerColor;

  /// info color
  final Color? infoColor;

  /// primary text color
  final Color? primaryTextColor;

  /// backgroundColorBase
  final Color? backgroundColorBase;

  /// one level border color
  final Color? borderColorBase;

  /// two level border color
  final Color? borderColorLight;

  /// three level border color
  final Color? borderColorLighter;

  /// four level border color
  final Color? borderColorExtraLight;

  /// border theme data
  final EleBorderThemeData? borderThemeData;

  /// button theme data
  final EleButtonThemeData? buttonThemeData;

  factory EleThemeData.light() => EleThemeData();
}

/// status
enum EleThemeStatus {
  /// primary
  primary,

  /// success
  success,

  /// info
  info,

  /// warning
  warning,

  /// danger
  danger,
}
