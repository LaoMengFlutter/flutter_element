
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EleBorderThemeData with Diagnosticable {
  /// 线的颜色
  final Color? color;

  /// 宽
  final double? strokeWidth;

  /// 虚线空白处宽
  final double? dashGap;

  /// 虚线处宽
  final double? dashWidth;

  /// 圆角
  final Radius? radius;

  const EleBorderThemeData({
    this.color,
    this.strokeWidth,
    this.dashGap,
    this.dashWidth,
    this.radius,
  });
}
