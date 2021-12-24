import 'package:flutter/material.dart';
import 'package:element_ui/widgets.dart';

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
            value: true,
            label: '复选框',
            tristate: true,
          ),
          SizedBox(height: 12),
          ECheckbox(
            value: false,
            label: '复选框',
            style: ECheckboxStyle(
              backgroundColor: Colors.grey.withOpacity(.3),
              checkedBackgroundColor: Colors.blue,
            ),
          ),
          SizedBox(height: 12),
          ECheckbox(
            value: false,
            label: '复选框',
            border: true,
            style: ECheckboxStyle(
              borderColor: Colors.green,
              checkedBorderColor: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(height: 12),
          ECheckbox(
            value: false,
            label: '复选框',
            border: true,
            style: ECheckboxStyle(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                space: 30),
          ),
          SizedBox(height: 12),
          ECheckbox(
            value: false,
            label: '禁用',
            enable: false,
          ),
          SizedBox(height: 12),
          ECheckbox(
            value: true,
            shape: CircleBorder(),
            label: '圆形复选框',
          ),
        ],
      ),
    );
  }
}
