import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EButtonStyle with Diagnosticable {
  final Color? loadingColor;

  /// radius
  final BorderRadius? radius;

  const EButtonStyle({
    this.loadingColor,
    this.radius,
  });

  EButtonStyle merge(EButtonStyle? other) {
    if (other == null) {
      return this;
    }
    return EButtonStyle(
      loadingColor: other.loadingColor ?? loadingColor,
      radius: other.radius ?? radius,
    );
  }
}
