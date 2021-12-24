import 'package:element_ui/widgets.dart';
import 'package:flutter/material.dart';

class PageViewDemo extends StatelessWidget {
  const PageViewDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var itemBuilder = (context, index) {
      return Container(
        color: index % 2 == 0 ? Color(0xFF99a9bf) : Color(0xFFd3dce6),
        alignment: Alignment.center,
        child: Text(
          'AutoPlay:$index',
          style: TextStyle(color: Colors.white, fontSize: 26),
        ),
      );
    };

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: EPageView(
                itemBuilder: itemBuilder,
                itemCount: 5,
              ),
            ),
            SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: EPageView(
                itemBuilder: itemBuilder,
                itemCount: 5,
                scrollDirection: Axis.vertical,
              ),
            ),
            SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: EPageView(
                itemBuilder: itemBuilder,
                itemCount: 5,
                viewportFraction: .8,
              ),
            ),
            SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: EPageView(
                itemBuilder: itemBuilder,
                itemCount: 5,
                type: PageViewType.card,
                viewportFraction: .8,
                cardScale: .9,
                loop: true,
              ),
            ),
            SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: EPageView(
                itemBuilder: itemBuilder,
                itemCount: 5,
                loop: true,
              ),
            ),
            SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: EPageView(
                itemBuilder: itemBuilder,
                itemCount: 5,
                autoPlay: true,
              ),
            ),
            SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: EPageView(
                itemBuilder: itemBuilder,
                itemCount: 5,
                showIndicator: true,
                loop: true,
              ),
            ),
            SizedBox(height: 12),
            Container(
              height: 200,
              color: Colors.black,
              child: EPageView(
                itemBuilder: itemBuilder,
                itemCount: 5,
                showIndicator: true,
                loop: true,
                indicatorPosition: PageViewIndicatorPosition.outside,
              ),
            ),
            SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: EPageView(
                itemBuilder: itemBuilder,
                itemCount: 5,
                showIndicator: true,
                loop: true,
                scrollDirection: Axis.vertical,
              ),
            ),
            SizedBox(height: 12),
            Container(
              height: 200,
              color: Colors.black,
              child: EPageView(
                itemBuilder: itemBuilder,
                itemCount: 5,
                showIndicator: true,
                loop: true,
                scrollDirection: Axis.vertical,
                indicatorPosition: PageViewIndicatorPosition.outside,
              ),
            ),
            SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: EPageView(
                itemBuilder: itemBuilder,
                itemCount: 5,
                showIndicator: true,
                indicatorType: PageViewIndicatorType.line,
                loop: true,
              ),
            ),
            SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: EPageView(
                itemBuilder: itemBuilder,
                itemCount: 5,
                showIndicator: true,
                scrollDirection: Axis.vertical,
                indicatorType: PageViewIndicatorType.line,
                loop: true,
              ),
            ),
            SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: EPageView(
                itemBuilder: itemBuilder,
                itemCount: 5,
                showControl: true,
              ),
            ),
            SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: EPageView(
                itemBuilder: itemBuilder,
                itemCount: 5,
                showControl: true,
                scrollDirection: Axis.vertical,
                loop: true,
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
