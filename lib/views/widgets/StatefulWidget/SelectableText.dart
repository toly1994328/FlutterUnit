import 'package:flutter/material.dart';

//    {
//      "widgetId": 53,
//      "name": 'SelectableText基本使用',
//      "priority": 1,
//      "subtitle":
//          "【入参】 : 显示文字   【String】\n"
//          "【style】 : 文字样式   【TextStyle】\n"
//          "【cursorRadius】 : 光标半径   【Radius】\n"
//          "【cursorColor】 : 光标颜色   【Color】\n"
//          "【cursorWidth】 : 光标宽度   【double】\n"
//          "【showCursor】 : 是否显示光标   【bool】\n"
//          "【autofocus】 : 自动聚焦   【bool】"
//    }
class CustomSelectableText extends StatelessWidget {
  final text = "        始臣之解牛之时，所见无非牛者。三年之后，未尝见全牛也。方今之时，"
      "臣以神遇而不以目视，官知止而神欲行。依乎天理，批大郤，导大窾，因其固然，"
      "技经肯綮之未尝，而况大軱乎！良庖岁更刀，割也；族庖月更刀，折也。"
      "今臣之刀十九年矣，所解数千牛矣，而刀刃若新发于硎。彼节者有间，而刀刃者无厚；"
      "以无厚入有间，恢恢乎其于游刃必有余地矣，是以十九年而刀刃若新发于硎。"
      "虽然，每至于族，吾见其难为，怵然为戒，视为止，行为迟。动刀甚微，謋然已解，如土委地。"
      "提刀而立，为之四顾，为之踌躇满志，善刀而藏之.";

  @override
  Widget build(BuildContext context) {
    return SelectableText(
      text,
      style: TextStyle(fontSize: 18, color: Colors.orange),
      cursorColor: Colors.green,
      cursorRadius: Radius.circular(3),
      cursorWidth: 5,
      showCursor: true,
      autofocus: false,
    );
  }
}

//    {
//      "widgetId": 53,
//      "name": 'SelectableText对齐属性',
//      "priority": 2,
//      "subtitle":
//          "【textAlign】 : 对齐方式*6   【textAlign】\n"
//          "【textDirection】 : 文字方向*2   【TextDirection】",
//    }
class AlignSelectableText extends StatefulWidget {
  @override
  _AlignSelectableTextState createState() => _AlignSelectableTextState();
}

class _AlignSelectableTextState extends State<AlignSelectableText> {
  final text =
      "The [SelectableText] widget displays a string of text with a single style."
      "The string might break across multiple lines or might all be displayed on"
      "the same line depending on the layout constraints.";
  var _textAlign = TextAlign.left;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildSelector(),
        SelectableText(
          text,
          style: TextStyle(fontSize: 18, color: Colors.red),
          cursorColor: Colors.green,
          cursorRadius: Radius.circular(3),
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
        Text(
          "textAlign属性选择:",
          style: TextStyle(
              fontSize: 16, color: Colors.blue, fontWeight: FontWeight.bold),
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
                _textAlign = e;
              });
            }),
      ],
    );
  }
}
