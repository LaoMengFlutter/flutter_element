import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class EDropdownStyle with Diagnosticable {
  final Color? dropdownBorderColor;
  final Color? dropdownFocusBorderColor;
  final Color? fontColor;
  final Color? selectFontColor;

  EDropdownStyle({
    this.fontColor,
    this.selectFontColor,
    this.dropdownBorderColor,
    this.dropdownFocusBorderColor,
  });

  EDropdownStyle merge(EDropdownStyle? other) {
    if (other == null) {
      return this;
    }
    return EDropdownStyle(
      fontColor: other.fontColor ?? fontColor,
      selectFontColor: other.selectFontColor ?? selectFontColor,
      dropdownBorderColor: other.dropdownBorderColor ?? dropdownBorderColor,
      dropdownFocusBorderColor:
          other.dropdownFocusBorderColor ?? dropdownFocusBorderColor,
    );
  }
}
