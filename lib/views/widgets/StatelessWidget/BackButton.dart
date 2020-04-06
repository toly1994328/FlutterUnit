import 'package:flutter/material.dart';
import 'package:flutter_unit/components/panel/panel.dart';

class BackButtonPage extends StatelessWidget {
  BackButtonPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      NodePanel(
          code: """class CustomBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = [Colors.red,Colors.yellow,Colors.blue,Colors.green];
    return Wrap(
      spacing: 10,
      children: data.map((e)=>BackButton(
        color: e,
      )).toList()
    );
  }
}""",
          show: CustomBackButton(),
          text: "CupertinoButton点击事件",
          subText:
          "【color】: 颜色   【Color】\n"
              "【onPressed】: 点击事件   【Function】\n"
              "   onPressed为空会退出当前栈\n"
      ),
    ]);
  }
}


class CustomBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = [Colors.red,Colors.yellow,Colors.blue,Colors.green];
    return Wrap(
      spacing: 10,
      children: data.map((e)=>BackButton(
        color: e,
      )).toList()
    );
  }
}
