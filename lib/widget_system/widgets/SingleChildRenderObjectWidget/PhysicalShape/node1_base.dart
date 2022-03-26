
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/7/22
/// contact me by email 1981462002@qq.com
/// 说明: 279 PhysicalShape 物理形状 可以让子组件按照路径进行剪裁,并且可以指定背景色、影深、阴影颜色、剪切行为。
//    {
//      "widgetId": 279,
//      "name": "PhysicalShape基本使用",
//      "priority": 1,
//      "subtitle": "【clipper】 : 裁剪器   【CustomClipper<Path>】\n"
//          "【clipBehavior】 : 裁剪行为   【Clip】\n"
//          "【child】 : 子组件   【Widget】\n"
//          "【elevation】 : 阴影深   【double】\n"
//          "【shadowColor】 : 阴影颜色   【Color】\n"
//          "【color】: 颜色    【Color】",
//    }

class PhysicalShapeDemo extends StatelessWidget {
  const PhysicalShapeDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: PhysicalShape(
          shadowColor: Colors.orange,
          elevation: 3,
          child: Image.asset(
            'assets/images/caver.webp',
            fit: BoxFit.cover,
          ),
          clipBehavior: Clip.hardEdge,
          clipper: const ShapeBorderClipper(
            shape: CircleBorder(side: BorderSide.none),
          ),
          color: Colors.deepPurpleAccent),
    );
  }
}
