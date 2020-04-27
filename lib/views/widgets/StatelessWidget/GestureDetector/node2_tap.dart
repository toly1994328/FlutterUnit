import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/27
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 146,
//      "name": 'GestureDetector详情信息',
//      "priority": 2,
//      "subtitle":
//          "【onTapDown】 : 按下回调   【Function(TapDownDetails)】\n"
//          "【onTapUp】 : 子组件   【Function(TapUpDetails)】\n"
//          "【onTapCancel】 : 点击取消   【Function()】",
//    }
class TapGestureDetector extends StatefulWidget {
  @override
  _TapGestureDetectorState createState() => _TapGestureDetectorState();
}

class _TapGestureDetectorState extends State<TapGestureDetector> {
  var _info = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (detail) => setState(() => _info =
      'onTapDown:\n相对落点:${detail.localPosition}\n绝对落点:${detail.globalPosition}'),
      onTapUp: (detail) => setState(() => _info =
      'onTapUp:\n相对落点:${detail.localPosition}\n绝对落点:${detail.globalPosition}'),
      onTapCancel: () => setState(() => _info = 'onTapCancel'),
      child: Container(
        alignment: Alignment.center,
        width: 300,
        height: 300 * 0.618,
        color: Colors.grey.withAlpha(33),
        child: Text(
          _info,
          style: TextStyle(fontSize: 18, color: Colors.blue),
        ),
      ),
    );
  }
}