import 'package:flutter/cupertino.dart';

void showCupertinoPicker_(BuildContext context){
  var names=['Java','Kotlin','Dart','Swift','C++','Python',"JavaScript","PHP","Go","Object-c"];
  final picker  = CupertinoPicker(
      itemExtent: 40,
      onSelectedItemChanged: (position){
        print('当前条目  ${names[position]}');
      }, children: names.map((e){
    return Text(e);
  }).toList());

  showCupertinoModalPopup(context: context, builder: (cxt){
    return Container(
      height: 200,
      child: picker,
    );
  });
}