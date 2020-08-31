import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-23
/// contact me by email 1981462002@qq.com
/// 说明: 319 Directionality  定向性 为后代改变有textDirection属性的组件统一设置属性值,也可以通过Directionality.of(context)获取当前textDirection默认属性。
//    {
//      "widgetId": 319,
//      "name": "Directionality基本使用",
//      "priority": 1,
//      "subtitle": "【textDirection】 : 文字排列方向   【TextDirection】\n"
//          "【child】 : 子组件   【Widget】",
//    }
class DirectionalityDemo extends StatefulWidget {
  @override
  _DirectionalityDemoState createState() => _DirectionalityDemoState();
}

class _DirectionalityDemoState extends State<DirectionalityDemo> {
  TextDirection _textDirection = TextDirection.rtl;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: _textDirection,
      child: Container(
        padding: EdgeInsets.all(8),
        width: 250,
        color: Colors.grey.withAlpha(33),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                'A widget that determines the ambient directionality of text and text direction sensitive render objects.'),
            _buildSwitch(),
            Text(
                'The text direction from the closest instance of this class that encloses the given context.'),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitch() {
    return Row(
            children: [
              Switch(
                value: _textDirection == TextDirection.rtl,
                onChanged: (v) {
                  setState(() {
                    _textDirection =
                        v ? TextDirection.rtl : TextDirection.ltr;
                  });
                },
              ),
              Text(
                _textDirection.toString(),
                style: TextStyle(color: Colors.blue, fontSize: 18),
              )
            ],
          );
  }
}
