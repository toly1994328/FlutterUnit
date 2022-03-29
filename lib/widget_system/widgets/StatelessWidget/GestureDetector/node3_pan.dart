import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 146,
//      "name": 'GestureDetector的Pan事件',
//      "priority": 3,
//      "subtitle":
//          "【onPanDown】 : 按下回调   【GestureDragDownCallback】\n"
//          "【onPanEnd】 : 拖动结束   【GestureDragEndCallback】\n"
//          "【onPanStart】 : 开始拖动   【GestureDragStartCallback】\n"
//          "【onPanUpdate】 : 拖动更新   【GestureDragUpdateCallback】\n"
//          "【onPanCancel】 : 拖动取消   【GestureDragCancelCallback】",
//    }
class PanGestureDetector extends StatefulWidget {
  const PanGestureDetector({Key? key}) : super(key: key);

  @override
  _PanGestureDetectorState createState() => _PanGestureDetectorState();
}

class _PanGestureDetectorState extends State<PanGestureDetector> {
  String _info = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (detail) => setState(() => _info =
      'onPanDown:\n相对落点:${detail.localPosition}\n绝对落点:${detail.globalPosition}'),
      onPanEnd: (detail) => setState(() => _info =
      'onPanEnd:\n初速度:${detail.primaryVelocity}\n最终速度:${detail.velocity}'),
      onPanUpdate: (detail) => setState(() => _info =
      'onPanUpdate:\n相对落点:${detail.localPosition}\n绝对落点:${detail.globalPosition}'),
      onPanStart: (detail) => setState(() => _info =
      'onPanStart:\n相对落点:${detail.localPosition}\n绝对落点:${detail.globalPosition}'),
      onPanCancel: () => setState(() => _info = 'onTapCancel'),
      child: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          width: 300,
          height: 300 * 0.618,
          color: Colors.grey.withAlpha(33),
          child: Text(
            _info,
            style: const TextStyle(fontSize: 18, color: Colors.blue),
          ),
        ),
      ),
    );
  }
}
