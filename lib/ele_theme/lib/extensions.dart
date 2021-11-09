library ele_theme;

import 'dart:ui';

import 'package:ele_theme/ele_theme_data.dart';

extension EleThemeStatusExtension on EleThemeStatus {
  Color? color(EleThemeData themeData) {
    Color? color;
    switch (this) {
      case EleThemeStatus.primary:
        color = themeData.primaryColor;
        break;
      case EleThemeStatus.success:
        color = themeData.successColor;
        break;
      case EleThemeStatus.warning:
        color = themeData.warningColor;
        break;
      case EleThemeStatus.danger:
        color = themeData.dangerColor;
        break;
      case EleThemeStatus.info:
        color = themeData.infoColor;
        break;
    }
    return color;
  }
}
