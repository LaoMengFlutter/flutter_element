import 'dart:math';

import 'package:flutter_element/widgets.dart';

import 'package:flutter/material.dart';

class ImageDemo extends StatelessWidget {
  const ImageDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  child: EImage(
                    image: NetworkImage(
                        'https://avatars0.githubusercontent.com/u/8264639?s=460&v=4'),
                  ),
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
                Container(
                  width: 150,
                  height: 150,
                  child: EImage(
                    image: NetworkImage(
                        'https://avatars0.githubusercontent.com/u/8264639?s=460&v=4'),
                    radius: BorderRadius.all(Radius.circular(12)),
                  ),
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
                Container(
                  width: 150,
                  height: 150,
                  child: EImage(
                    image: NetworkImage(
                        'http://pic1.win4000.com/wallpaper/2018-06-02/5b1204212b018.jpg'),
                  ),
                ),
                Container(
                  width: 150,
                  height: 150,
                  child: EImage(
                    image: NetworkImage(
                        'http://pic1.win4000.com/wallpaper/2018-06-02/5b1204212b018.jpg'),
                    loadingBuilder: (context, child, progress) {
                      print('progress:$progress');
                      if (progress == null) {
                        return child;
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
                Container(
                  width: 150,
                  height: 150,
                  child: EImage(
                    radius: BorderRadius.all(Radius.circular(20)),
                    image: NetworkImage(
                        'https://avatars0.githubusercontent.com/u/8264639fda'),
                    errorWidget: Container(
                      color: Colors.grey,
                      alignment: Alignment.center,
                      child: Text(
                        'error',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 150,
                  height: 150,
                  child: EImage(
                    radius: BorderRadius.all(Radius.circular(20)),
                    image: NetworkImage(
                        'https://avatars0.githubusercontent.com/u/8264639fda'),
                  ),
                ),
              ],
            )),
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
