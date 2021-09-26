

/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 134,
//      "name": 'DayPicker基本使用',
//      "priority": 1,
//      "subtitle":
//          "【selectedDate】 : 选中日期   【DateTime】\n"
//          "【currentDate】 : 当前日期   【DateTime】\n"
//          "【firstDate】 : 最前日期限制   【DateTime】\n"
//          "【lastDate】 : 最后日期限制   【DateTime】\n"
//          "【displayedMonth】 : 当前展示的月份   【DateTime】\n"
//          "【onChanged】 : 点击回调  【Function(DateTime)】",
//    }
import 'package:flutter/material.dart';

class CustomDayPicker extends StatefulWidget {
  @override
  _CustomDayPickerState createState() => _CustomDayPickerState();
}

class _CustomDayPickerState extends State<CustomDayPicker> {

  DateTime _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: DayPicker(
          selectedDate: _date,
          currentDate: DateTime.now(),
          onChanged: (date){
           setState(() => _date = date);
          },
          firstDate:  DateTime(2018),
          lastDate: DateTime(2030),
          displayedMonth: DateTime.now()
      ),
    );
  }
}
