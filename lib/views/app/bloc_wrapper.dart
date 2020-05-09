import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/enums.dart';
import 'package:flutter_unit/blocs/bloc_exp.dart';
import 'package:flutter_unit/repositories/impl/catagory_db_repository.dart';
import 'package:flutter_unit/repositories/impl/widget_db_repository.dart';
import 'package:flutter_unit/storage/app_storage.dart';

/// create by 张风捷特烈 on 2020/4/28
/// contact me by email 1981462002@qq.com
/// 说明:

final storage = AppStorage();

class BlocWrapper extends StatelessWidget {
  final Widget child;

  BlocWrapper({this.child});

  final repository = WidgetDbRepository(storage);
  final categoryRepo = CategoryDbRepository(storage);

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
      BlocProvider<CategoryBloc>(
//          lazy: false,
          create: (_) =>
              CategoryBloc(repository: categoryRepo)..add(EventLoadCategory())),

      BlocProvider<CollectBloc>(
          create: (_) =>
              CollectBloc(repository: repository)..add(EventSetCollectData())),

      BlocProvider<SearchBloc>(
          create: (_) => SearchBloc(repository: repository)),
    ], child: child);
  }
}
