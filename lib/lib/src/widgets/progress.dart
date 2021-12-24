library ele_progress;

import 'dart:math';

import 'package:flutter/material.dart';
import 'theme/theme.dart';
import 'theme/theme_data.dart';

enum ProgressType { line, circle, dashboard, liquid }

class EProgress extends StatelessWidget {
  /// min progress
  static const double _minProgress = 0;

  /// max progress
  static const double _maxProgress = 1;

  ///
  /// 百分比 范围0-1
  ///
  final double progress;

  ///
  /// 进度条类型,默认line
  ///
  final ProgressType type;

  ///
  /// 进度条的宽度,默认6
  ///
  final double strokeWidth;

  ///
  /// 进度条显示文字内置在进度条内（只在 type=line 时可用）,默认false
  ///
  final bool textInside;

  ///
  /// 是否显示进度条文字内容,true
  ///
  final bool showText;

  ///
  /// textStyle
  ///
  final TextStyle? textStyle;

  ///
  /// circle/dashboard 类型路径两端的形状,默认round
  ///
  final StrokeCap strokeCap;

  ///
  /// 指定进度条文字内容
  ///
  final String? Function(double percentage)? format;

  ///
  /// 进度条激活颜色,多个代表渐变色
  ///
  final List<Color>? colors;

  ///
  /// 进度条背景颜色
  ///
  final Color? backgroundColor;

  /// direction 用于type=line 和liquid
  final Axis direction;

  /// border width type=和liquid
  final double borderWidth;

  /// border color type=和liquid
  final Color? borderColor;

  /// radius type=和liquid
  final double radius;

  const EProgress({
    Key? key,
    this.progress = 0,
    this.type = ProgressType.line,
    this.strokeWidth = 6.0,
    this.textInside = false,
    this.colors,
    this.backgroundColor,
    this.showText = true,
    this.strokeCap = StrokeCap.round,
    this.direction = Axis.horizontal,
    this.borderColor,
    this.borderWidth = 3.0,
    this.radius = 0,
    this.format,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EleThemeData eleThemeData = EleTheme.of(context);
    List<Color> _colors = [];
    if (colors != null) {
      _colors = colors!;
    } else {
      _colors.add(eleThemeData.primaryColor ?? Theme.of(context).primaryColor);
    }

    var _backgroundColor = backgroundColor ??
        eleThemeData.borderColorLighter ??
        Colors.transparent;

    var _progress = progress.clamp(_minProgress, _maxProgress);

    String? _text;
    if (showText) {
      _text =
          format?.call(_progress) ?? '${(_progress * 100).toStringAsFixed(0)}%';
    }

    var _textStyle = textStyle ??
        ((textInside &&
                (type == ProgressType.line || type == ProgressType.liquid))
            ? const TextStyle(color: Colors.white)
            : TextStyle(color: eleThemeData.regularTextColor));

    if (type == ProgressType.liquid) {
      var _borderColor =
          borderColor ?? eleThemeData.borderColorLighter ?? Colors.transparent;
      return LiquidProgressWidget(
        progress: _progress,
        colors: _colors,
        direction: direction,
        backgroundColor: _backgroundColor,
        borderColor: _borderColor,
        radius: radius,
        borderWidth: borderWidth,
        textInside: textInside,
        text: _text,
        textStyle: _textStyle,
      );
    } else {
      _ProgressPainter? _painter;
      switch (type) {
        case ProgressType.line:
          _painter = _LineProgressPainter(
            progress: _progress,
            colors: _colors,
            backgroundColor: _backgroundColor,
            strokeWidth: strokeWidth,
            strokeCap: strokeCap,
            textInside: textInside,
            direction: direction,
            text: _text,
            textStyle: _textStyle,
          );
          break;
        case ProgressType.circle:
          _painter = _CircleProgressPainter(
            progress: _progress,
            colors: _colors,
            backgroundColor: _backgroundColor,
            strokeWidth: strokeWidth,
            strokeCap: strokeCap,
            text: _text,
            textStyle: _textStyle,
          );
          break;
        case ProgressType.dashboard:
          _painter = _DashboardProgressPainter(
            progress: _progress,
            colors: _colors,
            backgroundColor: _backgroundColor,
            strokeWidth: strokeWidth,
            strokeCap: strokeCap,
            text: _text,
            textStyle: _textStyle,
          );
          break;
        case ProgressType.liquid:
          break;
      }
      return CustomPaint(
        painter: _painter,
      );
    }
  }
}

abstract class _ProgressPainter extends CustomPainter {
  ///
  /// 进度条激活颜色
  ///
  final List<Color> colors;

  ///
  /// 进度条背景颜色
  ///
  final Color backgroundColor;

  ///
  /// 百分比 范围0-1，默认值0
  ///
  final double progress;

  ///
  /// 进度条的宽度
  ///
  final double strokeWidth;

  ///
  /// StrokeCap
  ///
  final StrokeCap strokeCap;

  ///textStyle
  final TextStyle? textStyle;

  ///text
  final String? text;

  ///
  /// 激活paint
  ///
  late Paint _activePaint;

  ///
  /// 背景paint
  ///
  late Paint _backgroundPaint;

  /// textPainter
  TextPainter? textPainter;

  _ProgressPainter(
      {required this.progress,
      required this.colors,
      required this.backgroundColor,
      required this.strokeWidth,
      required this.strokeCap,
      this.text,
      this.textStyle}) {
    _activePaint = Paint()
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.fill
      ..strokeCap = strokeCap;

    _backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.fill
      ..strokeCap = strokeCap;

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
}

class _LineProgressPainter extends _ProgressPainter {
  final bool textInside;

  /// direction
  final Axis direction;

  _LineProgressPainter({
    required double progress,
    required List<Color> colors,
    required Color backgroundColor,
    required double strokeWidth,
    required StrokeCap strokeCap,
    required this.textInside,
    required this.direction,
    String? text,
    TextStyle? textStyle,
  }) : super(
            progress: progress,
            colors: colors,
            backgroundColor: backgroundColor,
            strokeWidth: strokeWidth,
            strokeCap: strokeCap,
            text: text,
            textStyle: textStyle);

  @override
  void paint(Canvas canvas, Size size) {
    if (direction == Axis.horizontal) {
      _paintHorizontal(canvas, size);
    } else {
      _paintVertical(canvas, size);
    }
  }

  void _paintHorizontal(Canvas canvas, Size size) {
    var startX = 0.0;
    if (strokeCap == StrokeCap.round || strokeCap == StrokeCap.square) {
      startX = strokeWidth / 2;
    }
    var endX = size.width;
    if (!textInside && textPainter != null) {
      endX -= textPainter!.width + 3;
    }

    canvas.drawLine(Offset(startX, size.height / 2),
        Offset(endX - startX, size.height / 2), _backgroundPaint);

    if (colors.length == 1) {
      _activePaint.color = colors[0];
    } else {
      Gradient gradient = LinearGradient(
        colors: colors,
      );
      _activePaint.shader =
          gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    }

    if (progress != 0) {
      canvas.drawLine(
          Offset(startX, size.height / 2),
          Offset(startX + (endX - strokeWidth) * progress, size.height / 2),
          _activePaint);
    }

    if (textPainter != null) {
      var textX =
          (startX + (size.width - strokeWidth) * progress) - textPainter!.width;
      if (textX < 0) {
        textX = 0;
      }
      var textY = size.height / 2 - textPainter!.height / 2;
      if (textInside) {
        textPainter?.paint(canvas, Offset(textX, textY));
      } else {
        textPainter?.paint(
            canvas, Offset(size.width - textPainter!.width, textY));
      }
    }
  }

  void _paintVertical(Canvas canvas, Size size) {
    double capOffset = 0;
    if (strokeCap == StrokeCap.round || strokeCap == StrokeCap.square) {
      capOffset = strokeWidth / 2;
    }

    canvas.drawLine(Offset(size.width / 2, size.height - capOffset),
        Offset(size.width / 2, capOffset), _backgroundPaint);

    if (colors.length == 1) {
      _activePaint.color = colors[0];
    } else {
      Gradient gradient = LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: colors,
      );
      _activePaint.shader =
          gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    }

    if (progress != 0) {
      canvas.drawLine(
          Offset(size.width / 2, size.height - capOffset),
          Offset(
              size.width / 2,
              (size.height - capOffset) -
                  (size.height - 2 * capOffset) * progress),
          _activePaint);
    }

    if (textPainter != null) {
      var textX = size.width / 2 - textPainter!.width / 2;
      if (textX < 0) {
        textX = 0;
      }
      var textY = size.height / 2 - textPainter!.height / 2;

      if (textInside) {
        textY = ((size.height - capOffset) -
                (size.height - 2 * capOffset) * progress) -
            textPainter!.height / 2;

        if (textY < textPainter!.height / 2) {
          textY = textPainter!.height / 2;
        }
        if (textY > (size.height - textPainter!.height)) {
          textY = size.height - textPainter!.height;
        }
      }
      textPainter?.paint(canvas, Offset(textX, textY));
    }
  }

  @override
  bool shouldRepaint(covariant _LineProgressPainter oldDelegate) {
    return progress != oldDelegate.progress ||
        colors != oldDelegate.colors ||
        backgroundColor != oldDelegate.backgroundColor ||
        strokeWidth != oldDelegate.strokeWidth ||
        text != oldDelegate.text ||
        textStyle != oldDelegate.textStyle ||
        textInside != oldDelegate.textInside ||
        direction != oldDelegate.direction;
  }
}

class _CircleProgressPainter extends _ProgressPainter {
  _CircleProgressPainter({
    required double progress,
    required List<Color> colors,
    required Color backgroundColor,
    required double strokeWidth,
    required StrokeCap strokeCap,
    String? text,
    TextStyle? textStyle,
  }) : super(
          progress: progress,
          colors: colors,
          backgroundColor: backgroundColor,
          strokeWidth: strokeWidth,
          strokeCap: strokeCap,
          text: text,
          textStyle: textStyle,
        ) {
    _activePaint.style = PaintingStyle.stroke;
    _backgroundPaint.style = PaintingStyle.stroke;
  }

  @override
  void paint(Canvas canvas, Size size) {
    double radius = min(size.width, size.height) / 2 - strokeWidth / 2;
    Rect rect =
        Rect.fromLTWH(strokeWidth / 2, strokeWidth / 2, radius * 2, radius * 2);
    //背景圆环
    canvas.drawArc(rect, 0, pi * 2, false, _backgroundPaint);

    if (colors.length == 1) {
      _activePaint.color = colors[0];
    } else {
      Gradient gradient = SweepGradient(
        startAngle: _degreeToRad(-90),
        endAngle: _degreeToRad(-90 + 360.0),
        tileMode: TileMode.repeated,
        colors: colors,
      );
      _activePaint.shader = gradient.createShader(rect);
    }
    double scapToDegree = 0.0;
    if (strokeCap == StrokeCap.round || strokeCap == StrokeCap.square) {
      scapToDegree = strokeWidth / 2 / radius;
    }

    double startAngle = _degreeToRad(-90) + scapToDegree;
    double sweepAngle = _degreeToRad(360) - scapToDegree;
    if (strokeCap == StrokeCap.round || strokeCap == StrokeCap.square) {
      sweepAngle = _degreeToRad(360);
    }
    canvas.drawArc(
        rect, startAngle, progress * sweepAngle, false, _activePaint);

    if (textPainter != null) {
      var textX = size.width / 2 - textPainter!.width / 2;
      if (textX < 0) {
        textX = 0;
      }
      var textY = size.height / 2 - textPainter!.height / 2;
      textPainter?.paint(canvas, Offset(textX, textY));
    }
  }

  double _degreeToRad(double degree) => degree * pi / 180;

  @override
  bool shouldRepaint(covariant _CircleProgressPainter oldDelegate) {
    return progress != oldDelegate.progress ||
        colors != oldDelegate.colors ||
        backgroundColor != oldDelegate.backgroundColor ||
        strokeWidth != oldDelegate.strokeWidth ||
        text != oldDelegate.text ||
        textStyle != oldDelegate.textStyle;
  }
}

class _DashboardProgressPainter extends _ProgressPainter {
  ///
  /// 开始角度
  ///
  final double _bottomAngle = pi / 3;

  _DashboardProgressPainter({
    required double progress,
    required List<Color> colors,
    required Color backgroundColor,
    required double strokeWidth,
    required StrokeCap strokeCap,
    String? text,
    TextStyle? textStyle,
  }) : super(
          progress: progress,
          colors: colors,
          backgroundColor: backgroundColor,
          strokeWidth: strokeWidth,
          strokeCap: strokeCap,
          text: text,
          textStyle: textStyle,
        ) {
    _activePaint.style = PaintingStyle.stroke;
    _backgroundPaint.style = PaintingStyle.stroke;
  }

  @override
  void paint(Canvas canvas, Size size) {
    double radius = min(size.width, size.height) / 2 - strokeWidth / 2;
    Rect rect =
        Rect.fromLTWH(strokeWidth / 2, strokeWidth / 2, radius * 2, radius * 2);

    double _startAngle = _bottomAngle / 2 + pi / 2;
    double _maxSweepAngle = 2 * pi - _bottomAngle;

    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(_startAngle);
    canvas.translate(-size.width / 2, -size.height / 2);

    if (colors.length == 1) {
      _activePaint.color = colors[0];
    } else {
      var _colors = [
        ...colors,
        colors[colors.length - 1],
        colors[0],
      ];

      List<double> _stops = [];
      double percentage = _bottomAngle / (2 * pi);
      _stops.add(0.0);
      for (int i = 1; i < colors.length; i++) {
        _stops.add((i / (colors.length - 1)) * (1 - percentage));
      }
      _stops.add((1 - percentage) + .5 * percentage);
      _stops.add(1.0);
      Gradient gradient = SweepGradient(
        startAngle: 0,
        endAngle: 2 * pi,
        colors: _colors,
        stops: _stops,
      );
      _activePaint.shader = gradient.createShader(rect);
    }

    //背景圆环
    canvas.drawArc(rect, 0, _maxSweepAngle, false, _backgroundPaint);
    //进度圆环
    canvas.drawArc(rect, 0, (_maxSweepAngle) * progress, false, _activePaint);

    canvas.restore();

    if (textPainter != null) {
      var textX = size.width / 2 - textPainter!.width / 2;
      if (textX < 0) {
        textX = 0;
      }
      var textY = size.height / 2 - textPainter!.height / 2;
      textPainter?.paint(canvas, Offset(textX, textY));
    }
  }

  @override
  bool shouldRepaint(covariant _DashboardProgressPainter oldDelegate) {
    return progress != oldDelegate.progress ||
        colors != oldDelegate.colors ||
        backgroundColor != oldDelegate.backgroundColor ||
        strokeWidth != oldDelegate.strokeWidth ||
        text != oldDelegate.text ||
        textStyle != oldDelegate.textStyle;
  }
}

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
