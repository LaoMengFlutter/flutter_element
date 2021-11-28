import 'dart:math';

import 'package:flutter/material.dart';
import 'package:element_ui/widgets.dart';

///
/// 开关默认width
///
const double _kDefaultWidth = 60;

///
/// 开关默认height
///
const double _kDefaultHeight = 35;

///
/// 开启状态下默认文字
///
const String _kDefaultActiveText = 'ON';

///
/// 关闭状态下默认文字
///
const String _kDefaultInactiveText = 'OFF';

///
/// 默认过度动画时长
///
const Duration _kDefaultDuration = Duration(milliseconds: 300);

///
/// desc: 滚动效果滑块
///
class EWheelSwitch extends StatefulWidget {
  const EWheelSwitch({
    Key? key,
    this.value = false,
    this.onChanged,
    this.width = _kDefaultWidth,
    this.height = _kDefaultHeight,
    this.activeText = _kDefaultActiveText,
    this.inactiveText = _kDefaultInactiveText,
    this.duration = _kDefaultDuration,
    this.style,
  }) : super(key: key);

  /// 开关是开还是关，不能设置为null
  final bool value;

  /// 开关发生变化时回调
  final ValueChanged<bool>? onChanged;

  /// 开关 width
  final double width;

  /// 开关 height
  final double height;

  /// 开启状态下滑块的文字
  final String activeText;

  /// 关闭状态下滑块的文字
  final String inactiveText;

  /// 过度动画时长
  final Duration duration;
  final EWheelSwitchStyle? style;

  @override
  _WheelSwitchState createState() => _WheelSwitchState();
}

class _WheelSwitchState extends State<EWheelSwitch>
    with SingleTickerProviderStateMixin {
  final double _paddingHorizontal = 1.5;

  late AnimationController _controller;
  late bool _value;
  late Animation<Color?> _colorTrackAnimation;
  late Animation<Color?> _colorThumbAnimation;
  late Animation<TextStyle> _textStyleAnimation;
  late Animation<Alignment> _alignmentAnimation;

  @override
  void initState() {
    _value = widget.value;
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _alignmentAnimation = AlignmentTween(
      begin: !widget.value ? Alignment.centerLeft : Alignment.centerRight,
      end: widget.value ? Alignment.centerLeft : Alignment.centerRight,
    ).animate(_controller);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant EWheelSwitch oldWidget) {
    if (oldWidget.value != widget.value) {
      _value = widget.value;
    }
    if (oldWidget.duration != widget.duration) {
      _controller = AnimationController(vsync: this, duration: widget.duration);
    }
    _alignmentAnimation = AlignmentTween(
      begin: !widget.value ? Alignment.centerLeft : Alignment.centerRight,
      end: widget.value ? Alignment.centerLeft : Alignment.centerRight,
    ).animate(_controller);
    _init();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    _init();
    super.didChangeDependencies();
  }

  void _init() {
    EleThemeData eleTheme = EleTheme.of(context);
    var _style = eleTheme.wheelSwitchStyle?.merge(widget.style) ?? widget.style;

    _colorTrackAnimation = ColorTween(
      begin: widget.value ? _style?.activeColor : _style?.trackColor,
      end: !widget.value ? _style?.activeColor : _style?.trackColor,
    ).animate(_controller);

    _colorThumbAnimation = ColorTween(
      begin: widget.value ? _style?.thumbColor : _style?.inactiveThumbColor,
      end: !widget.value ? _style?.thumbColor : _style?.inactiveThumbColor,
    ).animate(_controller);

    _textStyleAnimation = TextStyleTween(
      begin: widget.value ? _style?.activeTextStyle : _style?.inactiveTextStyle,
      end: !widget.value ? _style?.activeTextStyle : _style?.inactiveTextStyle,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _thumbSize = _computeThumbSize();
    return GestureDetector(
      onTap: _onClick,
      child: AnimatedBuilder(
        animation: _colorTrackAnimation,
        builder: (BuildContext context, Widget? child) {
          String _text;
          if (_controller.isAnimating) {
            _text = _controller.value > 0.5
                ? widget.activeText
                : widget.inactiveText;
          } else {
            _text = _value ? widget.activeText : widget.inactiveText;
          }
          return Container(
            height: widget.height,
            width: widget.width,
            alignment: _alignmentAnimation.value,
            padding: EdgeInsets.symmetric(horizontal: _paddingHorizontal),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(widget.height),
              color: _colorTrackAnimation.value ?? Colors.transparent,
            ),
            child: Transform(
              transform: Matrix4.rotationZ(widget.value
                  ? -1 * _controller.value * pi * 2
                  : _controller.value * pi * 2),
              origin: Offset(_thumbSize / 2, _thumbSize / 2),
              child: Container(
                height: _thumbSize,
                width: _thumbSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _colorThumbAnimation.value,
                ),
                alignment: Alignment.center,
                child: Text(
                  _text,
                  style: _textStyleAnimation.value,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _onClick() {
    if (_controller.isAnimating) {
      return;
    }
    if (_controller.isDismissed) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    _value = !_value;
    widget.onChanged?.call(_value);
  }

  double _computeThumbSize() {
    return min(widget.height, widget.width) - _paddingHorizontal * 2;
  }
}
