import 'dart:async';

import 'package:app/app.dart';
import 'package:authentication/authentication.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:widget_module/widget_module.dart';

import '../../view/mobile/news.dart';
import '../../view/mobile/unit_navigation.dart';

GoRoute get widgetsRoute => GoRoute(
      path: AppRoute.widget.path,
      builder: (_, __) {
        if (kAppEnv.isDesktopUI) {
          return const DeskWidgetPanel(
            header: NewsHeader(),
          );
        }
        return const UnitPhoneNavigation();
      },
      routes: [
        GoRoute(path: AppRoute.widgetDetail.path, builder: widgetDetailBuilder),
      ],
    );

Widget widgetDetailBuilder(BuildContext context, GoRouterState state) {
  Object? extra = state.extra;
  String? widgetName = state.pathParameters['name'];

  WidgetModel? model;
  if (extra is WidgetModel) {
    model = extra;
  }
  if (model != null) {
    unawaited(context.read<ProgressionCubit>().recordWidgetView(model.id));
  }
  if (kAppEnv.isDesktopUI) {
    return DeskWidgetDetailPageScope(
      model: model,
      widgetName: widgetName,
    );
  }
  assert(model != null);
  return WidgetDetailPageScope(model: model!);
}
