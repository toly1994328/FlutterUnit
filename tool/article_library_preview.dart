import 'package:app/app.dart';
import 'package:artifact/artifact.dart';
import 'package:artifact/src/articles/bloc/exp.dart';
import 'package:artifact/src/articles/view/library/library_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/src/starter/bridge/unit_bridge.dart';

/// 直接预览真实在线文库，方便单独验证阅读页与响应式布局。
void main() {
  registerFlutterUnitHost();
  ArtifactEnv().attachBridge(UnitArtifactBridge());
  runApp(const ArticleLibraryPreview());
}

class ArticleLibraryPreview extends StatelessWidget {
  const ArticleLibraryPreview({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme(const AppConfig()),
        home: MultiBlocProvider(providers: <BlocProvider<dynamic>>[
          BlocProvider<ArticleBloc>(create: _articles),
          BlocProvider<ColumnizeBloc>(create: _collections),
        ], child: const Scaffold(body: SafeArea(child: ArticleLibraryPage()))),
      );
  ArticleBloc _articles(BuildContext context) =>
      ArticleBloc(const ArticleRepository(), pageSize: 40)..init();
  ColumnizeBloc _collections(BuildContext context) =>
      ColumnizeBloc(const ColumnizeRepository())..init();
}
