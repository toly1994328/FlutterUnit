import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/7/21
/// contact me by email 1981462002@qq.com
/// 说明: 211 MaterialBanner Material风格的横幅组件，支持左中右或左中下结构，可指定边距背景色等。

//    {
//      "widgetId": 211,
//      "name": 'MaterialBanner一行的使用',
//      "priority": 1,
//      "subtitle": "【content】 : 中间组件   【Widget】\n"
//          "【leading】: 左侧组件   【Widget】\n"
//          "【actions】: 右侧组件列表   【List<Widget>】\n"
//          "【padding】: 内边距   【EdgeInsetsGeometry】\n"
//          "【forceActionsBelow】: 是否按钮在下方   【bool】\n"
//          "【backgroundColor】: 背景色    【Color】",
//    }
class MaterialBannerDemo extends StatelessWidget {
  const MaterialBannerDemo({Key? key}) : super(key: key);

  final String info = 'Welcome to Flutter Unit!';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        MaterialBanner(
          content: Text(
            info,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.purple,
          leading: const Icon(Icons.info, color: Colors.lightBlueAccent),
          padding: const EdgeInsetsDirectional.only(start: 16.0, top: 2.0),
          forceActionsBelow: false,
          // 默认false
          actions: const <Widget>[
            Text(
              'I KNOW',
              style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            )
          ],
        )],
    );
  }

}
