import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/6/30
/// contact me by email 1981462002@qq.com
/// 说明:
///
//    {
//      "widgetId": 262,
//      "name": '基本使用',
//      "priority": 1,
//      "subtitle":
//          "【children】 : 组件Map   【Map<T, Widget>】\n"
//          "【onValueChanged】 : 最小值   【ValueChanged<T>】\n"
//          "【groupValue】 : 选中值   【T】\n"
//          "【padding】 : 内边距   【EdgeInsetsGeometry】",
//    }
class CupertinoSegmentedControlDemo extends StatefulWidget {
  @override
  _CupertinoSegmentedControlDemoState createState() =>
      _CupertinoSegmentedControlDemoState();
}

class _CupertinoSegmentedControlDemoState
    extends State<CupertinoSegmentedControlDemo> {
  var _value = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CupertinoSegmentedControl<int>(
        groupValue: _value,
        onValueChanged: _onValueChanged,
        padding: EdgeInsets.only(top: 20),
        children: {
          1: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Text("混沌战士"),
          ),
          2: Text("青眼白龙"),
          3: Text("黑魔术士"),
        },
      ),
    );
  }

  void _onValueChanged(int value) {
    setState(() {
      _value=value;
    });
  }
}
