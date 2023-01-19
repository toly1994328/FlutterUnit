import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com
/// 说明: 215 CheckedModeBanner  仅在debug运行模式中显示右上角角标，没什么太大卵用。在 MaterialApp 组件源码中有使用场景。
//    {
//      "widgetId": 215,
//      "name": 'CheckedModeBanner基本使用',
//      "priority": 1,
//      "subtitle": "【child】 : 组件   【Widget】",
//    }

class CheckedModeBannerDemo extends StatelessWidget {
  const CheckedModeBannerDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CheckedModeBanner(
      child: Container(
        alignment: Alignment.center,
        width: 250,
        height: 150,
        color: Theme.of(context).primaryColor,
        child: const Text(
          "CheckedModeBanner",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
