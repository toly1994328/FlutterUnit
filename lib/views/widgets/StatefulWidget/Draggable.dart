import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-22
/// contact me by email 1981462002@qq.com
/// 说明:
///
//    {
//      "widgetId": 103,
//      "name": 'Draggable基本使用',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 孩子   【Widget】\n"
//          "【feedback】 : 拖拽时的孩子   【Widget】\n"
//          "【axis】 : 拖动的轴   【Axis】",
//    }
class CustomDraggable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var axis = [null, Axis.vertical, Axis.horizontal];
    return Wrap(
        spacing: 30,
        children: axis
            .map((e) => Draggable(
                  axis: e,
                  child: Container(
                    width: 30,
                    height: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.blue, shape: BoxShape.circle),
                  ),
                  feedback: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Colors.red, shape: BoxShape.circle),
                  ),
                ))
            .toList());
  }
}

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
  @override
  _DraggablePageState createState() => _DraggablePageState();
}

class _DraggablePageState extends State<DraggablePage> {
  Color _color = Colors.grey;
  String _info = 'DragTarget';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Wrap(
            children: _buildColors(),
            spacing: 10,
          ),
          SizedBox(
            height: 20,
          ),
          _buildDragTarget()
        ],
      ),
    );
  }

  List<Widget> _buildColors() {
    var colors = [
      Colors.red,
      Colors.yellow,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.cyanAccent
    ];
    return colors
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
                  style: TextStyle(
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
        )
        .toList();
  }

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
                style: TextStyle(color: Colors.white),
              ),
            )));
  }
}

//    {
//      "widgetId": 103,
//      "name": 'Draggable其他使用',
//      "priority": 3,
//      "subtitle":
//          "可以根据拖拽来处理一些事件。如删除、查询、弹框等"
//    }

class DeleteDraggable extends StatefulWidget {
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
    return Container(
      child: Column(
        children: <Widget>[
          Wrap(
            children: _buildColors(),
            spacing: 10,
          ),
          SizedBox(
            height: 20,
          ),
          _buildDragTarget()
        ],
      ),
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
                BoxDecoration(color: Colors.red, shape: BoxShape.circle),
            child: Center(
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
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
