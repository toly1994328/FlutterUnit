import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-22
/// contact me by email 1981462002@qq.com
/// 说明: 

//    {
//      "widgetId": 104,
//      "name": 'DragTarget基本使用',
//      "priority": 1,
//      "subtitle":
//          "【builder】 : 组件构造器   【DragTargetBuilder<T>】\n"
//          "【onWillAccept】 : 拖入时   【Function(T)】\n"
//          "【onAccept】 : 拖拽成功   【Function(T)】\n"
//          "【onLeave】 : 拖入再脱出   【Function(T)】",
//    }

class CustomDragTarget extends StatefulWidget {
  const CustomDragTarget({Key? key}) : super(key: key);

  @override
  _CustomDragTargetState createState() => _CustomDragTargetState();
}

class _CustomDragTargetState extends State<CustomDragTarget> {
  Color _color = Colors.grey;
  String _info = 'DragTarget';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Wrap(children: _buildColors(), spacing: 10),
        const SizedBox(height: 20),
        _buildDragTarget()
      ],
    );
  }

  final List<Color> colors = const [
    Colors.red,
    Colors.yellow,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.cyanAccent
  ];

  List<Widget> _buildColors() => colors
      .map(
        (e) => Draggable<Color>(
            child: Container(
              width: 30,
              height: 30,
              alignment: Alignment.center,
              child: Text(
                colors.indexOf(e).toString(),
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            decoration: BoxDecoration(color: e, shape: BoxShape.circle),
          ),
          data: e,
          feedback: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(color: e, shape: BoxShape.circle),
          )),
    ).toList();

  Widget _buildDragTarget() {
    return DragTarget<Color>(
        onLeave: (data) => setState(() => _info='onLeave'),
        onAccept: (data) => setState(() {
            _info='onAccept';
            _color = data;
          }),
        onWillAccept: (data) {
          setState(() {
            _info='onWillAccept';
          });
          print("onWillAccept: data = $data ");
          return data != null;
        },
        builder: (context, candidateData, rejectedData) => Container(
            width: 150.0,
            height: 50.0,
            color: _color,
            child: Center(
              child: Text(
                _info,
                style: const TextStyle(color: Colors.white),
              ),
            )));
  }
}