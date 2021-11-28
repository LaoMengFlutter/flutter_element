import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EInputNumberStyle with Diagnosticable {
  final Color? fontColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? focusBorderColor;
  final Color? iconColor;
  final Color? iconBackgroundColor;
  final BorderRadius? borderRadius;

  const EInputNumberStyle({
    this.fontColor,
    this.backgroundColor,
    this.borderColor,
    this.focusBorderColor,
    this.iconColor,
    this.iconBackgroundColor,
    this.borderRadius,
  });

  EInputNumberStyle merge(EInputNumberStyle? other) {
    if (other == null) {
      return this;
    }
    return EInputNumberStyle(
      fontColor: other.fontColor ?? fontColor,
      backgroundColor: other.backgroundColor ?? backgroundColor,
      borderColor: other.borderColor ?? borderColor,
      focusBorderColor: other.focusBorderColor ?? focusBorderColor,
      iconColor: other.iconColor ?? iconColor,
      iconBackgroundColor: other.iconBackgroundColor ?? iconBackgroundColor,
      borderRadius: other.borderRadius ?? borderRadius,
    );
  }
}
