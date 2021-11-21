import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class ECheckboxStyle with Diagnosticable {
  final Color? fontColor;
  final Color? checkedFontColor;
  final Color? backgroundColor;
  final Color? checkedBackgroundColor;
  final Color? borderColor;
  final Color? checkedBorderColor;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;

  /// The distance between the checkbox and the label
  final double? space;

  ECheckboxStyle({
    this.fontColor,
    this.checkedFontColor,
    this.backgroundColor,
    this.checkedBackgroundColor,
    this.borderColor,
    this.checkedBorderColor,
    this.borderRadius,
    this.padding,
    this.space,
  });

  ECheckboxStyle merge(ECheckboxStyle? other) {
    if (other == null) {
      return this;
    }
    return ECheckboxStyle(
      fontColor: other.fontColor ?? fontColor,
      checkedFontColor: other.checkedFontColor ?? checkedFontColor,
      backgroundColor: other.backgroundColor ?? backgroundColor,
      checkedBackgroundColor:
          other.checkedBackgroundColor ?? checkedBackgroundColor,
      borderColor: other.borderColor ?? borderColor,
      checkedBorderColor: other.checkedBorderColor ?? checkedBorderColor,
      borderRadius: other.borderRadius ?? borderRadius,
      padding: other.padding ?? padding,
      space: other.space ?? space,
    );
  }
}
