import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

Widget _kPlaceholderWidget = Container();

class EImageStyle with Diagnosticable {
  /// placeholderWidget
  final Widget? placeholderWidget;

  /// errorWidget
  final Widget? errorWidget;

  const EImageStyle({
    this.placeholderWidget,
    this.errorWidget,
  });

  EImageStyle copyWith({
    Widget? placeholderWidget,
    Widget? errorWidget,
  }) {
    return EImageStyle(
      placeholderWidget: placeholderWidget ?? this.placeholderWidget,
      errorWidget: errorWidget ?? this.errorWidget,
    );
  }

  EImageStyle merge(EImageStyle? other) {
    if (other == null) {
      return this;
    }
    return EImageStyle(
      placeholderWidget: other.placeholderWidget ?? placeholderWidget,
      errorWidget: other.errorWidget ?? errorWidget,
    );
  }

  factory EImageStyle.from(Color color) {
    return EImageStyle(
        placeholderWidget: Container(
          color: color,
        ),
        errorWidget: Container(
          color: color,
        ));
  }
}
