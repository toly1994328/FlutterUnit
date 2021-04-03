import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/res/str_unit.dart';
import 'package:flutter_unit/app/router/unit_router.dart';
import 'package:flutter_unit/blocs/bloc_exp.dart';
import 'package:flutter_unit/model/enums.dart';
import 'package:flutter_unit/views/pages/splash/splash_bottom.dart';

import 'unit_paint.dart';

/// create by 张风捷特烈 on 2020-03-07
/// contact me by email 1981462002@qq.com
/// 说明: app 闪屏页

class UnitSplash extends StatefulWidget {
  @override
  _UnitSplashState createState() => _UnitSplashState();
}

class _UnitSplashState extends State<UnitSplash> with TickerProviderStateMixin {
  AnimationController _controller;
  bool _animEnd = false;

  final Duration animTime = const Duration(milliseconds: 1000);
  final Duration delayTime = const Duration(milliseconds: 500);
  final Duration fadeInTime = const Duration(milliseconds: 600);

  @override
  void initState() {
    super.initState();

    SystemUiOverlayStyle systemUiOverlayStyle =
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

    _controller = AnimationController(duration: animTime, vsync: this)
      ..addStatusListener(_listenStatus)
      ..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _listenStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      setState(() {
        _animEnd = true;
        Future.delayed(delayTime).then((e) {
          Navigator.of(context).pushReplacementNamed(UnitRouter.nav);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double winH = MediaQuery.of(context).size.height;
    final double winW = MediaQuery.of(context).size.width;

    return BlocListener<GlobalBloc, GlobalState>(
      listener: _listenStart,
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            _buildFlutterLogo(),
            Container(
              width: winW,
              height: winH,
              child: CustomPaint(
                painter: UnitPainter(repaint: _controller),
              ),
            ),
            _buildFlutterUnitText(winH, winW),
            _buildHead(),
            Positioned(bottom: 15, child: SplashBottom())
          ],
        ),
      ),
    );
  }

  Widget _buildFlutterUnitText(double winH, double winW) {
    final shadowStyle = TextStyle(
      fontSize: 45,
      color: Theme.of(context).primaryColor,
      fontWeight: FontWeight.bold,
      shadows: [
        const Shadow(
          color: Colors.grey,
          offset: Offset(1.0, 1.0),
          blurRadius: 1.0,
        )
      ],
    );

    return Positioned(
      top: winH / 1.4,
      child: AnimatedOpacity(
          duration: fadeInTime,
          opacity: _animEnd ? 1.0 : 0.0,
          child: Text(
            StrUnit.appName,
            style: shadowStyle,
          )),
    );
  }

  Widget _buildFlutterLogo() {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0),
        end: const Offset(0, -1.5),
      ).animate(_controller),
      child: RotationTransition(
          turns: _controller,
          child: ScaleTransition(
            scale: Tween(begin: 2.0, end: 1.0).animate(_controller),
            child: FadeTransition(
                opacity: _controller,
                child: Container(
                  height: 120,
                  child: const FlutterLogo(
                    size: 60,
                  ),
                )),
          )),
    );
  }

  Widget _buildHead() => SlideTransition(
      position: Tween<Offset>(
        end: const Offset(0, 0),
        begin: const Offset(0, -5),
      ).animate(_controller),
      child: Container(
        height: 45,
        width: 45,
        child: Image.asset('assets/images/icon_head.webp'),
      ));

  // 监听资源加载完毕，启动，触发事件
  void _listenStart(BuildContext context, GlobalState state) {
      BlocProvider.of<WidgetsBloc>(context).add(EventTabTap(WidgetFamily.statelessWidget));
      BlocProvider.of<LikeWidgetBloc>(context).add(EventLoadLikeData());
      BlocProvider.of<CategoryBloc>(context).add(EventLoadCategory());
  }
}
