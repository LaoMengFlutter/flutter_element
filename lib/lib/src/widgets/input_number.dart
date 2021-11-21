import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_element/widgets.dart';

class InputNumber extends StatefulWidget {
  final double? value;
  final ETextFieldStyle? style;
  final TextEditingController? controller;
  final int height;
  final double min;
  final double max;
  final double step;

  /// 精度
  final int precision;

  const InputNumber({
    Key? key,
    this.value,
    this.style,
    this.controller,
    required this.height,
    this.min = -double.infinity,
    this.max = double.infinity,
    this.step = 1,
    this.precision = 0,
  }) : super(key: key);

  @override
  _InputNumberState createState() => _InputNumberState();
}

class _InputNumberState extends State<InputNumber> {
  late TextEditingController _controller;
  double? _value;
  bool _isMax = false;
  bool _isMin = false;

  @override
  initState() {
    _value = widget.value;
    _controller = widget.controller ?? TextEditingController()
      ..value = TextEditingValue(text: '${_value ?? ''}');
    _checkMax();
    _checkMin();
    super.initState();
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
      var text = _value?.toStringAsFixed(widget.precision) ?? '';
      var textPainter = TextPainter(
        text: TextSpan(
          text: text,
        ),
        textDirection: TextDirection.ltr,
        textWidthBasis: TextWidthBasis.longestLine,
      )..layout();
      print('text height:${textPainter.height}');
      setState(() {
        _controller.value = TextEditingValue(
          text: text,
          selection: TextSelection.fromPosition(
            TextPosition(
              affinity: TextAffinity.downstream,
              offset: text.length,
            ),
          ),
        );
      });
    }
  }

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
  }

  @override
  Widget build(BuildContext context) {
    EleThemeData eleTheme = EleTheme.of(context);
    var _style = eleTheme.textFieldStyle?.merge(widget.style) ?? widget.style;
    return Stack(
      children: [
        Positioned.fill(
          child: _buildTextField(_style),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          top: 0,
          child: _buildAdd(),
        ),
        Positioned(
          left: 0,
          bottom: 0,
          top: 0,
          child: _buildReduce(),
        ),
      ],
    );
  }

  Widget _buildTextField(ETextFieldStyle? style) {
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
        contentPadding: widget.height > 17
            ? EdgeInsets.symmetric(vertical: (widget.height-8.5) / 2)
            : EdgeInsets.zero,
      ),
      maxLines: 1,
      // maxLines: 1000,
    );
  }

  Widget _buildAdd() {
    return GestureDetector(
      onTap: _onClickAdd,
      child: Padding(
        padding: const EdgeInsets.only(top: 1, bottom: 1, right: 1),
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            // alignment: Alignment.center,
            color: Colors.red,
            child: Icon(
              Icons.add,
              size: widget.height / 2,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReduce() {
    return GestureDetector(
      onTap: _onClickReduce,
      child: Padding(
        padding: const EdgeInsets.only(top: 1, bottom: 1, right: 1),
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            // alignment: Alignment.center,
            color: Colors.red,
            child: Icon(
              Icons.remove,
              size: widget.height / 2,
            ),
          ),
        ),
      ),
    );
  }
}
