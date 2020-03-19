import 'dart:math';

import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-19
/// contact me by email 1981462002@qq.com
/// 说明:


class ExpendPanel extends StatefulWidget {
  @override
  _ExpendPanelState createState() => _ExpendPanelState();
}

class _ExpendPanelState extends State<ExpendPanel>
    with SingleTickerProviderStateMixin {
  AnimationController _ctrl;
  double _sizeFactor = 0;
  Animation<double> _expend;
  bool _opened = false;

  @override
  void initState() {
    _ctrl =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {
              _sizeFactor = (_opened ? (1 - _expend.value) : _expend.value);
            });
          })
          ..addStatusListener((s) {
            if (s == AnimationStatus.completed) {
              setState(() {
                _opened = !_opened;
              });
            }
          });
    _expend = Tween(begin: 0.0, end: 1.0).animate(_ctrl);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
            onTap: () {
              _ctrl.reset();
              _ctrl.forward();
            },
            child: Icon(Icons.arrow_upward)),
        ClipRect(
          child: Align(
            alignment: Alignment.center,
            heightFactor: _sizeFactor,
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                color: Colors.orange,
                child: Icon(Icons.android, color: Colors.green, size: 80)),
          ),
        )
      ],
    );
  }
}
