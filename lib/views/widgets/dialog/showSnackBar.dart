import 'package:flutter/material.dart';

showSnackBar_(BuildContext context) {
  var snackBar = SnackBar(
      backgroundColor: Color(0xffFB6431), //颜色
      content: Text('Hello!'), //内容
      duration: Duration(seconds: 3), //持续时间
      action: SnackBarAction(
          label: '确定',
          onPressed: () {
            print("Flutter之旅");
          }));
  Scaffold.of(context).showSnackBar(snackBar); //这样就行了
}