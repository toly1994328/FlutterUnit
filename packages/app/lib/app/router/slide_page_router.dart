//右--->左
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'cupertino_back_gesture_detector.dart';

class SlidePageRouter<T> extends MaterialPageRoute<T> {
  final Widget child;
  final Duration duration;
  final Curve? curve;

  SlidePageRouter({
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
          enabledCallback: () => _isPopGestureEnabled<T>(this),
          onStartPopGesture: () => _startPopGesture<T>(this),
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


  // Called by _CupertinoBackGestureDetector when a pop ("back") drag start
  // gesture is detected. The returned controller handles all of the subsequent
  // drag events.
  static CupertinoBackGestureController<T> _startPopGesture<T>(
      PageRoute<T> route) {
    return CupertinoBackGestureController<T>(
      navigator: route.navigator!,
      controller: route.controller!, // protected access
    );
  }

  static bool _isPopGestureEnabled<T>(PageRoute<T> route) {
    print(
        "======_isPopGestureEnabled:${route.hasScopedWillPopCallback}=========");
    // If there's nothing to go back to, then obviously we don't support
    // the back gesture.
    if (route.isFirst) {
      return false;
    }
    // If the route wouldn't actually pop if we popped it, then the gesture
    // would be really confusing (or would skip internal routes), so disallow it.
    if (route.willHandlePopInternally) {
      return false;
    }
    // If attempts to dismiss this route might be vetoed such as in a page
    // with forms, then do not allow the user to dismiss the route with a swipe.
    if (route.hasScopedWillPopCallback) {
      return false;
    }
    // Fullscreen dialogs aren't dismissible by back swipe.
    if (route.fullscreenDialog) {
      return false;
    }
    // If we're in an animation already, we cannot be manually swiped.
    if (route.animation!.status != AnimationStatus.completed) {
      return false;
    }
    // If we're being popped into, we also cannot be swiped until the pop above
    // it completes. This translates to our secondary animation being
    // dismissed.
    if (route.secondaryAnimation!.status != AnimationStatus.dismissed) {
      return false;
    }
    // If we're in a gesture already, we cannot start another.
    if (isPopGestureInProgress(route)) {
      return false;
    }

    // Looks like a back gesture would be welcome!
    return true;
  }

  /// True if an iOS-style back swipe pop gesture is currently underway for [route].
  ///
  /// This just check the route's [NavigatorState.userGestureInProgress].
  ///
  /// See also:
  ///
  ///  * [popGestureEnabled], which returns true if a user-triggered pop gesture
  ///    would be allowed.
  static bool isPopGestureInProgress(PageRoute<dynamic> route) {
    return route.navigator!.userGestureInProgress;
  }
}
