import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//缩放路由动画
class ScaleRouter<T> extends MaterialPageRoute<T> {
  final Widget child;
  final Duration duration;
  final Curve curve;

  ScaleRouter({
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.fastOutSlowIn,
  }) : super(builder: (_) => child);

  @override
  Widget buildTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    return ScaleTransition(
      scale: Tween(begin: 0.0, end: 1.0)
          .animate(CurvedAnimation(parent: animation, curve: curve)),
      child: child,
    );
  }

  @override
  Duration get transitionDuration => duration;
}


//渐变透明路由动画
class FadeRouter<T> extends MaterialPageRoute<T> {
  final Widget child;
  final Duration duration;
  final Curve curve;

  FadeRouter({
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.fastOutSlowIn,
  }) : super(builder: (_) => child);

  @override
  Widget buildTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    return FadeTransition(
      opacity: Tween(begin: 0.1, end: 1.0).animate(CurvedAnimation(
        parent: animation,
        curve: curve,
      )),
      child: child,
    );
  }

  @override
  Duration get transitionDuration => duration;
}

//旋转路由动画
class RotateRouter<T> extends MaterialPageRoute<T> {
  final Widget child;
  final Duration duration;
  final Curve curve;

  RotateRouter({
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.fastOutSlowIn,
  }) : super(builder: (_) => child);

  @override
  Widget buildTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    return RotationTransition(
      turns: Tween(begin: 0.1, end: 1.0).animate(CurvedAnimation(
        parent: animation,
        curve: curve,
      )),
      child: child,
    );
  }

  @override
  Duration get transitionDuration => duration;
}

//右--->左
class Right2LeftRouter<T> extends MaterialPageRoute<T> {
  final Widget child;
  final Duration duration;
  final Curve curve;

  Right2LeftRouter({
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.fastOutSlowIn,
  }) : super(builder: (_) => child);

  @override
  Widget buildTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: const Offset(0.0, 0.0),
      ).animate(CurvedAnimation(parent: animation, curve: curve)),
      child: child,
    );
  }

  @override
  Duration get transitionDuration => duration;
}

//左--->右
class Left2RightRouter<T> extends MaterialPageRoute<T> {
  final Widget child;
  final Duration duration;
  final Curve curve;

  Left2RightRouter({
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.fastOutSlowIn,
  }) : super(builder: (_) => child);

  @override
  Widget buildTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-1.0, 0.0),
          end: const Offset(0.0, 0.0),
        ).animate(CurvedAnimation(parent: animation, curve: curve)),
        child: child);
  }

  @override
  Duration get transitionDuration => duration;
}


//上--->下
class Top2BottomRouter<T> extends MaterialPageRoute<T> {
  final Widget child;
  final Duration duration;
  final Curve curve;

  Top2BottomRouter({
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.fastOutSlowIn,
  }) : super(builder: (_) => child);

  @override
  Widget buildTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.0, -1.0),
          end: const Offset(0.0, 0.0),
        ).animate(CurvedAnimation(parent: animation, curve: curve)),
        child: child);
  }

  @override
  Duration get transitionDuration => duration;
}

//下--->上
class Bottom2TopRouter<T> extends MaterialPageRoute<T> {
  final Widget child;
  final Duration duration;
  final Curve curve;

  Bottom2TopRouter({
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.fastOutSlowIn,
  }) : super(builder: (_) => child);

  @override
  Widget buildTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.0, 1.0),
          end: const Offset(0.0, 0.0),
        ).animate(CurvedAnimation(parent: animation, curve: curve)),
        child: child);
  }

  @override
  Duration get transitionDuration => duration;
}

//缩放+透明+旋转路由动画
class ScaleFadeRouter<T> extends MaterialPageRoute<T> {
  final Widget child;
  final Duration duration;
  final Curve curve;

  ScaleFadeRouter({
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.fastOutSlowIn,
  }) : super(builder: (_) => child);

  @override
  Widget buildTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    return ScaleTransition(
      //缩放动画
      scale: Tween(begin: 0.6, end: 1.0)
          .animate(CurvedAnimation(parent: animation, curve: curve)),
      child: FadeTransition(
        opacity: //透明度动画
        Tween(begin: 0.5, end: 1.0)
            .animate(CurvedAnimation(parent: animation, curve: curve)),
        child: child,
      ),
    );
  }

  @override
  Duration get transitionDuration => duration;
}


//缩放+透明+旋转路由动画
class ScaleFadeRotateRouter<T> extends MaterialPageRoute<T> {
  final Widget child;
  final Duration duration;
  final Curve curve;

  ScaleFadeRotateRouter({
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.fastOutSlowIn,
  }) : super(builder: (_) => child);

  @override
  Widget buildTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    return RotationTransition(
      //旋转动画
      turns: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animation,
        curve: curve,
      )),
      child: ScaleTransition(
        //缩放动画
        scale: Tween(begin: 0.0, end: 1.0)
            .animate(CurvedAnimation(parent: animation, curve: curve)),
        child: FadeTransition(
          opacity: //透明度动画
          Tween(begin: 0.5, end: 1.0)
              .animate(CurvedAnimation(parent: animation, curve: curve)),
          child: child,
        ),
      ),
    );
  }

  @override
  Duration get transitionDuration => duration;
}


//无动画
class NoAnimRouter<T> extends MaterialPageRoute<T> {
  final Widget page;
  NoAnimRouter(this.page) : super(builder: (_) => page);

  @override
  Widget buildTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    return child;
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);
}

