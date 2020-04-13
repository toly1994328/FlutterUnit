import 'dart:async';

import 'package:flutter/material.dart';

class AnimatedText extends StatefulWidget {
  final String text;
  final int delayInMilliseconds;
  final int durationInMilliseconds;
  final TextStyle textStyle;

  AnimatedText(this.text, this.delayInMilliseconds,
      {this.durationInMilliseconds: 2500, this.textStyle});

  @override createState() =>  AnimatedTextState();
}

class AnimatedTextState extends State<AnimatedText>
    with SingleTickerProviderStateMixin {

  String currentText = '';

  AnimationController _controller;

  List<int> get  textRunes=> widget.text.runes.toList();
  int get value => _controller.value.toInt();

  int curIndex = 0;


  @override
  void initState()  {
    super.initState();
    currentText = String.fromCharCode(textRunes[0]);

    _controller =  AnimationController(
        vsync: this,
        value: 0.0,
        lowerBound: 0.0,
        upperBound: textRunes.length.toDouble(),
        duration:  Duration(milliseconds: widget.durationInMilliseconds));

    _controller..addListener(_updateText)..forward();

  }

  _updateText(){
    if (value > curIndex && value < textRunes.length) {
      setState(() {
        curIndex = value;
        currentText +=  String.fromCharCode(textRunes[curIndex]);
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Text(currentText, textAlign: TextAlign.left,
      style: widget.textStyle ??
           TextStyle(fontWeight: FontWeight.w600, fontSize: 20.0),);
  }
}