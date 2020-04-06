import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 135,
//      "name": 'MonthPicker基本使用',
//      "priority": 1,
//      "subtitle":
//          "【selectedDate】 : 选中日期   【DateTime】\n"
//          "【firstDate】 : 最前日期限制   【DateTime】\n"
//          "【lastDate】 : 最后日期限制   【DateTime】\n"
//          "【onChanged】 : 点击回调  【Function(DateTime)】",
//    }
class CustomMonthPicker extends StatefulWidget {
  @override
  _CustomMonthPickerState createState() => _CustomMonthPickerState();
}

class _CustomMonthPickerState extends State<CustomMonthPicker> {
  DateTime _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: MonthPicker(
        selectedDate: _date,
        onChanged: (date) => setState(() => _date = date),
        firstDate: DateTime(2018),
        lastDate: DateTime(2030),
      ),
    );
  }
}
