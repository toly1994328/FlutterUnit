import 'package:flutter/material.dart';

void showTimePicker_(BuildContext cxt) {
  showTimePicker(//选取时间
    context: cxt,
    initialTime: TimeOfDay(hour: 11, minute: 45),
    builder: (BuildContext context, Widget child) {
      return Theme(
        data: ThemeData.dark(),
        child: child,
      );
    },
  ).then((data){
    print(data);
  });
}