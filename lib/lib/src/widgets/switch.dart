import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'theme/switch_style.dart';
import 'theme/theme.dart';
import 'theme/theme_data.dart';

class ESwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final ESwitchStyle? style;
  final bool enable;

  const ESwitch({
    Key? key,
    this.value = false,
    this.onChanged,
    this.style,
    this.enable = true,
  }) : super(key: key);

  @override
  _ESwitchState createState() => _ESwitchState();
}

class _ESwitchState extends State<ESwitch> {
  late bool _value;

  @override
  initState() {
    _value = widget.value;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ESwitch oldWidget) {
    if (oldWidget.value != widget.value) {
      _value = widget.value;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    EleThemeData eleTheme = EleTheme.of(context);
    var _style = eleTheme.switchStyle?.merge(widget.style) ?? widget.style;

    return CupertinoSwitch(
      value: _value,
      onChanged: widget.enable ? _onChanged : null,
      activeColor: _style?.activeColor ?? eleTheme.primaryColor,
      trackColor: _style?.trackColor ?? eleTheme.borderColorBase,
      thumbColor: _style?.thumbColor ?? eleTheme.backgroundColorWhite,
    );
  }

  void _onChanged(bool value) {
    if (!mounted) {
      return;
    }
    setState(() {
      _value = !_value;
    });
    widget.onChanged?.call(value);
  }
}
