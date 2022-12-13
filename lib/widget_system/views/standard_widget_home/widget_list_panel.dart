import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/components/project/default/empty_shower.dart';
import 'package:flutter_unit/components/project/default/error_shower.dart';
import 'package:flutter_unit/components/project/default/loading_shower.dart';
import 'package:flutter_unit/widget_system/blocs/widget_system_bloc.dart';
import 'package:flutter_unit/old_fancy_mobile_ui/home_page/desk_widget_content.dart';
import 'package:flutter_unit/old_fancy_mobile_ui/home_page/phone_widget_content.dart';
import 'package:widget_repository/widget_repository.dart';

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
