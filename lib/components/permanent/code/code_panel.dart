import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'high_light_code.dart';
import 'highlighter_style.dart';

class CodeWidget extends StatelessWidget {
  CodeWidget({
    Key key,
    @required this.code,
    this.style,
    this.fontSize = 13,
    this.fontFamily,
  }) : super(key: key);

  final String code;
  final HighlighterStyle style;
  final double fontSize;
  final String fontFamily;
  @override
  Widget build(BuildContext context) {
    if (code == null) {
      return Container();
    }

    Widget _codeWidget = FutureBuilder(
      future: compute(_hightlight, _HightlightArgs(style, code)),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(code);
        }
        if (snapshot.hasData)
          return RichText(
            text: TextSpan(
              children: <TextSpan>[snapshot.data],
            ),
          );
        // computing
        return SizedBox.shrink();
      },
    );

    return SingleChildScrollView(
      child: Container(
        child: DefaultTextStyle(
          child: _codeWidget,
          style: TextStyle(fontSize: fontSize, fontFamily: fontFamily),
        ),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: style.backgroundColor ?? Color(0xffF6F8FA),
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
      ),
    );
  }
}

class _HightlightArgs {
  final HighlighterStyle style;
  final String code;
  _HightlightArgs(this.style, this.code);
}

TextSpan _hightlight(_HightlightArgs args) =>
    DartHighlighter(args.style).format(args.code);
