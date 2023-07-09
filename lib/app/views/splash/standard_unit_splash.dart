import 'dart:math';

import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utils/utils.dart';

import 'package:widget_module/blocs/blocs.dart';

import 'dart:ui' as ui;

import 'package:widget_repository/widget_repository.dart';

import 'flutter_unit_text.dart';

/// create by 张风捷特烈 on 2020-03-07
/// contact me by email 1981462002@qq.com
/// 说明: app 闪屏页

class StandardUnitSplash extends StatefulWidget {
  const StandardUnitSplash({Key? key}) : super(key: key);

  @override
  _StandardUnitSplashState createState() => _StandardUnitSplashState();
}

class _StandardUnitSplashState extends State<StandardUnitSplash>
    with TickerProviderStateMixin {
  static const int _minCost = 1500;

  int _recorder = 0;

  final Paint paint = Paint()
    ..style = PaintingStyle.stroke
    ..shader = ui.Gradient.linear(
      const Offset(0, 0),
      const Offset(22, 0),
      [Colors.red, Colors.yellow, Colors.blue, Colors.green],
      [1 / 4, 2 / 4, 3 / 4, 1],
      TileMode.mirror,
      Matrix4.rotationZ(pi / 4).storage,
    );

  @override
  void initState() {
    super.initState();
    _recorder = DateTime.now().millisecondsSinceEpoch;
  }

  @override
  Widget build(BuildContext context) {
    final Size winSize = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark),
      child: Material(
        child: BlocListener<AppBloc, AppState>(
            listener: _listenStart,
            listenWhen: (p,n)=>p.dbPath.isEmpty&&n.dbPath.isNotEmpty,
            child: Column(
              children: [
                const Spacer(),
                Expanded(
                    child: Wrap(
                  direction: Axis.vertical,
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Text(
                          "U",
                          style: TextStyle(
                              fontSize: 26,
                              height: 1,
                              fontWeight: FontWeight.bold,
                              foreground: paint),
                        ),
                        const FlutterLogo(size: 60),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    _buildFlutterUnitText(winSize.height, winSize.width),
                  ],
                )),
                Expanded(
                    child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Positioned(
                        bottom: 15,
                        child: Wrap(
                          direction: Axis.vertical,
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: const [
                            Text("Power By 张风捷特烈",
                                style: UnitTextStyle.splashShadows),
                            Text("· 2021 ·  @编程之王 ",
                                style: UnitTextStyle.splashShadows),
                          ],
                        )),
                  ],
                ))
              ],
            )),
      ),
    );
  }

  Widget _buildFlutterUnitText(double winH, double winW) {
    return FlutterUnitText(
      text: StrUnit.appName,
      color: Theme.of(context).primaryColor,
    );
  }

  // 监听资源加载完毕，启动，触发事件
  void _listenStart(BuildContext context, AppState state) {
    HttpUtil.instance.rebase(PathUnit.baseUrl);
    int cost = DateTime.now().millisecondsSinceEpoch - _recorder;
    BlocProvider.of<WidgetsBloc>(context)
        .add(const EventTabTap(WidgetFamily.statelessWidget));
    BlocProvider.of<LikeWidgetBloc>(context).add(const EventLoadLikeData());
    BlocProvider.of<CategoryBloc>(context).add(const EventLoadCategory());

    // 启动耗时小于 _minCost 时，等待 delay 毫秒
    int delay = cost < _minCost ? _minCost - cost : 0;
    Future.delayed(Duration(milliseconds: delay)).then((value) {
      Navigator.of(context).pushReplacementNamed(UnitRouter.nav);
    });
  }
}
