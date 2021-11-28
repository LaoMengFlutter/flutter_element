import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class ESwitchStyle with Diagnosticable {
  final Color? activeColor;
  final Color? trackColor;
  final Color? thumbColor;

  ESwitchStyle({
    this.activeColor,
    this.trackColor,
    this.thumbColor,
  });

  ESwitchStyle merge(ESwitchStyle? other) {
    if (other == null) {
      return this;
    }
    return ESwitchStyle(
      activeColor: other.activeColor ?? activeColor,
      trackColor: other.trackColor ?? trackColor,
      thumbColor: other.thumbColor ?? thumbColor,
    );
  }
}
