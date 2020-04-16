import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_unit/app/res/cons.dart';

class CustomContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      width: 200,
      height: 200 * 0.618,
      color: Colors.red.withAlpha(88),
    );
  }
}

class ContainerWithChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(10),
      width: 200,
      height: 200 * 0.618,
      color: Colors.grey.withAlpha(88),
      child: Icon(Icons.android),
    );
  }
}

class ContainerAlignment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      width: 200,
      height: 200 * 0.618,
      color: Colors.grey.withAlpha(88),
      child: Icon(
        Icons.android,
        color: Colors.green,
      ),
    );
  }
}

class ContainerDecoration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var stops = [0.0, 1 / 6, 2 / 6, 3 / 6, 4 / 6, 5 / 6, 1.0];
    return Container(
      //容器
      alignment: Alignment.center,
      width: 200,
      height: 200 * 0.618,
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        //添加渐变色
          gradient: LinearGradient(
              stops: stops,
              colors: Cons.rainbow.map((e) => Color(e)).toList()),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              bottomRight: Radius.circular(50)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                offset: Offset(1, 1),
                blurRadius: 10,
                spreadRadius: 1),
          ]),
      child: Text(
        "Container",
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}

class ContainerTransform extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //容器
      alignment: Alignment.center,
      color: Colors.cyanAccent,
      width: 150,
      height: 150 * 0.618,
      transform: Matrix4.skew(-pi / 10, 0),
      child: Text(
        "Container",
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}

class ContainerConstraints extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //容器
      color: Colors.blue,
      width: 200,
      height: 200 * 0.618,
      constraints: BoxConstraints(
          minWidth: 100, maxWidth: 150,
          minHeight: 20, maxHeight: 100),
    );
  }
}
