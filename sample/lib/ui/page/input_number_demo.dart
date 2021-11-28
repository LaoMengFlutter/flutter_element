import 'package:flutter/material.dart';
import 'package:flutter_element/widgets.dart';

class InputNumberDemo extends StatelessWidget {
  const InputNumberDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 12, width: double.infinity),
              Container(
                height: 45,
                width: 150,
                child: const EInputNumber(
                  height: 45,
                ),
              ),
              SizedBox(height: 12),
              Container(
                height: 45,
                width: 150,
                child: const EInputNumber(
                  height: 45,
                  value: 2,
                ),
              ),
              SizedBox(height: 12),
              Container(
                height: 45,
                width: 150,
                child: const EInputNumber(
                  height: 45,
                  max: 10,
                  min: 0,
                ),
              ),
              SizedBox(height: 12),
              SizedBox(height: 12),
              Container(
                height: 45,
                width: 150,
                child: const EInputNumber(
                  height: 45,
                  step: 5,
                ),
              ),
              SizedBox(height: 12),
              Container(
                height: 45,
                width: 150,
                child: const EInputNumber(
                  height: 45,
                  precision: 1,
                ),
              ),
              SizedBox(height: 12),
              Container(
                height: 45,
                width: 150,
                child: const EInputNumber(
                  height: 45,
                  type: InputNumberControlType.right,
                ),
              ),
              SizedBox(height: 12),
              Container(
                height: 100,
                width: 300,
                child: const EInputNumber(
                  height: 100,
                ),
              ),
              SizedBox(height: 12),
              Container(
                height: 45,
                width: 150,
                child: const EInputNumber(
                  height: 45,
                  step: .1,
                  precision: 2,
                ),
              ),
              SizedBox(height: 12),
              const EInputNumber(
                height: 45,
                step: .3,
                precision: 2,
                max: 0.8,
              ),
              SizedBox(height: 12),
              Container(
                height: 45,
                width: 150,
                child: const EInputNumber(
                  height: 45,
                  style: EInputNumberStyle(
                    fontColor: Colors.red,
                    backgroundColor: Colors.green,
                    borderColor: Colors.blue,
                  ),
                ),
              ),
              SizedBox(height: 12),
              Container(
                height: 45,
                width: 150,
                child: const EInputNumber(
                  height: 45,
                  style: EInputNumberStyle(
                    focusBorderColor: Colors.red,
                    iconColor: Colors.red,
                    iconBackgroundColor: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(25))
                  ),
                ),
              ),
              SizedBox(height: 12),
              Container(
                height: 45,
                width: 150,
                child: EInputNumber(
                  height: 45,
                  onChanged: (value){
                    print('value:$value');
                  },
                ),
              ),
              SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }
}
