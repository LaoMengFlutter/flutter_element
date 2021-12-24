import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class EImagePreview extends StatefulWidget {
  final ImageProvider imageProvider;

  const EImagePreview({
    Key? key,
    required this.imageProvider,
  }) : super(key: key);

  @override
  _EImagePreviewState createState() => _EImagePreviewState();
}

class _EImagePreviewState extends State<EImagePreview>
    with SingleTickerProviderStateMixin {
  ImageStream? _imageStream;
  ImageInfo? _imageInfo;

  /// 图片显示区域的rect
  Rect _imageRect = Rect.zero;

  /// rect
  Rect _viewRect = Rect.zero;

  late AnimationController _controller;
  Animation<double>? _imageRectLeftAnimation,
      _imageRectTopAnimation,
      _imageRectRightAnimation,
      _imageRectBottomAnimation;

  /// 最大偏移量
  final double _maxImageOffset = 100;

  @override
  initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100))
      ..addListener(() {
        resetImageRect();
      });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getImage();
  }

  @override
  void didUpdateWidget(EImagePreview oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.imageProvider != oldWidget.imageProvider) {
      _getImage();
    }
  }

  Size? get _size => context.size;

  void _getImage() {
    final ImageStream? oldImageStream = _imageStream;
    _imageStream =
        widget.imageProvider.resolve(createLocalImageConfiguration(context));
    if (_imageStream!.key != oldImageStream?.key) {
      final ImageStreamListener listener = ImageStreamListener(_updateImage);
      oldImageStream?.removeListener(listener);
      _imageStream!.addListener(listener);
    }
  }

  _updateValue() {
    if (!mounted) {
      return;
    }
    setState(() {});
  }

  void _updateImage(ImageInfo imageInfo, bool synchronousCall) {
    // 避免图片在 build 之前加载完成出现异常
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _imageInfo?.dispose();
      _imageInfo = imageInfo;
      var imageRatio =
          imageInfo.image.width.toDouble() / imageInfo.image.height;
      var sizeRatio = _size!.width / _size!.height;
      if (imageRatio < sizeRatio) {
        //图片的宽高比小于组件的宽高比
        _imageRect = Rect.fromLTWH(0, 0, _imageInfo!.image.width.toDouble(),
            _imageInfo!.image.width.toDouble() / sizeRatio);
        _viewRect = Rect.fromLTWH(0, 0, _size!.width, _size!.height);
      } else {
        //图片的宽高比大于组件的宽高比
        _imageRect = Rect.fromLTWH(0, 0, _imageInfo!.image.width.toDouble(),
            _imageInfo!.image.height.toDouble());
        var _viewHeight = _size!.width / imageRatio;
        _viewRect =
            Rect.fromLTWH(0, 0, (_size!.height - _viewHeight / 2), _viewHeight);
      }
      _updateValue();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _imageStream?.removeListener(ImageStreamListener(_updateImage));
    _imageInfo?.dispose();
    _imageInfo = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _imageInfo?.image == null
        ? Container()
        : Listener(
            onPointerMove: _onPointerMove,
            onPointerUp: (event) {
              _onPointerUp();
            },
            onPointerCancel: (event) {
              _onPointerUp();
            },
            child: GestureDetector(
              onScaleStart: (ScaleStartDetails details) {},
              onScaleUpdate: (ScaleUpdateDetails details) {},
              onScaleEnd: (ScaleEndDetails details) {},
              child: CustomPaint(
                size: const Size(double.infinity, double.infinity),
                painter: _ImageCustomPainter(
                  image: _imageInfo!.image,
                  imageRect: _imageRect,
                  viewRect: _viewRect,
                ),
              ),
            ),
          );
  }

  void _onPointerMove(PointerMoveEvent event) {
    if (_controller.isAnimating) {
      return;
    }
    var _dx = -event.delta.dx;
    var _dy = -event.delta.dy;
    if (_imageRect.left < 0 && event.delta.dx > 0) {
      _dx = _applyFriction(_maxImageOffset, -_imageRect.left, _dx);
    }
    if ((_imageRect.width - _imageRect.right) < 0 && event.delta.dx < 0) {
      _dx = _applyFriction(
          _maxImageOffset, _imageRect.right - _imageRect.width, _dx);
    }
    if (_imageRect.top < 0 && event.delta.dy > 0) {
      _dy = _applyFriction(_maxImageOffset, -_imageRect.top, _dy);
    }
    if ((_imageInfo!.image.height - _imageRect.bottom) < 0 &&
        event.delta.dy < 0) {
      _dy = _applyFriction(
          _maxImageOffset, _imageRect.bottom - _imageInfo!.image.height, _dy);
    }
    _imageRect = _imageRect.translate(_dx, _dy);
    _updateValue();
  }

  void _onPointerUp() {
    if (_controller.isAnimating) {
      return;
    }
    if (_imageRect.left < 0) {
      //水平向左移
      _imageRectLeftAnimation =
          Tween<double>(begin: _imageRect.left, end: 0).animate(_controller);
    }
    if (_imageRect.right > _imageRect.width) {
      //水平向右移
      _imageRectLeftAnimation =
          Tween<double>(begin: _imageRect.right, end: _imageRect.width)
              .animate(_controller);
    }
    if (_imageRect.top < 0) {
      //向下移
      _imageRectTopAnimation =
          Tween<double>(begin: _imageRect.top, end: 0).animate(_controller);
    }
    if (_imageRect.bottom > _imageRect.height) {
      //向上移
      _imageRectTopAnimation =
          Tween<double>(begin: _imageRect.bottom, end: _imageRect.height)
              .animate(_controller);
    }
    // _imageRectRightAnimation =
    //     Tween<double>(begin: _imageRect.right, end: 0).animate(_controller);
    // _imageRectBottomAnimation =
    //     Tween<double>(begin: _imageRect.bottom, end: 0).animate(_controller);
    _controller.reset();
    _controller.forward();
  }

  /// 阻尼效果
  ///
  /// 返回增加阻尼效果后的偏移
  double _applyFriction(double maxOffset, double alreadyOffset, double delta) {
    if (alreadyOffset + delta.abs() >= maxOffset) {
      //超过最大偏移量
      return maxOffset - alreadyOffset;
    }
    return (1 - (delta.abs() + alreadyOffset) / maxOffset) * delta;
  }

  /// 复位，
  void resetImageRect() {
    _imageRect = Rect.fromLTWH(_imageRectLeftAnimation!.value,
        _imageRectTopAnimation!.value, _imageRect.width, _imageRect.height);
    _updateValue();
  }
}

class _ImageCustomPainter extends CustomPainter {
  final ui.Image image;
  final Rect imageRect;
  final Rect viewRect;
  late Paint _paint;

  _ImageCustomPainter({
    required this.image,
    required this.imageRect,
    required this.viewRect,
  }) {
    _paint = Paint()
      ..isAntiAlias = false
      ..style = PaintingStyle.fill
      ..color = Colors.black;
  }

  @override
  void paint(Canvas canvas, Size size) {
    //background
    canvas.drawRect(
        Rect.fromLTWH(
          0,
          0,
          size.width,
          size.height,
        ),
        _paint);
    //image
    canvas.drawImageRect(image, imageRect, viewRect, _paint);
  }

  @override
  bool shouldRepaint(covariant _ImageCustomPainter oldDelegate) {
    return oldDelegate.image != image ||
        oldDelegate.imageRect != imageRect ||
        oldDelegate.viewRect != viewRect;
  }
}
