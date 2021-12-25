import 'package:element_ui/widgets.dart';

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
        child: Column(
          // runSpacing: 10,
          // spacing: 10,
          children: [
            SizedBox(width: double.infinity,),
            EButton(
              onPressed: () {},
              child: Text('默认按钮'),
            ),
            EButton(
              onPressed: () {},
              shape: BoxShape.rectangle,
              radius: BorderRadius.all(Radius.circular(0)),
              child: Text('矩形按钮'),
            ),
            EButton(
              onPressed: () {},
              shape: BoxShape.rectangle,
              radius: BorderRadius.all(Radius.circular(5)),
              child: Text('圆角矩形按钮'),
            ),
            EButton(
              onPressed: () {},
              shape: BoxShape.rectangle,
              radius: BorderRadius.circular(30),
              child: Text('按钮'),
            ),
            EButton(
              onPressed: () {},
              shape: BoxShape.circle,
              child: Text('圆形'),
            ),
            EButton(
              onPressed: () {},
              borderStyle: EButtonBorderStyle.stroke,
              child: Text('边框按钮'),
            ),
            EButton(
              onPressed: () {},
              borderStyle: EButtonBorderStyle.none,
              child: Text('文字按钮'),
            ),

            EButton(
              onPressed: () {
                print('onPressed');
              },
              loading: true,
              child: Text('加载中'),
            ),
            EButton(
              onPressed: () {},
              gradientColors: [Colors.red, Colors.blue],
              child: Text('渐变按钮'),
            ),
            EButton(
              onPressed: () {},
              shape: BoxShape.circle,
              gradientColors: [Colors.red, Colors.blue],
              child: Text('渐变按钮'),
            ),
            EButton(
              onPressed: () {},
              gradientColors: [Colors.red, Colors.blue],
              radius: BorderRadius.circular(20),
              child: Text('渐变按钮'),
            ),
          ],
        ),
      ),
    );
  }
}
