import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/7/22
/// contact me by email 1981462002@qq.com
/// 说明: 218 CupertinoNavigationBarBackButton Cupertino风格的导航栏返回按钮,可指定颜色和点击事件,一般不单独使用。
//    {
//      "widgetId": 218,
//      "name": "返回按钮基本使用",
//      "priority": 1,
//      "subtitle": "【onPressed】 : 点击事件   【VoidCallback】\n"
//          "【color】: 颜色    【Color】",
//    }

class CupertinoNavigationBarBackButtonDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CupertinoNavigationBarBackButton(
        color: Colors.deepPurpleAccent,
        onPressed: ()=>Navigator.of(context).pop(),
      ),
    );
  }
}
