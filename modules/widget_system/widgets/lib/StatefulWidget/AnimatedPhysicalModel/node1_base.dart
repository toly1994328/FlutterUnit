import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-23
/// contact me by email 1981462002@qq.com
/// 说明: 225 相关属性变化时具有动画效果的PhysicalModel组件，本质是PhysicalModel和动画结合的产物。可指定阴影、影深、圆角、动画时长、结束回调等属性。
//    {
//      "widgetId": 225 ,
//      "name": 'AnimatedPhysicalModel基本使用',
//      "priority": 1,
//      "subtitle":
//          "【color】 : 背景色   【Color】\n"
//          "【duration】 : 动画时长   【Duration】\n"
//          "【onEnd】 : 动画结束回调   【Function()】\n"
//          "【curve】 : 动画曲线   【Duration】\n"
//          "【shape】 : 形状   【BoxShape】\n"
//          "【elevation】 : 影深   【double】\n"
//          "【borderRadius】 : 圆角   【BorderRadius】\n"
//          "【shadowColor】 : 阴影色   【Color】\n"
//          "【child】 : 子组件   【Widget】",
//    }
class AnimatedPhysicalModelDemo extends StatefulWidget {
  const AnimatedPhysicalModelDemo({Key? key}) : super(key: key);

  @override
  _AnimatedPhysicalModelDemoState createState() =>
      _AnimatedPhysicalModelDemoState();
}

class _AnimatedPhysicalModelDemoState extends State<AnimatedPhysicalModelDemo> {
  bool flag = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSwitch(),
        SizedBox(
          width: 150,
          height: 150,
          child: AnimatedPhysicalModel(
            duration: const Duration(seconds: 2),
            curve: Curves.fastOutSlowIn,
            shadowColor: flag?Colors.orange:Colors.purple,
            elevation: flag?10:5,
            child: Image.asset(
              'assets/images/caver.webp',
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.all(Radius.circular(flag? 10:75)),
            clipBehavior: Clip.hardEdge,
            shape: BoxShape.rectangle,
            color: Colors.deepPurpleAccent,
            onEnd: () => print('----onEnd---'),
          ),
        ),
      ],
    );
  }

  Widget _buildSwitch() => Switch(
        value: flag,
        onChanged: (v) {
          setState(() {
            flag = v;
          });
        });
}