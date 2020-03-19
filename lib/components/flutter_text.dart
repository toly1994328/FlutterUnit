import 'dart:math';

import 'package:flutter/material.dart';

import 'flutter_container.dart';

class FlutterText extends StatelessWidget {
  final String  str;
  final TextStyle style;
  final AnimConfig config;
  FlutterText(this.str, {Key key, this.style, this.config=const AnimConfig()}):super(key:key);

  @override
  Widget build(BuildContext context) =>
  Wrap(children: str.split("").map((e)=>
  FlutterContainer(
  config: config,
  child: Text(e, style: style),)).toList()
  );

}