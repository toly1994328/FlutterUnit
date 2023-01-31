 import 'package:flutter/material.dart';
import 'package:widgets/utils/color_utils.dart';

/// create by 张风捷特烈 on 2020-03-22
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 106,
//      "name": 'Expanded基本使用',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 孩子   【Widget】\n"
//          "【flex】 : 剩余空间分配占比   【int】",
//    }
class CustomExpended extends StatefulWidget {
  const CustomExpended({Key? key}) : super(key: key);

  @override
  _CustomExpendedState createState() => _CustomExpendedState();
}

class _CustomExpendedState extends State<CustomExpended> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        buildRow([0, 0, 0]),
        const SizedBox(height: 10,),
        buildRow([0, 0, 1]),
        const SizedBox(height: 10,),
        buildRow([1, 1, 1]),
        const SizedBox(height: 10,),
        buildRow([2, 3, 3]),
      ],
    );
  }

  Widget buildRow(List<int> num) {
    return Row(
        children: num.map((e) => Expanded(
              flex: e,
              child: Container(
                alignment: Alignment.center,
                width: 50,
                height: 50,
                color: ColorUtils.randomColor(),
                child: Text(
                  'flex=$e',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            )).toList());
  }
}
