import 'package:flutter/material.dart';
import 'package:flutter_element/src/widgets/theme/checkbox_style.dart';
import 'package:flutter_element/widgets.dart';

class ECheckbox extends StatefulWidget {
  final bool? value;
  final bool tristate;
  final String? label;
  final ECheckboxStyle? style;
  final ValueChanged<bool?>? onChanged;

  const ECheckbox({
    Key? key,
    this.value,
    this.tristate = false,
    this.label,
    this.onChanged,
    this.style,
  }) : super(key: key);

  @override
  _ECheckboxState createState() => _ECheckboxState();
}

class _ECheckboxState extends State<ECheckbox> {
  bool? _value;

  @override
  initState() {
    _value = widget.value;
    super.initState();
  }

  _onChanged(bool? value) {
    setState(() {
      _value = value;
    });
    widget.onChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    EleThemeData eleTheme = EleTheme.of(context);
    var style = eleTheme.checkboxStyle?.merge(widget.style) ?? widget.style;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: _value,
          tristate: widget.tristate,
          onChanged: _onChanged,
        ),
        SizedBox(width: style?.space),
        if (widget.label != null)
          Text(
            '${widget.label}',
            style: TextStyle(
              color: (_value ?? false)
                  ? style?.checkedFontColor
                  : style?.fontColor,
            ),
          ),
      ],
    );
  }
}
