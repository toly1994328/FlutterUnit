import 'dart:math';

import 'package:db_storage/db_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/res/cons/str_unit.dart';
import 'package:flutter_unit/app/res/style/unit_text_style.dart';
import 'package:flutter_unit/app/router/unit_router.dart';
import 'package:flutter_unit/app/views/splash/splash_bottom.dart';
import 'package:flutter_unit/widget_system/blocs/widget_system_bloc.dart';
import 'package:flutter_unit/app/blocs/global/global_bloc.dart';
import 'package:flutter_unit/app/blocs/global/global_state.dart';
import 'package:widget_repository/widget_repository.dart';

import 'flutter_unit_text.dart';
import 'unit_paint.dart';
import 'dart:io';
/// create by 张风捷特烈 on 2020-03-07
/// contact me by email 1981462002@qq.com
/// 说明: app 闪屏页

class StandardUnitSplash extends StatefulWidget {
  const StandardUnitSplash({Key? key}) : super(key: key);

  @override
  _StandardUnitSplashState createState() => _StandardUnitSplashState();
}

class _StandardUnitSplashState extends State<StandardUnitSplash> with TickerProviderStateMixin {
 static const int _minCost = 1500;

  int _recoder = 0;

  @override
  void initState() {
    super.initState();
    _recoder = DateTime.now().millisecondsSinceEpoch;
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size winSize = MediaQuery.of(context).size;
    return Material(
      child: BlocListener<AppBloc, AppState>(
        listener: _listenStart,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Wrap(
              direction: Axis.vertical,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Row(
                  children: [
                    _buildHead(),
                    const  Padding(
                      padding:  EdgeInsets.all(8.0),
                      child:  Text('&',style: TextStyle(fontSize: 30),),
                    ),
                    const FlutterLogo(size: 60),
                  ],
                ),
                const SizedBox(height: 20,),
                _buildFlutterUnitText(winSize.height, winSize.width),
              ],
            ),
             Positioned(bottom: 15, child: Wrap(
              direction: Axis.vertical,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: const [
                Text("Power By 张风捷特烈", style: UnitTextStyle.splashShadows),
                Text("· 2021 ·  @编程之王 ", style: UnitTextStyle.splashShadows),
              ],
            ))
          ],
        ),
      ),
    );
  }
  Widget _buildHead() => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Image.asset(
      'assets/images/icon_head.webp',
      width: 50,
      height: 50,
    ),
  );

  Widget _buildFlutterUnitText(double winH, double winW) {
    return FlutterUnitText(
      text: StrUnit.appName,
      color: Theme.of(context).primaryColor,
    );
  }

  // 监听资源加载完毕，启动，触发事件
  void _listenStart(BuildContext context, AppState state) {
    int cost = DateTime.now().millisecondsSinceEpoch - _recoder;
    BlocProvider.of<WidgetsBloc>(context).add(const EventTabTap(WidgetFamily.statelessWidget));
    BlocProvider.of<LikeWidgetBloc>(context).add(const EventLoadLikeData());
    BlocProvider.of<CategoryBloc>(context).add(const EventLoadCategory());
    if(cost<_minCost){
      Future.delayed(Duration(milliseconds: _minCost-cost)).then((value){
        Navigator.of(context).pushReplacementNamed(UnitRouter.nav);
      });
    }

  }

}

