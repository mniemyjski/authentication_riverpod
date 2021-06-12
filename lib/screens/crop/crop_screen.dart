import 'dart:typed_data';

import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:image/image.dart';
import 'package:logger/logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CropScreenArguments {
  CropScreenArguments({required this.uint8List, required this.isCircleUi});
  final Uint8List uint8List;
  final isCircleUi;
}

class CropImageScreen extends HookWidget {
  CropImageScreen({
    Key? key,
    required this.uint8List,
    required this.isCircleUi,
  }) : super(key: key);

  final Uint8List uint8List;
  final isCircleUi;

  static Route route(CropScreenArguments args) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => CropImageScreen(uint8List: args.uint8List, isCircleUi: args.isCircleUi),
    );
  }

  static const String routeName = '/crop_image';
  final _cropController = CropController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crop'),
        actions: <Widget>[
          IconButton(
            onPressed: () => _save(context, isCircleUi, _cropController),
            icon: Icon(Icons.save),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(8),
              child: Consumer(builder: (context, watch, child) {
                return Crop(
                  image: uint8List,
                  controller: _cropController,
                  onCropped: (image) {
                    Image? i = decodeImage(image);
                    if (i != null) {
                      encodeJpg(i, quality: 50);
                      return Navigator.pop(context, image);
                    }
                  },
                  initialSize: 0.5,
                  withCircleUi: isCircleUi,
                  maskColor: Colors.white.withAlpha(100),
                  cornerDotBuilder: (size, cornerIndex) => const DotControl(color: Colors.indigo),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

_save(BuildContext context, bool isCircleUi, CropController controller) {
  isCircleUi ? controller.cropCircle() : controller.crop();
}
