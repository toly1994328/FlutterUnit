import 'package:app/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:widget_module/blocs/blocs.dart';
import 'package:widget_module/event/widget_event.dart';
import 'package:widget_repository/widget_repository.dart';
import 'package:fx_trace/fx_trace.dart';

import 'desk_widget_model_item.dart';
import 'desk_widget_top_bar.dart';

class DeskWidgetPanel extends StatefulWidget {
  const DeskWidgetPanel({super.key});

  @override
  State<DeskWidgetPanel> createState() => _DeskWidgetPanelState();
}

class _DeskWidgetPanelState extends State<DeskWidgetPanel> {
  @override
  Widget build(BuildContext context) {
    WidgetsState state = context.watch<WidgetsBloc>().state;

    return Scaffold(
      body: Column(
        children: [
          DeskWidgetTopBar(onTabPressed: _switchTab),
          const Divider(height: 1),
          Expanded(
            child: switch (state) {
              WidgetsLoading() => const CupertinoActivityIndicator(),
              WidgetsLoaded() => WidgetList(state: state),
              WidgetsLoadFailed() => Center(child: Text("${state.runtimeType}")),
            },
          ),
        ],
      ),
    );
  }

  void _switchTab(int index) {
    WidgetFamily widgetFamily = WidgetFamily.values[index];
    BlocProvider.of<WidgetsBloc>(context).add(EventTabTap(widgetFamily));
  }
}

class WidgetList extends StatelessWidget {
  final WidgetsLoaded state;

  const WidgetList({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    SliverGridDelegate gridDelegate = const SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 400,
      mainAxisSpacing: 10,
      mainAxisExtent: 110,
      crossAxisSpacing: 10,
    );

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      gridDelegate: gridDelegate,
      itemBuilder: _buildItem,
      itemCount: state.widgets.length,
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    WidgetModel model = state.widgets[index];
    return DeskWidgetItem(
      model: model,
      onTap: () {
        context.push('${AppRoute.widgetDetail.url}${model.name}', extra: model);
      },
    );
  }
}
