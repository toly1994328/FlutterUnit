
import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-03-29
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 38,
//      "name": '可从资源文件和网络加载图片',
//      "priority": 1,
//      "subtitle": "Image.asset加载资源图片,指定路径;\n"
//      "Image.network加载资源网络图片，指定链接。\n"
//      "Image.file加载资源文件图片，指定路径。\n"
//      "Image.memory加载内存图片，指定字节数组。\n"
//          "【height】 : 宽   【double】\n"
//          "【width】: 高 【double】"
//    }

class LoadImage extends StatelessWidget {
  const LoadImage({Key? key}) : super(key: key);

  final String assetsImagePath = "assets/images/icon_head.webp";
  final String netImageUrl = "https://p9-juejin.byteimg.com"
      "/tos-cn-i-k3u1fbpfcp/36dee4e4dceb4c41a93df4a3603439fe~"
      "tplv-k3u1fbpfcp-zoom-crop-mark:1304:1304:1304:734.awebp";

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: [
        Image.asset(assetsImagePath, height: 80, width: 80),
        _loadFromNet(),
      ],
    );
  }

  Widget _loadFromNet() => Image.network(netImageUrl, height: 80);
}
