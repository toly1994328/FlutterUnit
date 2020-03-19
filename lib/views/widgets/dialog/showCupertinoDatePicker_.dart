import 'package:flutter/cupertino.dart';

showCupertinoDatePicker_(BuildContext context){
  final picker =CupertinoDatePicker(
    onDateTimeChanged: (date){
      print("当前日期、时间 ${date.toString()}");
    },
    initialDateTime: DateTime(1994),
  );

  showCupertinoModalPopup(context: context, builder: (cxt){
    return Container(
      height: 200,
      child: picker,
    );
  });
}