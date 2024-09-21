import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/7/22
/// contact me by email 1981462002@qq.com

class CupertinoSlidingSegmentedControlDemo extends StatefulWidget {
  const CupertinoSlidingSegmentedControlDemo({Key? key}) : super(key: key);

  @override
  _CupertinoSlidingSegmentedControlDemoState createState() =>
      _CupertinoSlidingSegmentedControlDemoState();
}

class _CupertinoSlidingSegmentedControlDemoState
    extends State<CupertinoSlidingSegmentedControlDemo> {
  int _value = 1;

  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl(
      groupValue: _value,
      onValueChanged: _onValueChanged,
      thumbColor: Colors.amberAccent,
      backgroundColor: Colors.green.withAlpha(99),
      padding: const EdgeInsets.all(5),
      children: const {
        1: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Text("混沌战士"),
        ),
        2: Text("青眼白龙"),
        3: Text("黑魔导"),
      },
    );
  }

  void _onValueChanged(int? value) {
    if(value==null) return;
    setState(() {
      _value=value;
    });
  }
}
