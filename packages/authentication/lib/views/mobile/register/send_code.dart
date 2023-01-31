import 'dart:async';

import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2021/1/17
/// contact me by email 1981462002@qq.com
/// 说明:

class CountDownWidget extends StatefulWidget {
  final Function(BuildContext context)? onPress;

  const CountDownWidget({Key? key, this.onPress}) : super(key: key);

  @override
  _CountDownWidgetState createState() => _CountDownWidgetState();
}

class _CountDownWidgetState extends State<CountDownWidget> {
  Timer? timer;
  int count = 60;
  bool startTimer = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: startTimer
            ? null
            : () {
                timer = Timer.periodic(const Duration(seconds: 1), _update);
                setState(() {
                  startTimer = true;
                });
                widget.onPress?.call(context);
              },
        child: Text(startTimer ? '$count 秒后重试' : '获取验证码'));
  }

  void _update(Timer timer) {
    count--;
    if (count == 0) {
      timer.cancel();
      startTimer = false;
      count = 60;
    }
    setState(() {});
  }
}
