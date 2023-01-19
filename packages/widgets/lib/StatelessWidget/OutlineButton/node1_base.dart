import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 27,
//      "priority": 1,
//      "name": "OutlineButton点击事件",
//      "subtitle": "【textColor】: 子组件文字颜色   【Color】\n"
//          "【splashColor】: 水波纹颜色   【Color】\n"
//          "【highlightColor】: 长按高亮色   【Color】\n"
//          "【highlightedBorderColor】: 高亮时框色   【Color】\n"
//          "【child】: 子组件   【Widget】\n"
//          "【padding】: 内边距   【EdgeInsetsGeometry】\n"
//          "【borderSide】: 边线   【BorderSide】\n"
//          "【onPressed】: 点击事件   【Function】",
//    }

class CustomOutlineButton extends StatelessWidget {
  const CustomOutlineButton({Key? key}) : super(key: key);

  final String info =
      'OutlineButton 按钮于 Flutter3.0 退出历史舞台。取代者为 OutlinedButton 按钮。';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue.withOpacity(0.1),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: Text(info),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return OutlineButton(//边线按钮
  //     onPressed: () {},
  //     child: const Text("OutlineButton"),
  //     padding: const EdgeInsets.all(8),
  //     splashColor: Colors.green,
  //     highlightColor: Colors.orangeAccent,
  //     highlightedBorderColor: Colors.grey,
  //     textColor: const Color(0xff000000),
  //     borderSide: const BorderSide(color: Color(0xff0A66F8), width: 2),
  //   );
  // }
}
