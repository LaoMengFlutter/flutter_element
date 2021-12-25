import 'package:flutter/material.dart';
import 'package:element_ui/widgets.dart';

class RateDemo extends StatefulWidget {
  const RateDemo({Key? key}) : super(key: key);

  @override
  State<RateDemo> createState() => _RateDemoState();
}

class _RateDemoState extends State<RateDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            SizedBox(
              height: 12,
              width: double.infinity,
            ),
            ERate(value: 3.7),
            SizedBox(height: 12),
            ERate(
              value: 5.5,
              count: 6,
            ),
            SizedBox(height: 12),
            ERate(
              value: 3.7,
              showLabel: true,
            ),
            SizedBox(height: 12),
            ERate(
              value: 3.7,
              itemSize: 60,
            ),
            SizedBox(height: 12),
            ERate(
              value: 5,
              iconType: RateIconType.sentiment,
            ),
            SizedBox(height: 12),
            ERate(
              value: 5,
              iconType: RateIconType.sameSentiment,
            ),
            SizedBox(height: 12),
            ERate(
              value: 5,
              showLabel: true,
              labelBuilder: (double value) {
                String s = '';
                if (value <= 1) {
                  s = '极差';
                } else if (value <= 2) {
                  s = '失望';
                } else if (value <= 3) {
                  s = '一般';
                } else if (value <= 4) {
                  s = '满意';
                } else if (value <= 5) {
                  s = '惊喜';
                }
                return Text(s);
              },
            ),
            SizedBox(height: 12),
            ERate(
              value: 3.5,
              space: 12,
            ),
            SizedBox(height: 12),
            ERate(
              value: 3.5,
              enable: false,
            ),
            SizedBox(height: 12),
            ERate(
              value: 3.5,
              onChanged: (value) {
                print('$value');
              },
            ),
            SizedBox(height: 12),
            ERate(
              value: 3.5,
              child: SizedBox(
                width: 40,
                height: 40,
                child: ColoredBox(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 12),
            ERate(
              value: 3.5,
              itemBuilder: (context, index) {
                return Text('$index');
              },
            ),
            SizedBox(height: 12),
            ERate(
              value: 3.5,
              style: ERateStyle(
                activeColor: Colors.red,
                inactiveColor: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
