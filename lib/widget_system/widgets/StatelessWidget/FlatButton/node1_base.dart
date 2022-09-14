import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-03-26
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 25,
//      "priority": 1,
//      "name": "FlatButton点击事件",
//      "subtitle": "【color】: 颜色   【Color】\n"
//          "【splashColor】: 水波纹颜色   【Color】\n"
//          "【child】: 子组件   【Widget】\n"
//          "【textColor】: 子组件文字颜色   【Color】\n"
//          "【highlightColor】: 长按高亮色   【Color】\n"
//          "【padding】: 内边距   【EdgeInsetsGeometry】\n"
//          "【onPressed】: 点击事件   【Function】",
//    }

class CustomFlatButton extends StatelessWidget {
  const CustomFlatButton({Key? key}) : super(key: key);

  final String info =
      'FlatButton 按钮于 Flutter3.3 退出历史舞台。取代者为 ElevatedButton 按钮。';

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
//   return FlatButton(
//     onPressed: ()=>{},
//     padding: const EdgeInsets.all(8),
//     splashColor: Colors.green,
//     child: const Text("FlatButton"),
//     textColor: const Color(0xffFfffff),
//     color: Colors.blue,
//     highlightColor: const Color(0xffF88B0A),
//   );
// }
}
