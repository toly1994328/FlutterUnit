
/// create by 张风捷特烈 on 2020-04-15
/// contact me by email 1981462002@qq.com
/// 说明: 

import 'package:flutter/material.dart';

import 'high_light_code.dart';
import 'highlighter_style.dart';

class CodeWidget extends StatelessWidget {
  CodeWidget({Key key, @required this.code, this.style, this.fontSize = 13,this.fontFamily})
      : super(key: key);

  final String code;
  final HighlighterStyle style;
  final double fontSize;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (code == null) {
      return Container();
    } else {
      Widget _codeWidget;
      try {
        _codeWidget = RichText(
          text: TextSpan(
            style: TextStyle(fontSize: fontSize,fontFamily: fontFamily),
            children: <TextSpan>[DartHighlighter(style).format(code)],
          ),
        );
      } catch (err) {
        _codeWidget = Text(code);
      }
      body = SingleChildScrollView(
        child: Container(
          child: _codeWidget,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: style.backgroundColor ?? Color(0xffF6F8FA),
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
        ),
      );
    }
    return body;
  }
}