import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class ESliderStyle with Diagnosticable {
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? thumbColor;

  ESliderStyle({
    this.activeColor,
    this.inactiveColor,
    this.thumbColor,
  });

  ESliderStyle merge(ESliderStyle? other) {
    if (other == null) {
      return this;
    }
    return ESliderStyle(
      activeColor: other.activeColor ?? activeColor,
      inactiveColor: other.inactiveColor ?? inactiveColor,
      thumbColor: other.thumbColor ?? thumbColor,
    );
  }
}
