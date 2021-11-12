import 'package:flutter/material.dart';
import 'package:flutter_element/widgets.dart';

class CheckboxDemo extends StatelessWidget {
  const CheckboxDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ECheckbox(value: false,label: '复选框',),
        ],
      ),
    );
  }
}
