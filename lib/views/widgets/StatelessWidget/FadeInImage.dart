import 'package:flutter/material.dart';

class CustomFadeInImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var placeholder = "assets/images/icon_head.png";
    var img =
        "https://user-gold-cdn.xitu.io/2017/8/24/"
        "d324efef8cbee6468a018aad7ab2ba6b?imageView2/"
        "1/w/180/h/180/q/85/format/webp/interlace/1";
    return FadeInImage.assetNetwork(
        placeholder: placeholder,
        image: img,
      width: 100,
      height: 100,
      fit: BoxFit.cover,
      repeat:ImageRepeat.noRepeat,
      alignment: Alignment.center,
      fadeInDuration: Duration(seconds: 5),
      fadeInCurve: Curves.easeInCubic,
    );
  }
}
