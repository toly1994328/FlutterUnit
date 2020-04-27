import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/27
/// contact me by email 1981462002@qq.com
/// 说明: 

//    {
//      "widgetId": 168,
//      "name": 'Theme的用法',
//      "priority": 2,
//      "subtitle":
//          "使用Theme,可以指定非常多的属性作为主题,这些属性将应用于所有的后代组件，如指定字体、滑块、卡片、文字、分割线、按钮等属性。",
//    }
class CustomTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
            cardTheme: CardTheme(color: Colors.red, elevation: 4),
            dividerTheme: DividerThemeData(
                color: Colors.blue,
                thickness: 2
            ),
            sliderTheme: SliderThemeData(
              thumbColor: Colors.red,
              activeTrackColor: Colors.green,
              inactiveTrackColor: Colors.grey,
            )),
        child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              Card(
                child: Container(
                  width: 50,
                  height: 50,
                  color: Colors.transparent,
                ),
              ),
              Container(
                  width: 150,
                  child: Slider(value: 0.8, onChanged: (v) => {})),
              Container(  width: 150,child: Divider())
            ]));
  }
}