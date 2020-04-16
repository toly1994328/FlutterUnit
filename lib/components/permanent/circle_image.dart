import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  CircleImage(
      {Key key,
      @required this.image,
      this.size = 70,
      this.shadowColor,
      this.roundColor})
      : super(key: key);
  final ImageProvider image; //图片
  final double size; //大小
  final Color shadowColor; //阴影颜色
  final Color roundColor; //边框颜色
  @override
  Widget build(BuildContext context) {
    var headIcon = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle, //圆形装饰线
        color: roundColor ?? Colors.white,
        boxShadow: [
          BoxShadow(
            //阴影
            color: shadowColor ?? Colors.grey.withOpacity(0.3),
            offset: Offset(0.0, 0.0), blurRadius: 3.0, spreadRadius: 0.0,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(3),
        child:
        CircleAvatar(
          backgroundImage: image,
        ),
      ),
    );
    return headIcon;
  }
}
