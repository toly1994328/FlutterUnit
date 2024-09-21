import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-04-19
/// contact me by email 1981462002@qq.com

class ShapeImageDemo extends StatelessWidget {
  const ShapeImageDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                'assets/images/wy_200x300.webp',
              ))),
      child: SizedBox(
        height: 80,
        width: 80,
        child: Icon(
          Icons.ac_unit,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }
}
