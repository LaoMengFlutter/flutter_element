import 'dart:math';

import 'package:element_ui/src/widgets/theme/text_field_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'text_field.dart';
import 'theme/input_number_style.dart';
import 'theme/theme.dart';
import 'theme/theme_data.dart';

class EInputNumber extends StatefulWidget {
  final double? value;
  final EInputNumberStyle? style;
  final double height;
  final double min;
  final double max;
  final double step;
  final InputNumberControlType type;
  final ValueChanged<double?>? onChanged;

  /// 精度
  final int precision;

  const EInputNumber({
    Key? key,
    this.value,
    this.style,
    required this.height,
    this.min = -double.infinity,
    this.max = double.infinity,
    this.step = 1,
    this.precision = 0,
    this.type = InputNumberControlType.side,
    this.onChanged,
  }) : super(key: key);

  @override
  _InputNumberState createState() => _InputNumberState();
}

class _InputNumberState extends State<EInputNumber> {
  double? _value;
  bool _isMax = false;
  bool _isMin = false;
  final FocusNode _focusNode = FocusNode();
  String _textFieldValue = '';

  @override
  initState() {
    _value = widget.value;
    _checkMax();
    _checkMin();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        //有焦点
      } else {
        //失去焦点
        _onSubmitted();
      }
    });
    super.initState();
  }

  @override
  void didUpdateWidget(covariant EInputNumber oldWidget) {
    if (oldWidget.value != widget.value) {
      _value = widget.value;
    }
    _checkMax();
    _checkMin();
    super.didUpdateWidget(oldWidget);
  }

  // void _getTextHeight(TextStyle textStyle) {
  //   var textPainter = TextPainter(
  //     text: TextSpan(
  //       text: '',
  //       style: textStyle,
  //     ),
  //     textDirection: TextDirection.ltr,
  //     textWidthBasis: TextWidthBasis.longestLine,
  //   )..layout();
  //   _textHeight = textPainter.height;
  // }

  void _onClickAdd() {
    if (_isMax) {
      return;
    }
    _value = _value ?? 0;
    _value = _value! + widget.step;
    _valueChange();
  }

  void _onClickReduce() {
    if (_isMin) {
      return;
    }
    _value = _value ?? 0;
    _value = _value! - widget.step;
    _valueChange();
  }

  /// 是否达到最大值
  void _checkMax() {
    if (_value == null) {
      _isMax = false;
    } else {
      _isMax = _value! >= widget.max;
    }
  }

  /// 是否达到最小值
  void _checkMin() {
    if (_value == null) {
      _isMin = true;
    } else {
      _isMin = _value! <= widget.min;
    }
  }

  void _updateValue() {
    if (mounted) {
      setState(() {});
    }
  }

  String get _valueFormat => _value?.toStringAsFixed(widget.precision) ?? '';

  void _onChange(String value) {
    _textFieldValue = value;
  }

  void _onSubmitted() {
    try {
      if (_textFieldValue.isEmpty) {
        _value = null;
      } else {
        _value = double.parse(_textFieldValue);
      }
      _valueChange();
    } catch (_) {}
  }

  void _valueChange() {
    if (_value != null) {
      _value = min(_value!, widget.max);
      _value = max(_value!, widget.min);
    }
    _checkMax();
    _checkMin();
    _updateValue();
    widget.onChanged?.call(_value);
  }

  @override
  Widget build(BuildContext context) {
    EleThemeData eleTheme = EleTheme.of(context);
    var _style = eleTheme.inputNumberStyle?.merge(widget.style) ?? widget.style;
    var borderRadius = _style?.borderRadius ??
        BorderRadius.circular(EleTheme.of(context).borderRadiusBase ?? 0.0);
    if (widget.type == InputNumberControlType.side) {
      return SizedBox(
        height: widget.height,
        child: Stack(
          children: [
            Positioned.fill(
              child: _buildTextField(context, _style, borderRadius),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              top: 0,
              child: _buildAdd(Icons.add, _style, borderRadius),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              top: 0,
              child: _buildReduce(Icons.remove, _style),
            ),
          ],
        ),
      );
    } else {
      return SizedBox(
        height: widget.height,
        child: Stack(
          children: [
            Positioned.fill(
              child: _buildTextField(context, _style, borderRadius),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              top: 0,
              child: Column(
                children: [
                  Expanded(
                      child:
                          _buildAdd(Icons.expand_less, _style, borderRadius)),
                  Expanded(child: _buildReduce(Icons.expand_more, _style)),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildTextField(BuildContext context, EInputNumberStyle? style,
      BorderRadius borderRadius) {
    // _getTextHeight(const TextStyle());
    return ETextField(
      value: _valueFormat,
      focusNode: _focusNode,
      height: widget.height,
      style: ETextFieldStyle(
        borderRadius: borderRadius,
        backgroundColor: style?.backgroundColor ??
            EleTheme.of(context).backgroundColorWhite ??
            Colors.transparent,
        borderColor: style?.borderColor ?? EleTheme.of(context).borderColorBase,
        focusBorderColor:
            style?.focusBorderColor ?? EleTheme.of(context).primaryColor,
      ),
      keyboardType: widget.precision == 0
          ? TextInputType.number
          : const TextInputType.numberWithOptions(decimal: true),
      textInputAction: TextInputAction.done,
      textAlign: TextAlign.center,
      onChanged: _onChange,
      onSubmitted: (value) {
        _onSubmitted();
      },
      inputFormatters: <TextInputFormatter>[
        if (widget.precision == 0) FilteringTextInputFormatter.digitsOnly
      ],
      textStyle: TextStyle(color: style?.fontColor),
      maxLines: 1,
    );
  }

  Widget _buildAdd(
      IconData iconData, EInputNumberStyle? style, BorderRadius borderRadius) {
    double paddingBottom = (widget.type == InputNumberControlType.side) ? 1 : 0;
    return GestureDetector(
      onTap: _onClickAdd,
      child: Padding(
        padding: EdgeInsets.only(top: 1, bottom: paddingBottom, right: 1),
        child: AspectRatio(
          aspectRatio: widget.type == InputNumberControlType.side ? 1 : 2 / 1,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.zero,
              topRight: borderRadius.topRight,
              bottomLeft: Radius.zero,
              bottomRight: (widget.type == InputNumberControlType.side)
                  ? borderRadius.bottomRight
                  : Radius.zero,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: style?.iconBackgroundColor ??
                    EleTheme.of(context).backgroundColorBase,
                border: Border(
                  left: BorderSide(
                      color: style?.borderColor ??
                          EleTheme.of(context).borderColorBase ??
                          Colors.transparent),
                  bottom: widget.type == InputNumberControlType.side
                      ? BorderSide.none
                      : BorderSide(
                          color: style?.borderColor ??
                              EleTheme.of(context).borderColorBase ??
                              Colors.transparent),
                ),
              ),
              child: Icon(
                iconData,
                size: widget.height / 2,
                color:
                    style?.iconColor ?? EleTheme.of(context).regularTextColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReduce(IconData iconData, EInputNumberStyle? style) {
    return GestureDetector(
      onTap: _onClickReduce,
      child: Padding(
        padding: EdgeInsets.only(
          top: (widget.type == InputNumberControlType.side) ? 1 : 0,
          bottom: 1,
          left: (widget.type == InputNumberControlType.side) ? 1 : 0,
          right: (widget.type == InputNumberControlType.side) ? 0 : 1,
        ),
        child: AspectRatio(
          aspectRatio: widget.type == InputNumberControlType.side ? 1 : 2 / 1,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: (widget.type == InputNumberControlType.side)
                  ? style?.borderRadius?.topLeft ??
                      Radius.circular(
                          EleTheme.of(context).borderRadiusBase ?? 0.0)
                  : Radius.zero,
              topRight: Radius.zero,
              bottomLeft: (widget.type == InputNumberControlType.side)
                  ? style?.borderRadius?.bottomLeft ??
                      Radius.circular(
                          EleTheme.of(context).borderRadiusBase ?? 0.0)
                  : Radius.zero,
              bottomRight: (widget.type == InputNumberControlType.side)
                  ? Radius.zero
                  : style?.borderRadius?.bottomRight ??
                      Radius.circular(
                          EleTheme.of(context).borderRadiusBase ?? 0.0),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: style?.iconBackgroundColor ??
                    EleTheme.of(context).backgroundColorBase,
                border: Border(
                  right: widget.type == InputNumberControlType.side
                      ? BorderSide(
                          color: style?.borderColor ??
                              EleTheme.of(context).borderColorBase ??
                              Colors.transparent)
                      : BorderSide.none,
                  left: widget.type == InputNumberControlType.side
                      ? BorderSide.none
                      : BorderSide(
                          color: style?.borderColor ??
                              EleTheme.of(context).borderColorBase ??
                              Colors.transparent),
                ),
              ),
              child: Icon(
                iconData,
                size: widget.height / 2,
                color:
                    style?.iconColor ?? EleTheme.of(context).regularTextColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum InputNumberControlType {
  /// 两边
  side,

  /// 右边
  right,
}
