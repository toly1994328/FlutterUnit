import 'package:flutter/material.dart';



/// create by 张风捷特烈 on 2020/4/27
/// contact me by email 1981462002@qq.com
/// 说明:
//      {
//      "widgetId": 14,
//      "priority": 2,
//      "name": "可以接受选中事件",
//      "subtitle": "【selected】: 是否选中   【bool】\n"
//          "【onSelected】: 选中事件   【Function(bool)】",
//      }

class SelectInputChip extends StatefulWidget {
  const SelectInputChip({Key? key}) : super(key: key);

  @override
  _SelectInputChipState createState() => _SelectInputChipState();
}

class _SelectInputChipState extends State<SelectInputChip> {
  bool _select = false;

  @override
  Widget build(BuildContext context) {
    return InputChip(
      selected: _select,
      padding: const EdgeInsets.all(5),
      labelPadding: const EdgeInsets.all(3),
      label: const Text("This is a InputChip."),
      backgroundColor: Colors.grey.withAlpha(66),
      avatar: Image.asset("assets/images/icon_head.webp"),
      selectedColor: Colors.orangeAccent.withAlpha(88),
      selectedShadowColor: Colors.blue,
      shadowColor: Colors.orangeAccent,
      elevation: 3,
      onDeleted: () =>  Navigator.of(context).pushNamed('AboutMePage'),
      onSelected: (bool value) {
        setState(() {
          _select = value;
        });
        print("onSelected");
      },
    );
  }
}