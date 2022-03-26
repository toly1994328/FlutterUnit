import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-23
/// contact me by email 1981462002@qq.com
/// 说明: 296 PhysicalModel 物理模块 可以让子组件按照圆形、方行进行剪裁,并且可以指定背景色、圆角、影深、阴影颜色、剪切行为。
//    {
//      "widgetId": 296,
//      "name": "PhysicalModel基本使用",
//      "priority": 1,
//      "subtitle": "【clipBehavior】 : 裁剪行为   【Clip】\n"
//          "【borderRadius】 : 圆角   【BorderRadius】\n"
//          "【child】 : 子组件   【Widget】\n"
//          "【elevation】 : 阴影深   【double】\n"
//          "【shadowColor】 : 阴影颜色   【Color】\n"
//          "【shape】 : 形状   【BoxShape】\n"
//          "【color】: 颜色    【Color】",
//    }
class PhysicalModelDemo extends StatelessWidget{
  const PhysicalModelDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: 150,
          height: 150,
          child: PhysicalModel(
              shadowColor: Colors.orange,
              elevation: 3,
              child: Image.asset(
                'assets/images/caver.webp',
                fit: BoxFit.cover,
              ),
              clipBehavior: Clip.hardEdge,
              shape: BoxShape.circle,
              color: Colors.deepPurpleAccent),
        ),

        SizedBox(
          width: 150,
          height: 150,
          child: PhysicalModel(
              shadowColor: Colors.orange,
              elevation: 3,
              child: Image.asset(
                'assets/images/caver.webp',
                fit: BoxFit.cover,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              clipBehavior: Clip.hardEdge,
              shape: BoxShape.rectangle,
              color: Colors.deepPurpleAccent),
        ),
      ],
    );
  }

}
