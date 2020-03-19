import 'dart:async';

import 'package:flutter/material.dart';

showStatefulWidgetDialog_(BuildContext context) {
  var progress = 0.0;
  StateSetter stateSetter;//状态设置器
  var ctxNow;
  Timer.periodic(Duration(milliseconds: 100), (timer) {//计时器模拟进度增加
    progress += 0.1;//进度增加
    if (stateSetter != null) {
      stateSetter(() {});//刷新
    }
    if (progress >= 1) {
      timer.cancel();//大于1时取消计时器
      stateSetter = null;
      Navigator.of(ctxNow).pop();//退出
    }
  });

  var child=Center(//内部组件
      child: SizedBox(
        width: 150, height: 150,
        child: Card(
            elevation: 24.0,
            color: Colors.blue.withAlpha(240),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(//圆形进度条
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                  value: progress,
                ),
                SizedBox(height: 20,),
                Text("Loading...",
                  style: TextStyle(color: Colors.white),),
                SizedBox(height: 5,),
                Text(
                  "done ${((progress - 0.1) * 100).toStringAsFixed(1)}%",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ))));
  //使用StatefulBuilder创建一个有状态的组件
  showDialog(context: context, builder: (ctx) =>
      StatefulBuilder(
        builder: (ctx, state) {
          ctxNow=ctx;
          stateSetter = state;
          return child;
    },
  ));
}