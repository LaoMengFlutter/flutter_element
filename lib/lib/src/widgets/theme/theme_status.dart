import 'dart:ui';

import 'theme_data.dart';


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
