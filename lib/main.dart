import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/enums.dart';
import 'package:flutter_unit/blocs/collect/collect_event.dart';
import 'package:flutter_unit/blocs/search/search_bloc.dart';
import 'package:flutter_unit/repositories/widget_db_repository.dart';
import 'package:flutter_unit/storage/app_storage.dart';
import 'package:flutter_unit/views/pages/splash/unit_splash.dart';

//import 'tools/initial.dart';
import 'blocs/collect/collect_bloc.dart';
import 'blocs/detail/detail_bloc.dart';
import 'blocs/global/global_bloc.dart';
import 'blocs/global/global_event.dart';
import 'blocs/global/global_state.dart';
import 'blocs/widgets/home_bloc.dart';
import 'blocs/widgets/home_event.dart';

import 'app/router.dart';
//import 'tools/widget_me_repository.dart';

void main() async {
//    await Initial.init();
//  runApp(BlocWrapper(
//      child: ColorFiltered(
//          colorFilter: ColorFilter.mode(Colors.white, BlendMode.color),
//          child: FlutterApp())));
  runApp(BlocWrapper(child: FlutterApp()));
}

final storage = AppStorage();

class BlocWrapper extends StatelessWidget {
  final Widget child;

  BlocWrapper({this.child});

  final repository = WidgetDbRepository(storage);
//  final repository = WidgetMeRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(//使用MultiBlocProvider包裹
        providers: [
      //Bloc提供器
      BlocProvider<GlobalBloc>(
          create: (_) => GlobalBloc(storage)..add(EventInitApp())),
      BlocProvider<HomeBloc>(
          create: (_) => HomeBloc(repository: repository)
            ..add(EventTabTap(WidgetFamily.statelessWidget))),

      BlocProvider<DetailBloc>(
          create: (_) => DetailBloc(repository: repository)),

      BlocProvider<CollectBloc>(
          create: (_) =>
              CollectBloc(repository: repository)..add(EventSetCollectData())),
      BlocProvider<SearchBloc>(
          create: (_) => SearchBloc(repository: repository)),
    ], child: child);
  }
}

class FlutterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalBloc, GlobalState>(builder: (_, state) {
      return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          onGenerateRoute: Router.generateRoute,
          theme: ThemeData(
            primarySwatch: state.themeColor,
            fontFamily: state.fontFamily,
          ),
          home:
//      NavPage()
              UnitSplash()
//          UnitNavigation(),
          );
    });
  }
}
//NavPage()
