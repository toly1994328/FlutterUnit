import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/router.dart';
import 'package:flutter_unit/blocs/bloc_exp.dart';
import 'package:flutter_unit/views/app/splash/unit_splash.dart';

/// create by 张风捷特烈 on 2020/4/28
/// contact me by email 1981462002@qq.com
/// 说明: 主程序

class FlutterUnit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalBloc, GlobalState>(builder: (_, state) {
      return MaterialApp(
//            debugShowMaterialGrid: true,
            showPerformanceOverlay: state.showPerformanceOverlay,
//            showSemanticsDebugger: true,
//            checkerboardOffscreenLayers:true,
//            checkerboardRasterCacheImages:true,
            title: 'Flutter Unit',
            debugShowCheckedModeBanner: false,
            onGenerateRoute: UnitRouter.generateRoute,
            theme: ThemeData(
              primarySwatch: state.themeColor,
              fontFamily: state.fontFamily,
            ),
            home: UnitSplash(),
      );
    });
  }

}
