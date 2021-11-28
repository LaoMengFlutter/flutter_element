import 'package:flutter/material.dart';
import 'package:flutter_element/widgets.dart';

class CheckboxDemo extends StatelessWidget {
  const CheckboxDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 12, width: double.infinity),
          ECheckbox(
            value: false,
            label: '复选框',
          ),
          SizedBox(height: 12),
          ECheckbox(
            value: false,
            label: '复选框',
            border: true,
          ),
          SizedBox(height: 12),
          ECheckbox(
            value: false,
            label: '复选框',
            style: ECheckboxStyle(
              backgroundColor: Colors.red,
              checkedBackgroundColor: Colors.yellow,
            ),
          ),
          SizedBox(height: 12),
          ECheckbox(
            value: false,
            label: '复选框',
            border: true,
            style: ECheckboxStyle(
                borderColor: Colors.green, checkedBorderColor: Colors.red),
          ),
          SizedBox(height: 12),
          ECheckbox(
            value: false,
            label: '禁用',
            enable: false,
          ),
        ],
      ),
    );
  }
}
