library ele_image;

import 'dart:math';

import 'package:ele_theme/ele_theme.dart';
import 'package:ele_theme/ele_theme_data.dart';
import 'package:flutter/material.dart';

class EImage extends StatelessWidget {
  const EImage({
    Key? key,
    required this.image,
    this.borderColor,
    this.borderWidth = 0,
    this.radius = BorderRadius.zero,
    this.shape = ImageShape.rrect,
    this.clipper,
  }) : super(key: key);

  final ImageProvider image;

  /// border color
  final Color? borderColor;

  /// border width
  final double borderWidth;

  /// border radius
  final BorderRadius radius;

  /// shape
  final ImageShape shape;

  /// custom path
  final CustomClipper<Path>? clipper;

  @override
  Widget build(BuildContext context) {
    EleThemeData eleTheme = EleTheme.of(context);
    var _clipper = _getClipper(clipper, shape, radius);
    var _borderColor =
        borderColor ?? eleTheme.borderColorLight ?? Colors.transparent;
    return ClipPath(
      clipper: _clipper,
      child: CustomPaint(
        foregroundPainter: _BorderPainter(
            clipper: _clipper, strokeWidth: borderWidth, color: _borderColor),
        child: Image(
          image: image,
        ),
      ),
    );
  }

  CustomClipper<Path> _getClipper(
      CustomClipper<Path>? clipper, ImageShape shape, BorderRadius radius) {
    CustomClipper<Path> _clipper;
    if (clipper != null) {
      _clipper = clipper;
    } else {
      switch (shape) {
        case ImageShape.rrect:
          _clipper = _RRectClipper(
            topRight: radius.topRight,
            topLeft: radius.topLeft,
            bottomLeft: radius.bottomLeft,
            bottomRight: radius.bottomRight,
          );
          break;
        case ImageShape.circle:
          _clipper = _CircleClipper();
          break;
      }
    }
    return _clipper;
  }
}

class _RRectClipper extends CustomClipper<Path> {
  final Radius topLeft;

  final Radius topRight;

  final Radius bottomRight;

  final Radius bottomLeft;

  _RRectClipper({
    required this.topLeft,
    required this.topRight,
    required this.bottomRight,
    required this.bottomLeft,
  });

  @override
  Path getClip(Size size) {
    final path = Path()
      ..addRRect(
        RRect.fromLTRBAndCorners(
          0,
          0,
          size.width,
          size.height,
          topLeft: topLeft,
          topRight: topRight,
          bottomLeft: bottomLeft,
          bottomRight: bottomRight,
        ),
      );
    return path;
  }

  @override
  bool shouldReclip(_RRectClipper oldClipper) {
    return topLeft != oldClipper.topRight ||
        topRight != oldClipper.topRight ||
        bottomLeft != oldClipper.bottomLeft ||
        bottomRight != oldClipper.bottomRight;
  }
}

class _CircleClipper extends CustomClipper<Path> {
  _CircleClipper();

  @override
  Path getClip(Size size) {
    double radius = min(size.width, size.height) / 2;
    final path = Path()
      ..addOval(Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2), radius: radius));
    return path;
  }

  @override
  bool shouldReclip(_CircleClipper oldClipper) => false;
}

class _BorderPainter extends CustomPainter {
  final Color color;
  final CustomClipper<Path> clipper;
  final double strokeWidth;

  _BorderPainter(
      {required this.clipper, required this.color, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    canvas.drawPath(clipper.getClip(size), paint);
  }

  @override
  bool shouldRepaint(_BorderPainter oldDelegate) =>
      color != oldDelegate.color ||
      clipper != oldDelegate.clipper ||
      strokeWidth != oldDelegate.strokeWidth;
}

enum ImageShape {
  /// rrect
  rrect,

  /// circle
  circle,
}
