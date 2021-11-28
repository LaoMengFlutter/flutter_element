import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_element/widgets.dart';

class EInputNumber extends StatefulWidget {
  final double? value;
  final EInputNumberStyle? style;
  final TextEditingController? controller;
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
    this.controller,
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
  late TextEditingController _controller;
  double? _value;
  bool _isMax = false;
  bool _isMin = false;
  double _textHeight = 0;

  @override
  initState() {
    _value = widget.value;
    _controller = widget.controller ?? TextEditingController()
      ..value = TextEditingValue(text: _valueFormat);
    _getTextHeight();
    _checkMax();
    _checkMin();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant EInputNumber oldWidget) {
    if (oldWidget.value != widget.value) {
      _value = widget.value;
    }
    _controller = widget.controller ?? TextEditingController()
      ..value = TextEditingValue(text: _valueFormat);
    _checkMax();
    _checkMin();
    super.didUpdateWidget(oldWidget);
  }

  void _getTextHeight() {
    var textPainter = TextPainter(
      text: const TextSpan(
        text: '',
      ),
      textDirection: TextDirection.ltr,
      textWidthBasis: TextWidthBasis.longestLine,
    )..layout();
    _textHeight = textPainter.height;
  }

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
      setState(() {
        _controller.value = TextEditingValue(
          text: _valueFormat,
          selection: TextSelection.fromPosition(
            TextPosition(
              affinity: TextAffinity.downstream,
              offset: _valueFormat.length,
            ),
          ),
        );
      });
    }
  }

  String get _valueFormat => _value?.toStringAsFixed(widget.precision) ?? '';

  void _onChange(String value) {
    if (value.isEmpty) {
      return;
    }
    try {
      _value = double.parse(value);
      _valueChange();
    } catch (_) {}
  }

  void _valueChange() {
    _value = min(_value!, widget.max);
    _value = max(_value!, widget.min);
    _checkMax();
    _checkMin();
    _updateValue();
    widget.onChanged?.call(_value);
  }

  @override
  Widget build(BuildContext context) {
    EleThemeData eleTheme = EleTheme.of(context);
    var _style = eleTheme.inputNumberStyle?.merge(widget.style) ?? widget.style;

    if (widget.type == InputNumberControlType.side) {
      return SizedBox(
        height: widget.height,
        child: Stack(
          children: [
            Positioned.fill(
              child: _buildTextField(_style),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              top: 0,
              child: _buildAdd(Icons.add, _style),
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
              child: _buildTextField(_style),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              top: 0,
              child: Column(
                children: [
                  Expanded(child: _buildAdd(Icons.expand_less, _style)),
                  Expanded(child: _buildReduce(Icons.expand_more, _style)),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildTextField(EInputNumberStyle? style) {
    return TextField(
      controller: _controller,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      textAlign: TextAlign.center,
      onChanged: _onChange,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      style: TextStyle(color: style?.fontColor),
      decoration: InputDecoration(
        fillColor: style?.backgroundColor,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: style?.borderColor ?? Colors.transparent),
          borderRadius: style?.borderRadius ?? BorderRadius.zero,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: style?.focusBorderColor ?? Colors.transparent),
          borderRadius: style?.borderRadius ?? BorderRadius.zero,
        ),
        contentPadding: EdgeInsets.only(
          top: widget.height > _textHeight
              ? (widget.height - _textHeight / 2) / 2
              : 0,
          bottom: widget.height > _textHeight
              ? (widget.height - _textHeight / 2) / 2
              : 0,
          left: 0,
          right: widget.type == InputNumberControlType.side ? 0 : widget.height,
        ),
      ),
      maxLines: 1,
      // maxLines: 1000,
    );
  }

  Widget _buildAdd(IconData iconData, EInputNumberStyle? style) {
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
              topRight: style?.borderRadius?.topRight ?? Radius.zero,
              bottomLeft: Radius.zero,
              bottomRight: (widget.type == InputNumberControlType.side)
                  ? style?.borderRadius?.bottomRight ?? Radius.zero
                  : Radius.zero,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: style?.iconBackgroundColor,
                border: Border(
                  left: BorderSide(
                      color: style?.borderColor ?? Colors.transparent),
                  bottom: widget.type == InputNumberControlType.side
                      ? BorderSide.none
                      : BorderSide(
                          color: style?.borderColor ?? Colors.transparent),
                ),
              ),
              child: Icon(
                iconData,
                size: widget.height / 2,
                color: style?.iconColor,
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
                  ? style?.borderRadius?.topLeft ?? Radius.zero
                  : Radius.zero,
              topRight: Radius.zero,
              bottomLeft: (widget.type == InputNumberControlType.side)
                  ? style?.borderRadius?.bottomLeft ?? Radius.zero
                  : Radius.zero,
              bottomRight: (widget.type == InputNumberControlType.side)
                  ? Radius.zero
                  : style?.borderRadius?.bottomRight ?? Radius.zero,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: style?.iconBackgroundColor,
                border: Border(
                  right: widget.type == InputNumberControlType.side
                      ? BorderSide(
                          color: style?.borderColor ?? Colors.transparent)
                      : BorderSide.none,
                  left: widget.type == InputNumberControlType.side
                      ? BorderSide.none
                      : BorderSide(
                          color: style?.borderColor ?? Colors.transparent),
                ),
              ),
              child: Icon(
                iconData,
                size: widget.height / 2,
                color: style?.iconColor,
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
