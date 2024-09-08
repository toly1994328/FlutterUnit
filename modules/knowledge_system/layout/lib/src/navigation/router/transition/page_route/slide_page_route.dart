//右--->左
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../slide_transition/cupertino_back_gesture_detector.dart';



class SlidePageRoute<T> extends MaterialPageRoute<T> {
  final Widget child;
  final Duration duration;

  SlidePageRoute({
    required this.child,
    this.duration = const Duration(milliseconds: 300),
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
          child: child);
    }
    final bool linearTransition = isPopGestureInProgress(this);
    return CupertinoPageTransition(
      primaryRouteAnimation: animation,
      secondaryRouteAnimation: secondaryAnimation,
      linearTransition: linearTransition,
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
