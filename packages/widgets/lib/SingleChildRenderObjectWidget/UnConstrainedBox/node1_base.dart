import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-04-19
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 81,
//      "name": 'UnConstrainedBox基本使用',
//      "priority": 1,
//      "subtitle": "【child】 : 孩子组件   【Widget】\n"
//          "【constrainedAxis】 : 仍受约束的轴*2   【Axis】\n"
//          "【alignment】 : 对齐方式   【AlignmentGeometry】",
//    }
class CustomUnConstrainedBox extends StatefulWidget {
  const CustomUnConstrainedBox({Key? key}) : super(key: key);

  @override
  _CustomUnConstrainedBoxState createState() => _CustomUnConstrainedBoxState();
}

class _CustomUnConstrainedBoxState extends State<CustomUnConstrainedBox> {
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      children: [_buildUnconstrainedBox(), _buildConstrainedAxis()],
    );
  }

  Widget _buildUnconstrainedBox() {
    Widget child = Container(
      color: Colors.cyanAccent,
      width: 60,
      height: 60,
      child: Switch(
        value: _value,
        onChanged: (v) {
          setState(() {
            _value = v;
          });
        },
      ),
    );

    return Column(
      children: <Widget>[
        Container(
          color: Colors.grey.withAlpha(22),
          width: 150,
          height: 100,
          child: _value
              ? UnconstrainedBox(alignment: Alignment.center, child: child)
              : child,
        ),
        Text(_value ? "已解除约束" : "子组件受约束")
      ],
    );
  }

  Widget _buildConstrainedAxis() {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.grey.withAlpha(22),
          width: 150,
          height: 100,
          child: UnconstrainedBox(
              alignment: Alignment.center,
              constrainedAxis: Axis.vertical,
              child: Container(
                color: Colors.cyanAccent,
                width: 60,
                height: 60,
              )),
        ),
        const Text("竖直方向仍约束")
      ],
    );
  }
}
