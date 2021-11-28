import 'package:flutter/material.dart';
import 'package:flutter_element/widgets.dart';

class WheelSwitchDemo extends StatelessWidget {
  const WheelSwitchDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            SizedBox(height: 12),
            EWheelSwitch(),
          ],
        ),
      ),
    );
  }
}
