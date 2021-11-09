import 'package:ele_button/ele_button.dart';
import 'package:ele_theme/ele_button_theme_data.dart';
import 'package:ele_theme/ele_theme_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonDemo extends StatelessWidget {
  const ButtonDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          runSpacing: 10,
          spacing: 10,
          children: [
            EButton(
              onPressed: () {},
              child: Text('默认按钮'),
            ),
            EButton(
              onPressed: () {},
              style: EleButtonThemeData(status: EleThemeStatus.primary),
              child: Text('主要按钮'),
            ),
            EButton(
              onPressed: () {},
              style: EleButtonThemeData(status: EleThemeStatus.success),
              child: Text('成功按钮'),
            ),
            EButton(
              onPressed: () {},
              style: EleButtonThemeData(status: EleThemeStatus.info),
              child: Text('信息按钮'),
            ),
            EButton(
              onPressed: () {},
              style: EleButtonThemeData(status: EleThemeStatus.danger),
              child: Text('危险按钮'),
            ),
            EButton(
              onPressed: () {},
              style: EleButtonThemeData(status: EleThemeStatus.warning),
              child: Text('警告按钮'),
            ),
            EButton(
              onPressed: () {},
              style: EleButtonThemeData(
                  status: EleThemeStatus.primary, plain: true),
              child: Text('主要按钮'),
            ),
            EButton(
              onPressed: () {},
              style: EleButtonThemeData(
                  status: EleThemeStatus.success, plain: true),
              child: Text('成功按钮'),
            ),
            EButton(
              onPressed: () {},
              style:
                  EleButtonThemeData(status: EleThemeStatus.info, plain: true),
              child: Text('信息按钮'),
            ),
            EButton(
              onPressed: () {},
              style: EleButtonThemeData(
                  status: EleThemeStatus.danger, plain: true),
              child: Text('危险按钮'),
            ),
            EButton(
              onPressed: () {},
              style: EleButtonThemeData(
                  status: EleThemeStatus.warning, plain: true),
              child: Text('警告按钮'),
            ),
            EButton(
              onPressed: () {},
              style: EleButtonThemeData(shape: ButtonShape.round),
              child: Text('圆角按钮'),
            ),
            EButton(
              onPressed: () {},
              style: EleButtonThemeData(
                status: EleThemeStatus.primary,
                shape: ButtonShape.round,
              ),
              child: Text('圆角按钮'),
            ),
            EButton(
              onPressed: () {},
              style: EleButtonThemeData(status: EleThemeStatus.primary),
              child: Icon(Icons.arrow_right),
            ),
            EButton(
              onPressed: null,
              style: EleButtonThemeData(status: EleThemeStatus.primary),
              child: Text('禁用按钮'),
            ),
            EButton(
              onPressed: null,
              child: Text('默认按钮'),
            ),
            EButton(
              onPressed: null,
              style: EleButtonThemeData(status: EleThemeStatus.primary),
              child: Text('主要按钮'),
            ),
            EButton(
              onPressed: null,
              style: EleButtonThemeData(status: EleThemeStatus.success),
              child: Text('成功按钮'),
            ),
            EButton(
              onPressed: null,
              style: EleButtonThemeData(status: EleThemeStatus.info),
              child: Text('信息按钮'),
            ),
            EButton(
              onPressed: null,
              style: EleButtonThemeData(status: EleThemeStatus.danger),
              child: Text('危险按钮'),
            ),
            EButton(
              onPressed: null,
              style: EleButtonThemeData(status: EleThemeStatus.warning),
              child: Text('警告按钮'),
            ),
            EButton(
              onPressed: null,
              style: EleButtonThemeData(
                  status: EleThemeStatus.primary, plain: true),
              child: Text('主要按钮'),
            ),
            EButton(
              onPressed: null,
              style: EleButtonThemeData(
                  status: EleThemeStatus.success, plain: true),
              child: Text('成功按钮'),
            ),
            EButton(
              onPressed: null,
              style:
                  EleButtonThemeData(status: EleThemeStatus.info, plain: true),
              child: Text('信息按钮'),
            ),
            EButton(
              onPressed: null,
              style: EleButtonThemeData(
                  status: EleThemeStatus.danger, plain: true),
              child: Text('危险按钮'),
            ),
            EButton(
              onPressed: null,
              style: EleButtonThemeData(
                  status: EleThemeStatus.warning, plain: true),
              child: Text('警告按钮'),
            ),
            EButton(
              onPressed: null,
              style: EleButtonThemeData(shape: ButtonShape.round),
              child: Text('圆角按钮'),
            ),
            EButton(
              onPressed: () {
                print('onPressed');
              },
              loading: true,
              child: Text('加载中'),
            ),
            EButton(
              onPressed: () {
                print('onPressed');
              },
              loading: true,
              style: EleButtonThemeData(
                status: EleThemeStatus.primary,
              ),
              child: Text('加载中'),
            ),
          ],
        ),
      ),
    );
  }
}
