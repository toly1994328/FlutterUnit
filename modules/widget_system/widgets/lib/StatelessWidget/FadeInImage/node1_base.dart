import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-26
/// contact me by email 1981462002@qq.com


class CustomFadeInImage extends StatelessWidget {
  const CustomFadeInImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String placeholder = "assets/images/icon_head.webp";
    String img =
        "https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/"
        "15739960c2da4de3a263eeabcb60057f~tplv-k3u1fbpfcp-zoom-crop-mark"
        ":1304:1304:1304:734.awebp";
    return FadeInImage.assetNetwork(
        placeholder: placeholder,
        image: img,
      width: 100,
      height: 100,
      fit: BoxFit.cover,
      repeat:ImageRepeat.noRepeat,
      alignment: Alignment.center,
      fadeInDuration:const Duration(seconds: 5),
      fadeInCurve: Curves.easeInCubic,
    );
  }
}
