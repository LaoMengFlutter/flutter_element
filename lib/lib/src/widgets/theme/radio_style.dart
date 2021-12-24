import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class ERadioStyle with Diagnosticable {
  final Color? fontColor;
  final Color? checkedFontColor;
  final Color? backgroundColor;
  final Color? checkedBackgroundColor;
  final Color? borderColor;
  final Color? checkedBorderColor;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;

  /// The distance between the radio and the label
  final double? space;

  ERadioStyle({
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

  ERadioStyle merge(ERadioStyle? other) {
    if (other == null) {
      return this;
    }
    return ERadioStyle(
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
