import 'dart:math';

import 'package:ele_image/ele_image.dart';
import 'package:flutter/material.dart';

class ImageDemo extends StatelessWidget {
  const ImageDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Container(
                  width: 150,
                  height: 150,
                  child: EImage(
                    image: NetworkImage(
                        'https://avatars0.githubusercontent.com/u/8264639?s=460&v=4'),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Container(
                  width: 150,
                  height: 150,
                  child: EImage(
                    image: NetworkImage(
                        'https://avatars0.githubusercontent.com/u/8264639?s=460&v=4'),
                    radius: BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Container(
                  width: 150,
                  height: 150,
                  child: EImage(
                    image: NetworkImage(
                        'https://avatars0.githubusercontent.com/u/8264639?s=460&v=4'),
                    radius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Container(
                  width: 200,
                  height: 150,
                  child: EImage(
                    image: NetworkImage(
                        'https://avatars0.githubusercontent.com/u/8264639?s=460&v=4'),
                    shape: ImageShape.circle,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Container(
                  width: 150,
                  height: 150,
                  child: EImage(
                    image: NetworkImage(
                        'https://avatars0.githubusercontent.com/u/8264639?s=460&v=4'),
                    radius: BorderRadius.all(Radius.circular(12)),
                    borderWidth: 3,
                    borderColor: Colors.red,
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Container(
                  width: 150,
                  height: 150,
                  child: EImage(
                    image: NetworkImage(
                        'https://avatars0.githubusercontent.com/u/8264639?s=460&v=4'),
                    shape: ImageShape.circle,
                    borderWidth: 3,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Container(
                  width: 150,
                  height: 150,
                  child: EImage(
                    image: NetworkImage(
                        'https://avatars0.githubusercontent.com/u/8264639?s=460&v=4'),
                    radius: BorderRadius.all(Radius.circular(12)),
                    clipper: StarPath(),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Container(
                  width: 150,
                  height: 150,
                  child: EImage(
                    image: NetworkImage(
                        'https://avatars0.githubusercontent.com/u/8264639?s=460&v=4'),
                    shape: ImageShape.circle,
                    borderWidth: 3,
                    borderColor: Colors.red,
                    clipper: StarPath(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class StarPath extends CustomClipper<Path> {
  StarPath({this.scale = 2});

  final double scale;

  double perDegree = 36;

  /// 角度转弧度公式
  double degree2Radian(double degree) {
    return (pi * degree / 180);
  }

  @override
  Path getClip(Size size) {
    var R = min(size.width / 2, size.height / 2);
    var r = R / scale;
    var x = size.width / 2;
    var y = size.height / 2;

    var path = Path();
    path.moveTo(x, y - R);
    path.lineTo(x - sin(degree2Radian(perDegree)) * r,
        y - cos(degree2Radian(perDegree)) * r);
    path.lineTo(x - sin(degree2Radian(perDegree * 2)) * R,
        y - cos(degree2Radian(perDegree * 2)) * R);
    path.lineTo(x - sin(degree2Radian(perDegree * 3)) * r,
        y - cos(degree2Radian(perDegree * 3)) * r);
    path.lineTo(x - sin(degree2Radian(perDegree * 4)) * R,
        y - cos(degree2Radian(perDegree * 4)) * R);
    path.lineTo(x - sin(degree2Radian(perDegree * 5)) * r,
        y - cos(degree2Radian(perDegree * 5)) * r);
    path.lineTo(x - sin(degree2Radian(perDegree * 6)) * R,
        y - cos(degree2Radian(perDegree * 6)) * R);
    path.lineTo(x - sin(degree2Radian(perDegree * 7)) * r,
        y - cos(degree2Radian(perDegree * 7)) * r);
    path.lineTo(x - sin(degree2Radian(perDegree * 8)) * R,
        y - cos(degree2Radian(perDegree * 8)) * R);
    path.lineTo(x - sin(degree2Radian(perDegree * 9)) * r,
        y - cos(degree2Radian(perDegree * 9)) * r);
    path.lineTo(x - sin(degree2Radian(perDegree * 10)) * R,
        y - cos(degree2Radian(perDegree * 10)) * R);
    return path;
  }

  @override
  bool shouldReclip(StarPath oldClipper) {
    return oldClipper.scale != this.scale;
  }
}
