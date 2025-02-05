import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:widget_module/widget_module.dart';
import 'package:note/note.dart';

GoRoute get collectRoute => GoRoute(
  path: AppRoute.collection.path,
  builder: (_, __) => const CollectPageAdapter(),
  routes: [
    GoRoute(path: AppRoute.collectionDetail.path, builder: collectionDetailBuilder),
  ],
);

GoRoute get noteRoute => GoRoute(
  path: AppRoute.note.path,
  builder: (_, __) => ArtSysScope(child: const ArticleAdmin()),
  // routes: [
  //   GoRoute(path: AppRoute.collectionDetail.path, builder: collectionDetailBuilder),
  // ],
);

Widget collectionDetailBuilder(BuildContext context, GoRouterState state) {
  Object? extra = state.extra;
  CategoryModel? model;
  if (extra is CategoryModel) {
    model = extra;
  }
  return CategoryShow(model: model!);
}
