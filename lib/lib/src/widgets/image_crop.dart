import 'dart:math';

import 'package:flutter/material.dart';
import 'theme/image_crop_style.dart';
import 'theme/theme.dart';
import 'theme/theme_data.dart';

class EImageCrop extends StatefulWidget {
  final ImageProvider image;

  /// 宽高比
  final double cropAspectRatio;
  final EImageCropStyle? style;

  /// 四边顶点高度
  final double vertexHeight;

  /// 改变指示器大小的时候，是否保持比例不变
  final bool keepAspectRatio;

  const EImageCrop({
    Key? key,
    required this.image,
    this.cropAspectRatio = 1,
    this.style,
    this.vertexHeight = 12,
    this.keepAspectRatio = true,
  }) : super(key: key);

  @override
  _EImageCropState createState() => _EImageCropState();
}

class _EImageCropState extends State<EImageCrop> {
  @override
  Widget build(BuildContext context) {
    EleThemeData eleTheme = EleTheme.of(context);
    var _style = eleTheme.imageCropStyle?.merge(widget.style) ?? widget.style;
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(
          child: Image(
            image: widget.image,
            fit: BoxFit.fill,
          ),
        ),
        Positioned.fill(
          child: Center(
            child: _CropAreaIndicator(
              aspectRatio: widget.cropAspectRatio,
              borderColor: _style?.borderColor ?? Colors.white,
              borderWidth: _style?.borderWidget ?? 1,
              radius: _style?.borderRadius ?? 0,
              vertexHeight: widget.vertexHeight,
              keepAspectRatio: widget.keepAspectRatio,
            ),
          ),
        ),
      ],
    );
  }
}



/// 裁剪区域指示器
///
///
class _CropAreaIndicator extends StatefulWidget {
  /// 宽高比
  final double aspectRatio;
  final Color borderColor;

  final double borderWidth;

  final double radius;

  /// 四边顶点高度
  final double vertexHeight;

  /// 改变指示器大小的时候，是否保持比例不变
  final bool keepAspectRatio;

  const _CropAreaIndicator({
    Key? key,
    required this.aspectRatio,
    required this.borderColor,
    required this.borderWidth,
    required this.radius,
    required this.vertexHeight,
    required this.keepAspectRatio,
  })  : assert(aspectRatio > 0),
        assert(borderWidth >= 0),
        assert(radius >= 0),
        assert(vertexHeight >= 0),
        super(key: key);

  @override
  State<_CropAreaIndicator> createState() => _CropAreaIndicatorState();
}

class _CropAreaIndicatorState extends State<_CropAreaIndicator> {
  double _paddingLeft = 0;
  double _paddingTop = 0;
  double _paddingRight = 0;
  double _paddingBottom = 0;
  late double _minWidth;
  late double _minHeight;

  @override
  initState() {
    _minWidth = 2 * widget.vertexHeight;
    _minHeight = 2 * widget.vertexHeight;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant _CropAreaIndicator oldWidget) {
    if (oldWidget.vertexHeight != widget.vertexHeight) {
      _minWidth = 2 * widget.vertexHeight;
      _minHeight = 2 * widget.vertexHeight;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: widget.aspectRatio,
      child: Padding(
        padding: EdgeInsets.only(
          left: _paddingLeft,
          top: _paddingTop,
          right: _paddingRight,
          bottom: _paddingBottom,
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.all(widget.vertexHeight / 2),
                child: CustomPaint(
                  painter: _CropAreaIndicatorPainter(
                      borderColor: Colors.white,
                      borderWidth: 1,
                      radius: 0,
                      divideCount: 2),
                ),
              ),
            ),
            Positioned.fill(
                child:
                    _buildFourVertexCircle(widget.vertexHeight, Colors.white)),
          ],
        ),
      ),
    );
  }

  ///  四个顶角圆点
  ///
  ///
  Widget _buildFourVertexCircle(double vertexHeight, Color color) {
    return Stack(
      children: [
        //左上角
        Positioned(
          left: 0,
          top: 0,
          child: Listener(
            onPointerMove: (PointerMoveEvent pointerMoveEvent) {
              _leftTopMove(pointerMoveEvent);
            },
            child: _buildCircle(vertexHeight, color),
          ),
        ),
        //右上角
        Positioned(
          right: 0,
          top: 0,
          child: Listener(
            onPointerMove: (PointerMoveEvent pointerMoveEvent) {
              _rightTopMove(pointerMoveEvent);
            },
            child: _buildCircle(vertexHeight, color),
          ),
        ),
        //左下角
        Positioned(
          left: 0,
          bottom: 0,
          child: Listener(
            onPointerMove: (PointerMoveEvent pointerMoveEvent) {
              _leftBottomMove(pointerMoveEvent);
            },
            child: _buildCircle(vertexHeight, color),
          ),
        ),
        //右下角
        Positioned(
          right: 0,
          bottom: 0,
          child: Listener(
            onPointerMove: (PointerMoveEvent pointerMoveEvent) {
              _rightBottomMove(pointerMoveEvent);
            },
            child: _buildCircle(vertexHeight, color),
          ),
        ),
      ],
    );
  }

  Widget _buildCircle(double vertexHeight, Color color) {
    return SizedBox(
      width: vertexHeight,
      height: vertexHeight,
      child: CustomPaint(
        painter: _CirclePainter(color: color),
      ),
    );
  }

  /// 移动左上角顶点
  void _leftTopMove(PointerMoveEvent pointerMoveEvent) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    if (widget.keepAspectRatio) {
      //保持比例不变
      if (pointerMoveEvent.delta.dx.abs() >= pointerMoveEvent.delta.dy.abs()) {
        //以x轴为准
        _paddingLeft += pointerMoveEvent.delta.dx;
        if (_paddingLeft < 0) {
          _paddingLeft = 0;
        }
        if (_paddingLeft + _paddingRight + _minWidth >= renderBox.size.width) {
          _paddingLeft = renderBox.size.width - _minWidth - _paddingRight;
        }
        // _paddingTop 通过比例计算
        var indicatorWidth =
            renderBox.size.width - _paddingLeft - _paddingRight;
        var indicatorHeight = indicatorWidth / widget.aspectRatio;
        _paddingTop = renderBox.size.height - indicatorHeight - _paddingBottom;
        if (_paddingTop < 0) {
          _paddingTop = 0;
        }
        if (_paddingTop + _paddingBottom + _minHeight >=
            renderBox.size.height) {
          _paddingTop = renderBox.size.height - _minHeight - _paddingBottom;
        }
      } else if (pointerMoveEvent.delta.dx.abs() <
          pointerMoveEvent.delta.dy.abs()) {
        //以y轴为准
        _paddingTop += pointerMoveEvent.delta.dy;
        if (_paddingTop < 0) {
          _paddingTop = 0;
        }
        if (_paddingTop + _paddingBottom + _minHeight >=
            renderBox.size.height) {
          _paddingTop = renderBox.size.height - _minHeight - _paddingBottom;
        }

        // _paddingLeft 通过比例计算
        var indicatorHeight =
            renderBox.size.height - _paddingBottom - _paddingTop;
        var indicatorWidth = indicatorHeight * widget.aspectRatio;
        _paddingLeft = renderBox.size.width - indicatorWidth - _paddingRight;
        if (_paddingLeft < 0) {
          _paddingLeft = 0;
        }
        if (_paddingLeft + _paddingRight + _minWidth >= renderBox.size.width) {
          _paddingLeft = renderBox.size.width - _minWidth - _paddingRight;
        }
      }
    } else {
      _paddingLeft += pointerMoveEvent.delta.dx;
      if (_paddingLeft < 0) {
        _paddingLeft = 0;
      }
      if (_paddingLeft + _paddingRight + _minWidth >= renderBox.size.width) {
        _paddingLeft = renderBox.size.width - _minWidth - _paddingRight;
      }
      _paddingTop += pointerMoveEvent.delta.dy;
      if (_paddingTop < 0) {
        _paddingTop = 0;
      }
      if (_paddingTop + _paddingBottom + _minHeight >= renderBox.size.height) {
        _paddingTop = renderBox.size.height - _minHeight - _paddingBottom;
      }
    }
    _updatePadding();
  }

  /// 移动右上角顶点
  void _rightTopMove(PointerMoveEvent pointerMoveEvent) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;

    if (widget.keepAspectRatio) {
      //保持比例不变
      if (pointerMoveEvent.delta.dx.abs() >= pointerMoveEvent.delta.dy.abs()) {
        //以x轴为准
        _paddingRight += -pointerMoveEvent.delta.dx;
        if (_paddingRight < 0) {
          _paddingRight = 0;
        }
        if (_paddingLeft + _paddingRight + _minWidth >= renderBox.size.width) {
          _paddingRight = renderBox.size.width - _minWidth - _paddingLeft;
        }
        // _paddingTop 通过比例计算
        var indicatorWidth =
            renderBox.size.width - _paddingLeft - _paddingRight;
        var indicatorHeight = indicatorWidth / widget.aspectRatio;
        _paddingTop = renderBox.size.height - indicatorHeight - _paddingBottom;
        if (_paddingTop < 0) {
          _paddingTop = 0;
        }
        if (_paddingTop + _paddingBottom + _minHeight >=
            renderBox.size.height) {
          _paddingTop = renderBox.size.height - _minHeight - _paddingBottom;
        }
      } else if (pointerMoveEvent.delta.dx.abs() <
          pointerMoveEvent.delta.dy.abs()) {
        //以y轴为准
        _paddingTop += pointerMoveEvent.delta.dy;
        if (_paddingTop < 0) {
          _paddingTop = 0;
        }
        if (_paddingTop + _paddingBottom + _minHeight >=
            renderBox.size.height) {
          _paddingTop = renderBox.size.height - _minHeight - _paddingBottom;
        }

        // _paddingLeft 通过比例计算
        var indicatorHeight =
            renderBox.size.height - _paddingBottom - _paddingTop;
        var indicatorWidth = indicatorHeight * widget.aspectRatio;
        _paddingRight = renderBox.size.width - indicatorWidth - _paddingLeft;
        if (_paddingRight < 0) {
          _paddingRight = 0;
        }
        if (_paddingLeft + _paddingRight + _minWidth >= renderBox.size.width) {
          _paddingRight = renderBox.size.width - _minWidth - _paddingLeft;
        }
      }
    } else {
      _paddingRight += -pointerMoveEvent.delta.dx;
      if (_paddingRight < 0) {
        _paddingRight = 0;
      }
      if (_paddingLeft + _paddingRight + _minWidth >= renderBox.size.width) {
        _paddingRight = renderBox.size.width - _minWidth - _paddingLeft;
      }
      _paddingTop += pointerMoveEvent.delta.dy;
      if (_paddingTop < 0) {
        _paddingTop = 0;
      }
      if (_paddingTop + _paddingBottom + _minHeight >= renderBox.size.height) {
        _paddingTop = renderBox.size.height - _minHeight - _paddingBottom;
      }
    }
    _updatePadding();
  }

  /// 移动左下角顶点
  void _leftBottomMove(PointerMoveEvent pointerMoveEvent) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    if (widget.keepAspectRatio) {
      //保持比例不变
      if (pointerMoveEvent.delta.dx.abs() >= pointerMoveEvent.delta.dy.abs()) {
        //以x轴为准
        _paddingLeft += pointerMoveEvent.delta.dx;
        if (_paddingLeft < 0) {
          _paddingLeft = 0;
        }
        if (_paddingLeft + _paddingRight + _minWidth >= renderBox.size.width) {
          _paddingLeft = renderBox.size.width - _minWidth - _paddingRight;
        }
        // _paddingTop 通过比例计算
        var indicatorWidth =
            renderBox.size.width - _paddingLeft - _paddingRight;
        var indicatorHeight = indicatorWidth / widget.aspectRatio;
        _paddingBottom = renderBox.size.height - indicatorHeight - _paddingTop;
        if (_paddingBottom < 0) {
          _paddingBottom = 0;
        }
        if (_paddingTop + _paddingBottom + _minHeight >=
            renderBox.size.height) {
          _paddingBottom = renderBox.size.height - _minHeight - _paddingTop;
        }
      } else if (pointerMoveEvent.delta.dx.abs() <
          pointerMoveEvent.delta.dy.abs()) {
        //以y轴为准
        _paddingBottom += -pointerMoveEvent.delta.dy;
        if (_paddingBottom < 0) {
          _paddingBottom = 0;
        }
        if (_paddingTop + _paddingBottom + _minHeight >=
            renderBox.size.height) {
          _paddingBottom = renderBox.size.height - _minHeight - _paddingTop;
        }

        // _paddingLeft 通过比例计算
        var indicatorHeight =
            renderBox.size.height - _paddingBottom - _paddingTop;
        var indicatorWidth = indicatorHeight * widget.aspectRatio;
        _paddingLeft = renderBox.size.width - indicatorWidth - _paddingRight;
        if (_paddingLeft < 0) {
          _paddingLeft = 0;
        }
        if (_paddingLeft + _paddingRight + _minWidth >= renderBox.size.width) {
          _paddingLeft = renderBox.size.width - _minWidth - _paddingRight;
        }
      }
    } else {
      _paddingLeft += pointerMoveEvent.delta.dx;
      if (_paddingLeft < 0) {
        _paddingLeft = 0;
      }
      if (_paddingLeft + _paddingRight + _minWidth >= renderBox.size.width) {
        _paddingLeft = renderBox.size.width - _minWidth - _paddingRight;
      }
      _paddingBottom += -pointerMoveEvent.delta.dy;
      if (_paddingBottom < 0) {
        _paddingBottom = 0;
      }
      if (_paddingTop + _paddingBottom + _minHeight >= renderBox.size.height) {
        _paddingBottom = renderBox.size.height - _minHeight - _paddingTop;
      }
    }
    _updatePadding();
  }

  /// 移动右下角顶点
  void _rightBottomMove(PointerMoveEvent pointerMoveEvent) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;

    if (widget.keepAspectRatio) {
      //保持比例不变
      if (pointerMoveEvent.delta.dx.abs() >= pointerMoveEvent.delta.dy.abs()) {
        //以x轴为准
        _paddingRight += -pointerMoveEvent.delta.dx;
        if (_paddingRight < 0) {
          _paddingRight = 0;
        }
        if (_paddingLeft + _paddingRight + _minWidth >= renderBox.size.width) {
          _paddingRight = renderBox.size.width - _minWidth - _paddingLeft;
        }
        // _paddingTop 通过比例计算
        var indicatorWidth =
            renderBox.size.width - _paddingLeft - _paddingRight;
        var indicatorHeight = indicatorWidth / widget.aspectRatio;
        _paddingBottom = renderBox.size.height - indicatorHeight - _paddingTop;
        if (_paddingBottom < 0) {
          _paddingBottom = 0;
        }
        if (_paddingTop + _paddingBottom + _minHeight >=
            renderBox.size.height) {
          _paddingBottom = renderBox.size.height - _minHeight - _paddingTop;
        }
      } else if (pointerMoveEvent.delta.dx.abs() <
          pointerMoveEvent.delta.dy.abs()) {
        //以y轴为准
        _paddingBottom += -pointerMoveEvent.delta.dy;
        if (_paddingBottom < 0) {
          _paddingBottom = 0;
        }
        if (_paddingTop + _paddingBottom + _minHeight >=
            renderBox.size.height) {
          _paddingBottom = renderBox.size.height - _minHeight - _paddingTop;
        }

        // _paddingLeft 通过比例计算
        var indicatorHeight =
            renderBox.size.height - _paddingBottom - _paddingTop;
        var indicatorWidth = indicatorHeight * widget.aspectRatio;
        _paddingRight = renderBox.size.width - indicatorWidth - _paddingLeft;
        if (_paddingRight < 0) {
          _paddingRight = 0;
        }
        if (_paddingLeft + _paddingRight + _minWidth >= renderBox.size.width) {
          _paddingRight = renderBox.size.width - _minWidth - _paddingLeft;
        }
      }
    } else {
      _paddingRight += -pointerMoveEvent.delta.dx;
      if (_paddingRight < 0) {
        _paddingRight = 0;
      }
      if (_paddingLeft + _paddingRight + _minWidth >= renderBox.size.width) {
        _paddingRight = renderBox.size.width - _minWidth - _paddingLeft;
      }
      _paddingBottom += -pointerMoveEvent.delta.dy;
      if (_paddingBottom < 0) {
        _paddingBottom = 0;
      }
      if (_paddingTop + _paddingBottom + _minHeight >= renderBox.size.height) {
        _paddingBottom = renderBox.size.height - _minHeight - _paddingTop;
      }
    }
    _updatePadding();
  }

  void _updatePadding() {
    if (_paddingLeft < 0) {
      _paddingLeft = 0;
    }
    if (_paddingRight < 0) {
      _paddingRight = 0;
    }
    if (_paddingTop < 0) {
      _paddingTop = 0;
    }
    if (_paddingBottom < 0) {
      _paddingBottom = 0;
    }
    if (!mounted) {
      return;
    }
    setState(() {});
  }
}

class _CropAreaIndicatorPainter extends CustomPainter {
  final Color borderColor;

  final double borderWidth;

  final double radius;

  final int divideCount;

  late Paint _paint;

  _CropAreaIndicatorPainter({
    required this.borderColor,
    required this.borderWidth,
    required this.radius,
    required this.divideCount,
  }) {
    assert(divideCount >= 0);
    assert(radius >= 0);
    assert(borderWidth >= 0);
    _paint = Paint()
      ..color = borderColor
      ..strokeWidth = borderWidth
      ..style = PaintingStyle.stroke;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // 四边框
    canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, size.width, size.height),
            Radius.circular(radius)),
        _paint);

    // 垂直分割线
    List.generate(divideCount, (index) {
      var x = (size.width * (index + 1)) / (divideCount + 1);
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), _paint);
    });

    // 水平分割线
    List.generate(divideCount, (index) {
      var y = (size.height * (index + 1)) / (divideCount + 1);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), _paint);
    });
  }

  @override
  bool shouldRepaint(covariant _CropAreaIndicatorPainter oldDelegate) {
    return oldDelegate.borderColor != borderColor ||
        oldDelegate.borderWidth != borderWidth ||
        oldDelegate.radius != radius ||
        oldDelegate.divideCount != divideCount;
  }
}

class _CirclePainter extends CustomPainter {
  final Color color;
  late Paint _paint;

  _CirclePainter({
    required this.color,
  }) {
    _paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var radius = min(size.width, size.height) / 2;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), radius, _paint);
  }

  @override
  bool shouldRepaint(covariant _CirclePainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
