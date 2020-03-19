import 'package:flutter/material.dart';

import 'high_light_code.dart';


class CodeWidget extends StatelessWidget {

  CodeWidget({Key key,@required this.code}):super(key:key);

  final String code;

  @override
  Widget build(BuildContext context) {
    final SyntaxHighlighterStyle style =
    Theme.of(context).brightness == Brightness.dark
        ? SyntaxHighlighterStyle.darkThemeStyle()
        : SyntaxHighlighterStyle.lightThemeStyle();

    Widget body;
    if (code == null) {
      return Container();
    } else {
      Widget _codeWidget;
      try{
        DartSyntaxHighlighter(style).format(code);
        _codeWidget = RichText(
          text: TextSpan(
            style: const TextStyle(fontSize: 13.0),
            children: <TextSpan>[
              DartSyntaxHighlighter(style).format(code)
            ],),
        );
      }catch (err){
        _codeWidget = Text(code);
      }
      body = SingleChildScrollView(
          child: _codeWidget,
      );
    }
    return body;
  }
}
