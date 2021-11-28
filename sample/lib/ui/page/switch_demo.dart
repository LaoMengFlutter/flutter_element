import 'package:flutter/material.dart';
import 'package:flutter_element/widgets.dart';

class SwitchDemo extends StatelessWidget {
  const SwitchDemo({Key? key}) : super(key: key);

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
            ESwitch(),
            SizedBox(height: 12),
            ESwitch(enable: false,),
            SizedBox(height: 12),
            ESwitch(
              value: true,
            ),
            SizedBox(height: 12),
            ESwitch(
              style: ESwitchStyle(
                activeColor: Colors.green,
                trackColor: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
