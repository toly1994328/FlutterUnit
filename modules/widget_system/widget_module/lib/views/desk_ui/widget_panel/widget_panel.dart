import 'package:app/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:widget_module/blocs/blocs.dart';
import 'package:widget_module/event/widget_event.dart';
import 'package:widget_module/widget_module.dart';
import 'package:widget_repository/widget_repository.dart';
import 'package:fx_trace/fx_trace.dart';
import 'package:toly_ui/toly_ui.dart';
import 'desk_widget_top_bar.dart';
import 'widget_tiled.dart';

class DeskWidgetPanel extends StatefulWidget {
  final Widget? header;
  const DeskWidgetPanel({super.key, this.header});

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
              WidgetsLoaded() => WidgetList(
                  state: state,
                  header: widget.header,
                ),
              WidgetsLoadFailed() =>
                Center(child: Text("${state.runtimeType}")),
            },
          ),
        ],
      ),
    );
  }

  void _switchTab(int index) {
    WidgetFamily widgetFamily = WidgetFamily.values[index];
    context.switchWidgetFamily(widgetFamily);
  }
}

class WidgetList extends StatelessWidget {
  final Widget? header;

  final WidgetsLoaded state;

  const WidgetList({super.key, required this.state, this.header});

  @override
  Widget build(BuildContext context) {
    SliverGridDelegate gridDelegate =
        const SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 400,
      mainAxisSpacing: 10,
      mainAxisExtent: 110,
      crossAxisSpacing: 10,
    );
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            margin: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
                color: Theme.of(context).listTileTheme.tileColor,
                borderRadius: BorderRadius.circular(8)),
            height: 180,
            child: header,
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(left: 14, right: 14, bottom: 8),
          sliver: SliverGrid.builder(
            gridDelegate: gridDelegate,
            itemBuilder: _buildItem,
            itemCount: state.widgets.length,
          ),
        )
      ],
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
    return WidgetTiled(
      model: model,
      onTap: () {
        context.push('${AppRoute.widgetDetail.url}${model.name}', extra: model);
      },
    );
  }
}
