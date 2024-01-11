import 'dart:io';

import 'package:app/app/style/transition/slide_transition/cupertino_back_gesture_detector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SlidePageTransitionsBuilder extends PageTransitionsBuilder {
  const SlidePageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
      PageRoute<T>? route,
      BuildContext? context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    if (Platform.isIOS) {
      child = CupertinoBackGestureDetector(
          enabledCallback: () => isPopGestureEnabled<T>(route!),
          onStartPopGesture: () => startPopGesture<T>(route!),
          child: child);
    }
    final bool linearTransition = isPopGestureInProgress(route!);
    return CupertinoPageTransition(
      primaryRouteAnimation: animation,
      secondaryRouteAnimation: secondaryAnimation,
      linearTransition: linearTransition,
      child: child,
    );
  }
}