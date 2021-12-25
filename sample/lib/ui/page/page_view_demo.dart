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
          'PageView:$index',
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
                type: PageViewType.card,
                viewportFraction: .8,
                cardScale: .9,
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
                loop: true,
                autoPlayDuration: Duration(seconds: 5),
                nextPageDuration: Duration(microseconds: 800),
              ),
            ),
            SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: EPageView(
                itemBuilder: itemBuilder,
                itemCount: 5,
                showIndicator: true,
              ),
            ),
            SizedBox(
              height: 200,
              child: EPageView(
                itemBuilder: itemBuilder,
                itemCount: 5,
                showIndicator: true,
                style: EPageViewStyle(
                  indicatorColor: Colors.black,
                  indicatorActiveColor: Colors.red,
                ),
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
              ),
            ),
            SizedBox(height: 12),
            Container(
              height: 200,
              color: Colors.grey.withOpacity(.4),
              child: EPageView(
                itemBuilder: itemBuilder,
                itemCount: 5,
                showIndicator: true,
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
                scrollDirection: Axis.vertical,
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
                scrollDirection: Axis.vertical,
              ),
            ),
            SizedBox(height: 12),
            Container(
              height: 200,
              color: Colors.grey.withOpacity(.4),
              child: EPageView(
                itemBuilder: itemBuilder,
                itemCount: 5,
                showIndicator: true,
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
            SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: EPageView(
                itemBuilder: itemBuilder,
                itemCount: 5,
                showControl: true,
                nextWidget: Text(
                  '下一页',
                  style: TextStyle(color: Colors.white),
                ),
                previousWidget: Text(
                  '上一页',
                  style: TextStyle(color: Colors.white),
                ),
                showIndicator: true,
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
