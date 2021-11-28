import 'dart:math';

import 'theme/button_theme_data.dart';
import 'theme/theme.dart';
import 'theme/theme_data.dart';
import 'package:flutter/material.dart';

import 'theme/theme_status.dart';

class EButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final EleButtonThemeData? style;
  final bool loading;

  /// disable opacity
  static const double _disableOpacity = .7;

  const EButton({
    Key? key,
    this.onPressed,
    required this.child,
    this.style,
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EleThemeData eleTheme = EleTheme.of(context);

    Color primaryColor =
        eleTheme.primaryColor ?? Theme.of(context).primaryColor;

    var status = style?.status ?? eleTheme.buttonThemeData?.status;
    var plain = style?.plain ?? eleTheme.buttonThemeData?.plain ?? false;
    var enable = onPressed == null || loading;

    ButtonBorderStyle borderStyle = style?.borderStyle ??
        eleTheme.buttonThemeData?.borderStyle ??
        getTypeByStatus(status, plain);

    var textStyle =
        MaterialStateProperty.all(eleTheme.buttonThemeData?.textStyle);

    var foregroundColor = style?.foregroundColor ??
        eleTheme.buttonThemeData?.foregroundColor ??
        getForegroundColorByStatus(status, eleTheme, plain) ??
        primaryColor;
    if (enable) {
      var opacity = foregroundColor.opacity;
      foregroundColor = foregroundColor.withOpacity(opacity * _disableOpacity);
    }
    var foreground = MaterialStateProperty.all(foregroundColor);

    var backgroundColor = borderStyle == ButtonBorderStyle.fill
        ? (style?.backgroundColor ??
            eleTheme.buttonThemeData?.backgroundColor ??
            getBackgroundColorByStatus(status, eleTheme, plain) ??
            primaryColor)
        : null;
    if (enable) {
      var opacity = backgroundColor?.opacity ?? 1.0;
      backgroundColor = backgroundColor?.withOpacity(opacity * _disableOpacity);
    }
    var background = borderStyle == ButtonBorderStyle.fill
        ? MaterialStateProperty.all(backgroundColor)
        : null;

    var overlayColor = MaterialStateProperty.all(
        style?.overlayColor ?? eleTheme.buttonThemeData?.overlayColor);

    var padding = MaterialStateProperty.all(style?.padding ??
        eleTheme.buttonThemeData?.padding ??
        const EdgeInsets.symmetric(horizontal: 16, vertical: 8));

    var shape =
        style?.shape ?? eleTheme.buttonThemeData?.shape ?? ButtonShape.rrect;
    var radius = eleTheme.buttonThemeData?.radius ?? 3.0;

    var borderColor = style?.borderColor ??
        eleTheme.buttonThemeData?.borderColor ??
        getBorderColorByStatus(status, eleTheme, plain);

    if (enable) {
      var opacity = borderColor?.opacity ?? 1.0;
      borderColor = borderColor?.withOpacity(opacity * _disableOpacity);
    }

    var side = borderColor != null && borderStyle != ButtonBorderStyle.none
        ? MaterialStateProperty.all(
            BorderSide(color: borderColor.withOpacity(.3)))
        : null;

    return OutlinedButton(
      onPressed: loading ? null : onPressed,
      style: ButtonStyle(
        textStyle: textStyle,
        foregroundColor: foreground,
        backgroundColor: background,
        overlayColor: overlayColor,
        padding: padding,
        shape: getOutlinedBorder(shape, radius),
        side: side,
        minimumSize: MaterialStateProperty.all(Size.zero),
      ),
      child: loading
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _Indicator(
                  radius: 8,
                  color: foregroundColor,
                ),
                const SizedBox(
                  width: 8,
                ),
                child
              ],
            )
          : child,
    );
  }

  Color? getForegroundColorByStatus(
      EleThemeStatus? status, EleThemeData eleTheme, bool plain) {
    if (status == null) {
      return eleTheme.primaryTextColor;
    }
    if (plain) {
      return status.color(eleTheme);
    }
    return Colors.white;
  }

  Color? getBorderColorByStatus(
      EleThemeStatus? status, EleThemeData eleTheme, bool plain) {
    if (status == null || !plain) {
      return null;
    }
    return status.color(eleTheme);
  }

  ButtonBorderStyle getTypeByStatus(EleThemeStatus? type, bool plain) {
    if (plain) {
      return ButtonBorderStyle.fill;
    }
    if (type == null) {
      return ButtonBorderStyle.stroke;
    }
    return ButtonBorderStyle.fill;
  }

  Color? getBackgroundColorByStatus(
      EleThemeStatus? status, EleThemeData eleTheme, bool plain) {
    if (status == null) {
      return Colors.transparent;
    }
    Color? color = status.color(eleTheme);
    if (plain) {
      color = color?.withOpacity(.1);
    }
    return color;
  }

  MaterialStateProperty<OutlinedBorder?>? getOutlinedBorder(
      ButtonShape shape, double radius) {
    MaterialStateProperty<OutlinedBorder?>? border;
    switch (shape) {
      case ButtonShape.round:
        border = MaterialStateProperty.all(const StadiumBorder());
        break;
      case ButtonShape.rrect:
        border = MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius)));
        break;
      case ButtonShape.rect:
        border = MaterialStateProperty.all(const RoundedRectangleBorder());
        break;
      case ButtonShape.circle:
        border = MaterialStateProperty.all(const CircleBorder());
        break;
    }
    return border;
  }

  Color resolve(Color color, Color? overlayColor, Set<MaterialState> states) {
    if (states.contains(MaterialState.hovered)) {
      return overlayColor ?? color.withOpacity(0.04);
    }
    if (states.contains(MaterialState.focused) ||
        states.contains(MaterialState.pressed)) {
      return overlayColor ?? color.withOpacity(0.12);
    }
    return color;
  }
}

class _Indicator extends StatefulWidget {
  final double radius;
  final Color color;

  const _Indicator({Key? key, required this.radius, required this.color})
      : super(key: key);

  @override
  __IndicatorState createState() => __IndicatorState();
}

class __IndicatorState extends State<_Indicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200))
      ..repeat();
    _animation = Tween(begin: .0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _animation,
      child: SizedBox(
        height: widget.radius,
        width: widget.radius,
        child: CustomPaint(
          painter:
              _IndicatorPainter(radius: widget.radius, color: widget.color),
        ),
      ),
    );
  }
}

class _IndicatorPainter extends CustomPainter {
  final double radius;
  final Color color;
  final int _count = 10;
  late Paint _paint;
  late RRect _rect;

  _IndicatorPainter({required this.radius, required this.color}) {
    _paint = Paint()..color = color;
    _rect = RRect.fromLTRBXY(
      -radius / 10.0,
      -radius / 3.0,
      radius / 10.0,
      -radius,
      radius / 10.0,
      radius / 10.0,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.translate(size.width / 2.0, size.height / 2.0);
    for (int i = 0; i < _count; ++i) {
      canvas.drawRRect(_rect, _paint);
      canvas.rotate(2 * pi / _count);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _IndicatorPainter oldDelegate) {
    return oldDelegate.radius != radius || oldDelegate.color != color;
  }
}
