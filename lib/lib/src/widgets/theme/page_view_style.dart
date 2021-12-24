import 'dart:ui';

import 'package:flutter/foundation.dart';

class EPageViewStyle with Diagnosticable {
  final Color? indicatorColor;
  final Color? indicatorActiveColor;

  EPageViewStyle({
    this.indicatorColor,
    this.indicatorActiveColor,
  });

  EPageViewStyle merge(EPageViewStyle? other) {
    if (other == null) {
      return this;
    }
    return EPageViewStyle(
      indicatorColor: other.indicatorColor ?? indicatorColor,
      indicatorActiveColor: other.indicatorActiveColor ?? indicatorActiveColor,
    );
  }
}
