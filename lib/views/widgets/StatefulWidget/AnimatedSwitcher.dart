import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-23
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 116,
//      "name": 'AnimatedSwitcher基本使用',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 孩子组件   【Widget】\n"
//          "【duration】 : 动画时长  【Duration】\n"
//          "【switchOutCurve】 : 切出曲线  【Curves】\n"
//          "【switchInCurve】 : 切入曲线  【Curves】\n"
//          "【switchInCurve】 : 切入曲线  【Curves】\n"
//          "【transitionBuilder】 : 动画构造器  【Widget Function(Widget, Animation<double>)】",
//    }

class CustomAnimatedSwitcher extends StatefulWidget {
  @override
  _CustomAnimatedSwitcherState createState() => _CustomAnimatedSwitcherState();
}

class _CustomAnimatedSwitcherState extends State<CustomAnimatedSwitcher> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) =>
                ScaleTransition(
                    child: RotationTransition(turns: animation, child: child),
                    scale: animation),
            child: Text(
              '$_count',
              key: ValueKey<int>(_count),
              style: Theme.of(context).textTheme.display3,
            ),
          ),
          RaisedButton(
            child: const Text('Increment'),
            onPressed: () => setState(() => _count += 1),
          ),
        ],
      ),
    );
  }
}
