import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

Widget _kPlaceholderWidget = Container();

class EleImageThemeData with Diagnosticable {
  /// placeholderWidget
  final Widget? placeholderWidget;

  /// errorWidget
  final Widget? errorWidget;

  const EleImageThemeData({
    this.placeholderWidget,
    this.errorWidget,
  });

  EleImageThemeData copyWith({
    Widget? placeholderWidget,
    Widget? errorWidget,
  }) {
    return EleImageThemeData(
      placeholderWidget: placeholderWidget ?? this.placeholderWidget,
      errorWidget: errorWidget ?? this.errorWidget,
    );
  }

  EleImageThemeData merge(EleImageThemeData? other) {
    if (other == null) {
      return this;
    }
    return EleImageThemeData(
      placeholderWidget: other.placeholderWidget ?? placeholderWidget,
      errorWidget: other.errorWidget ?? errorWidget,
    );
  }

  factory EleImageThemeData.from(Color color) {
    return EleImageThemeData(
        placeholderWidget: Container(
          color: color,
        ),
        errorWidget: Container(
          color: color,
        ));
  }
}
