import 'package:app_config/app_config.dart';
import 'package:db_storage/db_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/update_part/bloc_exp.dart';
import 'package:flutter_unit/painter_system/bloc/gallery_unit/bloc.dart';
import 'package:flutter_unit/user_system/bloc/authentic/bloc.dart';
import 'package:flutter_unit/user_system/bloc/authentic/event.dart';

import 'package:flutter_unit/widget_system/blocs/widget_system_bloc.dart';
import 'package:widget_repository/widget_repository.dart';



/// create by 张风捷特烈 on 2020/4/28
/// contact me by email 1981462002@qq.com
/// 说明: Bloc提供器包裹层

// final AppStart storage = AppStart();

class BlocWrapper extends StatefulWidget {
  final Widget child;

  const BlocWrapper({Key? key, required this.child}) : super(key: key);

  @override
  _BlocWrapperState createState() => _BlocWrapperState();
}

class _BlocWrapperState extends State<BlocWrapper> {
  final WidgetRepository repository = const WidgetDbRepository();

  final CategoryBloc categoryBloc= CategoryBloc(repository: CategoryDbRepository());

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          // 全局 bloc : 维护应用存储状态、更新、认证
          BlocProvider<AppBloc>(create: (_) => AppBloc(AppStateRepository())..initApp()),
          BlocProvider<UpdateBloc>(create: (_) => UpdateBloc()),
          BlocProvider<AuthenticBloc>(create: (_) => AuthenticBloc()..add(const AppStarted())),

          BlocProvider<WidgetsBloc>(create: (_) => WidgetsBloc(repository: repository)),
          BlocProvider<CategoryBloc>(create: (_) => categoryBloc),
          BlocProvider<LikeWidgetBloc>(create: (_) => LikeWidgetBloc(repository: repository)),
          BlocProvider<CategoryWidgetBloc>(create: (_) => CategoryWidgetBloc(categoryBloc: categoryBloc)),
          BlocProvider<GalleryUnitBloc>(create: (_) => GalleryUnitBloc()..loadGalleryInfo()),
        ], child: widget.child);
  }

  @override
  void dispose() {
    categoryBloc.close();
    LocalDb.instance.closeDb();
    super.dispose();
  }
}
