import 'package:flutter/cupertino.dart';
import 'package:app/app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_module/blocs/blocs.dart';
import 'package:widget_ui/widget_ui.dart';

import '../../widget_module.dart';

extension WidgetContext on BuildContext {
  void initWidgetData() {
    switchWidgetFamily(WidgetFamily.stateless);
  }

  void switchWidgetFamily(WidgetFamily family) {
    String locale = read<AppConfigBloc>().state.language.code;
    read<WidgetsBloc>().add(EventTabTap(family, locale: locale));
  }

  void toggleLike(int widgetId) {
    read<LikeWidgetBloc>().toggle(widgetId);
  }

  void handleWidgetAction(WidgetAction value) {
    switch (value) {
      case JumpWidgetDetail():
        String? name = value.widgetName ?? value.model?.name;
        push('${AppRoute.widgetDetail.url}$name', extra: value.model);
        return;
      case ToggleLikeWidget():
        toggleLike(value.widgetId);
    }
  }
}
