import 'package:flutter/material.dart';

void showDatePicker_(BuildContext cxt) {
  showDatePicker(//显示时间选择根据
    context: cxt,
    initialDate: DateTime.now(),//初始日期
    firstDate: DateTime(2018),//区域起始年份
    lastDate: DateTime(2030),//区域截止年份
    builder: (BuildContext context, Widget child) {
      return Theme(
        data: ThemeData.dark(),
        child: child,
      );
    },
  ).then((data){//获取选择数据
    print(data);
  });
}