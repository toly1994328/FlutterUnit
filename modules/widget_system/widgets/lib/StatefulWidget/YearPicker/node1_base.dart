import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com

class CustomYearPicker extends StatefulWidget {
  const CustomYearPicker({Key? key}) : super(key: key);

  @override
  _CustomYearPickerState createState() => _CustomYearPickerState();
}

class _CustomYearPickerState extends State<CustomYearPicker> {
  DateTime _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:150,
      child: YearPicker(
        selectedDate: _date,
        onChanged: (date) => setState(() => _date = date),
        firstDate: DateTime(2018),
        lastDate: DateTime(2030),
      ),
    );
  }
}
