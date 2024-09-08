import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/28
/// contact me by email 1981462002@qq.com
/// 说明: 

//    {
//      "widgetId": 103,
//      "name": 'Draggable其他使用',
//      "priority": 3,
//      "subtitle":
//          "可以根据拖拽来处理一些事件。如删除、查询、弹框等",
//    }

class DeleteDraggable extends StatefulWidget {
  const DeleteDraggable({Key? key}) : super(key: key);

  @override
  _DeleteDraggableState createState() => _DeleteDraggableState();
}

class _DeleteDraggableState extends State<DeleteDraggable> {
  List<Color> colors = [
    Colors.red,
    Colors.yellow,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.cyanAccent
  ];

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

  Widget _buildDragTarget() {
    return DragTarget<int>(
        onAccept: (data) {
          setState(() {
            colors.removeAt(data);
          });
        },
        onWillAccept: (data) => data != null,
        builder: (context, candidateData, rejectedData) => Container(
            width: 50.0,
            height: 50.0,
            decoration:
                const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
            child: const Center(
              child: Icon(Icons.delete_sweep, color: Colors.white),
            )));
  }

  List<Widget> _buildColors() => colors
      .map(
        (e) => Draggable<int>(
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
        data: colors.indexOf(e),
        feedback: Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
              color: e.withAlpha(100), shape: BoxShape.circle),
        )),
  )
      .toList();
}
