import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-30
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 177,
//      "name": 'ReorderableListView滑动方向',
//      "priority": 2,
//      "subtitle":
//          "【scrollDirection】 : 滑动方向   【Axis】\n"
//          "【reverse】 : 是否反向  【bool】",
//    }
class DirectionReorderableListView extends StatefulWidget {
  const DirectionReorderableListView({Key? key}) : super(key: key);

  @override
  _DirectionReorderableListViewState createState() =>
      _DirectionReorderableListViewState();
}

class _DirectionReorderableListViewState extends State<DirectionReorderableListView> {
  final List<Color> data = [
    Colors.yellow[50]!,
    Colors.yellow[100]!,
    Colors.yellow[200]!,
    Colors.yellow[300]!,
    Colors.yellow[400]!,
    Colors.yellow[500]!,
    Colors.yellow[600]!,
    Colors.yellow[700]!,
    Colors.yellow[800]!,
    Colors.yellow[900]!,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ReorderableListView(
        scrollDirection: Axis.horizontal,
        reverse: false,
        onReorder: _handleReorder,
        children: data.map((color) => _buildItem(color)).toList(),
      ),
    );
  }

  void _handleReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    setState(() {
      final element = data.removeAt(oldIndex);
      data.insert(newIndex, element);
    });

  }

  Widget _buildItem(Color color) {
    return Container(
      key: ValueKey(color)  ,
      alignment: Alignment.center,
      width: 80,
      color: color,
      child: Text(
        colorString(color),
        style: const TextStyle(color: Colors.white, shadows: [
          Shadow(
            color: Colors.black,
            offset: Offset(.5, .5),
            blurRadius: 2,
          )
        ]),
      ),
    );
  }

  String colorString(Color color) =>
      "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}