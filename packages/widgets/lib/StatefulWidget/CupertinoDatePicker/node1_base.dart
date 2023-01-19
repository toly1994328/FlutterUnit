import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 137,
//      "name": 'CupertinoDatePicker基本使用',
//      "priority": 1,
//      "subtitle":
//          "【initialDateTime】 : 初始日期   【DateTime】\n"
//          "【minimumYear】 : 最小年份   【int】\n"
//          "【maximumYear】 : 最大年份   【int】\n"
//          "【onDateTimeChanged】 : 点击回调  【Function(DateTime)】\n"
//          "【minuteInterval】 : 分钟间隔  【int】\n"
//          "【use24hFormat】 : 是否是24小时制  【bool】\n"
//          "【backgroundColor】 : 背景色  【Color】\n"
//          "【mode】 : 模式*3  【CupertinoDatePickerMode】",
//    }
class CustomCupertinoDatePicker extends StatefulWidget {
  const CustomCupertinoDatePicker({Key? key}) : super(key: key);

  @override
  _CustomCupertinoDatePickerState createState() =>
      _CustomCupertinoDatePickerState();
}

class _CustomCupertinoDatePickerState extends State<CustomCupertinoDatePicker> {
  DateTime _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          '当前日期:${_date.toIso8601String()}',
          style: const TextStyle(color: Colors.grey, fontSize: 16),
        ),
        _buildInfoTitle('CupertinoDatePickerMode.dateAndTime'),
        buildPicker(CupertinoDatePickerMode.dateAndTime),
        _buildInfoTitle('CupertinoDatePickerMode.date'),
        buildPicker(CupertinoDatePickerMode.date),
        _buildInfoTitle('CupertinoDatePickerMode.time'),
        buildPicker(CupertinoDatePickerMode.time),
      ],
    );
  }

  Container buildPicker(CupertinoDatePickerMode mode) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 150,
      child: CupertinoDatePicker(
        mode: mode,
        initialDateTime: DateTime.now(),
//        maximumDate: DateTime(2018,8,8),
//        minimumDate: DateTime(2030,8,8),
        minimumYear: 2018,
        maximumYear: 2030,
        use24hFormat: false,
        minuteInterval: 1,
        backgroundColor: CupertinoColors.white,
        onDateTimeChanged: (date) {
          print(date);
          setState(() => _date = date);
        },
      ),
    );
  }

  Widget _buildInfoTitle(info){
    return    Padding(
      padding: const EdgeInsets.only(left: 20,top: 20,bottom: 5),
      child: Text(
        info,
        style: const TextStyle(color: Colors.blue, fontSize: 16,fontWeight: FontWeight.bold),
      ),
    );
  }
}
