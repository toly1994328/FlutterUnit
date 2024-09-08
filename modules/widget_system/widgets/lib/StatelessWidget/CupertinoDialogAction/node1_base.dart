import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/7/22
/// contact me by email 1981462002@qq.com
/// 说明: 352 CupertinoDialogAction 0 一个简单的按钮，通常用于CupertinoAlertDialog中，一般不单独使用。
//    {
//      "widgetId": 352,
//      "name": "CupertinoDialogAction基本使用",
//      "priority": 1,
//      "subtitle": "【isDefaultAction】 : 是否是默认性操作   【bool】\n"
//          "【isDestructiveAction】 : 是否是毁灭性操作   【bool】\n"
//          "【textStyle】: 文字样式   【TextStyle】\n"
//          "【onPressed】: 点击事件   【VoidCallback】\n"
//          "【child】: 子组件   【Widget】",
//    }
class CupertinoDialogActionDemo extends StatelessWidget {
  const CupertinoDialogActionDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CupertinoDialogAction(
          isDestructiveAction: false,
          onPressed: () => _toast(context),
          child: const Text('CupertinoDialogAction'),
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () => _toast(context),
          child: const Text('CupertinoDialogAction'),
        ),
      ],
    );
  }

  void _toast(BuildContext context) {
    SnackBar snackBar = SnackBar(
      backgroundColor: Theme.of(context).primaryColor,
      content: const Text('CupertinoDialogAction'),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);

  }
}
