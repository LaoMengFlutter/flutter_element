import 'dart:math';

import 'package:flutter/material.dart';
import 'theme/theme.dart';
import 'theme/theme_data.dart';

class EImage extends StatelessWidget {
  const EImage({
    Key? key,
    required this.image,
    this.borderColor,
    this.borderWidth = 0,
    this.radius = BorderRadius.zero,
    this.shape = ImageShape.rrect,
    this.clipper,
    this.fit,
    this.width,
    this.height,
    this.placeholderWidget,
    this.loadingBuilder,
    this.errorWidget,
    this.errorBuilder,
    this.frameBuilder,
    this.semanticLabel,
    this.excludeFromSemantics = false,
    this.color,
    this.opacity,
    this.colorBlendMode,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.centerSlice,
    this.matchTextDirection = false,
    this.gaplessPlayback = false,
    this.isAntiAlias = false,
    this.filterQuality = FilterQuality.low,
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

  /// fit
  final BoxFit? fit;

  /// width
  final double? width;

  /// width
  final double? height;

  /// loadingBuilder
  final ImageLoadingBuilder? loadingBuilder;

  /// loadingBuilder
  final Widget? placeholderWidget;

  /// errorBuilder
  final ImageErrorWidgetBuilder? errorBuilder;

  /// errorWidget
  final Widget? errorWidget;
  final String? semanticLabel;

  /// Whether to exclude this image from semantics.
  ///
  /// Useful for images which do not contribute meaningful information to an
  /// application.
  final bool excludeFromSemantics;

  /// Whether to paint the image with anti-aliasing.
  ///
  /// Anti-aliasing alleviates the sawtooth artifact when the image is rotated.
  final bool isAntiAlias;
  final AlignmentGeometry alignment;

  /// How to paint any portions of the layout bounds not covered by the image.
  final ImageRepeat repeat;
  final bool matchTextDirection;
  final Rect? centerSlice;
  final Color? color;
  final bool gaplessPlayback;
  final Animation<double>? opacity;
  final FilterQuality filterQuality;
  final BlendMode? colorBlendMode;
  final ImageFrameBuilder? frameBuilder;

  @override
  Widget build(BuildContext context) {
    EleThemeData eleTheme = EleTheme.of(context);
    var _clipper = _getClipper(clipper, shape, radius);
    var _borderColor =
        borderColor ?? eleTheme.borderColorLight ?? Colors.transparent;

    var _loadingBuilder = loadingBuilder ??
        (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return placeholderWidget ??
              eleTheme.imageStyle?.placeholderWidget ??
              child;
        };

    var _errorBuilder = errorBuilder ??
        (BuildContext context, Object error, StackTrace? stackTrace) {
          return errorWidget ?? eleTheme.imageStyle?.errorWidget ?? Container();
        };
    var child = Image(
      key: key,
      image: image,
      fit: fit,
      width: width,
      height: height,
      loadingBuilder: _loadingBuilder,
      errorBuilder: _errorBuilder,
      frameBuilder: frameBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      filterQuality: filterQuality,
    );

    return ClipPath(
      clipper: _clipper,
      child: CustomPaint(
        foregroundPainter: _BorderPainter(
            clipper: _clipper, strokeWidth: borderWidth, color: _borderColor),
        child: child,
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
    if (strokeWidth <= 0) {
      return;
    }
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
