import 'package:app/app.dart';
import 'package:app_update/app_update.dart';
import 'package:authentication/authentication.dart';
import 'package:draw_system/draw_system.dart';
import 'package:storage/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_module/blocs/blocs.dart';
import 'package:widget_module/widget_module.dart';

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

  final CategoryBloc categoryBloc =
      CategoryBloc(repository: CategoryDbRepository());
  final AuthRepository authRepository = HttpAuthRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // 全局 bloc : 维护应用存储状态、更新、认证
        BlocProvider<AuthBloc>(create: (_) => AuthBloc(repository: authRepository)),
        BlocProvider<AppConfigBloc>(create: (_) => AppConfigBloc()),
        BlocProvider<UpdateBloc>(create: (_) => UpdateBloc()),
        BlocProvider<UserBloc>(create: (_) => UserBloc()),

        BlocProvider<WidgetsBloc>(create: (_) => WidgetsBloc(repository: repository)),
        BlocProvider<CategoryBloc>(create: (_) => categoryBloc),
        BlocProvider<LikeWidgetBloc>(create: (_) => LikeWidgetBloc(repository: repository)),
        BlocProvider<CategoryWidgetBloc>(create: (_) => CategoryWidgetBloc(categoryBloc: categoryBloc)),
        BlocProvider<GalleryUnitBloc>(create: (_) => GalleryUnitBloc()..loadGalleryInfo()),
      ],
      child: widget.child,
    );
  }

  @override
  void dispose() {
    categoryBloc.close();
    FlutterDbStorage.instance.closeDb();
    super.dispose();
  }
}
