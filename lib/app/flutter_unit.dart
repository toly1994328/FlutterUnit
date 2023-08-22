import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter_unit/app/router/unit_router.dart';
import 'package:flutter_unit/app/views/splash/standard_unit_splash.dart';


/// create by 张风捷特烈 on 2020/4/28
/// contact me by email 1981462002@qq.com
/// 说明: 主程序

class FlutterUnit extends StatelessWidget {
  const FlutterUnit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(builder: (_, state) {
      return DefaultTextStyle(
        style: TextStyle(fontFamily: state.fontFamily),
        child: MaterialApp(
          // routes: ,
          showPerformanceOverlay: state.showPerformanceOverlay,
          title: StrUnit.appName,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: UnitRouters.generateRoute,
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
          supportedLocales: const [
            Locale('zh', 'CN'),
          ],
          // themeMode: ThemeMode.light,
          themeMode: state.themeMode,
          darkTheme: AppTheme.darkTheme(state),
          theme: AppTheme.lightTheme(state),
          // theme: ThemeData(
          //   primarySwatch: state.themeColor,
          //   fontFamily: state.fontFamily,
          // ),
          home: const StandardUnitSplash(),
        ),
      );
    });
  }
}
