import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'border.dart';
import 'theme/border_style.dart';
import 'theme/radio_style.dart';
import 'theme/theme.dart';
import 'theme/theme_data.dart';

const double _kSpace = 3.0;

class ERadioItem<T> {
  final T value;
  final String? label;
  final ValueChanged<T?>? onChanged;
  final ERadioStyle? style;
  final bool enable;

  ERadioItem({
    required this.value,
    this.label,
    this.onChanged,
    this.style,
    this.enable = true,
  });
}

class ERadioGroup<T> extends StatefulWidget {
  final T? selectValue;
  final List<ERadioItem<T>> radios;
  final ValueChanged<T?>? onChanged;
  final ERadioStyle? style;
  final bool border;
  final double spacing;
  final double runSpacing;
  final Axis direction;
  final WrapAlignment alignment;
  final WrapAlignment runAlignment;
  final WrapCrossAlignment crossAxisAlignment;
  final VerticalDirection verticalDirection;

  const ERadioGroup({
    Key? key,
    required this.radios,
    this.selectValue,
    this.onChanged,
    this.style,
    this.border = false,
    this.spacing = 12.0,
    this.runSpacing = 6.0,
    this.direction = Axis.horizontal,
    this.alignment = WrapAlignment.start,
    this.runAlignment = WrapAlignment.start,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    this.verticalDirection = VerticalDirection.down,
  }) : super(key: key);

  @override
  _ERadioGroupState createState() => _ERadioGroupState<T>();
}

class _ERadioGroupState<T> extends State<ERadioGroup<T>> {
  T? _selectValue;

  @override
  initState() {
    _selectValue = widget.selectValue;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ERadioGroup<T> oldWidget) {
    if (oldWidget.selectValue != widget.selectValue) {
      _selectValue = widget.selectValue;
    }
    super.didUpdateWidget(oldWidget);
  }

  void _onChanged(T? value) {
    if (!mounted) {
      return;
    }
    setState(() {
      _selectValue = value;
    });
    widget.onChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    EleThemeData eleTheme = EleTheme.of(context);
    var style = eleTheme.radioStyle?.merge(widget.style) ?? widget.style;

    return Wrap(
      spacing: widget.spacing,
      runSpacing: widget.runSpacing,
      direction: widget.direction,
      alignment: widget.alignment,
      runAlignment: widget.runAlignment,
      crossAxisAlignment: widget.crossAxisAlignment,
      children: [
        ...widget.radios.map((e) {
          return _ERadio<T>(
            value: e.value,
            checked: _selectValue == e.value,
            label: e.label,
            onChanged: _onChanged,
            style: style?.merge(e.style) ?? e.style,
            border: widget.border,
            enable: e.enable,
          );
        }).toList()
      ],
    );
  }
}

class ERadioButtonGroup<T extends Object> extends StatefulWidget {
  final T? selectValue;
  final List<ERadioItem<T>> radios;
  final ValueChanged<T?>? onChanged;
  final ERadioStyle? style;

  const ERadioButtonGroup({
    Key? key,
    required this.radios,
    this.selectValue,
    this.onChanged,
    this.style,
  }) : super(key: key);

  @override
  State<ERadioButtonGroup<T>> createState() => _ERadioButtonGroupState<T>();
}

class _ERadioButtonGroupState<T extends Object>
    extends State<ERadioButtonGroup<T>> {
  T? _selectValue;

  @override
  initState() {
    _selectValue = widget.selectValue;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ERadioButtonGroup<T> oldWidget) {
    if (oldWidget.selectValue != widget.selectValue) {
      _selectValue = widget.selectValue;
    }
    super.didUpdateWidget(oldWidget);
  }

  void _onChanged(T? value) {
    if (!mounted) {
      return;
    }
    setState(() {
      _selectValue = value;
    });
    widget.onChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    EleThemeData eleTheme = EleTheme.of(context);
    ERadioStyle? _style =
        eleTheme.radioStyle?.merge(widget.style) ?? widget.style;

    Map<T, Widget> _children = {};
    for (var element in widget.radios) {
      _children.putIfAbsent(
          element.value,
          () => Padding(
                padding: _style?.padding ?? EdgeInsets.zero,
                child: Text(
                  '${element.label}',
                  style: TextStyle(
                      color: element.value == _selectValue
                          ? _style?.checkedFontColor ??
                              EleTheme.of(context).backgroundColorWhite
                          : _style?.fontColor ??
                              EleTheme.of(context).regularTextColor),
                ),
              ));
    }

    return CupertinoSegmentedControl<T>(
      groupValue: _selectValue,
      children: _children,
      selectedColor:
          _style?.checkedBackgroundColor ?? EleTheme.of(context).primaryColor,
      unselectedColor:
          _style?.backgroundColor ?? EleTheme.of(context).backgroundColorWhite,
      borderColor: _style?.borderColor ?? EleTheme.of(context).borderColorBase,
      onValueChanged: _onChanged,
      padding: EdgeInsets.zero,
    );
  }
}

class _ERadio<T> extends StatelessWidget {
  final T value;
  final String? label;
  final ValueChanged<T?>? onChanged;
  final bool checked;
  final bool border;
  final ERadioStyle? style;
  final bool enable;

  const _ERadio({
    Key? key,
    required this.value,
    required this.checked,
    this.onChanged,
    this.label,
    this.border = false,
    this.style,
    this.enable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var child = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio(
          value: value,
          onChanged: enable ? onChanged : null,
          groupValue: checked ? value : null,
          visualDensity: const VisualDensity(
              horizontal: VisualDensity.minimumDensity,
              vertical: VisualDensity.minimumDensity),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          fillColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return EleTheme.of(context).primaryColor;
            }
            return EleTheme.of(context).borderColorBase;
          }),
        ),
        SizedBox(width: style?.space ?? _kSpace),
        if (label != null)
          Text(
            '$label',
            style: TextStyle(
              color: checked
                  ? style?.checkedFontColor ?? EleTheme.of(context).primaryColor
                  : style?.fontColor ?? EleTheme.of(context).regularTextColor,
            ),
          ),
      ],
    );
    if (border) {
      return Container(
        color: checked ? style?.checkedBackgroundColor : style?.backgroundColor,
        child: EBorder(
          mainAxisSize: MainAxisSize.min,
          style: EBorderStyle(
            color: checked
                ? style?.checkedBorderColor ?? EleTheme.of(context).primaryColor
                : style?.borderColor,
            radius: style?.borderRadius ??
                BorderRadius.circular(
                    EleTheme.of(context).borderRadiusBase ?? 4.0),
            padding: style?.padding,
          ),
          child: child,
        ),
      );
    }
    return child;
  }
}
