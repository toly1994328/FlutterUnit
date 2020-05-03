
import 'package:flutter/material.dart';
import '../../../dialogs/dialog_about.dart';

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
  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      buttonHeight: 40,
      buttonPadding: EdgeInsets.only(left: 15,right: 15),
      children: <Widget>[
        RaisedButton(
            color: Colors.blue,
            child: Text("Raised"),
            onPressed: () => DialogAbout.show(context)),
        OutlineButton(
            child: Text("Outline"),
            onPressed: () => DialogAbout.show(context)),
        FlatButton(
          color: Colors.blue,
          onPressed: () => DialogAbout.show(context),
          child: Text("Flat"),
        )
      ],
    );
  }
}
