import 'package:components/project_ui/project_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:old_fancy_mobile_ui/old_fancy_mobile_ui.dart';
import 'package:widget_module/blocs/blocs.dart';
import 'package:widget_repository/widget_repository.dart';

import '../../../navigation/home_page/phone_widget_content.dart';

class WidgetListPanel extends StatelessWidget {
  const WidgetListPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WidgetsBloc, WidgetsState>(
      builder: (_, state) => _buildContent(state),
    );
  }

  Widget _buildContent(WidgetsState state) {
    if (state is WidgetsLoading) {
      return const SliverFillRemaining(
        child: LoadingShower(),
      );
    }

    if (state is WidgetsLoaded) {
      List<WidgetModel> items = state.widgets;
      if (items.isEmpty) {
        return const SliverFillRemaining(
          child: EmptyShower(
            message: "没数据，哥也没办法\n(≡ _ ≡)/~┴┴",
          ),
        );
      }
      return SliverLayoutBuilder(builder: (_, c) {
        if (c.crossAxisExtent > 500) {
          return DeskWidgetContent(
            items: items,
            width: c.crossAxisExtent,
          );
        }
        return PhoneWidgetContent(
          items: items,
        );
      });
    }

    if (state is WidgetsLoadFailed) {
      return SliverFillRemaining(
          child: ErrorShower(
        error: "数据加载异常:\n${state.error}",
      ));
    }
    return Container();
  }
}
