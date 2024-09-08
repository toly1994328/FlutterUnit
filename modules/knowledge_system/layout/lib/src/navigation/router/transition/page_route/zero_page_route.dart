
import 'dart:io';

import 'package:flutter/material.dart';

import '../slide_transition/cupertino_back_gesture_detector.dart';


class ZeroPageRoute<T> extends MaterialPageRoute<T> {
  final Widget child;


  ZeroPageRoute({
    required this.child,
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
    return child;
  }

  @override
  Duration get transitionDuration => Duration.zero;
}
