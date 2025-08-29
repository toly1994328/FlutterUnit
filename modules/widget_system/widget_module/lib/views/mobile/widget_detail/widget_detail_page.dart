import 'dart:io';

import 'package:app/app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l10n/l10n.dart';
import 'package:unit_widgets_display/unit_widgets_display.dart';
import 'package:widget_repository/widget_repository.dart';

import '../../desk_ui/widget_detail/link_widget_buttons.dart';
import 'node_display/node_display.dart';
import 'package:widget_module/blocs/blocs.dart';

import 'category_end_drawer.dart';
import 'widget_detail_bar.dart';
import 'widget_detail_panel.dart';
import 'widget_fields_sliver.dart';
import 'package:tolyui/tolyui.dart';

// 用于组件详情不需要在一开始就加载
// WidgetDetailBloc 可以在稍后提供
class WidgetDetailPageScope extends StatelessWidget {
  final WidgetModel model;

  const WidgetDetailPageScope({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    WidgetRepository widgetRepository = context.read<WidgetsBloc>().repository;
    NodeRepository nodeRepository =
        kIsWeb ? MemoryNodeRepository() : const NodeDbRepository();

    return BlocProvider<WidgetDetailBloc>(
      create: (_) => WidgetDetailBloc(
        widgetRepo: widgetRepository,
        nodeRepo: nodeRepository,
      )..push(model),
      child: WidgetDetailPage(model: model),
    );
  }
}

class WidgetDetailPage extends StatelessWidget {
  final WidgetModel model;

  const WidgetDetailPage({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    WidgetDetailBloc bloc = context.watch<WidgetDetailBloc>();
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      endDrawer: CategoryEndDrawer(widget: bloc.currentWidget),
      body: Builder(builder: (ctx) => _buildContent(ctx, bloc)),
    );
  }

  Widget linkText(BuildContext context) => Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 15, right: 5),
            child: Icon(Icons.link, color: Colors.blue),
          ),
          Text(context.l10n.relatedComponents, style: UnitTextStyle.labelBold),
        ],
      );

  Widget _buildContent(BuildContext context, WidgetDetailBloc bloc) {
    DetailState state = bloc.state;
    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) =>
            _onPop(context, didPop, result),
        child: CustomScrollView(
          slivers: [
            SliverWidgetDetailBar(model: bloc.currentWidget),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WidgetDetailPanel(model: bloc.currentWidget),
                  linkText(context),
                  if (state is DetailWithData)
                    LinkWidgetButtons(links: state.links, onSelect: bloc.push),
                ],
              ),
            ),
            if (state is DetailWithData)
              state.nodes.isNotEmpty
                  ? SliverNodeList(
                      nodes: state.nodes,
                      model: state.widgetModel,
                    )
                  : SliverWidgetFieldsList(widgetId: model.id),
          ],
        ));
  }

  void _onPop(BuildContext context, bool didPop, dynamic result) {
    if (didPop) {
      return;
    }
    WidgetDetailBloc detailBloc = context.read<WidgetDetailBloc>();
    // 检查抽屉是否打开
    if (Scaffold.of(context).isEndDrawerOpen) {
      if (context.mounted) {
        Navigator.of(context).pop();
      }
      return;
    }
    // 调用原来的 pop 逻辑
    detailBloc.pop().then((bool canPop) {
      if (canPop && context.mounted) {
        Navigator.of(context).pop();
      }
    });
  }
}

class SliverNodeList extends StatelessWidget {
  final List<NodeModel> nodes;
  final WidgetModel model;

  const SliverNodeList({super.key, required this.nodes, required this.model});

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (_, i) => NodeDisplay(
        mapper: _nodeMapper,
        node: nodes[i],
        isDeath: model.death,
      ),
      childCount: nodes.length,
    ));
  }

  Widget _nodeMapper(NodeModel node) {
    NodeType type = node.type(model.name, node.priority);
    Widget display = mapNodeDisplay(model.id, node.priority);
    return switch (type) {
      NodeType.display => display,
      NodeType.newPage => newPageDisplay(display),
      NodeType.description => display,
      NodeType.deprecated => display,
    };
  }
}

Widget newPageDisplay(Widget page) {
  return Builder(
    builder: (ctx) => ElevatedButton(
      onPressed: () {
        Navigator.of(ctx).push(MaterialPageRoute(builder: (_) => page));
      },
      child: Wrap(
        spacing: 6,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Icon(
            Icons.open_in_new,
            size: 16,
            color: Colors.white,
          ),
          Text('新界面打开'),
        ],
      ),
      style: FillButtonPalette(
        foregroundPalette: Palette.all(Colors.white),
        borderRadius: BorderRadius.circular(6),
        backgroundPalette: const Palette(
          normal: Color(0xff1890ff),
          hover: Color(0xff40a9ff),
          pressed: Color(0xff096dd9),
        ),
      ).style,
    ),
  );
}
