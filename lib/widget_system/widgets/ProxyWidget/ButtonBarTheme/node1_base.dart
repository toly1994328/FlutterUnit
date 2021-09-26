import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/7/22
/// contact me by email 1981462002@qq.com
/// 说明: 338 ButtonBarTheme 5 主要用于为后代的ButtonBar组件统一设置默认属性,也可以通过该组件获取默认ButtonBarTheme的属性。
//    {
//      "widgetId": 338,
//      "name": "ButtonBarTheme基本使用",
//      "priority": 1,
//      "subtitle": "可指定ButtonBarThemeData数据属性为【后代】的ButtonBar组件设置默认样式，如对齐方式、样式、边距等。也可以用ButtonBarTheme.of获取ButtonBar的主题属性。",
//    }

class ButtonBarThemeDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ButtonBarTheme(
        child: TempButtonBar(),
        data: ButtonBarTheme.of(context).copyWith(
            alignment: MainAxisAlignment.center,
            buttonPadding: EdgeInsets.symmetric(horizontal: 6),
            overflowDirection: VerticalDirection.up,
            buttonMinWidth: 150,
            buttonHeight: 30,
            buttonTextTheme: ButtonTextTheme.primary));
  }
}

class TempButtonBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        RaisedButton(
            color: Colors.blue, child: Text("1.Raised"), onPressed: () {}),
        OutlineButton(child: Text("2.Outline"), onPressed: () {}),
        FlatButton(
          color: Colors.blue,
          onPressed: () {},
          child: Text("3.Flat"),
        )
      ],
    );
  }
}
