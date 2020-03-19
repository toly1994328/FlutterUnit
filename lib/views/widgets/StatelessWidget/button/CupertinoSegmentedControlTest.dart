import 'dart:math';

import 'package:flutter/cupertino.dart';


//class CupertinoButtonTest extends StatelessWidget {
//  CupertinoButtonTest({Key key}) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return  CupertinoSegmentedControl(
//      onValueChanged: (v) {
//        print(object)
//      },
//      pressedColor: Color(0xff7c1c25),
//      borderColor: Color(0xffac172a),
//      selectedColor: Color(0xffac172a),
//      groupValue: value,
//      children: {
//        'a': Container(
//            alignment: Alignment.center,
//            width: 130.0,
//            child: Text('a')
//        ),
//        'c': Text('C'),
//        'b': Text('B'),
//      },
//    );
//}
//
class CupertinoSegmentedControlTest extends StatefulWidget {
  _Demo createState() => _Demo();
}

class _Demo extends State<CupertinoSegmentedControlTest> {
  String value = 'Java';
  @override
  Widget build(BuildContext context) {
    return  CupertinoSegmentedControl(
      onValueChanged: (v) {
        this.setState(() {
          value = v;
        });
      },
      pressedColor: CupertinoColors.activeGreen,//点击时颜色
      borderColor: CupertinoColors.inactiveGray,//边框颜色
      selectedColor: CupertinoColors.activeBlue,//选中的颜色
      groupValue: value,//当前值
      children: {//对于组件
        'Java': Container(
            alignment: Alignment.center,
            width: 100.0,
            child: Text('Java')
        ),
        'Kotlin': Text('Kotlin'),
        'Dart': Text('Dart'),
      },
    );
  }
}
