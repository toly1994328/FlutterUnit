import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-31
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 53,
//      "name": 'SelectableText对齐属性',
//      "priority": 2,
//      "subtitle":
//          "【textAlign】 : 对齐方式*6   【textAlign】\n"
//          "【textDirection】 : 文字方向*2   【TextDirection】",
//    }
class AlignSelectableText extends StatefulWidget {
  const AlignSelectableText({Key? key}) : super(key: key);

  @override
  _AlignSelectableTextState createState() => _AlignSelectableTextState();
}

class _AlignSelectableTextState extends State<AlignSelectableText> {
  final String text =
      "The [SelectableText] widget displays a string of text with a single style."
      "The string might break across multiple lines or might all be displayed on"
      "the same line depending on the layout constraints.";
  TextAlign _textAlign = TextAlign.left;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildSelector(),
        SelectableText(
          text,
          style: const TextStyle(fontSize: 18, color: Colors.red),
          cursorColor: Colors.green,
          cursorRadius: const Radius.circular(3),
          cursorWidth: 5,
          showCursor: true,
          textAlign: _textAlign,
          textDirection: TextDirection.ltr,
          autofocus: false,
        ),
      ],
    );
  }

  Widget _buildSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        const Text(
          "textAlign属性选择:",
          style: TextStyle(
            fontSize: 16,
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        DropdownButton<TextAlign>(
            underline: Container(),
            value: _textAlign,
            items: TextAlign.values
                .map((e) => DropdownMenuItem<TextAlign>(
                      value: e,
                      child: Text(e.toString()),
                    ))
                .toList(),
            onChanged: (e) {
              setState(() {
                _textAlign = e??_textAlign;
              });
            }),
      ],
    );
  }
}
