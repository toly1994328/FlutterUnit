
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/7/22
/// contact me by email 1981462002@qq.com
/// 说明: 293 MouseRegion 用于鼠标事件监听的组件,通常用于桌面和Web平台，可监听鼠标的移入、移除、移动事件。
//    {
//      "widgetId": 293,
//      "name": "MouseRegion基本使用",
//      "priority": 1,
//      "subtitle": "【onEnter】 : 移入事件   【PointerEnterEventListener】\n"
//          "【onHover】: 移动事件    【PointerHoverEventListener】\n"
//          "【onExit】: 移出事件    【PointerExitEventListener】",
//    }

class MouseRegionDemo extends StatefulWidget {
  const MouseRegionDemo({Key? key}) : super(key: key);

  @override
  _MouseRegionDemoState createState() => _MouseRegionDemoState();
}

class _MouseRegionDemoState extends State<MouseRegionDemo> {
  int _enterCounter = 0;
  int _exitCounter = 0;
  double x = 0.0;
  double y = 0.0;
  void _incrementEnter(PointerEvent details) {
    setState(() {
      _enterCounter++;
    });
  }
  void _incrementExit(PointerEvent details) {
    setState(() {
      _exitCounter++;
    });
  }
  void _updateLocation(PointerEvent details) {
    setState(() {
      x = details.position.dx;
      y = details.position.dy;
    });
  }
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tight(const Size(300.0, 200.0)),
      child: MouseRegion(
        onEnter: _incrementEnter,
        onHover: _updateLocation,
        onExit: _incrementExit,
        child: Container(
          color: Colors.lightBlueAccent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('你的鼠标移入移除信息:'),
              Text(
                '$_enterCounter Entries\n$_exitCounter Exits',
                style: Theme.of(context).textTheme.headline4,
              ),
              Text(
                'The cursor is here: (${x.toStringAsFixed(2)}, ${y.toStringAsFixed(2)})',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
