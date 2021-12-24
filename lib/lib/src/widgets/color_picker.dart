import 'package:element_ui/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../animations.dart';

/// 默认滑块圆角半径，无限大圆形
const _kThumbRadius = Radius.circular(24);

/// 滑块尺寸
const _kThumbSize = Size(24, 24);
const _kColorPickerThumbSize = Size(12, 12);
const _kThumbColor = Colors.white;
const _kBackgroundColor = Colors.white;

/// 轨道宽度
const _kTrackWidth = 12.0;
const _kSpace = 12.0;
const double _kPickerWidth = 300;
const double _kPickerHeight = 200;
const HSVColor _kHSVColor = HSVColor.fromAHSV(1.0, 0.0, 1.0, 1.0);

class EColorPickerButton extends StatefulWidget {
  final Color? color;
  final double? width;
  final double? height;
  final Color? borderColor;
  final double pickerWidth;
  final double pickerHeight;
  final Color backgroundColor;
  final EdgeInsetsGeometry buttonPadding;
  final ValueChanged<Color?>? onChange;
  final ValueChanged<Color?>? onConfirm;
  final bool showAlpha;
  final bool showTextField;
  final bool showConfirmButton;
  final String confirmButtonTxt;
  final bool showClearButton;
  final ValueChanged<Color?>? onClear;
  final String clearButtonTxt;
  final List<Color>? predefineColors;
  final double predefineSize;

  const EColorPickerButton({
    Key? key,
    this.color,
    this.width,
    this.height,
    this.pickerWidth = _kPickerWidth,
    this.pickerHeight = _kPickerHeight,
    this.borderColor,
    this.backgroundColor = _kBackgroundColor,
    this.buttonPadding = const EdgeInsets.all(4),
    this.showAlpha = false,
    this.showTextField = true,
    this.showConfirmButton = true,
    this.confirmButtonTxt = '确认',
    this.onConfirm,
    this.showClearButton = false,
    this.clearButtonTxt = '清空',
    this.predefineColors,
    this.predefineSize = 25,
    this.onChange,
    this.onClear,
  }) : super(key: key);

  @override
  _EColorPickerButtonState createState() => _EColorPickerButtonState();
}

class _EColorPickerButtonState extends State<EColorPickerButton> {
  Color? _color;
  _ColorPickerRoute? _colorPickerRoute;

  @override
  void initState() {
    _color = widget.color;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant EColorPickerButton oldWidget) {
    if (oldWidget.color != widget.color) {
      _color = widget.color;
    }
    super.didUpdateWidget(oldWidget);
  }

  EBorderStyle? get _borderStyle => EleTheme.of(context).borderStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: SizedBox(
        width: widget.width ?? double.infinity,
        height: widget.height ?? double.infinity,
        child: EBorder(
          style: EBorderStyle(
            color: widget.borderColor ?? EleTheme.of(context).borderColorBase,
            padding: widget.buttonPadding,
          ),
          child: _color == null
              ? _buildNoColorView()
              : Stack(
                  fit: StackFit.expand,
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: _borderStyle?.radius ?? BorderRadius.zero,
                        child: CustomPaint(
                          painter: _ChessPainter(),
                          foregroundPainter: _ColorPainter(
                            color: _color,
                          ),
                        ),
                      ),
                    ),
                    const Positioned.fill(
                      child: Center(
                        child: Icon(
                          Icons.expand_more,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildNoColorView() {
    return Container(
      color: Colors.white,
      child: const Icon(Icons.clear, size: 16, color: Colors.grey),
    );
  }

  _onColorChange(Color? color) {
    setState(() {
      _color = color;
    });
    widget.onChange?.call(color);
  }

  _onConfirm(Color? color) {
    setState(() {
      _color = color;
    });
    widget.onConfirm?.call(color);
    _removeRoute();
  }

  _onTap() {
    final NavigatorState navigator = Navigator.of(context);
    final RenderBox itemBox = context.findRenderObject()! as RenderBox;
    final Rect itemRect = itemBox.localToGlobal(
            itemBox.size.topLeft(Offset.zero),
            ancestor: navigator.context.findRenderObject()) &
        itemBox.size;
    _colorPickerRoute = _ColorPickerRoute(
      color: _color,
      onChange: _onColorChange,
      buttonRect: itemRect,
      buttonSize: itemBox.size,
      width: widget.pickerWidth,
      height: widget.pickerHeight,
      backgroundColor: widget.backgroundColor,
      onConfirm: _onConfirm,
      showAlpha: widget.showAlpha,
      showTextField: widget.showTextField,
      showConfirmButton: widget.showConfirmButton,
      confirmButtonTxt: widget.confirmButtonTxt,
      showClearButton: widget.showClearButton,
      clearButtonTxt: widget.clearButtonTxt,
      predefineColors: widget.predefineColors,
      predefineSize: widget.predefineSize,
      onClear: widget.onClear,
    );
    navigator.push(_colorPickerRoute!).then<void>((Color? newValue) {
      _removeRoute();
      if (!mounted) {
        return;
      }
      if (newValue != null) {
        // widget.onChanged?.call(newValue.result);
      }
    });
  }

  void _removeRoute() {
    _colorPickerRoute?._dismiss();
    _colorPickerRoute = null;
  }
}

class _ColorPickerRoute extends PopupRoute<Color?> {
  _ColorPickerRoute({
    this.color,
    this.onChange,
    required this.buttonRect,
    required this.buttonSize,
    required this.width,
    required this.height,
    required this.backgroundColor,
    this.barrierLabel,
    this.showAlpha = false,
    this.showTextField = true,
    this.showConfirmButton = true,
    this.confirmButtonTxt = '确认',
    this.onConfirm,
    this.showClearButton = false,
    this.clearButtonTxt = '清空',
    this.predefineColors,
    this.predefineSize = 25,
    this.onClear,
  });

  final Color? color;
  final ValueChanged<Color?>? onChange;
  final Rect buttonRect;
  final Size buttonSize;
  final double width;
  final double height;
  final ValueChanged<Color?>? onConfirm;
  final bool showAlpha;
  final bool showTextField;
  final bool showConfirmButton;
  final String confirmButtonTxt;
  final bool showClearButton;
  final String clearButtonTxt;
  final ValueChanged<Color?>? onClear;
  final List<Color>? predefineColors;
  final double predefineSize;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  bool get barrierDismissible => true;

  @override
  Color? get barrierColor => null;

  @override
  final String? barrierLabel;
  final Color backgroundColor;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return _ColorPickerRoutePage(
          color: color,
          route: this,
          onChange: onChange,
          buttonRect: buttonRect,
          buttonSize: buttonSize,
          width: width,
          height: height,
          backgroundColor: backgroundColor,
          onConfirm: onConfirm,
          showAlpha: showAlpha,
          showTextField: showTextField,
          showConfirmButton: showConfirmButton,
          confirmButtonTxt: confirmButtonTxt,
          showClearButton: showClearButton,
          clearButtonTxt: clearButtonTxt,
          predefineColors: predefineColors,
          predefineSize: predefineSize,
          onClear: onClear,
        );
      },
    );
  }

  void _dismiss() {
    if (isActive) {
      navigator?.removeRoute(this);
    }
  }
}

class _ColorPickerRoutePage extends StatelessWidget {
  const _ColorPickerRoutePage({
    Key? key,
    required this.route,
    this.color,
    this.onChange,
    required this.buttonRect,
    required this.buttonSize,
    required this.width,
    required this.height,
    required this.backgroundColor,
    this.onConfirm,
    this.showAlpha = false,
    this.showTextField = true,
    this.showConfirmButton = true,
    this.confirmButtonTxt = '确认',
    this.showClearButton = false,
    this.clearButtonTxt = '清空',
    this.onClear,
    this.predefineColors,
    this.predefineSize = 25,
  }) : super(key: key);

  final Color? color;
  final ValueChanged<Color?>? onChange;
  final Rect buttonRect;
  final Size buttonSize;
  final _ColorPickerRoute route;
  final double width;
  final double height;
  final Color backgroundColor;
  final ValueChanged<Color?>? onConfirm;
  final bool showAlpha;
  final bool showTextField;
  final bool showConfirmButton;
  final String confirmButtonTxt;
  final bool showClearButton;
  final ValueChanged<Color?>? onClear;
  final String clearButtonTxt;
  final List<Color>? predefineColors;
  final double predefineSize;

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildLayout(
      delegate: _ColorPickerRouteLayout(
        buttonRect: buttonRect,
        buttonSize: buttonSize,
      ),
      child: UnconstrainedBox(
        child: ECollapseTransition(
          collapse: route.animation!,
          child: Container(
            color: backgroundColor,
            width: width,
            height: height,
            child: EBorder(
              style: EBorderStyle(color: EleTheme.of(context).borderColorBase),
              child: Material(
                child: EColorPicker(
                  color: color,
                  onChange: onChange,
                  onConfirm: onConfirm,
                  showAlpha: showAlpha,
                  showTextField: showTextField,
                  showConfirmButton: showConfirmButton,
                  confirmButtonTxt: confirmButtonTxt,
                  showClearButton: showClearButton,
                  clearButtonTxt: clearButtonTxt,
                  predefineColors: predefineColors,
                  predefineSize: predefineSize,
                  onClear: onClear,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ColorPickerRouteLayout extends SingleChildLayoutDelegate {
  _ColorPickerRouteLayout({
    required this.buttonRect,
    required this.buttonSize,
  });

  final Rect buttonRect;
  final Size buttonSize;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints(
      minWidth: 0,
      maxWidth: constraints.maxWidth,
      minHeight: 0,
      maxHeight: constraints.maxHeight,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    var left = buttonRect.left + buttonSize.width / 2 - childSize.width / 2;
    left = left.clamp(0, size.width - childSize.width);

    var top = buttonRect.top + buttonSize.height;
    if (top + childSize.height > size.height) {
      //显示在上面
      top = buttonRect.top - childSize.height;
    }

    return Offset(left, top);
  }

  @override
  bool shouldRelayout(_ColorPickerRouteLayout oldDelegate) {
    return buttonRect != oldDelegate.buttonRect;
  }
}

class EColorPicker extends StatefulWidget {
  final Color? color;
  final ValueChanged<Color?>? onChange;
  final ValueChanged<Color?>? onConfirm;
  final bool showAlpha;
  final bool showTextField;
  final bool showConfirmButton;
  final String confirmButtonTxt;
  final bool showClearButton;
  final String clearButtonTxt;
  final ValueChanged<Color?>? onClear;
  final List<Color>? predefineColors;
  final double predefineSize;

  const EColorPicker({
    Key? key,
    this.color,
    this.onChange,
    this.showAlpha = false,
    this.showTextField = true,
    this.showConfirmButton = true,
    this.confirmButtonTxt = '确认',
    this.onConfirm,
    this.showClearButton = false,
    this.clearButtonTxt = '清空',
    this.onClear,
    this.predefineColors,
    this.predefineSize = 25,
  }) : super(key: key);

  @override
  _EColorPickerState createState() => _EColorPickerState();
}

class _EColorPickerState extends State<EColorPicker> {
  HSVColor? _currentHsvColor;
  late Offset _colorPickerThumbPosition, _hueThumbPosition, _alphaThumbPosition;
  int? _predefineColorIndex;

  @override
  initState() {
    _currentHsvColor =
        widget.color != null ? HSVColor.fromColor(widget.color!) : null;
    _initSliderOffset();
    super.initState();
  }

  String _color2String(Color? color) {
    return color == null
        ? ''
        : '#${color.value.toRadixString(16).padLeft(8, '0')}'.toUpperCase();
  }

  @override
  void didUpdateWidget(covariant EColorPicker oldWidget) {
    if (oldWidget.color != widget.color) {
      _currentHsvColor =
          widget.color != null ? HSVColor.fromColor(widget.color!) : null;
      _initSliderOffset();
    }
    super.didUpdateWidget(oldWidget);
  }

  _initSliderOffset() {
    if (_currentHsvColor != null) {
      _colorPickerThumbPosition =
          Offset(_currentHsvColor!.saturation, 1 - _currentHsvColor!.value);
      _hueThumbPosition = Offset(.5, _currentHsvColor!.hue / 360.0);
      _alphaThumbPosition = Offset(_currentHsvColor!.alpha, .5);
    } else {
      _colorPickerThumbPosition = const Offset(1, 0);
      _hueThumbPosition = const Offset(.5, 0);
      _alphaThumbPosition = const Offset(1, .5);
    }
  }

  _onHueValueChange(double horizontal, double vertical) {
    _currentHsvColor ??= _kHSVColor;
    _currentHsvColor = _currentHsvColor?.withHue(vertical * 360);
    _updateValue();
  }

  _onAlphaValueChange(double horizontal, double vertical) {
    _currentHsvColor ??= _kHSVColor;
    _currentHsvColor = _currentHsvColor?.withAlpha(horizontal);
    _updateValue();
  }

  _onColorPickerValueChange(double horizontal, double vertical) {
    _currentHsvColor ??= _kHSVColor;
    _currentHsvColor =
        _currentHsvColor?.withSaturation(horizontal).withValue(1 - vertical);
    _updateValue();
  }

  _updateValue() {
    if (!mounted) {
      return;
    }
    setState(() {});
    widget.onChange?.call(_currentHsvColor?.toColor());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.all(
                        (_kThumbSize.width - _kColorPickerThumbSize.width) / 2),
                    child: _Slider(
                      thumbColor: _kThumbColor,
                      thumbCenter: _colorPickerThumbPosition,
                      thumbSize: _kColorPickerThumbSize,
                      thumbPaintingStyle: PaintingStyle.stroke,
                      thumbRadius: _kThumbRadius,
                      thumbStrokeWidth: 1,
                      sliderDirection: _SliderDirection.all,
                      onChange: _onColorPickerValueChange,
                      child: CustomPaint(
                        painter: _ColorPickerPainter(
                            color: _currentHsvColor ?? _kHSVColor),
                      ),
                    ),
                  ),
                ),
              ),
              // const SizedBox(width: _kSpace),
              SizedBox(
                width: _kTrackWidth,
                height: double.infinity,
                child: _Slider(
                  thumbColor: _kThumbColor,
                  thumbCenter: _hueThumbPosition,
                  thumbSize: _kThumbSize,
                  thumbPaintingStyle: PaintingStyle.fill,
                  thumbRadius: _kThumbRadius,
                  thumbStrokeWidth: 1,
                  sliderDirection: _SliderDirection.vertical,
                  onChange: _onHueValueChange,
                  padding:
                      EdgeInsets.symmetric(vertical: _kThumbSize.height / 2),
                  child: CustomPaint(
                    painter: _HueTrackPainter(),
                  ),
                ),
              ),
              const SizedBox(width: _kSpace),
            ],
          ),
        ),
        if (widget.showAlpha)
          Column(
            children: [
              SizedBox(
                height: _kTrackWidth,
                width: double.infinity,
                child: _Slider(
                  thumbColor: _kThumbColor,
                  thumbCenter: _alphaThumbPosition,
                  thumbSize: _kThumbSize,
                  thumbPaintingStyle: PaintingStyle.fill,
                  thumbRadius: _kThumbRadius,
                  thumbStrokeWidth: 1,
                  sliderDirection: _SliderDirection.horizontal,
                  onChange: _onAlphaValueChange,
                  padding: EdgeInsets.only(
                      left: _kThumbSize.width / 2,
                      right: _kTrackWidth +
                          _kSpace +
                          _kColorPickerThumbSize.width / 2),
                  child: CustomPaint(
                    painter: _ChessPainter(),
                    foregroundPainter: _AlphaPainter(
                        color: (_currentHsvColor ?? _kHSVColor).toColor()),
                  ),
                ),
              ),
              const SizedBox(height: _kSpace),
            ],
          ),
        if (widget.predefineColors != null)
          Padding(
            padding:
                EdgeInsets.only(left: _kThumbSize.width / 2, right: _kSpace),
            child: _buildPredefineColors(),
          ),
        Row(
          children: [
            SizedBox(width: _kThumbSize.width / 2),
            Expanded(
              child: widget.showTextField ? _buildTextField() : Container(),
            ),
            const SizedBox(width: 12),
            if (widget.showClearButton)
              EButton(
                child: Text(widget.clearButtonTxt),
                borderStyle: EButtonBorderStyle.none,
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(
                      EleTheme.of(context).primaryColor),
                ),
                onPressed: () {
                  _currentHsvColor = null;
                  _initSliderOffset();
                  _updateValue();
                  widget.onClear?.call(null);
                },
              ),
            if (widget.showConfirmButton)
              EButton(
                child: Text(widget.confirmButtonTxt),
                borderStyle: EButtonBorderStyle.stroke,
                onPressed: () {
                  widget.onConfirm?.call(_currentHsvColor?.toColor());
                },
              ),
            const SizedBox(width: _kSpace),
          ],
        ),
        const SizedBox(height: _kSpace),
      ],
    );
  }

  Widget _buildPredefineColors() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Wrap(
        runSpacing: 6,
        spacing: 6,
        children: [
          ...List.generate(
            widget.predefineColors!.length,
            (index) => GestureDetector(
              onTap: () {
                _predefineColorIndex = index;
                _onClickPredefineColor(widget.predefineColors![index]);
              },
              child: Container(
                width: widget.predefineSize,
                height: widget.predefineSize,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: EleTheme.of(context).primaryColor ??
                            Colors.transparent,
                        blurRadius: index == _predefineColorIndex ? 3 : 0),
                  ],
                  borderRadius: BorderRadius.circular(
                      EleTheme.of(context).borderRadiusBase ?? 0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      EleTheme.of(context).borderRadiusBase ?? 0),
                  child: CustomPaint(
                    painter: _ChessPainter(),
                    foregroundPainter: _ColorPainter(
                      color: widget.predefineColors![index],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _onClickPredefineColor(Color color) {
    _currentHsvColor = HSVColor.fromColor(color);
    _initSliderOffset();
    _updateValue();
  }

  Widget _buildTextField() {
    return ETextField(
      height: 35,
      value: _color2String(_currentHsvColor?.toColor()),
      onSubmitted: _onTextFieldSubmitted,
    );
  }

  _onTextFieldSubmitted(value) {
    var _color = _getColorFromHex(value);
    if (_color != null) {
      _currentHsvColor = HSVColor.fromColor(_color);
      _initSliderOffset();
      setState(() {});
    }
  }

  Color? _getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
    return null;
  }
}

/// 滑动方向
enum _SliderDirection {
  vertical,
  horizontal,
  all,
}

typedef _SliderValueChange = Function(double horizontal, double vertical);

class _Slider extends StatefulWidget {
  final Widget child;
  final Color thumbColor;
  final Offset thumbCenter;
  final Size thumbSize;
  final PaintingStyle thumbPaintingStyle;
  final double thumbStrokeWidth;
  final Radius thumbRadius;
  final _SliderDirection sliderDirection;
  final _SliderValueChange? onChange;
  final EdgeInsets? padding;

  const _Slider({
    Key? key,
    required this.child,
    required this.thumbColor,
    required this.thumbCenter,
    required this.thumbSize,
    required this.thumbPaintingStyle,
    required this.thumbStrokeWidth,
    required this.thumbRadius,
    required this.sliderDirection,
    this.padding,
    this.onChange,
  }) : super(key: key);

  @override
  _SliderState createState() => _SliderState();
}

class _SliderState extends State<_Slider> {
  late Offset _thumbCenter;

  @override
  initState() {
    _thumbCenter = widget.thumbCenter;
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      var dx = widget.thumbCenter.dx * context.size!.width;
      var dy = widget.thumbCenter.dy * context.size!.height;
      switch (widget.sliderDirection) {
        case _SliderDirection.vertical:
          dy = dy.clamp(widget.thumbSize.width / 2,
              context.size!.height - widget.thumbSize.width / 2);
          _thumbCenter = Offset(context.size!.width / 2, dy);
          break;
        case _SliderDirection.horizontal:
          dx = dx.clamp(widget.thumbSize.width / 2,
              context.size!.width - widget.padding!.right);
          _thumbCenter = Offset(dx, context.size!.height / 2);
          break;
        case _SliderDirection.all:
          dx = dx.clamp(widget.thumbSize.width / 2,
              context.size!.width - widget.thumbSize.width / 2);
          dy = dy.clamp(widget.thumbSize.height / 2,
              context.size!.height - widget.thumbSize.height / 2);
          _thumbCenter = Offset(dx, dy);
          break;
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  void didUpdateWidget(covariant _Slider oldWidget) {
    if (oldWidget.thumbCenter != widget.thumbCenter) {
      _thumbCenter = widget.thumbCenter;
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        var dx = widget.thumbCenter.dx * context.size!.width;
        var dy = widget.thumbCenter.dy * context.size!.height;
        switch (widget.sliderDirection) {
          case _SliderDirection.vertical:
            dy = dy.clamp(widget.thumbSize.width / 2,
                context.size!.height - widget.thumbSize.width / 2);
            _thumbCenter = Offset(context.size!.width / 2, dy);
            break;
          case _SliderDirection.horizontal:
            dx = dx.clamp(widget.thumbSize.width / 2,
                context.size!.width - widget.padding!.right);
            _thumbCenter = Offset(dx, context.size!.height / 2);
            break;
          case _SliderDirection.all:
            dx = dx.clamp(widget.thumbSize.width / 2,
                context.size!.width - widget.thumbSize.width / 2);
            dy = dy.clamp(widget.thumbSize.height / 2,
                context.size!.height - widget.thumbSize.height / 2);
            _thumbCenter = Offset(dx, dy);
            break;
        }
        setState(() {});
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  _onPointerDown(PointerDownEvent event) {
    _thumbMove(event.localPosition.dx, event.localPosition.dy);
  }

  _onPointerMove(event) {
    _thumbMove(event.localPosition.dx, event.localPosition.dy);
  }

  _thumbMove(double dx, double dy) {
    switch (widget.sliderDirection) {
      case _SliderDirection.vertical:
        widget.onChange?.call(0, (dy / context.size!.height).clamp(0, 1));
        dy = dy.clamp(widget.thumbSize.width / 2,
            context.size!.height - widget.thumbSize.width / 2);
        _thumbCenter = Offset(_thumbCenter.dx, dy);
        break;
      case _SliderDirection.horizontal:
        widget.onChange?.call((dx / context.size!.width).clamp(0, 1), 0);
        dx = dx.clamp(widget.thumbSize.width / 2,
            context.size!.width - widget.padding!.right);
        _thumbCenter = Offset(dx, _thumbCenter.dy);
        break;
      case _SliderDirection.all:
        widget.onChange?.call((dx / context.size!.width).clamp(0, 1),
            (dy / context.size!.height).clamp(0, 1));
        dx = dx.clamp(widget.thumbSize.width / 2,
            context.size!.width - widget.thumbSize.width / 2);
        dy = dy.clamp(widget.thumbSize.height / 2,
            context.size!.height - widget.thumbSize.height / 2);
        _thumbCenter = Offset(dx, dy);
        break;
    }
    _updateValue();
  }

  _updateValue() {
    if (!mounted) {
      return;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var child = widget.child;
    if (widget.sliderDirection == _SliderDirection.all) {
      child = Padding(
        padding: EdgeInsets.symmetric(
            horizontal: widget.thumbSize.width / 2,
            vertical: widget.thumbSize.height / 2),
        child: child,
      );
    }
    if (widget.padding != null) {
      child = Padding(
        padding: widget.padding!,
        child: child,
      );
    }
    return Listener(
      onPointerDown: _onPointerDown,
      onPointerMove: _onPointerMove,
      behavior: HitTestBehavior.opaque,
      child: CustomPaint(
        child: child,
        foregroundPainter: _ThumbPainter(
          color: widget.thumbColor,
          size: widget.thumbSize,
          center: _thumbCenter,
          strokeWidth: widget.thumbStrokeWidth,
          paintingStyle: widget.thumbPaintingStyle,
          borderRadius: widget.thumbRadius,
        ),
      ),
    );
  }
}

class _HueTrackPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset.zero & size;
    Gradient gradient = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const HSVColor.fromAHSV(1.0, 0.0, 1.0, 1.0).toColor(),
          const HSVColor.fromAHSV(1.0, 60.0, 1.0, 1.0).toColor(),
          const HSVColor.fromAHSV(1.0, 120.0, 1.0, 1.0).toColor(),
          const HSVColor.fromAHSV(1.0, 180.0, 1.0, 1.0).toColor(),
          const HSVColor.fromAHSV(1.0, 240.0, 1.0, 1.0).toColor(),
          const HSVColor.fromAHSV(1.0, 300.0, 1.0, 1.0).toColor(),
          const HSVColor.fromAHSV(1.0, 360.0, 1.0, 1.0).toColor()
        ]);
    canvas.drawRect(rect, Paint()..shader = gradient.createShader(rect));
  }

  @override
  bool shouldRepaint(covariant _HueTrackPainter oldDelegate) {
    return false;
  }
}

class _ThumbPainter extends CustomPainter {
  final Color color;
  final Offset center;
  final Size size;
  final PaintingStyle paintingStyle;
  final double strokeWidth;
  final Radius borderRadius;

  _ThumbPainter({
    required this.color,
    required this.size,
    required this.center,
    required this.paintingStyle,
    required this.strokeWidth,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size canvasSize) {
    var rect =
        Rect.fromCenter(center: center, width: size.width, height: size.height);
    var rrect = RRect.fromRectAndRadius(rect, borderRadius);
    canvas.drawRRect(
      rrect,
      Paint()
        ..style = paintingStyle
        ..strokeWidth = strokeWidth
        ..color = color,
    );
    canvas.drawRRect(
      rrect,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..color = Colors.grey.withOpacity(.5),
    );
  }

  @override
  bool shouldRepaint(covariant _ThumbPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.size != size ||
        oldDelegate.center != center ||
        oldDelegate.paintingStyle != paintingStyle ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.borderRadius != borderRadius;
  }
}

class _AlphaPainter extends CustomPainter {
  final Color color;
  final double minAlpha;
  final double maxAlpha;

  _AlphaPainter({
    required this.color,
    this.minAlpha = 0.0,
    this.maxAlpha = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset.zero & size;
    Gradient gradient = LinearGradient(colors: [
      color.withOpacity(minAlpha),
      color.withOpacity(maxAlpha),
    ]);
    canvas.drawRect(rect, Paint()..shader = gradient.createShader(rect));
  }

  @override
  bool shouldRepaint(covariant _AlphaPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.minAlpha != minAlpha ||
        oldDelegate.maxAlpha != maxAlpha;
  }
}

/// 棋盘
///
/// 用于透明下的背景
class _ChessPainter extends CustomPainter {
  final Color darkColor;
  final Color lightColor;
  final Size itemSize;
  static const _defaultDarkColor = Color(0xffcccccc);
  static const _defaultSize = Size(6, 6);

  _ChessPainter({
    this.darkColor = _defaultDarkColor,
    this.lightColor = Colors.white,
    this.itemSize = _defaultSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var darkPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = darkColor;

    var lightPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = lightColor;

    var xCount = (size.width / itemSize.width).ceil();
    var yCount = (size.height / itemSize.height).ceil();
    List.generate(yCount, (y) {
      List.generate(xCount, (x) {
        var _itemWidth = itemSize.width;
        if (itemSize.width * x + itemSize.width > size.width) {
          // out of range
          _itemWidth = size.width - itemSize.width * x;
        }
        var _itemHeight = itemSize.height;
        if (itemSize.height * y + itemSize.height > size.height) {
          // out of range
          _itemHeight = size.height - itemSize.height * y;
        }
        canvas.drawRect(
          Offset(itemSize.width * x, itemSize.width * y) &
              Size(_itemWidth, _itemHeight),
          (x + y) % 2 != 0 ? lightPaint : darkPaint,
        );
      });
    });
  }

  @override
  bool shouldRepaint(covariant _ChessPainter oldDelegate) {
    return oldDelegate.darkColor != darkColor ||
        oldDelegate.lightColor != lightColor;
  }
}

class _ColorPickerPainter extends CustomPainter {
  final HSVColor color;

  _ColorPickerPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    var rect = Rect.fromLTWH(0, 0, size.width, size.height);
    var gradient = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.white, Colors.black],
    );
    var gradientH = LinearGradient(
      colors: [
        Colors.white,
        HSVColor.fromAHSV(1.0, color.hue, 1.0, 1.0).toColor(),
      ],
    );
    canvas.drawRect(rect, Paint()..shader = gradient.createShader(rect));
    canvas.drawRect(
      rect,
      Paint()
        ..blendMode = BlendMode.multiply
        ..shader = gradientH.createShader(rect),
    );
  }

  @override
  bool shouldRepaint(covariant _ColorPickerPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

class _ColorPainter extends CustomPainter {
  final Color? color;

  _ColorPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = color ?? Colors.white);
  }

  @override
  bool shouldRepaint(covariant _ColorPainter oldDelegate) =>
      oldDelegate.color != color;
}
