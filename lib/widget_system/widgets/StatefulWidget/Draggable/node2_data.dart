import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-22
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 103,
//      "name": 'Draggable与DragTarget联用',
//      "priority": 2,
//      "subtitle":
//          "【data】 : 数据   【T】\n"
//          "【onDragStarted】 : 开始拖拽   【Function()】\n"
//          "【onDragEnd】 : 结束拖拽   【Function(DraggableDetails)】\n"
//          "【onDragCompleted】 : 拖拽完成   【Function()】\n"
//          "【onDraggableCanceled】 : 拖拽取消   【Function(Velocity,Offset)】\n"
//          "【onChanged】 : 改变时回调   【Function(T)】",
//    }

class DraggablePage extends StatefulWidget {
  const DraggablePage({Key? key}) : super(key: key);

  @override
  _DraggablePageState createState() => _DraggablePageState();
}

class _DraggablePageState extends State<DraggablePage> {
  Color _color = Colors.grey;
  String _info = 'DragTarget';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Wrap(
          children: _buildColors(),
          spacing: 10,
        ),
        const SizedBox(
          height: 20,
        ),
        _buildDragTarget()
      ],
    );
  }

  List<Color> colors = [
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
            onDragStarted: () => setState(() => _info = '开始拖拽'),
            onDragEnd: (d) => setState(() => _info = '结束拖拽'),
            onDragCompleted: () => _info = '拖拽完成',
            onDraggableCanceled: (v, o) => _info = '拖拽取消',
            child: Container(
              width: 30,
              height: 30,
              alignment: Alignment.center,
              child: Text(
              colors.indexOf(e).toString(),
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold,),
            ),
            decoration: BoxDecoration(color: e, shape: BoxShape.circle),
          ),
          data: e,
          feedback: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(color: e, shape: BoxShape.circle),
          )),
    )
        .toList();

  Widget _buildDragTarget() {
    return DragTarget<Color>(
        onLeave: (data) => print("onLeave: data = $data "),
        onAccept: (data) {
          print("onAccept: data = $data ");
          setState(() {
            _color = data;
          });
        },
        onWillAccept: (data) {
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
