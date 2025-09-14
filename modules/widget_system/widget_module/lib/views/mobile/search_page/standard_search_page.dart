import 'package:app/app.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:widget_module/blocs/blocs.dart';
import 'package:l10n/l10n.dart';
import 'package:widget_module/widget_module.dart';

import 'package:widget_repository/widget_repository.dart';
import 'package:widget_ui/widget_ui.dart';
import 'standard_search_bar.dart';

// SearchPage 可以复用 WidgetsBloc，进行局部的 Bloc
// 不必单独提供 SearchBloc 增加复杂性
class StandardSearchPageProvider extends StatelessWidget {
  const StandardSearchPageProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (BuildContext context) => WidgetsBloc(
        repository: BlocProvider.of<WidgetsBloc>(context).repository,
      ),
      child: const StandardSearchPage(),
    );
  }
}

class StandardSearchPage extends StatelessWidget {
  const StandardSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color color = isDark
        ? Theme.of(context).appBarTheme.backgroundColor ?? Colors.black
        : Colors.white;
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: color,
            height: MediaQuery.of(context).padding.top,
            width: MediaQuery.of(context).size.width,
          ),
          const StandardSearchBarInner(),
          Expanded(
              child: BlocBuilder<WidgetsBloc, WidgetsState>(
            builder: _buildBodyByState,
          ))
        ],
      ),
    );
  }

  Widget _buildBodyByState(BuildContext context, WidgetsState state) {
    Widget noSearchArg = NotSearchPage(
      tips: context.l10n.searchSomething,
    );
    if (state.filter.name.isEmpty) {
      return noSearchArg;
    }

    if (state is WidgetsLoaded) {
      if (state.widgets.isEmpty) {
        return EmptyShower(message: context.l10n.emptySearch);
      }
      return ListView.builder(
        padding: EdgeInsets.zero,
        itemBuilder: (_, index) => Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
          child: WidgetItem(
            searchArgs: state.filter.name,
            model: state.widgets[index],
            onWidget: context.handleWidgetAction,
          ),
        ),
        itemCount: state.widgets.length,
      );
    }

    if (state is WidgetsLoading) {
      return const LoadingShower();
    }

    if (state is WidgetsLoadFailed) {
      return const ErrorPage();
    }

    return noSearchArg;
  }
}
