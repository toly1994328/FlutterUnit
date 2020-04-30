import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-04-19
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 287,
//      "name": 'LayoutBuilder的展开使用',
//      "priority": 3,
//      "subtitle":
//          "使用TextPainter来检测文字的行数，实现展开或收起功能。",
//    }

class SimpleExpandableText extends StatefulWidget {

  @override
  createState() => _SimpleExpandableTextState();
}

class _SimpleExpandableTextState extends State<SimpleExpandableText> {

  final text = '桃树、杏树、梨树，你不让我，我不让你，都开满了花赶趟儿。'
      '红的像火，粉的像霞，白的像雪。'
      '花里带着甜味儿；闭了眼，树上仿佛已经满是桃儿、杏儿、梨儿。'
      '花下成千成百的蜜蜂嗡嗡地闹着，大小的蝴蝶飞来飞去。'
      '野花遍地是：杂样儿，有名字的，没名字的，散在草丛里，像眼睛，像星星，还眨呀眨的。';

  bool expand = false;
  int maxLines =3;


  final style = TextStyle(fontSize: 15, color: Colors.grey, shadows: [
    Shadow(
        color: Colors.white, offset: Offset(1,1)
    )
  ]);

  @override
  build(context) => Container(
    decoration: BoxDecoration(
        color: Colors.cyanAccent.withAlpha(8),
        borderRadius: BorderRadiusDirectional.all(Radius.circular(20))),
    padding: EdgeInsets.all(15),
    child: LayoutBuilder(builder: (context, size) {

      final painter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: maxLines,
        textDirection: TextDirection.ltr,
      );
      painter.layout(maxWidth: size.maxWidth);
      if (!painter.didExceedMaxLines)
        return Text(text, style: style);

      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(text, maxLines: expand ? null : 3, style: style),
          GestureDetector(
            onTap: () => setState(() {
                expand = !expand;
              }),
            child: Text(
              expand ? '<< 收起' : '展开 >>',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      );
    }),
  );
}

