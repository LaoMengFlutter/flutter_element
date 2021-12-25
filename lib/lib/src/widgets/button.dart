import 'dart:math';

import 'theme/theme.dart';
import 'package:flutter/material.dart';

class EButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final ButtonStyle? style;
  final Color? loadingColor;

  /// radius
  final BorderRadius? radius;
  final bool loading;

  /// type
  final EButtonBorderStyle borderStyle;

  /// shape
  final BoxShape shape;
  final List<Color>? gradientColors;
  final AlignmentGeometry gradientBegin;
  final AlignmentGeometry gradientEnd;
  final List<double>? gradientStops;

  const EButton({
    Key? key,
    this.onPressed,
    required this.child,
    this.style,
    this.shape = BoxShape.rectangle,
    this.borderStyle = EButtonBorderStyle.fill,
    this.loading = false,
    this.loadingColor,
    this.radius,
    this.gradientColors,
    this.gradientBegin = Alignment.centerLeft,
    this.gradientEnd = Alignment.centerRight,
    this.gradientStops,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _child = child;
    if (loading) {
      _child = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _Indicator(
            radius: 8,
            color: loadingColor ??
                EleTheme.of(context).backgroundColorWhite ??
                Colors.white,
          ),
          const SizedBox(width: 8),
          _child
        ],
      );
    }
    if (gradientColors != null) {
      _child = ClipRRect(
        borderRadius: radius ??
            BorderRadius.circular(EleTheme.of(context).borderRadiusBase ?? 4.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: gradientBegin,
              end: gradientEnd,
              colors: gradientColors!,
              stops: gradientStops,
            ),
            shape: shape,
          ),
          padding: style?.padding?.resolve({
                MaterialState.hovered,
                MaterialState.pressed,
                MaterialState.focused,
                MaterialState.dragged,
                MaterialState.selected,
                MaterialState.scrolledUnder,
                MaterialState.disabled,
                MaterialState.error,
              }) ??
              const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          child: _child,
        ),
      );
    }

    return OutlinedButton(
      onPressed: loading ? null : onPressed,
      style: ButtonStyle(
        textStyle: style?.textStyle,
        foregroundColor: style?.foregroundColor ??
            MaterialStateProperty.resolveWith((states) {
              if (borderStyle == EButtonBorderStyle.fill) {
                return EleTheme.of(context).backgroundColorWhite;
              } else {
                if (states.contains(MaterialState.focused) ||
                    states.contains(MaterialState.pressed) ||
                    states.contains(MaterialState.hovered)) {
                  return EleTheme.of(context).primaryColor;
                }
                return EleTheme.of(context).regularTextColor;
              }
            }),
        backgroundColor: style?.backgroundColor ??
            MaterialStateProperty.resolveWith((states) {
              if (borderStyle == EButtonBorderStyle.fill) {
                return EleTheme.of(context).primaryColor;
              } else if (borderStyle == EButtonBorderStyle.none) {
                return Colors.transparent;
              }
              return EleTheme.of(context).backgroundColorWhite;
            }),
        side: style?.side ??
            MaterialStateProperty.resolveWith((states) {
              if (borderStyle == EButtonBorderStyle.stroke) {
                return BorderSide(
                    color: EleTheme.of(context).borderColorBase ??
                        Colors.transparent);
              }
              if (borderStyle == EButtonBorderStyle.none) {
                return const BorderSide(color: Colors.transparent);
              }
              return null;
            }),
        overlayColor: style?.overlayColor ??
            MaterialStateProperty.resolveWith((states) {
              if (borderStyle == EButtonBorderStyle.none) {
                return Colors.transparent;
              }
            }),
        padding: gradientColors == null
            ? style?.padding
            : MaterialStateProperty.all(EdgeInsets.zero),
        shadowColor: style?.shadowColor,
        elevation: style?.elevation,
        shape: style?.shape ??
            getOutlinedBorder(
                shape,
                radius ??
                    BorderRadius.circular(
                        EleTheme.of(context).borderRadiusBase ?? 4.0)),
        minimumSize: gradientColors == null
            ? style?.minimumSize
            : MaterialStateProperty.all(Size.zero),
        fixedSize: style?.fixedSize,
        maximumSize: style?.maximumSize,
        mouseCursor: style?.mouseCursor,
        visualDensity: style?.visualDensity,
        tapTargetSize: style?.tapTargetSize,
        animationDuration: style?.animationDuration,
        enableFeedback: style?.enableFeedback,
        alignment: style?.alignment,
        splashFactory: style?.splashFactory,
      ),
      child: _child,
    );
  }

  MaterialStateProperty<OutlinedBorder?>? getOutlinedBorder(
      BoxShape shape, BorderRadius borderRadius) {
    MaterialStateProperty<OutlinedBorder?>? border;
    switch (shape) {
      case BoxShape.rectangle:
        border = MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: borderRadius));
        break;
      case BoxShape.circle:
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

enum EButtonBorderStyle {
  /// none
  none,

  /// stroke
  stroke,

  /// fill
  fill
}
