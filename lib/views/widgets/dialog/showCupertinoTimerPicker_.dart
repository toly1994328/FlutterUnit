
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showCupertinoTimerPicker_(BuildContext cxt){
  final picker = CupertinoTimerPicker(onTimerDurationChanged: (duration){
    print('当前时间 $duration');
  });

  showCupertinoModalPopup(context: cxt, builder: (cxt){
    return Material(child: Container(
      height: 200,
      child: picker,
    ),);
  });
}
