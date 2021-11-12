
import 'dart:math';
import 'dart:ui';

import 'package:flutter_element/widgets.dart';
import 'package:flutter/material.dart';

class EBorder extends StatelessWidget {
  /// 线的类型
  final BorderType type;

  /// 子组件，
  final Widget? child;

  /// border style
  final EleBorderThemeData? style;

  ///形状
  final BorderShape shape;

  /// child alignment
  ///
  /// default center
  final Alignment alignment;

  /// 方向
  ///
  /// shape == line 时，表示方向
  final BorderLineDirection direction;

  const EBorder({
    Key? key,
    this.child,
    this.style,
    this.alignment = Alignment.center,
    this.type = BorderType.solid,
    this.shape = BorderShape.rrect,
    this.direction = BorderLineDirection.horizontal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EleThemeData eleThemeData = EleTheme.of(context);
    final Color color = style?.color ??
        eleThemeData.primaryColor ??
        Theme.of(context).primaryColor;
    final double strokeWidth =
        style?.strokeWidth ?? eleThemeData.borderThemeData?.strokeWidth ?? 1.0;
    final Radius radius = style?.radius ??
        eleThemeData.borderThemeData?.radius ??
        const Radius.circular(3.0);

    final double dashWidth =
        style?.dashWidth ?? eleThemeData.borderThemeData?.dashWidth ?? 3.0;
    final double dashGap =
        style?.dashGap ?? eleThemeData.borderThemeData?.dashGap ?? 3.0;

    var painter = type == BorderType.solid
        ? _SolidPainter(
            color: color,
            strokeWidth: strokeWidth,
            radius: radius,
            shape: shape,
            direction: direction,
          )
        : _DashedPainter(
            color: color,
            strokeWidth: strokeWidth,
            dashWidth: dashWidth,
            dashGap: dashGap,
            radius: radius,
            shape: shape,
            direction: direction,
          );
    return CustomPaint(
      painter: painter,
      child: Align(alignment: alignment, child: child),
    );
  }
}

abstract class _BasePainter extends CustomPainter {
  /// 线的颜色
  final Color color;

  /// 线框宽
  final double strokeWidth;

  /// 圆角
  final Radius radius;

  ///形状
  final BorderShape shape;

  /// 方向
  ///
  /// shape == line 时，表示方向
  final BorderLineDirection direction;

  /// 画笔
  late Paint _paint;

  _BasePainter({
    required this.color,
    required this.strokeWidth,
    required this.radius,
    required this.shape,
    required this.direction,
  }) {
    _paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
  }

  Path getPath(Size size) {
    Path _path = Path();
    switch (shape) {
      case BorderShape.line:
        if (direction == BorderLineDirection.horizontal) {
          _path.moveTo(0, size.height / 2);
          _path.lineTo(size.width, size.height / 2);
        } else {
          _path.moveTo(size.width / 2, 0);
          _path.lineTo(size.width / 2, size.height);
        }
        break;
      case BorderShape.rect:
        _path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));
        break;
      case BorderShape.circle:
        _path.addOval(Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2),
            radius: min(size.width, size.height) / 2));
        break;
      case BorderShape.rrect:
        _path.addRRect(RRect.fromRectAndRadius(
            Rect.fromLTWH(0, 0, size.width, size.height), radius));
        break;
      case BorderShape.round:
        _path.addRRect(RRect.fromRectAndRadius(
            Rect.fromLTWH(0, 0, size.width, size.height),
            Radius.circular(max(size.width, size.height) / 2)));
        break;
    }
    return _path;
  }
}

class _DashedPainter extends _BasePainter {
  /// 线框虚线空白宽
  final double dashGap;

  /// 线框虚线宽
  final double dashWidth;

  _DashedPainter({
    required Color color,
    required double strokeWidth,
    required this.dashGap,
    required this.dashWidth,
    required Radius radius,
    required BorderShape shape,
    required BorderLineDirection direction,
  }) : super(
          color: color,
          strokeWidth: strokeWidth,
          radius: radius,
          shape: shape,
          direction: direction,
        );

  @override
  void paint(Canvas canvas, Size size) {
    var path = getPath(size);
    var dashPath =
        _dashPath(source: path, dashWidth: dashWidth, dashGap: dashGap);
    canvas.drawPath(dashPath, _paint);
  }

  /// 参考 path_drawing 插件，稍作修改
  ///
  /// pub地址：https://pub.dev/packages/path_drawing
  Path _dashPath(
      {required Path source,
      required double dashWidth,
      required double dashGap}) {
    final Path dest = Path();
    for (final PathMetric metric in source.computeMetrics()) {
      double distance = 0;
      bool draw = true;
      int index = 0;
      while (distance < metric.length) {
        final double len = index % 2 == 0 ? dashWidth : dashGap;
        if (draw) {
          dest.addPath(
              metric.extractPath(distance, distance + len), Offset.zero);
        }
        distance += len;
        draw = !draw;
      }
    }
    return dest;
  }

  @override
  bool shouldRepaint(covariant _DashedPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.dashWidth != dashWidth ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.dashGap != dashGap ||
        oldDelegate.radius != radius ||
        oldDelegate.shape != shape ||
        oldDelegate.direction != direction;
  }
}

class _SolidPainter extends _BasePainter {
  _SolidPainter({
    required Color color,
    required double strokeWidth,
    required Radius radius,
    required BorderShape shape,
    required BorderLineDirection direction,
  }) : super(
          color: color,
          strokeWidth: strokeWidth,
          radius: radius,
          shape: shape,
          direction: direction,
        );

  @override
  void paint(Canvas canvas, Size size) {
    var path = getPath(size);
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(covariant _SolidPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.radius != radius ||
        oldDelegate.shape != shape ||
        oldDelegate.direction != direction;
  }
}

/// 线框类型
enum BorderType {
  /// 实线
  solid,

  /// 虚线
  dashed
}

/// 线框形状
enum BorderShape {
  /// 直线
  line,

  /// 虚线
  circle,

  ///矩形
  rect,

  ///圆角矩形
  rrect,

  ///圆角 类似足球场形状
  round,
}

enum BorderLineDirection {
  /// 水平
  horizontal,

  /// 垂直
  vertical
}
