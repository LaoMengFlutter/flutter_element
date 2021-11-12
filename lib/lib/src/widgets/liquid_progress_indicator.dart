import 'dart:math';

import 'package:flutter/material.dart';

class LiquidProgressWidget extends StatefulWidget {
  ///
  /// 百分比 范围0-1
  ///
  final double progress;

  ///
  /// 进度条激活颜色
  ///
  final List<Color> colors;

  ///
  /// 进度条背景颜色
  ///
  final Color backgroundColor;

  ///textStyle
  final TextStyle? textStyle;

  ///text
  final String? text;

  /// border width
  final double borderWidth;

  /// border color
  final Color borderColor;

  /// radius
  final double radius;

  /// direction
  final Axis direction;

  /// textInside
  final bool textInside;

  const LiquidProgressWidget({
    Key? key,
    required this.progress,
    required this.colors,
    required this.backgroundColor,
    required this.borderWidth,
    required this.borderColor,
    required this.radius,
    required this.direction,
    this.text,
    this.textStyle,
    required this.textInside,
  }) : super(key: key);

  @override
  _LiquidProgressWidgetState createState() => _LiquidProgressWidgetState();
}

class _LiquidProgressWidgetState extends State<LiquidProgressWidget> {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _LinearClipper(
        radius: widget.radius,
      ),
      child: CustomPaint(
        painter: _LinearPainter(
          color: widget.backgroundColor,
          radius: widget.radius,
        ),
        foregroundPainter: _LinearBorderPainter(
          progress: widget.progress,
          color: widget.borderColor,
          width: widget.borderWidth,
          radius: widget.radius,
          direction: widget.direction,
          text: widget.text,
          textStyle: widget.textStyle,
          textInside: widget.textInside,
        ),
        child: _WaveView(
          progress: widget.progress,
          colors: widget.colors,
          direction: widget.direction,
        ),
      ),
    );
  }
}

class _LinearPainter extends CustomPainter {
  final Color color;
  final double radius;

  _LinearPainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          Radius.circular(radius),
        ),
        paint);
  }

  @override
  bool shouldRepaint(_LinearPainter oldDelegate) => color != oldDelegate.color;
}

class _LinearBorderPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double width;
  final double radius;
  final String? text;
  final bool textInside;
  final TextStyle? textStyle;

  /// direction
  final Axis direction;
  TextPainter? textPainter;

  _LinearBorderPainter({
    required this.progress,
    required this.color,
    required this.width,
    required this.radius,
    required this.textInside,
    required this.direction,
    this.text,
    this.textStyle,
  }) {
    if (text != null) {
      textPainter = TextPainter(
        text: TextSpan(
          text: text,
          style: textStyle,
        ),
        textDirection: TextDirection.ltr,
        textWidthBasis: TextWidthBasis.longestLine,
      )..layout();
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    final alteredRadius = radius;
    canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
              width / 2, width / 2, size.width - width, size.height - width),
          Radius.circular(alteredRadius - width),
        ),
        paint);

    if (textPainter != null) {
      if (direction == Axis.vertical) {
        double textX = size.width / 2 - textPainter!.width / 2;
        if (textX < 0) {
          textX = 0;
        }

        var textY = size.height / 2 - textPainter!.height / 2;

        if (textInside) {
          textY = size.height * (1 - progress) - textPainter!.height / 2;
          if (textY < 0) {
            textY = 0;
          }
          if (textY > (size.height - textPainter!.height)) {
            textY = size.height - textPainter!.height;
          }
        }
        textPainter?.paint(canvas, Offset(textX, textY));
      } else {
        double textX = size.width / 2 - textPainter!.width / 2;

        if (textInside) {
          textX = size.width * progress - textPainter!.width / 2;
          if (textX < 0) {
            textX = 0;
          }
          if (textX > (size.width - textPainter!.width)) {
            textX = size.width - textPainter!.width;
          }
        }

        var textY = size.height / 2 - textPainter!.height / 2;
        if (textY < 0) {
          textY = 0;
        }
        textPainter?.paint(canvas, Offset(textX, textY));
      }
    }
  }

  @override
  bool shouldRepaint(_LinearBorderPainter oldDelegate) =>
      color != oldDelegate.color ||
      width != oldDelegate.width ||
      radius != oldDelegate.radius;
}

class _LinearClipper extends CustomClipper<Path> {
  final double radius;

  _LinearClipper({required this.radius});

  @override
  Path getClip(Size size) {
    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          Radius.circular(radius),
        ),
      );
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _WaveView extends StatefulWidget {
  final double progress;
  final List<Color> colors;
  final Axis direction;

  const _WaveView({
    Key? key,
    required this.progress,
    required this.colors,
    required this.direction,
  }) : super(key: key);

  @override
  _WaveState createState() => _WaveState();
}

class _WaveState extends State<_WaveView> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
      builder: (context, child) => ClipPath(
        child: widget.colors.length == 1
            ? Container(
                color: widget.colors[0],
              )
            : Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: widget.direction == Axis.horizontal
                      ? Alignment.centerLeft
                      : Alignment.bottomCenter,
                  end: widget.direction == Axis.horizontal
                      ? Alignment.centerRight
                      : Alignment.topCenter,
                  colors: widget.colors,
                )),
              ),
        clipper: _WaveClipper(
          animationValue: _animationController.value,
          progress: widget.progress,
          direction: widget.direction,
        ),
      ),
    );
  }
}

class _WaveClipper extends CustomClipper<Path> {
  final double animationValue;
  final double progress;
  final Axis direction;

  _WaveClipper({
    required this.animationValue,
    required this.progress,
    required this.direction,
  });

  @override
  Path getClip(Size size) {
    if (direction == Axis.horizontal) {
      Path path = Path()
        ..addPolygon(_generateHorizontalWavePath(size), false)
        ..lineTo(0.0, size.height)
        ..lineTo(0.0, 0.0)
        ..close();
      return path;
    }

    Path path = Path()
      ..addPolygon(_generateVerticalWavePath(size), false)
      ..lineTo(size.width, size.height)
      ..lineTo(0.0, size.height)
      ..close();
    return path;
  }

  List<Offset> _generateHorizontalWavePath(Size size) {
    final waveList = <Offset>[];
    for (int i = -2; i <= size.height.toInt() + 2; i++) {
      final waveHeight = (size.width / 20);
      final dx =
          sin((animationValue * 360 - i) % 360 * (pi / 180)) * waveHeight +
              (size.width * progress);
      waveList.add(Offset(dx, i.toDouble()));
    }
    return waveList;
  }

  List<Offset> _generateVerticalWavePath(Size size) {
    final waveList = <Offset>[];
    for (int i = -2; i <= size.width.toInt() + 2; i++) {
      final waveHeight = (size.height / 20);
      final dy =
          sin((animationValue * 360 - i) % 360 * (pi / 180)) * waveHeight +
              (size.height - (size.height * progress));
      waveList.add(Offset(i.toDouble(), dy));
    }
    return waveList;
  }

  @override
  bool shouldReclip(_WaveClipper oldClipper) =>
      animationValue != oldClipper.animationValue ||
      progress != oldClipper.progress ||
      direction != oldClipper.direction;
}
