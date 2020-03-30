import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/enums.dart';
import 'package:flutter_unit/blocs/search/search_bloc.dart';
import 'package:flutter_unit/repositorys/widget_me_repository.dart';
import 'package:flutter_unit/views/unit_splash.dart';
import 'package:flutter_unit/views/widgets/StatefulWidget/Checkbox.dart';

import 'blocs/detail/detail_bloc.dart';
import 'blocs/global/global_bloc.dart';
import 'blocs/widgets/widget_bloc.dart';
import 'blocs/widgets/widget_event.dart';

import 'app/router.dart';
import 'views/pages/unit_navigation.dart';

void main() async {
//    await Initial.init();
  runApp(BlocWrapper(child: FlutterApp()));
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
      BlocProvider<WidgetBloc>(
          create: (_) => WidgetBloc(repository: repository)
            ..add(LoadWidget(WidgetFamily.statelessWidget))),

      BlocProvider<DetailBloc>(
          create: (_) => DetailBloc(repository: repository)),
      BlocProvider<GlobalBloc>(create: (_) => GlobalBloc()),
      BlocProvider<SearchBloc>(create: (_) => SearchBloc()),
    ], child: child);
  }
}

class FlutterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      onGenerateRoute: Router.generateRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
//      NavPage()
          UnitNavigation(),
    );
  }
}
//NavPage()
