import 'package:flutter/cupertino.dart';

/// create by 张风捷特烈 on 2020/6/30
/// contact me by email 1981462002@qq.com
/// 说明:
///
//    {
//      "widgetId": 262,
//      "name": 'iOS页签基本使用',
//      "priority": 1,
//      "subtitle":
//          "【children】 : 组件Map   【Map<T, Widget>】\n"
//          "【onValueChanged】 : 值改变回调   【ValueChanged<T>】\n"
//          "【groupValue】 : 选中值   【T】\n"
//          "【padding】 : 内边距   【EdgeInsetsGeometry】",
//    }
class CupertinoSegmentedControlDemo extends StatefulWidget {
  const CupertinoSegmentedControlDemo({Key? key}) : super(key: key);

  @override
  _CupertinoSegmentedControlDemoState createState() =>
      _CupertinoSegmentedControlDemoState();
}

class _CupertinoSegmentedControlDemoState
    extends State<CupertinoSegmentedControlDemo> {
  int _value = 1;

  @override
  Widget build(BuildContext context) {
    return CupertinoSegmentedControl<int>(
      groupValue: _value,
      onValueChanged: _onValueChanged,
      padding: const EdgeInsets.only(top: 20),
      children: const {
        1: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Text("混沌战士"),
        ),
        2: Text("青眼白龙"),
        3: Text("黑魔术士"),
      },
    );
  }

  void _onValueChanged(int value) {
    setState(() {
      _value=value;
    });
  }
}
