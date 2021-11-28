import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class EImageCropStyle with Diagnosticable {
  final Color? borderColor;

  final double? borderWidget;

  final double? borderRadius;

  EImageCropStyle({
    this.borderColor,
    this.borderWidget,
    this.borderRadius,
  });

  EImageCropStyle merge(EImageCropStyle? other) {
    if (other == null) {
      return this;
    }
    return EImageCropStyle(
      borderColor: other.borderColor ?? borderColor,
      borderWidget: other.borderWidget ?? borderWidget,
      borderRadius: other.borderRadius ?? borderRadius,
    );
  }
}
