import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'
    hide RefreshIndicator, RefreshIndicatorState;
import 'package:flutter/services.dart';
import 'package:refresh/refresh.dart';

class TolyRefreshIndicator extends RefreshIndicator {
  const TolyRefreshIndicator({super.key});

  @override
  State<StatefulWidget> createState() => _TolyRefreshIndicatorState();
}

class _TolyRefreshIndicatorState
    extends RefreshIndicatorState<TolyRefreshIndicator>
    with TickerProviderStateMixin {
  late AnimationController _iconRotateCtrl;
  late Animation<double> rotateAnima;

  @override
  void initState() {
    super.initState();
    _iconRotateCtrl =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 250));
    rotateAnima = Tween(begin: 0.0, end: -0.5).animate(_iconRotateCtrl);
  }

  @override
  void onModeChange(RefreshStatus? mode) {
    if (mode == RefreshStatus.canRefresh) {
      HapticFeedback.lightImpact();
      _iconRotateCtrl.forward();
    }

    if (mode == RefreshStatus.idle) {
      if (_iconRotateCtrl.isCompleted) {
        _iconRotateCtrl.reverse();
      }
    }
  }

  @override
  Future<void> readyToRefresh() {
    // TODO: implement readyToRefresh
    // final Simulation simulation = SpringSimulation(
    //     SpringDescription(
    //       mass: 3.4,
    //       stiffness: 10000.5,
    //       damping: 6,
    //     ),
    //     _beizerBounceCtl.value,
    //     0,
    //     1000);
    // _beizerBounceCtl.animateWith(simulation);
    // if (widget.readyRefresh != null) {
    //   return widget.readyRefresh!();
    // }
    return super.readyToRefresh();
  }

  @override
  Widget buildContent(BuildContext context, RefreshStatus mode) {
    Widget child = switch (mode) {
      RefreshStatus.refreshing => const CupertinoActivityIndicator(radius: 10,),
      RefreshStatus.completed => const Icon(Icons.check,color: Colors.green,),
      RefreshStatus.idle || RefreshStatus.canRefresh => RotationTransition(
          turns: rotateAnima,
          child: Icon(
            CupertinoIcons.arrow_down,
            color: Color(0xff666668),
          ),
        ),
      _ => SizedBox()
    };

    return Container(
      // color: Colors.blue,
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: child,
      )),
    );
  }

  @override
  void onOffsetChange(double offset) {
    // print(offset);
  }
}
