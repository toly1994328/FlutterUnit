import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 138,
//      "name": 'CupertinoTimerPicker基本使用',
//      "priority": 1,
//      "subtitle":
//          "【initialTimerDuration】 : 初始时间   【Duration】\n"
//          "【minuteInterval】 : 分钟间隔数   【double】\n"
//          "【secondInterval】 : 秒间隔数   【double】\n"
//          "【alignment】 : 对齐方式  【AlignmentGeometry】\n"
//          "【backgroundColor】 : 背景色  【Color】\n"
//          "【mode】 : 模式*3  【CupertinoTimerPickerMode】",
//    }
class CustomCupertinoTimerPicker extends StatefulWidget {
  const CustomCupertinoTimerPicker({Key? key}) : super(key: key);

  @override
  _CustomCupertinoTimerPickerState createState() =>
      _CustomCupertinoTimerPickerState();
}

class _CustomCupertinoTimerPickerState
    extends State<CustomCupertinoTimerPicker> {
  Duration _date = const Duration(seconds: 30);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          '当前时间:${_date.toString()}',
          style: const TextStyle(color: Colors.grey, fontSize: 16),
        ),
        _buildInfoTitle('CupertinoTimerPickerMode.hms'),
        buildPicker(CupertinoTimerPickerMode.hms),
        _buildInfoTitle('CupertinoTimerPickerMode.hm'),
        buildPicker(CupertinoTimerPickerMode.hm),
        _buildInfoTitle('CupertinoTimerPickerMode.ms'),
        buildPicker(CupertinoTimerPickerMode.ms),
      ],
    );
  }

  Widget _buildInfoTitle(info) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20, bottom: 5),
      child: Text(
        info,
        style: const TextStyle(
            color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildPicker(CupertinoTimerPickerMode mode) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 150,
      child: CupertinoTimerPicker(
        mode: mode,
        initialTimerDuration: const Duration(seconds: 30),
        onTimerDurationChanged: (date) {
          print(date);
          setState(() => _date = date);
        },
      ),
    );
  }
}
