import 'package:flutter/material.dart';

import 'package:element_ui/widgets.dart';
import 'package:sample/ui/navigator_list.dart';

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
          primaryColor: Colors.blue,
          imageStyle: EImageStyle(
            errorWidget: Container(
              color: Colors.grey.withOpacity(.3),
              alignment: Alignment.center,
              child: Text(
                '加载失败',
                style: TextStyle(color: Colors.white),
              ),
            ),
            placeholderWidget: Container(
              color: Colors.grey.withOpacity(.3),
            ),
          ),
        ),
        child: NavigatorList(),
      ),
    );
  }
}
