

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'theme_data.dart';


class EleTheme extends StatelessWidget {
  const EleTheme({
    Key? key,
    required this.data,
    required this.child,
  }) : super(key: key);

  /// theme data
  final EleThemeData data;

  /// child
  final Widget child;

  static final EleThemeData _kDefaultTheme = EleThemeData.light();

  static EleThemeData of(BuildContext context) {
    final _InheritedTheme? inheritedTheme =
        context.dependOnInheritedWidgetOfExactType<_InheritedTheme>();
    return inheritedTheme?.theme.data ?? _kDefaultTheme;
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedTheme(
      theme: this,
      child: child,
    );
  }
}

class _InheritedTheme extends InheritedTheme {
  const _InheritedTheme({
    Key? key,
    required this.theme,
    required Widget child,
  })  : assert(theme != null),
        super(key: key, child: child);

  final EleTheme theme;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return EleTheme(data: theme.data, child: child);
  }

  @override
  bool updateShouldNotify(_InheritedTheme old) => theme.data != old.theme.data;
}
