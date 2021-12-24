import 'package:flutter/material.dart';
import 'theme/slider_style.dart';
import 'theme/theme.dart';
import 'theme/theme_data.dart';

class ESlider extends StatefulWidget {
  final double value;
  final RangeValues? rangeValues;
  final ValueChanged<double>? onChanged;
  final double min;
  final double max;
  final ESliderStyle? style;
  final bool enable;
  final String? label;
  final int? divisions;
  final bool range;
  final RangeLabels? rangeLabels;
  final ValueChanged<RangeValues>? onRangeChanged;

  const ESlider({
    Key? key,
    this.value = 0,
    this.rangeValues,
    this.onChanged,
    this.min = 0,
    this.max = 1,
    this.style,
    this.enable = true,
    this.label,
    this.divisions,
    this.range = false,
    this.rangeLabels,
    this.onRangeChanged,
  }) : super(key: key);

  @override
  State<ESlider> createState() => _ESliderState();
}

class _ESliderState extends State<ESlider> {
  late double _value;
  late RangeValues _rangeValues;

  @override
  initState() {
    _value = widget.value;
    _rangeValues = widget.rangeValues ?? RangeValues(widget.min, widget.max);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ESlider oldWidget) {
    if (oldWidget.value != widget.value) {
      _value = widget.value;
    }
    if (oldWidget.rangeValues != widget.rangeValues) {
      _rangeValues = widget.rangeValues ?? RangeValues(widget.min, widget.max);
    }
    super.didUpdateWidget(oldWidget);
  }

  _onChanged(double value) {
    if (!mounted) {
      return;
    }
    setState(() {
      _value = value;
    });
    widget.onChanged?.call(_value);
  }

  _onRangeChanged(RangeValues values) {
    if (!mounted) {
      return;
    }
    setState(() {
      _rangeValues = values;
    });
    widget.onRangeChanged?.call(_rangeValues);
  }

  @override
  Widget build(BuildContext context) {
    EleThemeData eleTheme = EleTheme.of(context);
    var _style = eleTheme.sliderStyle?.merge(widget.style) ?? widget.style;
    if (widget.range) {
      return SliderTheme(
        data: SliderTheme.of(context).copyWith(
          activeTrackColor:
              _style?.activeColor ?? EleTheme.of(context).primaryColor,
          thumbColor:
              _style?.thumbColor ?? EleTheme.of(context).backgroundColorWhite,
        ),
        child: RangeSlider(
          values: _rangeValues,
          onChanged: widget.enable ? _onRangeChanged : null,
          inactiveColor:
              _style?.inactiveColor ?? EleTheme.of(context).borderColorLight,
          labels: widget.rangeLabels ??
              RangeLabels('${_rangeValues.start}', '${_rangeValues.end}'),
          divisions: widget.divisions,
          min: widget.min,
          max: widget.max,
        ),
      );
    }

    return Slider(
      value: _value,
      onChanged: widget.enable ? _onChanged : null,
      activeColor: _style?.activeColor ?? EleTheme.of(context).primaryColor,
      inactiveColor:
          _style?.inactiveColor ?? EleTheme.of(context).borderColorLight,
      thumbColor:
          _style?.thumbColor ?? EleTheme.of(context).backgroundColorWhite,
      label: widget.label ?? '$_value',
      divisions: widget.divisions,
      min: widget.min,
      max: widget.max,
    );
  }
}
