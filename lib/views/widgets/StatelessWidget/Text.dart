import 'package:flutter/material.dart';
import 'package:flutter_unit/components/permanent/panel.dart';

class CustomText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var style = TextStyle(
      color: Colors.blue,
      fontSize: 20,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      letterSpacing: 10,
    );
    return Container(
      width: 200,
      color: Colors.cyanAccent.withAlpha(33),
      height: 200 * 0.618 * 0.618,
      child: Text("toly-张风捷特烈-1994`", style: style),
    );
  }
}

class DecorationText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "19940328",
      style: TextStyle(
          fontSize: 50,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
          decorationThickness: 3,
          decorationStyle: TextDecorationStyle.wavy,
          decorationColor: Colors.blue,
          fontStyle: FontStyle.italic,
          fontFamily: "DancingScript",
          letterSpacing: 10),
    );
  }
}

class ShadowText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "张风捷特烈",
      style: TextStyle(
          fontSize: 50,
          color: Colors.white,
          backgroundColor: Colors.black,
          shadows: [
            Shadow(
                color: Colors.cyanAccent,
                offset: Offset(1, 1),
                blurRadius: 10),
            Shadow(
                color: Colors.blue,
                offset: Offset(-0.1, 0.1),
                blurRadius: 10),
          ]),
    );
  }
}

class TextAlignText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: TextAlign.values
          .map((e) => Container(
                width: 120,
                color: Colors.cyanAccent.withAlpha(33),
                height: 120 * 0.618,
                child: Text(
                  " 张风捷特烈 toly " * 3,
                  textAlign: e,
                ),
              ))
          .toList(),
    );
  }
}

class TextDirectionText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 40,
      runSpacing: 10,
      children: TextDirection.values
          .map((e) => Container(
                width: 120,
                color: Colors.cyanAccent.withAlpha(33),
                height: 120 * 0.618,
                child: Text(
                  " 张风捷特烈 toly " * 10,
                  textDirection: e,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ))
          .toList(),
    );
  }
}

class SoftWrapText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: TextOverflow.values
          .map((e) => Container(
                width: 150,
                color: Colors.cyanAccent.withAlpha(33),
                height: 150 * 0.618 * 0.618,
                child: Text(" 张风捷特烈 toly " * 5,
                    overflow: e,
                    softWrap: false),
              ))
          .toList(),
    );
  }
}
