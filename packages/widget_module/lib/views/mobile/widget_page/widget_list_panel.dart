import 'package:components/project_ui/project_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_module/blocs/blocs.dart';

import 'phone_widget_content.dart';

class WidgetListPanel extends StatelessWidget {
  const WidgetListPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsState state = context.watch<WidgetsBloc>().state;


    if (state is WidgetsLoaded) {
      return PhoneWidgetContent(items: state.widgets);
    }

    if (state is WidgetsLoading) {
      return const SliverFillRemaining(
        child: LoadingShower(),
      );
    }

    if (state is WidgetsLoadFailed) {
      return SliverFillRemaining(
          child: ErrorShower(
        error: "数据加载异常:\n${state.error}",
      ));
    }

    return const SliverFillRemaining(
      child: EmptyShower(
        message: "没数据，哥也没办法\n(≡ _ ≡)/~┴┴",
      ),
    );
  }
}
