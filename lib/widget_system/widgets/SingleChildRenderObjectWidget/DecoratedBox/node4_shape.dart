import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/30
/// contact me by email 1981462002@qq.com
/// 说明: 
//    {
//      "widgetId": 70,
//      "name": 'DecoratedBox形状装饰',
//      "priority": 4,
//      "subtitle": "通过ShapeDecoration对象可指定边线形状\n",
//    }
class ShapeDecorationDemo extends StatelessWidget {
  const ShapeDecorationDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: ShapeDecoration(
          shadows: [
            BoxShadow(
                color: Colors.orangeAccent,
                offset: Offset(0, 0),
                blurRadius: 2,
                spreadRadius: 1),
          ],
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                'assets/images/wy_200x300.webp',
              )),
          shape: CircleBorder(
            side: BorderSide(width: 1.0, color: Colors.orangeAccent),
          )),
      child: SizedBox(
        height: 100,
        width: 100,
        child: Icon(
          Icons.ac_unit,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }
}