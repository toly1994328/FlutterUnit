import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-30
/// contact me by email 1981462002@qq.com
/// 说明: 
//    {
//      "widgetId": 179,
//      "name": 'ListWheelScrollView基本使用',
//      "priority": 1,
//      "subtitle": "【children】 : 子组件列表   【List<Widget>】\n"
//          "【perspective】 : 透视度   【double】\n"
//          "【itemExtent】 : item高   【EdgeInsets】\n"
//          "【onSelectedItemChanged】 : 选中回调  【ValueChanged<int> 】",
//    }
class CustomListWheelScrollView extends StatefulWidget {
  const CustomListWheelScrollView({Key? key}) : super(key: key);

  @override
  _CustomListWheelScrollViewState createState() =>
      _CustomListWheelScrollViewState();
}

class _CustomListWheelScrollViewState extends State<CustomListWheelScrollView> {
  final List<Color> data = [
    Colors.orange[50]!,
    Colors.orange[100]!,
    Colors.orange[200]!,
    Colors.orange[300]!,
    Colors.orange[400]!,
    Colors.orange[500]!,
    Colors.orange[600]!,
    Colors.orange[700]!,
    Colors.orange[800]!,
    Colors.orange[900]!,
  ];

  Color _color = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildCircle(),
        SizedBox(
          height: 150,
          width: 300,
          child: ListWheelScrollView(
            perspective: 0.006,
            itemExtent: 50,
            onSelectedItemChanged: (index) {
              print('onSelectedItemChanged:$index');
              setState(() => _color = data[index]);
            },
            children: data.map((color) => _buildItem(color)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildCircle() => Container(
    margin: const EdgeInsets.only(bottom: 5),
        width: 30,
        height: 30,
        decoration: BoxDecoration(color: _color, shape: BoxShape.circle),
      );

  Widget _buildItem(Color color) {
    return Container(
      key: ValueKey(color)  ,
      alignment: Alignment.center,
      height: 50,
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
