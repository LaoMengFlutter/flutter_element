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

  initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100));
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
    _imageRect = _imageRect.translate(-event.delta.dx, -event.delta.dy);
    _updateValue();
  }

  void _onPointerUp() {

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
      ..color = Colors.red;
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
