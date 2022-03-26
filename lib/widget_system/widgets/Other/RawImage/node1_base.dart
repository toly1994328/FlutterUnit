import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// create by 张风捷特烈 on 2020/7/22
/// contact me by email 1981462002@qq.com
/// 说明: 313 RawImage 6 是实现Image组件的核心组件，可以显示ui的Image,基本属性同Image,一般很少单独使用。
//    {
//      "widgetId": 313,
//      "name": "RawImage基本使用",
//      "priority": 1,
//      "subtitle": "【image】 : 图片   【ui.Image】\n"
//          "【width】 : 宽   【int】\n"
//          "【height】: 高   【int】\n"
//          "【isAntiAlias】: 是否抗锯齿   【bool】\n"
//          "【filterQuality】: 过滤质量   【FilterQuality】\n"
//          "很多属性同Image,详见之.",
//    }
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
