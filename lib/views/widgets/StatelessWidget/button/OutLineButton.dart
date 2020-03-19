import 'package:flutter/material.dart';
import 'package:flutter_unit/components/panel/panel.dart';

class OutlineButtonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      NodePanel(
          code: """class CustomOutlineButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlineButton(//边线按钮
      onPressed: () {},
      child: Text("OutlineButton"),
      padding: EdgeInsets.all(8),
      splashColor: Colors.green,
      highlightColor: Colors.orangeAccent,
      highlightedBorderColor: Colors.grey,
      textColor: Color(0xff000000),
      borderSide: BorderSide(color: Color(0xff0A66F8), width: 2),
    );
  }
}""",
          show: CustomOutlineButton(),
          text: "OutlineButton点击事件",
          subText:
              "【textColor】: 子组件文字颜色   【Color】\n"
              "【splashColor】: 水波纹颜色   【Color】\n"
              "【highlightColor】: 长按高亮色   【Color】\n"
                  "【highlightedBorderColor】: 高亮时框色   【Color】\n"
              "【child】: 子组件   【Widget】\n"
              "【padding】: 内边距   【EdgeInsetsGeometry】\n"

              "【borderSide】: 边线   【BorderSide】\n"
              "【onPressed】: 点击事件   【Function】"
      ),
    ]);
  }
}

class CustomOutlineButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlineButton(//边线按钮
      onPressed: () {},
      child: Text("OutlineButton"),
      padding: EdgeInsets.all(8),
      splashColor: Colors.green,
      highlightColor: Colors.orangeAccent,
      highlightedBorderColor: Colors.grey,
      textColor: Color(0xff000000),
      borderSide: BorderSide(color: Color(0xff0A66F8), width: 2),
    );
  }
}
