import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-04-19
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 70,
//      "name": 'DecoratedBox形状和图片装饰',
//      "priority": 2,
//      "subtitle":
//          "【shape】 : 形状   【BoxShape】\n"
//          "【image】 : 背景图片   【DecorationImage】\n",
//    }
class ShapeImageDemo extends StatelessWidget {
  const ShapeImageDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                'assets/images/wy_200x300.webp',
              ))),
      child: SizedBox(
        height: 80,
        width: 80,
        child: Icon(
          Icons.ac_unit,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }
}
