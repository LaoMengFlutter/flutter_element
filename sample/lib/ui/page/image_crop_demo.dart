import 'package:flutter/material.dart';
import 'package:flutter_element/widgets.dart';
import 'package:image_crop/image_crop.dart';

class ImageCropDemo extends StatefulWidget {
  const ImageCropDemo({Key? key}) : super(key: key);

  @override
  _ImageCropDemoState createState() => _ImageCropDemoState();
}

class _ImageCropDemoState extends State<ImageCropDemo> {
  final cropKey = GlobalKey<CropState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          color: Colors.black,
          padding: const EdgeInsets.all(20.0),
          child: EImageCrop(
            image: NetworkImage(
                'https://img0.baidu.com/it/u=1868816884,3782068186&fm=26&fmt=auto'),
          )
          // Crop(
          //   key: cropKey,
          //   image: NetworkImage(
          //       'https://avatars0.githubusercontent.com/u/8264639?s=460&v=4'),
          //   aspectRatio: 4.0 / 3.0,
          // ),
          ),
    );
  }
}
