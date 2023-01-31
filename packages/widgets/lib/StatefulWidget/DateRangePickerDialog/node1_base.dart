import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 339,
//      "name": 'DateRangePickerDialog 基本使用',
//      "priority": 1,
//      "subtitle":
//          "【firstDate】 : 最早日期   【DateTime】\n"
//          "【lastDate】 : 最晚日期   【DateTime】\n"
//          "【initialDateRange】 : 初始范围   【DateTimeRange?】\n"
//          "【saveText】 : 保存文字  【String?】",
//    }
class DateRangePickerDialogDemo extends StatefulWidget {
  const DateRangePickerDialogDemo({Key? key}) : super(key: key);

  @override
  _DateRangePickerDialogDemoState createState() =>
      _DateRangePickerDialogDemoState();
}

class _DateRangePickerDialogDemoState
    extends State<DateRangePickerDialogDemo> {
  String _dateRange = '';

  // 需要 intl 包
  final DateFormat format = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    String info = _dateRange.isEmpty ? '选择日期范围' : _dateRange;

    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          ElevatedButton(
            onPressed: _show,
            child: const Text('选择'),
          ),
          Text(
            info,
            style: const TextStyle(color: Colors.grey),
          )
        ],
      ),
    );
  }

  void _show() async {
    DateTime firstDate = DateTime(2021, 1, 1);
    DateTime lastDate = DateTime.now();
    DateTime start = lastDate.add(const Duration(days: -8));
    DateTime end = lastDate.add(const Duration(days: -2));
    DateTimeRange? range = await showDateRangePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
      initialDateRange: DateTimeRange(
        start: start,
        end: end,
      ),
      saveText: "确定",
    );
    if (range != null) {
      setState(() {
        _dateRange =
        "${format.format(range.start)} ~ ${format.format(range.end)}";
      });
    }
  }
}
