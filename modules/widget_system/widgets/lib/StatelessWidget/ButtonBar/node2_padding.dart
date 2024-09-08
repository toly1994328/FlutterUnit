
import 'package:flutter/material.dart';
import 'package:widgets/utils/dialog_about.dart';


/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 29,
//      "priority": 2,
//      "name": "ButtonBar边距和高",
//      "subtitle": "【buttonPadding】: 内边距   【EdgeInsetsGeometry】\n"
//          "【buttonHeight】: 高   【double】",
//    }
class PaddingButtonBar extends StatelessWidget {
  const PaddingButtonBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      buttonHeight: 40,
      buttonPadding: const EdgeInsets.only(left: 15,right: 15),
      children: <Widget>[
        ElevatedButton(
            child: const Text("ElevatedButton"),
            onPressed: () => DialogAbout.show(context)),
        OutlinedButton(
            child: const Text("Outlined"),
            onPressed: () => DialogAbout.show(context)),
        TextButton(
          onPressed: () => DialogAbout.show(context),
          child: const Text("TextButton"),
        )
      ],
    );
  }
}
