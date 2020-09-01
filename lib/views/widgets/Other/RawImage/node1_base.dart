import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

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
  @override
  _RawImageDemoState createState() => _RawImageDemoState();
}

class _RawImageDemoState extends State<RawImageDemo> {
  ui.Image _image;

  @override
  void initState() {
    super.initState();
    _loadImageFromAssets('assets/images/icon_head.webp');
  }

  @override
  Widget build(BuildContext context) {
    if (_image == null)
      return Container(
        width: 80,
        height: 80,
      );

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
            Text('isAntiAlias: true'),
            Text('FilterQuality.high')
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
            Text('isAntiAlias: false'),
            Text('FilterQuality.low')
          ],
        ),
      ],
    );
  }

  void _loadImageFromAssets(String name) async {
    _image = await loadImageByProvider(AssetImage(name));

    setState(() {});
  }

  //通过ImageProvider读取Image
  Future<ui.Image> loadImageByProvider(
    ImageProvider provider, {
    ImageConfiguration config = ImageConfiguration.empty,
  }) async {
    Completer<ui.Image> completer = Completer<ui.Image>(); //完成的回调
    ImageStreamListener listener;
    ImageStream stream = provider.resolve(config); //获取图片流
    listener = ImageStreamListener((ImageInfo frame, bool sync) {
      //监听
      final ui.Image image = frame.image;
      completer.complete(image); //完成
      stream.removeListener(listener); //移除监听
    });
    stream.addListener(listener); //添加监听
    return completer.future; //返回
  }
}
