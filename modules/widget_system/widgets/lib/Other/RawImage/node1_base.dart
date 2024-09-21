import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// create by 张风捷特烈 on 2020/7/22
/// contact me by email 1981462002@qq.com

class RawImageDemo extends StatefulWidget {
  const RawImageDemo({Key? key}) : super(key: key);

  @override
  _RawImageDemoState createState() => _RawImageDemoState();
}

class _RawImageDemoState extends State<RawImageDemo> {
  ui.Image? _image;

  @override
  void initState() {
    super.initState();
    _loadImageFromAssets('assets/images/icon_head.webp');
  }

  @override
  Widget build(BuildContext context) {
    if (_image == null) {
      return const SizedBox(
        width: 80,
        height: 80,
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RawImage(
              image: _image,
              width: 150,
              height: 150,
              isAntiAlias: true,
              filterQuality: FilterQuality.high,
            ),
            const Text('isAntiAlias: true'),
            const Text('FilterQuality.high')
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RawImage(
              image: _image,
              width: 150,
              height: 150,
              isAntiAlias: false,
            ),
            const Text('isAntiAlias: false'),
            const Text('FilterQuality.low')
          ],
        ),
      ],
    );
  }

  void _loadImageFromAssets(String name) async {
    _image = await loadImageFromAssets(name);
    setState(() {});
  }

  //读取 assets 中的图片
  Future<ui.Image> loadImageFromAssets(String path) async {
    ByteData data = await rootBundle.load(path);
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    return decodeImageFromList(Uint8List.fromList(bytes));
  }
}
