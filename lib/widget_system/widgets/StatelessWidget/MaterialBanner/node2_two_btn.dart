import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/7/21
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 211,
//      "name": 'MaterialBanner两行的使用',
//      "priority": 2,
//      "subtitle": "【contentTextStyle】: 中间位置样式   【TextStyle】\n"
//          "【leadingPadding】: 左侧组件边距    【EdgeInsetsGeometry】\n"
//          "当尾部组件数量大于1,该组件结构为左中下。",
//    }
class MaterialBannerDemoTwo extends StatelessWidget {
  final info =
      'A banner displays an important, succinct message, and provides actions for users to address. '
      'A user action is required for itto be dismissed.';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[MaterialBanner(
        content: Text(
          info,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
        leading: Icon(Icons.warning, color: Colors.yellow),
        padding: EdgeInsetsDirectional.only(start: 16.0, top: 2.0,end: 2),
        leadingPadding:EdgeInsetsDirectional.only(end: 16.0) ,
        actions: <Widget>[
          RaisedButton(
            color: Colors.white,
            onPressed: () {},
            child: Text(
              'I KNOW',
              style: TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
          ),

          RaisedButton(
            color: Colors.white,
            onPressed: () {},
            child: Text(
              'I IGNORE',
              style: TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
          ),
        ],
      )],
    );
  }

}
