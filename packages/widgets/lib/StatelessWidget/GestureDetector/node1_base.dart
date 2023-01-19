import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/27
/// contact me by email 1981462002@qq.com
/// 说明: 

/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 146,
//      "name": 'GestureDetector基本事件',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 子组件   【Widget】\n"
//          "【onTap】 : 点击事件   【Function()】\n"
//          "【onDoubleTap】 : 双击事件   【GestureTapCallback】\n"
//          "【onLongPress】 : 长按事件   【GestureLongPressCallback】",
//    }

class CustomGestureDetector extends StatefulWidget {
  const CustomGestureDetector({Key? key}) : super(key: key);

  @override
  _CustomGestureDetectorState createState() => _CustomGestureDetectorState();
}

class _CustomGestureDetectorState extends State<CustomGestureDetector> {
  String _info = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _info = 'onTap'),
      onDoubleTap: () => setState(() => _info = 'onDoubleTap'),
      onLongPress: () => setState(() => _info = 'onLongPress'),
      child: Container(
        alignment: Alignment.center,
        width: 300,
        height: 300 * 0.4,
        color: Colors.grey.withAlpha(33),
        child: Text(
          _info,
          style: const TextStyle(fontSize: 18, color: Colors.blue),
        ),
      ),
    );
  }
}