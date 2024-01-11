import 'package:toly_ui/toly_ui.dart';
import 'package:flutter/material.dart';


/// create by 张风捷特烈 on 2020/4/27
/// contact me by email 1981462002@qq.com
/// 说明:

class ArcClipper extends CustomClipper<Path> {
  final double factor;

  ArcClipper({this.factor = 0.618});

  @override
  Path getClip(Size size) => Path()
    ..moveTo(0, 0)
    ..relativeLineTo(size.width, 0)
    ..relativeLineTo(0, 0.8 * size.height)
    ..arcToPoint(
      Offset(0.0, size.height * 0.618),
      radius: const Radius.elliptical(50.0, 10.0),
      rotation: 0.0,
    )
    ..close();

  @override
  bool shouldReclip(ArcClipper oldClipper) => factor != oldClipper.factor;
}

class ArcBackground extends StatelessWidget {
  final Widget? child;
  final ImageProvider image;

  const ArcBackground({Key? key, this.child, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ArcClipper(),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: image,
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}

class UnitArcBackground extends StatelessWidget {
  final double height;
  const UnitArcBackground({Key? key,required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ArcBackground(
        image: const AssetImage("assets/images/caver.webp"),
        child: Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
              color: Colors.blue.withAlpha(88), shape: BoxShape.circle),
          child: const CircleImage(
              size: 100,
              roundColor: Colors.blue,
              image: AssetImage(
                'assets/images/sabar.webp',
              )),
        ),
      ),
    );
  }
}
