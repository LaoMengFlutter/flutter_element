import 'package:element_ui/widgets.dart';
import 'package:flutter/material.dart';

class ColorPickerDemo extends StatefulWidget {
  const ColorPickerDemo({Key? key}) : super(key: key);

  @override
  _ColorPickerDemoState createState() => _ColorPickerDemoState();
}

class _ColorPickerDemoState extends State<ColorPickerDemo> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.grey,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 12),
              Container(
                height: 300,
                width: 300,
                color: Colors.white,
                child: EColorPicker(
                  showAlpha: true,
                  showClearButton: true,
                  predefineColors: [
                    Color(0xFFff4500),
                    Color(0xFFff8c00),
                    Color(0xFFffd700),
                    Color(0xFF90ee90),
                    Color(0xFF00ced1),
                    Color(0xFF1e90ff),
                    Color(0xFFc71585),
                    Color(0xFFc71585),
                    Color(0x88c71585),
                    Color(0x11c71585),
                    Color(0xFF00ced1),
                    Color(0xFF1e90ff),
                  ],
                ),
              ),
              SizedBox(height: 12),
              EColorPickerButton(
                height: 45,
                width: 45,
                color: Colors.blue,
              ),
              SizedBox(height: 12),
              // Row(
              //   children: [
              //     EColorPickerButton(
              //       height: 45,
              //       width: 45,
              //       color: Colors.blue.withOpacity(.3),
              //     ),
              //     Expanded(child: Container()),
              //     EColorPickerButton(
              //       height: 45,
              //       width: 45,
              //       color: Colors.blue.withOpacity(.3),
              //     ),
              //   ],
              // ),
              // SizedBox(height: 600),
              // EColorPickerButton(
              //   height: 45,
              //   width: 45,
              //   color: Colors.blue.withOpacity(.3),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
