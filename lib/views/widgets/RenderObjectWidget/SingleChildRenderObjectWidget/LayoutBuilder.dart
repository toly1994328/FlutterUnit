import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-04-19
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 287,
//      "name": 'LayoutBuilder基本认识',
//      "priority": 1,
//      "subtitle":
//          "【builder】 : 布局构造器   【LayoutWidgetBuilder】",
//    }
class CustomLayoutBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('CustomLayoutBuild');
    return Container(
      alignment: Alignment.center,
      height: 80,
      width: 150,
      color: Colors.green,
      child: LayoutBuilder(
        builder: (_, zone) {
          return Text(
            '父容器宽:${zone.maxWidth}\n'
            '父容器高:${zone.maxHeight}',
            style: TextStyle(color: Colors.white, fontSize: 16),
          );
        },
      ),
    );
  }
}

//    {
//      "widgetId": 287,
//      "name": 'LayoutBuilder的适应布局',
//      "priority": 2,
//      "subtitle":
//          "可以根据区域的大小进行组件展示设计。"
//          "比如在不同的宽度区域显示不同的布局结构。"
//          "毕竟很多地方不容易获取父组件区域，使用LayoutBuilder就会非常爽口。",
//    }

class FitByLayoutBuilder extends StatefulWidget {
  @override
  _FitByLayoutBuilderState createState() => _FitByLayoutBuilderState();
}

class _FitByLayoutBuilderState extends State<FitByLayoutBuilder> {
  double _width = 100;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: _width,
          child: LayoutBuilder(
            builder: (_, zone) {
              if (zone.maxWidth <= 150) {
                return _buildType1();
              } else {
                return _buildType2(zone);
              }
            },
          ),
        ),
        _buildSlider(),
      ],
    );
  }

  Widget _buildSlider() {
    return Slider(
          min: 50,
          max: 300,
          label: "父宽:${_width.toStringAsFixed(1)}",
          value: _width,
          onChanged: (v) => setState(() {
              _width = v;
            }));
  }

  Widget _buildType1() => Container(
        color: Colors.blue,
        child: Column(
          children: <Widget>[
            _buildTitle(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildContent(),
            ),
          ],
        ),
      );

  Widget _buildType2(BoxConstraints zone) => Container(
        height: 100,
        width: zone.maxWidth,
        color: Colors.orange,
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              height: 80,
              width: 30,
              color: Colors.grey,
            ),
            Expanded(child: _buildContent())
          ],
        ),
      );

  Widget _buildTitle() => Container(
        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
        color: Colors.grey,
        height: 30,
      );

  Widget _buildContent() => Wrap(
        runSpacing: 3,
        children: <Widget>[
          Container(
            color: Colors.red,
            height: 30,
          ),
          Container(
            color: Colors.yellow,
            height: 30,
          ),
          Container(
            color: Colors.green,
            height: 30,
          ),
        ],
      );
}

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

