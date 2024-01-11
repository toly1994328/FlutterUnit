import 'package:flutter/material.dart';

class CircleText extends StatelessWidget {
  const CircleText({
    Key? key,
    required this.text,
    this.size = 70,
    this.fontSize = 24,
    this.color = Colors.white,
    this.shadowColor,
    this.backgroundColor,
    this.roundColor,
  }) : super(key: key);

  final String text; //图片
  final double size; //大小
  final double fontSize; //大小
  final Color? shadowColor; //阴影颜色
  final Color color; //阴影颜色
  final Color? roundColor; //边框颜色
  final Color? backgroundColor; //边框颜色

  @override
  Widget build(BuildContext context) {
    Widget headIcon = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle, //圆形装饰线
        color: roundColor ?? Colors.white,
        boxShadow: [
          BoxShadow(
            //阴影
            color: shadowColor ?? Colors.grey.withOpacity(0.3),
            offset: const Offset(0.0, 0.0), blurRadius: 3.0, spreadRadius: 0.0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: Container(
            alignment: Alignment.center,
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle, //圆形装饰线
              color: backgroundColor ?? const Color(0xffD8F5FF),
            ),
            child: Text(
              text.length > 2 ? text.substring(0, 2) : text,
              style: TextStyle(
                fontSize: fontSize,
                color: color,
                fontWeight: FontWeight.bold,
                shadows: const [
                  Shadow(
                    //阴影
                    color: Colors.grey,
                    offset: Offset(1.0, 1.0), blurRadius: 1.0,
                  )
                ],
              ),
            )),
      ),
    );
    return headIcon;
  }
}
