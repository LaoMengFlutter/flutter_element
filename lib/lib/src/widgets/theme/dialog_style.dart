import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class EDialogStyle with Diagnosticable {
  final Color? backgroundColor;
  final Color? borderColor;
  final BorderRadius? borderRadius;

  EDialogStyle({
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
  });

  EDialogStyle merge(EDialogStyle? other) {
    if (other == null) {
      return this;
    }
    return EDialogStyle(
      backgroundColor: other.backgroundColor ?? backgroundColor,
      borderColor: other.borderColor ?? borderColor,
      borderRadius: other.borderRadius ?? borderRadius,
    );
  }
}
