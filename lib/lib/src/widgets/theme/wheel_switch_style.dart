import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class EWheelSwitchStyle with Diagnosticable {
  final Color? activeColor;
  final Color? trackColor;
  final Color? thumbColor;

  /// 关闭状态下滑块的颜色
  final Color? inactiveThumbColor;
  final TextStyle? activeTextStyle;
  final TextStyle? inactiveTextStyle;

  EWheelSwitchStyle({
    this.activeColor,
    this.trackColor,
    this.thumbColor,
    this.inactiveThumbColor,
    this.activeTextStyle,
    this.inactiveTextStyle,
  });

  EWheelSwitchStyle merge(EWheelSwitchStyle? other) {
    if (other == null) {
      return this;
    }
    return EWheelSwitchStyle(
      activeColor: other.activeColor ?? activeColor,
      trackColor: other.trackColor ?? trackColor,
      thumbColor: other.thumbColor ?? thumbColor,
      inactiveThumbColor: other.inactiveThumbColor ?? inactiveThumbColor,
      activeTextStyle: activeTextStyle?.merge(other.activeTextStyle) ??
          other.activeTextStyle,
      inactiveTextStyle: activeTextStyle?.merge(other.inactiveTextStyle) ??
          other.inactiveTextStyle,
    );
  }
}
