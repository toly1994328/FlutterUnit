import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/enums.dart';
import 'package:flutter_unit/blocs/search/search_bloc.dart';
import 'package:flutter_unit/repositorys/widget_db_repository.dart';
import 'package:flutter_unit/repositorys/widget_me_repository.dart';
import 'package:flutter_unit/views/unit_splash.dart';

import 'app/initial.dart';
import 'blocs/collect/collect_bloc.dart';
import 'blocs/detail/detail_bloc.dart';
import 'blocs/global/global_bloc.dart';
import 'blocs/global/global_event.dart';
import 'blocs/global/global_state.dart';
import 'blocs/widgets/widget_bloc.dart';
import 'blocs/widgets/widget_event.dart';

import 'app/router.dart';
import 'views/pages/unit_navigation.dart';

void main() async {
//    await Initial.init();
//  runApp(BlocWrapper(
//      child: ColorFiltered(
//          colorFilter: ColorFilter.mode(Colors.white, BlendMode.color),
//          child: FlutterApp())));
  runApp(BlocWrapper(
      child: FlutterApp()));
//  runApp(FlutterApp());
}

class BlocWrapper extends StatelessWidget {
  final Widget child;

  BlocWrapper({this.child});

  final repository = WidgetMeRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(//使用MultiBlocProvider包裹
        providers: [
      //Bloc提供器
          BlocProvider<GlobalBloc>(create: (_) => GlobalBloc()..add(EventInitApp())),
      BlocProvider<WidgetBloc>(
          create: (_) => WidgetBloc(repository: repository)
            ..add(LoadWidget(WidgetFamily.statelessWidget))),

      BlocProvider<DetailBloc>(
          create: (_) => DetailBloc(repository: repository)),

      BlocProvider<CollectBloc>(create: (_) => CollectBloc(repository: repository)),
      BlocProvider<SearchBloc>(create: (_) => SearchBloc(repository: repository)),
    ], child: child);
  }
}

class FlutterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<GlobalBloc, GlobalState>(
    builder: (_, state) {
      print(state.themeColor);
      return MaterialApp(
        title: 'Flutter Demo',
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
