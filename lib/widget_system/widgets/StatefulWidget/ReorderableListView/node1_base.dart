import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-30
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 177,
//      "name": 'ReorderableListView基本使用',
//      "priority": 1,
//      "subtitle":
//          "【children】 : 子组件列表   【List<Widget>】\n"
//          "【header】 : 头部组件   【Widget】\n"
//          "【padding】 : 内边距   【EdgeInsets】\n"
//          "【onReorder】 : 调换时回调  【ReorderCallback】",
//    }
class CustomReorderableListView extends StatefulWidget {
  const CustomReorderableListView({Key? key}) : super(key: key);

  @override
  _CustomReorderableListViewState createState() => _CustomReorderableListViewState();
}

class _CustomReorderableListViewState extends State<CustomReorderableListView> {

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
      height: 250,
      child: ReorderableListView(
        padding: const EdgeInsets.all(10),
        header: Container(
          color: Colors.blue,
          alignment: Alignment.center,
            height: 50,
            child: const Text('长按拖拽进行换位',style: TextStyle(color: Colors.white),)),
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
      height: 50,
      color: color,
      child: Text(
        colorString(color),
        style: const TextStyle(color: Colors.white, shadows: [
          Shadow(color: Colors.black, offset: Offset(.5, .5), blurRadius: 2)
        ]),
      ),
    );
  }

  String colorString(Color color) =>
      "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}