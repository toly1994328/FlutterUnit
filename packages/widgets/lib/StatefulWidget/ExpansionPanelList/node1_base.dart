import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-30
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 178,
//      "name": 'ExpansionPanelList基本使用',
//      "priority": 1,
//      "subtitle":
//          "【children】 : 子组件列表   【List<Widget>】\n"
//          "【animationDuration】 : 动画时长   【Duration】\n"
//          "【expansionCallback】 : 展开回调   【List<Widget>】\n"
//          "【onPressed】 : 点击事件  【Function()】",
//    }
class CustomExpansionPanelList extends StatefulWidget {
  const CustomExpansionPanelList({Key? key}) : super(key: key);

  @override
  _CustomExpansionPanelListState createState() =>
      _CustomExpansionPanelListState();
}

class _CustomExpansionPanelListState extends State<CustomExpansionPanelList> {
  final List<Color> data = [
    Colors.red[50]!,
    Colors.red[100]!,
    Colors.red[200]!,
    Colors.red[300]!,
    Colors.red[400]!,
    Colors.red[500]!,
    Colors.red[600]!,
    Colors.red[700]!,
    Colors.red[800]!,
    Colors.red[900]!,
  ];
  int _position = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: ExpansionPanelList(
        children: data.map((color) => _buildItem(color)).toList(),
        animationDuration: const Duration(milliseconds: 200),
        expansionCallback: (index, open) {
          setState(() => _position = open ? -1 : index);
        },
      ),
    );
  }

  ExpansionPanel _buildItem(Color color) {
    return ExpansionPanel(
        isExpanded: data.indexOf(color) == _position,
        canTapOnHeader: true,
        headerBuilder: (ctx, index) => Center(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  Container(
                    height: 30,
                    width: 30,
                    decoration:
                        BoxDecoration(color: color, shape: BoxShape.circle),
                  ),
                  Container(
                    width: 120,
                    alignment: Alignment.center,
                    height: 50,
                    child: Text(
                      colorString(color),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
        body: Container(
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
        ));
  }

  String colorString(Color color) =>
      "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}
