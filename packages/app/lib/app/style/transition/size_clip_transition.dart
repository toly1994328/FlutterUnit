import 'dart:math';

import 'package:flutter/cupertino.dart';

class SizeClipTransition extends StatelessWidget {
  final Animation<double> animation;
  final Animation<double> secondaryAnimation;
  final Widget child;

  const SizeClipTransition({
    super.key,
    required this.animation,
    required this.secondaryAnimation,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CirclePathClipper(Curves.easeIn.transform(animation.value)),
      child: child,
    );
  }
}

class SizePathClipper extends CustomClipper<Path> {
  final double progress;

  SizePathClipper(this.progress);

  @override
  Path getClip(Size size) {
    Rect box = Rect.fromLTWH(0, 0, size.width, size.height);
    Rect center = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: size.width * (1 - progress),
      height: size.height,
    );

    return Path()
      ..addRect(box)
      ..addRect(center)
      ..fillType = PathFillType.evenOdd;
  }

  @override
  bool shouldReclip(covariant SizePathClipper oldClipper) {
    return oldClipper.progress != progress;
  }
}

class ScalePathClipper extends CustomClipper<Path> {
  final double progress;

  ScalePathClipper(this.progress);

  @override
  Path getClip(Size size) {
    Rect box = Rect.fromLTWH(0, 0, size.width, size.height);
    Rect center = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: size.width * (1 - progress),
      height: size.height* (1 - progress),
    );

    return Path()
      ..addRect(box)
      ..addRect(center)
      ..fillType = PathFillType.evenOdd;
  }

  @override
  bool shouldReclip(covariant ScalePathClipper oldClipper) {
    return oldClipper.progress != progress;
  }
}

class CirclePathClipper extends CustomClipper<Path> {
  final double progress;

  CirclePathClipper(this.progress);

  @override
  Path getClip(Size size) {
    print('progress:$progress');
    if(progress==0){
      return Path();
    }
    Rect box = Rect.fromLTWH(0, 0, size.width, size.height);
    Rect center = Rect.fromCircle(
      center: Offset(size.width , 0),
      radius: sqrt(size.width*size.width+size.height*size.height) * (progress),
    );

    Path zone = Path()..addRect(box);
    Path cliper = Path()..addOval(center);

    return Path.combine(PathOperation.intersect, zone, cliper );
  }

  @override
  bool shouldReclip(covariant CirclePathClipper oldClipper) {
    return oldClipper.progress != progress;
  }
}