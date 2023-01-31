import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widgets/utils/dialog_about.dart';


/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 132,
//      "name": 'CupertinoActionSheetAction基本使用',
//      "priority": 1,
//      "subtitle": "【child】 : 子组件   【Widget】\n"
//          "【isDefaultAction】 : 是否默认选中  【bool】\n"
//          "【onPressed】 : 点击事件  【Function()】",
//    }
class CustomCupertinoActionSheetAction extends StatelessWidget {
  const CustomCupertinoActionSheetAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(5),
          color: Colors.grey.withAlpha(33),
          child: CupertinoActionSheetAction(
              isDefaultAction: true,
              onPressed: () => DialogAbout.show(context),
              child: const Text('张风捷特烈')),
        ),
        Container(
          color: Colors.grey.withAlpha(33),
          margin: const EdgeInsets.all(5),
          child: CupertinoActionSheetAction(
              isDefaultAction: false,
              onPressed: () => DialogAbout.show(context),
              child: const Text('百里·巫缨')),
        ),
      ],
    );
  }
}
