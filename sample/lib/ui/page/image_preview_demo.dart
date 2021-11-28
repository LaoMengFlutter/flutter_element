import 'package:flutter/material.dart';
import 'package:flutter_element/widgets.dart';
import 'package:extended_image/extended_image.dart';
import 'package:image_crop/image_crop.dart';

class ImagePreviewDemo extends StatefulWidget {
  const ImagePreviewDemo({Key? key}) : super(key: key);

  @override
  State<ImagePreviewDemo> createState() => _ImagePreviewDemoState();
}

class _ImagePreviewDemoState extends State<ImagePreviewDemo> {
  final cropKey = GlobalKey<CropState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(30),
        child:
        // Crop(
        //   key: cropKey,
        //   image: AssetImage('assets/images/short.png'),
        //   aspectRatio: 4.0 / 3.0,
        // ),
        EImagePreview(
          imageProvider: AssetImage('assets/images/long.png'),
        ),
      ),
    );
  }
}
