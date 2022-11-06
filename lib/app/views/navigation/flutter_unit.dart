import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_unit/app/blocs/color_change_bloc.dart';
import 'package:flutter_unit/app/blocs/global/global_bloc.dart';
import 'package:flutter_unit/app/blocs/global/global_state.dart';
import 'package:flutter_unit/app/res/app_theme.dart';
import 'package:flutter_unit/app/res/cons.dart';
import 'package:flutter_unit/app/res/str_unit.dart';
import 'package:flutter_unit/app/res/style/app_style.dart';
import 'package:flutter_unit/app/router/unit_router.dart';
import 'package:flutter_unit/app/views/splash/standard_unit_splash.dart';
import 'package:flutter_unit/app/views/splash/unit_splash.dart';
import 'package:flutter_unit/components/project/overlay_tool_wrapper.dart';

/// create by 张风捷特烈 on 2020/4/28
/// contact me by email 1981462002@qq.com
/// 说明: 主程序

class FlutterUnit extends StatelessWidget {
  const FlutterUnit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
        builder: (_, state) {
          print('=====FlutterUnit#build==========');

          return BlocProvider(
          create: (_) => ColorChangeCubit(Cons.tabColors[0]),
          child: DefaultTextStyle(
            style: TextStyle(
                fontFamily: state.fontFamily
            ),
            child:  MaterialApp(
                showPerformanceOverlay: state.showPerformanceOverlay,
                    title: StrUnit.appName,
                    debugShowCheckedModeBanner: false,
                    onGenerateRoute: UnitRouter.generateRoute,
                    localizationsDelegates: GlobalMaterialLocalizations.delegates,
                    supportedLocales: const [
                      Locale('zh', 'CN'),
                    ],
                    themeMode: ThemeMode.light,
                    // themeMode: ThemeMode.dark,
                    darkTheme: AppTheme.darkTheme(state),
                    theme: AppTheme.lightTheme(state),
                    // theme: ThemeData(
                    //   primarySwatch: state.themeColor,
                    //   fontFamily: state.fontFamily,
                    // ),
                    home: const StandardUnitSplash(),
                  ),

          ),
        );
        });
  }

}
