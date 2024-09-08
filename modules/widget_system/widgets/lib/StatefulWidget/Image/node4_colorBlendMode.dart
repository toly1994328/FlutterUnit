import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-29
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 38,
//      "name": '图片颜色及混合模式',
//      "priority": 4,
//      "subtitle": "【color】 : 颜色   【Color】\n"
//          "【colorBlendMode】: 混合模式*29 【BlendMode】",
//    },

class BlendModeImage extends StatelessWidget {
  const BlendModeImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: BlendMode.values
          .toList()
          .map((mode) => Column(children:[
        Container(
            margin: const EdgeInsets.all(5),
            width: 60,
            height: 60,
            color: Colors.red,
            child: Image(
                image: const AssetImage("assets/images/icon_head.webp"),
                color: Colors.blue.withAlpha(88),
                colorBlendMode: mode)),
        Text(mode.toString().split(".")[1])
      ]))
          .toList(),
    );
  }
}