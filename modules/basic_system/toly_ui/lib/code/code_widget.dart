/// create by 张风捷特烈 on 2020-04-15
/// contact me by email 1981462002@qq.com
/// 说明:
import 'package:flutter/material.dart';

import 'high_light_code.dart';
import 'highlighter_style.dart';
import 'language/dart_languge.dart';

class CodeWidget extends StatelessWidget {
  CodeWidget(
      {Key? key,
      required this.code,
      required this.style,
      this.fontSize = 13,
      this.fontFamily})
      : super(key: key);

  final String code;
  final HighlighterStyle style;
  final double fontSize;
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    Widget body;
    Widget codeWidget;
    try {
      codeWidget = SelectableText.rich(
        selectionControls: MaterialTextSelectionControls(),
        TextSpan(
          style: TextStyle(fontSize: fontSize, fontFamily: fontFamily),
          children: <TextSpan>[
            CodeHighlighter(style: style, language: const DartLanguage())
                .format(code)
          ],
        ),
      );
    } catch (err) {
      print(err);
      codeWidget = SelectableText(code);
    }
    body = SingleChildScrollView(
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: style.backgroundColor ?? const Color(0xffF6F8FA),
            borderRadius: const BorderRadius.all(Radius.circular(5.0))),
        child: codeWidget,
      ),
    );
    return body;
  }
}
