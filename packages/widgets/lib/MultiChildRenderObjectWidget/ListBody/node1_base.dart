import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/8/2
/// contact me by email 1981462002@qq.com
/// 说明: 342 ListBody 列表体 将若干子组件按照轴向进行排列，可设置的属性很少，一般很少使用，而选择使用ListVIew。

//    {
//      "widgetId": 342,
//      "name": "ListView的基本使用",
//      "priority": 1,
//      "subtitle": "【mainAxis】 : 主轴方向   【Axis】\n"
//          "【reverse】: 是否反向   【bool】\n"
//          "【children】: 子组件集   【List<Widget>】",
//    }

class ListBodyDemo extends StatelessWidget {
  const ListBodyDemo({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView(
          children: <Widget>[
            ListBody(
              mainAxis: Axis.vertical,
              reverse: false,
              children: <Widget>[
                Container(color: Colors.red,  height: 50.0,),
                Container(color: Colors.orange, height: 50.0,),
                Container(color: Colors.yellow,  height: 50.0,),
              ],
            ),
            Container(color: Colors.green,  height: 80.0,),
            ListBody(
              mainAxis: Axis.vertical,
              reverse: false,
              children: <Widget>[
                Container(color: Colors.blue, height: 50.0,),
                Container(color: Colors.indigo,  height: 50.0,),
                Container(color: Colors.purple, height: 50.0,),
              ],
            )
          ]
      ),
    );
  }
}
