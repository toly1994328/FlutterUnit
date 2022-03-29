import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com
/// 说明: 294 SizeChangedLayoutNotifier 尺寸变化通告  使用 SizeChangedLayoutNotifier 可以在子组件布局区域发生变化后，发出通知。使用NotificationListener可以进行监听。
//    {
//      "widgetId": 294,
//      "name": '基本使用',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 组件   【Widget】",
//    }

class SizeChangedLayoutNotifierDemo extends StatefulWidget {
  const SizeChangedLayoutNotifierDemo({Key? key}) : super(key: key);

  @override
  _SizeChangedLayoutNotifierDemoState createState() => _SizeChangedLayoutNotifierDemoState();
}

class _SizeChangedLayoutNotifierDemoState extends State<SizeChangedLayoutNotifierDemo> {
  @override
  Widget build(BuildContext context) {
    return NotificationListener<SizeChangedLayoutNotification>(
      onNotification: _onNotification,
      child: const ChangeableBox(),
    );
  }

  bool _onNotification(SizeChangedLayoutNotification notification) {
    print('---------SizeChangedLayoutNotification------');
    return false;
  }
}

class ChangeableBox extends StatefulWidget {
  const ChangeableBox({Key? key}) : super(key: key);

  @override
  _ChangeableBoxState createState() => _ChangeableBoxState();
}

class _ChangeableBoxState extends State<ChangeableBox> {
  double width = 40;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizeChangedLayoutNotifier(
          child: Container(
            width: width,
            height: 100,
            color: Colors.blue,
          ),
        ),
        Slider(
          max: 200,
          min: 20,
          divisions: 10,
          value: width,
          onChanged: _changeWidth,
        )
      ],
    );
  }

  void _changeWidth(double value) {
    setState(() {
      width = value;
    });
  }
}
