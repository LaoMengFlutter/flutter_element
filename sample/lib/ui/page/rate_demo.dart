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
            // RatingBar.builder(
            //   initialRating: 3,
            //   minRating: 1,
            //   direction: Axis.horizontal,
            //   allowHalfRating: true,
            //   itemCount: 5,
            //   itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            //   itemBuilder: (context, _) => Icon(
            //     Icons.star,
            //     color: Colors.amber,
            //   ),
            //   onRatingUpdate: (rating) {
            //     print(rating);
            //   },
            // ),
            // SizedBox(height: 12),
            ERate(
              value: 3.7,
              style: ERateStyle(activeColor: Colors.amber),
            ),
            SizedBox(height: 12),
            ERate(
              value: 3.7,
              showLabel: true,
              itemSize: 30,
              style: ERateStyle(activeColor: Colors.amber),
            ),
            SizedBox(height: 12),
            ERate(
              value: 5,
              iconType: RateIconType.sentiment,
              style: ERateStyle(activeColor: Colors.amber),
            ),
            SizedBox(height: 12),
            ERate(
              value: 5,
              iconType: RateIconType.sentiment,
              showLabel: true,
              style: ERateStyle(activeColor: Colors.amber),
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
              iconType: RateIconType.sameSentiment,
              style: ERateStyle(activeColor: Colors.amber),
            ),
            SizedBox(height: 12),
            ERate(
              value: 3.5,
              iconType: RateIconType.sameSentiment,
              enable: false,
              style: ERateStyle(activeColor: Colors.amber),
            ),
          ],
        ),
      ),
    );
  }
}
