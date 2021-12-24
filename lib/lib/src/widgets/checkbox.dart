import 'package:flutter/material.dart';
import 'border.dart';
import 'theme/border_style.dart';
import 'theme/checkbox_style.dart';
import 'theme/theme.dart';
import 'theme/theme_data.dart';

class ECheckbox extends StatefulWidget {
  final bool? value;
  final bool tristate;
  final String? label;
  final bool border;
  final ECheckboxStyle? style;
  final ValueChanged<bool?>? onChanged;
  final bool enable;
  final OutlinedBorder? shape;

  const ECheckbox({
    Key? key,
    this.value,
    this.label,
    this.onChanged,
    this.tristate = false,
    this.border = false,
    this.style,
    this.enable = true,
    this.shape,
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

  @override
  void didUpdateWidget(covariant ECheckbox oldWidget) {
    if (oldWidget.value != widget.value) {
      _value = widget.value;
    }
    super.didUpdateWidget(oldWidget);
  }

  _onChanged(bool? value) {
    if (!mounted) {
      return;
    }
    setState(() {
      _value = value;
    });
    widget.onChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    EleThemeData eleTheme = EleTheme.of(context);
    var style = eleTheme.checkboxStyle?.merge(widget.style) ?? widget.style;

    Widget child = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: _value,
          tristate: widget.tristate,
          onChanged: widget.enable ? _onChanged : null,
          visualDensity: const VisualDensity(
              horizontal: VisualDensity.minimumDensity,
              vertical: VisualDensity.minimumDensity),
          shape: widget.shape,
          fillColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return EleTheme.of(context).primaryColor;
            }
            return EleTheme.of(context).borderColorBase;
          }),
        ),
        SizedBox(width: style?.space),
        if (widget.label != null)
          Text(
            '${widget.label}',
            style: TextStyle(
              color: (_value ?? false)
                  ? style?.checkedFontColor ?? EleTheme.of(context).primaryColor
                  : style?.fontColor ?? EleTheme.of(context).regularTextColor,
            ),
          ),
      ],
    );
    if (widget.border) {
      return Container(
        color: (_value ?? false)
            ? style?.checkedBackgroundColor
            : style?.backgroundColor,
        child: EBorder(
          mainAxisSize: MainAxisSize.min,
          style: EBorderStyle(
            color: (_value ?? false)
                ? style?.checkedBorderColor ?? EleTheme.of(context).primaryColor
                : style?.borderColor,
            radius: style?.borderRadius,
            padding: style?.padding,
          ),
          child: child,
        ),
      );
    }
    return Container(
      padding: widget.border ? style?.padding : EdgeInsets.zero,
      color: (_value ?? false)
          ? style?.checkedBackgroundColor
          : style?.backgroundColor,
      child: child,
    );
  }
}
