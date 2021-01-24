import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/blocs/authentic/bloc.dart';
import 'package:flutter_unit/blocs/login/bloc.dart';
import 'package:flutter_unit/blocs/register/bloc.dart';
import 'package:flutter_unit/model/enums.dart';
import 'package:flutter_unit/blocs/bloc_exp.dart';
import 'package:flutter_unit/views/components/project/overlay_tool_wrapper.dart';
import 'package:flutter_unit/repositories/impl/catagory_db_repository.dart';
import 'package:flutter_unit/repositories/impl/widget_db_repository.dart';
import 'package:flutter_unit/repositories/itf/widget_repository.dart';
import 'package:flutter_unit/storage/app_storage.dart';

/// create by 张风捷特烈 on 2020/4/28
/// contact me by email 1981462002@qq.com
/// 说明: Bloc提供器包裹层

final storage = AppStorage();

class BlocWrapper extends StatefulWidget {
  final Widget child;

  BlocWrapper({this.child});

  @override
  _BlocWrapperState createState() => _BlocWrapperState();
}

class _BlocWrapperState extends State<BlocWrapper> {
  final WidgetRepository repository = WidgetDbRepository(storage);

  final categoryBloc = CategoryBloc(repository: CategoryDbRepository(storage));
  final authBloc = AuthenticBloc();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        //使用MultiBlocProvider包裹
        providers: [
          //Bloc提供器
          BlocProvider<GlobalBloc>(
              create: (_) => GlobalBloc(storage)..add(EventInitApp())),

          BlocProvider<WidgetsBloc>(
              create: (_) => WidgetsBloc(repository: repository)
                ..add(EventTabTap(WidgetFamily.statelessWidget))),

          BlocProvider<DetailBloc>(
              create: (_) => DetailBloc(repository: repository)),

          BlocProvider<CategoryBloc>(
              create: (_) => categoryBloc..add(EventLoadCategory())),

          BlocProvider<LikeWidgetBloc>(
              create: (_) => LikeWidgetBloc(repository: repository)
                ..add(EventSetCollectData())),

          BlocProvider<RegisterBloc>(create: (_) => RegisterBloc()),
          BlocProvider<LoginBloc>(
              create: (_) => LoginBloc(authenticBloc: authBloc)),
          BlocProvider<AuthenticBloc>(create: (_) => authBloc),
          BlocProvider<CategoryWidgetBloc>(
              create: (_) => CategoryWidgetBloc(categoryBloc: categoryBloc)),

          BlocProvider<SearchBloc>(
              create: (_) => SearchBloc(repository: repository)),
          BlocProvider<PointBloc>(create: (_) => PointBloc()),
          BlocProvider<PointCommentBloc>(create: (_) => PointCommentBloc()),
        ], child: widget.child);
  }

  @override
  void dispose() {
    categoryBloc.close();
    authBloc.close();
    super.dispose();
  }
}
