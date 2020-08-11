import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:ui' as ui;
import 'node1_base.dart';

/// create by 张风捷特烈 on 2020/7/22
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 264,
//      "name": "保存Widget成为图片",
//      "priority": 2,
//      "subtitle": "通过RenderRepaintBoundary可以获取子组件的Image信息，从而获取字节保存为图片文件。",
//    }

class RepaintBoundarySave extends StatelessWidget {
  final GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RepaintBoundary(
          key: _globalKey,
          child: TempPlayBezier3Page(),
        ),
        Positioned(right: -10, child: _buildButton3(context))
      ],
    );
  }

  Widget _buildButton3(context) => MaterialButton(
      child: Icon(
        Icons.save_alt,
        size: 15,
        color: Colors.white,
      ),
      color: Colors.green,
      shape: CircleBorder(
        side: BorderSide(width: 2.0, color: Color(0xFFFFDFDFDF)),
      ),
      onPressed: () async {
        var bits = await _widget2Image(_globalKey);
        var dir = await getApplicationSupportDirectory();
        var file = File(dir.path + "/save_img.png");
        var f = await file.writeAsBytes(bits);
        Scaffold.of(context).showSnackBar(SnackBar(
          backgroundColor: Theme.of(context).primaryColor,
          content: Text('保存成功后! 路径为:${f.path}'),
        ));
      });

  Future<Uint8List> _widget2Image(GlobalKey key) async {
    RenderRepaintBoundary boundary = key.currentContext.findRenderObject();
    //获得 ui.image
    ui.Image img = await boundary.toImage();
    //获取图片字节
    var byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    Uint8List bits = byteData.buffer.asUint8List();
    return bits;
  }
}
