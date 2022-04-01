import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-29
/// contact me by email 1981462002@qq.com
/// 说明:


//    {
//      "widgetId": 176,
//      "name": 'Dismissible基本使用',
//      "priority": 1,
//      "subtitle": "【child】 : 子组件   【Widget】\n"
//          "【background】 : 左底  【Widget】\n"
//          "【secondaryBackground】 : 右底  【Widget】\n"
//          "【key】 : 键  【Key】\n"
//          "【confirmDismiss】 : 确认回调  【DismissDirectionCallback】\n"
//          "【onDismissed】 : 消失回调  【DismissDirectionCallback】\n",
//    }
class CustomDismissible extends StatefulWidget {
  const CustomDismissible({Key? key}) : super(key: key);

  @override
  _CustomDismissibleState createState() => _CustomDismissibleState();
}

class _CustomDismissibleState extends State<CustomDismissible> {
  final List<Color> data = [
    Colors.purple[50]!,
    Colors.purple[100]!,
    Colors.purple[200]!,
    Colors.purple[300]!,
    Colors.purple[400]!,
    Colors.purple[500]!,
    Colors.purple[600]!,
    Colors.purple[700]!,
    Colors.purple[800]!,
    Colors.purple[900]!,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        children: data.map((color) => _buildItem(color)).toList(),
      ),
    );
  }

  Widget _buildItem(Color color) {
    return Dismissible(
      background: Container(
        color: Colors.green,
        alignment: const Alignment(-0.9, 0),
        child: const Icon(
          Icons.check,
          color: Colors.white,
        ),
      ),
      secondaryBackground: Container(
        alignment: const Alignment(0.9, 0),
        child: const Icon(
          Icons.close,
          color: Colors.white,
        ),
        color: Colors.red,
      ),
      key: ValueKey(color),
      onDismissed: (d) {
        data.remove(color);
      },
      confirmDismiss: (e) async {
        if (e == DismissDirection.endToStart) {
          return true;
        } else {
          return false;
        }
      },
      child: Container(
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
      ),
    );
  }

  String colorString(Color color) =>
      "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}