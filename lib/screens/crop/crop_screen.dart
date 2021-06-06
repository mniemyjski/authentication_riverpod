import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:extended_image/extended_image.dart' hide File;
import 'package:flutter/material.dart' hide Image;
import 'package:image/image.dart';

class CropScreenArguments {
  CropScreenArguments({required this.uint8List});
  final Uint8List uint8List;
}

class CropImageScreen extends StatefulWidget {
  const CropImageScreen({Key? key, required this.uint8List}) : super(key: key);

  final Uint8List uint8List;
  static const String routeName = '/crop_image';

  static Route route(CropScreenArguments cropScreenArguments) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => CropImageScreen(uint8List: cropScreenArguments.uint8List),
    );
  }

  @override
  _CropImageScreenState createState() => _CropImageScreenState();
}

class _CropImageScreenState extends State<CropImageScreen> {
  final GlobalKey<ExtendedImageEditorState> editorKey = GlobalKey<ExtendedImageEditorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crop'),
        actions: <Widget>[
          IconButton(
            onPressed: () => _save(context),
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
                return ExtendedImage.memory(
                  widget.uint8List,
                  fit: BoxFit.contain,
                  cacheRawData: true,
                  mode: ExtendedImageMode.editor,
                  extendedImageEditorKey: editorKey,
                  initEditorConfigHandler: (state) {
                    return EditorConfig(
                      maxScale: 8.0,
                      cropRectPadding: EdgeInsets.all(20.0),
                      hitTestSize: 20.0,
                    );
                  },
                );
              }),
            ),
          ),
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.undo),
                tooltip: 'Undo',
                onPressed: () => editorKey.currentState!.reset(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _save(BuildContext context) {
    final Rect? cropRect = editorKey.currentState!.getCropRect();
    var data = editorKey.currentState?.rawImageData;

    if (data != null && cropRect != null) {
      Image? src = decodeImage(data);
      if (src != null) {
        src = bakeOrientation(src);
        src = copyCrop(src, cropRect.left.toInt(), cropRect.top.toInt(), cropRect.width.toInt(), cropRect.height.toInt());
        var fileData = encodeJpg(src, quality: 50);
        return Navigator.pop(context, Uint8List.fromList(fileData));
      }
    }
  }
}
