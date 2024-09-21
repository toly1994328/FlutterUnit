
import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-03-29
/// contact me by email 1981462002@qq.com


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
