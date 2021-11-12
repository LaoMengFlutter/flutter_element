import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_element/widgets.dart';

class ERadioItem<T> {
  final T value;
  final String? label;
  final ValueChanged<T?>? onChanged;
  final ERadioStyle? style;

  ERadioItem({
    required this.value,
    this.label,
    this.onChanged,
    this.style,
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

  void _onChanged(T? value) {
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

  void _onChanged(T? value) {
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
                child: Text('${element.label}'),
              ));
    }

    return CupertinoSegmentedControl<T>(
      groupValue: _selectValue,
      children: _children,
      selectedColor: _style?.checkedFontColor,
      unselectedColor: _style?.backgroundColor,
      borderColor: _style?.borderColor,
      onValueChanged: _onChanged,
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

  const _ERadio({
    Key? key,
    required this.value,
    required this.checked,
    this.onChanged,
    this.label,
    this.border = false,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color:
              checked ? style?.checkedBackgroundColor : style?.backgroundColor,
          border: border
              ? Border.all(
                  color: (checked
                          ? style?.checkedBorderColor
                          : style?.borderColor) ??
                      Colors.transparent,
                )
              : null,
          borderRadius: style?.borderRadius),
      padding: style?.padding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio(
            value: value,
            onChanged: onChanged,
            groupValue: checked ? value : null,
            visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          SizedBox(width: style?.space),
          if (label != null)
            Text(
              '$label',
              style: TextStyle(
                color: checked ? style?.checkedFontColor : style?.fontColor,
              ),
            ),
        ],
      ),
    );
  }
}
