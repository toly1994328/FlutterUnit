//渐变透明路由动画
import 'dart:io';

import 'package:flutter/material.dart';

import '../style/transition/slide_transition/cupertino_back_gesture_detector.dart';

class FadePageRoute<T> extends MaterialPageRoute<T> {
  final Widget child;
  final Duration duration;
  final Curve? curve;

  FadePageRoute({
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.curve,
  }) : super(builder: (_) => child);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (Platform.isIOS) {
      child = CupertinoBackGestureDetector(
        enabledCallback: () => isPopGestureEnabled<T>(this),
        onStartPopGesture: () => startPopGesture<T>(this),
        child: child,
      );
    }

    if (curve != null) {
      animation = CurvedAnimation(
        parent: animation,
        curve: curve!,
      );
    }

    return FadeTransition(
      opacity: Tween(begin: 0.1, end: 1.0).animate(animation),
      child: child,
    );
  }

  @override
  Duration get transitionDuration => duration;

  @override
  @protected
  bool get hasScopedWillPopCallback {
    return false;
  }
}
