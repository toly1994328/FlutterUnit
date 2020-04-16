import 'dart:io';

import 'package:flutter/material.dart';

//    {
//      "widgetId": 38,
//      "name": '可从资源文件和网络加载图片',
//      "priority": 1,
//      "subtitle":
//      "Image.asset加载资源图片,指定路径;\n"
//      "Image.network加载资源网络图片，指定链接。\n"
//      "Image.file加载资源文件图片，指定路径。\n"
//      "Image.memory加载内存图片，指定字节数组。\n"
//          "【height】 : 宽   【double】\n"
//          "【width】: 高 【double】"
//    }

class LoadImage extends StatelessWidget {
  final assetsImagePath = "assets/images/icon_head.png";
  final assetsGif = "assets/images/pica.gif";
  final netImageUrl = "https://user-gold-cdn.xitu.io"
      "/2019/7/24/16c225e78234ec26?"
      "imageView2/1/w/1304/h/734/q/85/format/webp/interlace/1";

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: <Widget>[
        _loadFromAssets(),
        _loadFromNet(),
      ],
    );
  }

  Widget _loadFromAssets() => Wrap(
        spacing: 10,
        children: <Widget>[
          Image.asset(assetsImagePath, height: 80, width: 80),
          Image.asset(assetsGif, height: 80, width: 80),
        ],
      );

  Widget _loadFromNet() => Image.network(netImageUrl, height: 80);
}

//    {
//      "widgetId": 38,
//      "name": '图片的适应模式',
//      "priority": 2,
//      "subtitle":
//          "【fit】 : 适应模式*7   【BoxFit】\n"
//    },

class FitImage extends StatefulWidget {
  @override
  _FitImageState createState() => _FitImageState();
}

class _FitImageState extends State<FitImage> {
  bool _smallImage = false;

  @override
  Widget build(BuildContext context) {
    var imageLi = BoxFit.values
        .toList()
        .map((mode) => Column(children: <Widget>[
              Container(
                  margin: EdgeInsets.all(5),
                  width: 100,
                  height: 80,
                  color: Colors.grey.withAlpha(88),
                  child: Image(
                      image: AssetImage(!_smallImage
                          ? "assets/images/wy_300x200.jpg"
                          : "assets/images/wy_30x20.jpg"),
                      fit: mode)),
              Text(mode.toString().split(".")[1])
            ]))
        .toList();

    return Wrap(
      children: [...imageLi, _buildSwitch()],
    );
  }

  Widget _buildSwitch() {
    return Container(
      alignment: Alignment.center,
      width: 200,
      height: 100,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          Text("使用小图"),
          Switch(
              value: _smallImage,
              onChanged: (b) => setState(() => _smallImage = b)),
        ],
      ),
    );
  }
}

//    {
//      "widgetId": 38,
//      "name": '图片对齐模式',
//      "priority": 3,
//      "subtitle":
//          "【alignment】 : 颜色   【AlignmentGeometry】\n"
//          "    常用Alignment类的九个静态常量，但也可定制位置"
//    },

class AlignmentImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var alignment = [
      Alignment.center,
      Alignment.centerLeft,
      Alignment.centerRight,
      Alignment.topCenter,
      Alignment.topLeft,
      Alignment.topRight,
      Alignment.bottomCenter,
      Alignment.bottomLeft,
      Alignment.bottomRight
    ]; //测试数组
    var imgLi = alignment
        .map((alignment) => //生成子Widget列表
            Column(children: <Widget>[
              Container(
                  margin: EdgeInsets.all(5),
                  width: 90,
                  height: 60,
                  color: Colors.grey.withAlpha(88),
                  child: Image(
                    image: AssetImage("assets/images/wy_30x20.jpg"),
                    alignment: alignment,
                  )),
              Text(alignment.toString())
            ]))
        .toList();
    var imageAlignment = Wrap(children: imgLi);
    return imageAlignment;
  }
}

//    {
//      "widgetId": 38,
//      "name": '图片颜色及混合模式',
//      "priority": 4,
//      "subtitle":
//          "【color】 : 颜色   【Color】\n"
//          "【colorBlendMode】: 混合模式*29 【BlendMode】"
//    },

class BlendModeImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: BlendMode.values
          .toList()
          .map((mode) => Column(children: <Widget>[
                Container(
                    margin: EdgeInsets.all(5),
                    width: 60,
                    height: 60,
                    color: Colors.red,
                    child: Image(
                        image: AssetImage("assets/images/icon_head.png"),
                        color: Colors.blue.withAlpha(88),
                        colorBlendMode: mode)),
                Text(mode.toString().split(".")[1])
              ]))
          .toList(),
    );
  }
}

//    {
//      "widgetId": 38,
//      "name": '图片重复模式',
//      "priority": 5,
//      "subtitle":
//          "【repeat】 : 重复模式*4   【ImageRepeat】"
//    },

class RepeatImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: ImageRepeat.values
          .toList()
          .map((mode) => Column(children: <Widget>[
                Container(
                    margin: EdgeInsets.all(5),
                    width: 150,
                    height: 60,
                    color: Colors.red,
                    child: Image(
                        image: AssetImage("assets/images/wy_30x20.jpg"),
                        repeat: mode)),
                Text(mode.toString().split(".")[1])
              ]))
          .toList(),
    );
  }
}

//    {
//      "widgetId": 38,
//      "name": '图片实现局部放大',
//      "priority": 6,
//      "subtitle":
//          "【centerSlice】 : 保留的区域   【Rect】"
//    },

class CenterSliceImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 80,
      child: Image.asset(
        "assets/images/right_chat.png",
        centerSlice: Rect.fromLTRB(9, 27, 60, 27 + 1.0),
        fit: BoxFit.fill,
      ),
    );
  }
}
