import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020/4/27
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 10,
//      "priority": 1,
//      "name": "根据visible控制内部子组件的显隐情况",
//      "subtitle": "【visible】 : 是否显示  【bool】\n"
//          "【child】: 孩子   【Widget】\n"
//          "默认孩子隐藏时会失去原来所在区域。",
//    }
class CustomVisibility extends StatelessWidget {
  const CustomVisibility({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: [
        _buildVisibility(true),
        _buildVisibility(false),
      ],
    );
  }

  Widget _buildVisibility(bool visible) {
    Widget box = Container(
      height: 30,
      width: 30,
      color: Colors.blue,
    );
    return Container(
      width: 150,
      height: 150 * 0.618,
      color: Colors.cyanAccent.withAlpha(33),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          box,
          Visibility(
              visible: visible,
              child: Container(
                alignment: Alignment.center,
                height: 80 * 0.618,
                width: 80,
                color: Colors.red,
                child: const Text(
                  "visible\ntrue",
                  style: TextStyle(fontSize: 20),
                ),
              )),
          box,
        ],
      ),
    );
  }
}
