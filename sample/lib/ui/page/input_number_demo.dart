import 'package:flutter/material.dart';
import 'package:flutter_element/widgets.dart';

class InputNumberDemo extends StatelessWidget {
  const InputNumberDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 12, width: double.infinity),
          Container(
            height: 30,
            width: 150,
            child: const InputNumber(
              height: 20,
            ),
          ),
          SizedBox(height: 12),
          Container(
            height: 100,
            width: 300,
            child: const InputNumber(
              height: 100,
            ),
          ),
          SizedBox(height: 12),
          Container(
            height: 45,
            width: 150,
            child: const InputNumber(
              height: 45,
              step: .1,
              precision: 2,
            ),
          ),
          SizedBox(height: 12),
          Container(
            height: 45,
            width: 150,
            child: const InputNumber(
              height: 45,
              step: .3,
              precision: 2,
              max: 0.8,
            ),
          ),
          SizedBox(height: 12),
        ],
      ),
    );
  }
}
