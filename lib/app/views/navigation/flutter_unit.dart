import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/blocs/global/global_bloc.dart';
import 'package:flutter_unit/app/blocs/global/global_state.dart';
import 'package:flutter_unit/app/res/cons.dart';
import 'package:flutter_unit/app/res/str_unit.dart';
import 'package:flutter_unit/app/router/unit_router.dart';

import 'package:flutter_unit/app/blocs/color_change_bloc.dart';
import 'package:flutter_unit/app/views/splash/unit_splash.dart';


/// create by 张风捷特烈 on 2020/4/28
/// contact me by email 1981462002@qq.com
/// 说明: 主程序

class FlutterUnit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalBloc, GlobalState>(
        builder: (_, state) => BlocProvider(
          create: (_) => ColorChangeCubit(
            Cons.tabColors[0]
          ),
          child: MaterialApp(
                showPerformanceOverlay: state.showPerformanceOverlay,
                title: StrUnit.appName,
                debugShowCheckedModeBanner: false,
                onGenerateRoute: UnitRouter.generateRoute,
                theme: ThemeData(
                  primarySwatch: state.themeColor,
                  fontFamily: state.fontFamily,
                ),
                home: const UnitSplash(),
              ),
        ));
  }

}
