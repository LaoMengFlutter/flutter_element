import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EBorderStyle with Diagnosticable {
  /// 线的颜色
  final Color? color;

  /// 宽
  final double? strokeWidth;

  /// 虚线空白处宽
  final double? dashGap;

  /// 虚线处宽
  final double? dashWidth;

  /// 虚线处宽
  final EdgeInsetsGeometry? padding;

  /// 圆角
  final BorderRadius? radius;

  const EBorderStyle({
    this.color,
    this.strokeWidth,
    this.dashGap,
    this.dashWidth,
    this.radius,
    this.padding,
  });

  EBorderStyle merge(EBorderStyle? other) {
    if (other == null) {
      return this;
    }
    return EBorderStyle(
      color: other.color ?? color,
      strokeWidth: other.strokeWidth ?? strokeWidth,
      dashGap: other.dashGap ?? dashGap,
      dashWidth: other.dashWidth ?? dashWidth,
      radius: other.radius ?? radius,
      padding: other.padding ?? padding,
    );
  }
}
