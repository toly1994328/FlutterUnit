
import 'package:flutter/material.dart';



/// create by 张风捷特烈 on 2020-03-29
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 38,
//      "name": '图片实现局部放大',
//      "priority": 6,
//      "subtitle": "【centerSlice】 : 保留的区域   【Rect】",
//    },

class CenterSliceImage extends StatelessWidget {
  const CenterSliceImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 80,
      child: Image.asset(
        "assets/images/right_chat.png",
        centerSlice: const Rect.fromLTRB(9, 27, 60, 27 + 1.0),
        fit: BoxFit.fill,
      ),
    );
  }
}
