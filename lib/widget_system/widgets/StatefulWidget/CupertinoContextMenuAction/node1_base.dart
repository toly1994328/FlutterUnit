/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 144,
//      "name": 'CupertinoContextMenuAction基本使用',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 子组件   【Widget】\n"
//          "【isDefaultAction】 : 是否默认选中  【bool】\n"
//          "【trailingIcon】 : 尾部  【bool】\n"
//          "【onPressed】 : 点击事件  【Function()】",
//    }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCupertinoContextMenuAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: 200,
          margin: EdgeInsets.all(5),
          child: CupertinoContextMenuAction(
              trailingIcon: CupertinoIcons.settings,
              isDefaultAction: true,
              onPressed: () =>  Navigator.of(context).pushNamed('AboutMePage'),
              child: Text('张风捷特烈')),
        ),
        Container(
          width: 200,
          margin: EdgeInsets.all(5),
          child: CupertinoContextMenuAction(
              trailingIcon: CupertinoIcons.home,
              isDefaultAction: false,
              onPressed: () =>  Navigator.of(context).pushNamed('AboutMePage'),
              child: Text('百里·巫缨')),
        ),
      ],
    );
  }
}
