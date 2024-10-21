import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:widget_module/widget_module.dart';

import '../../view/mobile/unit_navigation.dart';

GoRoute get widgetsRoute => GoRoute(
      path: AppRoute.widget.path,
      builder: (_, __) {
        if (kAppEnv.isDesktopUI){
          return const DeskWidgetPanel();
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
  if (kAppEnv.isDesktopUI) {
    return DeskWidgetDetailPageScope(
      model: model,
      widgetName: widgetName,
    );
  }
  assert(model != null);
  return WidgetDetailPageScope(model: model!);
}
