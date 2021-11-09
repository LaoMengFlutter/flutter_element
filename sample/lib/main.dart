import 'package:ele_theme/ele_theme.dart';
import 'package:ele_theme/ele_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:sample/ui/widgets/border_demo.dart';
import 'package:sample/ui/widgets/button_demo.dart';
import 'package:sample/ui/widgets/image_demo.dart';
import 'package:sample/ui/widgets/prgress_demo.dart';
import 'package:sample/ui/widgets/widget_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EleTheme(
        data: EleThemeData(),
        child: ProgressDemo(),
      ),
    );
  }
}
