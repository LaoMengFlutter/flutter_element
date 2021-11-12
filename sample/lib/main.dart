import 'package:flutter/material.dart';

import 'package:flutter_element/widgets.dart';

import 'ui/page/widget_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: EleTheme(
        data: EleThemeData(
          imageThemeData: EleImageThemeData(
              errorWidget: Container(
                color: Colors.red,
              ),
              placeholderWidget: Container(
                color: Colors.blue,
              )),
        ),
        child: WidgetList(),
      ),
    );
  }
}
