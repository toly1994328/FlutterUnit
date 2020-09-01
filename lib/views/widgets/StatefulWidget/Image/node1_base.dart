
import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-03-29
/// contact me by email 1981462002@qq.com
/// 说明:
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
  final assetsImagePath = "assets/images/icon_head.webp";
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
