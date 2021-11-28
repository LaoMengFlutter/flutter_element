import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class ERateStyle with Diagnosticable {
  final Color? activeColor;
  final Color? inactiveColor;

  ERateStyle({
    this.activeColor,
    this.inactiveColor,
  });

  ERateStyle merge(ERateStyle? other) {
    if (other == null) {
      return this;
    }
    return ERateStyle(
      activeColor: other.activeColor ?? activeColor,
      inactiveColor: other.inactiveColor ?? inactiveColor,
    );
  }
}
