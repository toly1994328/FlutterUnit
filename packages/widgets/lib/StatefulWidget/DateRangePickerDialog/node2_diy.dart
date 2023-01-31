import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'toly_date_picker.dart' as toly;

/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 339,
//      "name": '魔改 DateRangePickerDialog',
//      "priority": 2,
//      "subtitle": "修改 DateRangePickerDialog 源码，使得月份条目显示数值背景。",
//    }
class DiyDateRangePickerDialogDemo extends StatefulWidget {
  const DiyDateRangePickerDialogDemo({Key? key}) : super(key: key);

  @override
  _DiyDateRangePickerDialogDemoState createState() =>
      _DiyDateRangePickerDialogDemoState();
}

class _DiyDateRangePickerDialogDemoState
    extends State<DiyDateRangePickerDialogDemo> {
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
    DateTimeRange? range = await toly.showDateRangePicker(
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
