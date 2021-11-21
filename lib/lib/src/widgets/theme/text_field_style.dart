import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class ETextFieldStyle with Diagnosticable {
  final Color? fontColor;
  final Color? backgroundColor;
  final Color? placeholderColor;
  final Color? borderColor;
  final Color? focusBorderColor;
  final Color? clearColor;
  final BorderRadius? borderRadius;

  ETextFieldStyle({
    this.fontColor,
    this.backgroundColor,
    this.placeholderColor,
    this.borderColor,
    this.focusBorderColor,
    this.borderRadius,
    this.clearColor,
  });

  ETextFieldStyle merge(ETextFieldStyle? other) {
    if (other == null) {
      return this;
    }
    return ETextFieldStyle(
      fontColor: other.fontColor ?? fontColor,
      backgroundColor: other.backgroundColor ?? backgroundColor,
      placeholderColor: other.placeholderColor ?? placeholderColor,
      borderColor: other.borderColor ?? borderColor,
      focusBorderColor: other.focusBorderColor ?? focusBorderColor,
      borderRadius: other.borderRadius ?? borderRadius,
      clearColor: other.clearColor ?? clearColor,
    );
  }
}
