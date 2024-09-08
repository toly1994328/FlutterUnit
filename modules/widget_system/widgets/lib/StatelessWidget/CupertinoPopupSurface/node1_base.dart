import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com
/// 说明: 217 CupertinoPopupSurface 模糊弹出层
/// ios 弹出框的圆角矩形模糊背景，源码中应用于 Cupertino 风格的对话框中。
///
//    {
//      "widgetId": 217,
//      "name": 'CupertinoPopupSurface 使用',
//      "priority": 1,
//      "subtitle": "【isSurfacePainted】 : 是否绘白   【bool】\n"
//          "【child】 : 子组件   【Widget】\n"
//          "测试效果左侧 isSurfacePainted = false，右侧 isSurfacePainted = true",
//    }

class CupertinoPopupSurfaceDemo extends StatelessWidget {
  CupertinoPopupSurfaceDemo({Key? key}) : super(key: key);

  final List<int> rainbow = [
    0xffff0000,
    0xffFF7F00,
    0xffFFFF00,
    0xff00FF00,
    0xff00FFFF,
    0xff0000FF,
    0xff8B00FF
  ];

  final List<double> stops = [0.0, 1 / 6, 2 / 6, 3 / 6, 4 / 6, 5 / 6, 1.0];


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: RadialGradient(
              radius: 1.8,
              stops: stops,
              colors: rainbow.map((e) => Color(e)).toList())),
      padding: const EdgeInsets.all(10),
      child: Wrap(
        spacing: 10,
        children: [
          buildCupertinoPopupSurface(false),
          buildCupertinoPopupSurface(true),
        ],
      ),
    );
  }

  Widget buildCupertinoPopupSurface(bool isSurfacePainted) {
    return CupertinoPopupSurface(
      isSurfacePainted: isSurfacePainted,
      child: Container(
        width: 150,
        height: 100,
        color: Colors.white.withOpacity(0.3),
        alignment: Alignment.center,
      ),
    );
  }
}
