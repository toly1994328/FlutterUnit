import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-04-19
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 71,
//      "name": 'Offstage基本使用',
//      "priority": 1,
//      "subtitle": "【child】 : 孩子组件   【Widget】\n"
//          "【offstage】 : 是否消失   【bool】",
//    }
class CustomOffstage extends StatefulWidget {
  const CustomOffstage({Key? key}) : super(key: key);

  @override
  _CustomOffstageState createState() => _CustomOffstageState();
}

class _CustomOffstageState extends State<CustomOffstage> {
  bool _off = false;

  @override
  Widget build(BuildContext context) {
    Widget radBox = Container(
      height: 50,
      width: 60,
      color: Colors.red,
      child: Switch(
          value: _off,
          onChanged: (v) => setState(() => _off = v)),
    );

    return SizedBox(
      width: 250,
      height: 200,
      child: Row(
        children: <Widget>[radBox, _buildOffStage(), radBox],
      ),
    );
  }

  Widget _buildOffStage() => Offstage(
      offstage: _off,
      child: Container(
        alignment: Alignment.center,
        height: 100,
        width: 100,
        color: Colors.blue,
        child: const Text(
          "Offstage",
          style: TextStyle(fontSize: 20),
        ),
      ));
}
