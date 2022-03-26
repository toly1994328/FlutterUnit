import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 141,
//      "name": 'SnackBarAction基本使用',
//      "priority": 1,
//      "subtitle":
//          "【label】 :  标签  【String】\n"
//          "【textColor】 : 文字颜色   【Color】\n"
//          "【disabledTextColor】 : 文字失效色   【Color】\n"
//          "【onPressed】 : 点击回调  【Function()】",
//    }
class CustomSnackBarAction extends StatelessWidget {
  const CustomSnackBarAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SnackBarAction(
      disabledTextColor: Colors.red,
      textColor: Colors.blue,
      label: '确定',
      onPressed: () => print('onPressed'),
    );
  }
}
