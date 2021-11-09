library ele_theme;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'ele_theme_data.dart';

class EleButtonThemeData with Diagnosticable {
  /// textStyle
  final TextStyle? textStyle;

  /// backgroundColor
  final Color? backgroundColor;

  /// foregroundColor，text or icon color
  final Color? foregroundColor;

  /// borderColor
  final Color? borderColor;

  /// button focused, hovered, or pressed
  final Color? overlayColor;

  /// child padding
  final EdgeInsetsGeometry? padding;

  /// type
  final ButtonBorderStyle? borderStyle;

  /// shape
  final ButtonShape? shape;

  /// radius
  final double? radius;

  /// status
  final EleThemeStatus? status;

  /// plain
  final bool? plain;

  const EleButtonThemeData({
    this.textStyle,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.overlayColor,
    this.padding,
    this.status,
    this.shape,
    this.radius,
    this.borderStyle,
    this.plain,
  });
}

enum ButtonBorderStyle {
  /// none
  none,

  /// stroke
  stroke,

  /// fill
  fill
}

/// shape
enum ButtonShape {
  /// circle
  circle,

  ///rect
  rect,

  ///rrect
  rrect,

  ///round
  round,
}
