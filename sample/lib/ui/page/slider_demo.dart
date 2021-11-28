import 'package:flutter/material.dart';
import 'package:flutter_element/widgets.dart';

class SliderDemo extends StatelessWidget {
  const SliderDemo({Key? key}) : super(key: key);

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
            ESlider(),
            SizedBox(height: 12),
            ESlider(value: .5),
            SizedBox(height: 12),
            ESlider(
              value: 0,
              min: 0,
              max: 10,
              divisions: 10,
            ),
            SizedBox(height: 12),
            ESlider(
              value: .3,
              enable: false,
            ),
            SizedBox(height: 12),
            ESlider(
              range: true,
              rangeValues: RangeValues(.1, .5),
            ),
            SizedBox(height: 12),
            ESlider(
              range: true,
              rangeValues: RangeValues(.1, .5),
              style: ESliderStyle(thumbColor: Color(0xFFFF0000)),
            ),
          ],
        ),
      ),
    );
  }
}
