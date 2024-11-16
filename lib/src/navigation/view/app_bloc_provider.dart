import 'package:app/app.dart';
import 'package:app_update/app_update.dart';
import 'package:authentication/authentication.dart';
import 'package:draw_system/draw_system.dart';
import 'package:storage/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_module/widget_module.dart';


/// create by 张风捷特烈 on 2020/4/28
/// contact me by email 1981462002@qq.com
/// 说明: Bloc提供器包裹层

class AppBlocProvider extends StatefulWidget {
  final Widget child;

  const AppBlocProvider({Key? key, required this.child}) : super(key: key);

  @override
  State createState() => _AppBlocProviderState();
}

class _AppBlocProviderState extends State<AppBlocProvider> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // 全局 bloc : 维护应用存储状态、更新、认证
        BlocProvider<AuthBloc>(create: (_) => AuthBloc(repository: HttpAuthRepository())),
        BlocProvider<AppConfigBloc>(create: (_) => AppConfigBloc()),
        BlocProvider<UpgradeBloc>(create: (_) => UpgradeBloc(api: UnitUpgradeApi())),
        BlocProvider<UserBloc>(create: (_) => UserBloc()),

        BlocProvider<GalleryUnitBloc>(create: (_) => GalleryUnitBloc()..loadGalleryInfo()),
      ],
      child: WidgetsBlocProvider(child: widget.child),
    );
  }

  @override
  void dispose() {
    AppStorage().close();
    super.dispose();
  }
}
