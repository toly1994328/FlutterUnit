import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 140,
//      "name": 'SnackBar基本使用',
//      "priority": 1,
//      "subtitle":
//          "【content】 : 中间内容组件   【Widget】\n"
//          "【action】 : 右侧按钮   【SnackBarAction】\n"
//          "【duration】 : 持续时长   【Widget】\n"
//          "【backgroundColor】 : 背景色   【Color】\n"
//          "【elevation】 : 影深   【double】\n"
//          "【shape】 : 形状   【ShapeBorder】\n"
//          "【onVisible】 : 显示时回调  【Function()】",
//    }
class CustomSnackBar extends StatefulWidget {
  @override
  _CustomSnackBarState createState() => _CustomSnackBarState();
}

class _CustomSnackBarState extends State<CustomSnackBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: FlatButton(
            color: Colors.blue,
            onPressed: () =>
                Scaffold.of(context).showSnackBar(_buildSnackBar()),
            child: Text(
              '点我弹出SnackBar',
              style: TextStyle(color: Colors.white),
            )));
  }

  Widget _buildSnackBar() {
    return SnackBar(
      elevation: 3,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      content: Text('Wellcome to for join Flutter Unit!'),
      duration: Duration(seconds: 3),
      //持续时间
      backgroundColor: Colors.red,
      onVisible: () => print('onVisible'),
      action: SnackBarAction(
          textColor: Colors.white, label: '确定', onPressed: () {}),
    );
  }
}
