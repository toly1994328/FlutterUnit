import 'dart:math';

import 'package:flutter/material.dart';

enum FlutterMode {
  //颤动的模式
  random, //随机模式
  up_down, //上下
  left_right, //左右
  swing //倾斜
}

class AnimConfig {
  //动画配置信息
  final int duration; //时长
  final double offset; //偏移大小
  final FlutterMode mode; //摇晃模式
  final Curve curve; //运动曲线

  const AnimConfig(
      {this.duration = 1000,
      this.offset = 15,
      this.mode = FlutterMode.swing,
      this.curve = Curves.bounceIn});
}

class FlutterContainer extends StatefulWidget {
  final Widget child;
  final AnimConfig config;
  final VoidCallback onFinish;

  FlutterContainer(
      {Key key,
      @required this.child, //孩子
      this.config = const AnimConfig(), //配置
      this.onFinish} //动画结束回调
      )
      : super(key: key);

  _FlutterContainerState createState() => _FlutterContainerState();
}

class _FlutterContainerState extends State<FlutterContainer>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  Animation<double> animationRotate;
  var random = Random();

  @override
  initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);

    var offset = widget.config.offset; //偏移量
    var offsets = <Offset>[]; //起止值的列表盛放在offsets里
    offsets.add(Offset(0, offset)); //添加第一个
    var temp = offset; //临时变量
    for (var i = 1; i <= offset; i++) {
      temp--; //临时变量减小
      offsets.add(i.isOdd ? Offset(temp, -temp) : Offset(-temp, temp)); //动态添加
    }
    print(offsets);
    animation = TweenSequence<double>(offsets
            .map((e) => TweenSequenceItem<double>(
                tween: Tween(begin: e.dx, end: e.dy), weight: 1))
            .toList())
        .animate(CurveTween(curve: widget.config.curve).animate(controller))
          ..addStatusListener((s) {//添加完成回调
            if (s == AnimationStatus.completed) {
              if (widget.onFinish != null) widget.onFinish();
            }
          });
    controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.config.mode) {
      case FlutterMode.up_down: //上下效果
        return AnimUpDown(
          animation: animation,
          child: widget.child,
        );

      case FlutterMode.left_right: //左右效果
        return AnimLeftRight(
          animation: animation,
          child: widget.child,
        );

      case FlutterMode.swing: //摇摆效果
        animationRotate =
            Tween(begin: 0.0, end: pi / 180).animate(animation); //将参数转化为弧度
        return AnimRotate(
          animation: animationRotate,
          child: widget.child,
        );

      case FlutterMode.random: //随机效果
        var config = AnimConfig(
            mode: FlutterMode.values[random.nextInt(FlutterMode.values.length)],
            duration: widget.config.duration,
            offset: widget.config.offset,
            curve: widget.config.curve);
        return FlutterContainer(
          onFinish: widget.onFinish,
          child: widget.child,
          config: config,
        );
        break;
    }
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }
}

class AnimRotate extends AnimatedWidget {
  AnimRotate({Key key, Animation<double> animation, this.child})
      : super(key: key, listenable: animation);
  final Widget child; //孩子组件
  @override
  Widget build(BuildContext context) {
    final Animation animation = listenable; //获取动画器
    return Transform(
      //根据动画器数值对孩子进行旋转
      child: child,
      alignment: Alignment.center,
      transform: Matrix4.rotationZ(animation.value),
    );
  }
}

//左右动画
class AnimLeftRight extends AnimatedWidget {
  AnimLeftRight({Key key, Animation<double> animation, this.child})
      : super(key: key, listenable: animation);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final Animation animation = listenable;
    return Transform(
      transform: Matrix4.translationValues(animation.value, 0, 0),
      alignment: Alignment.center,
      child: child,
    );
  }
}

//上下效果
class AnimUpDown extends AnimatedWidget {
  AnimUpDown({Key key, Animation<double> animation, this.child})
      : super(key: key, listenable: animation);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final Animation animation = listenable;
    return Transform(
      alignment: Alignment.center,
      child: child,
      transform: Matrix4.translationValues(0, animation.value, 0),
    );
  }
}
