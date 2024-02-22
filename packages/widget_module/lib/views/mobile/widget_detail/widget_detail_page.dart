import 'dart:io';

import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l10n/l10n.dart';

import '../../../data/exp.dart';
import '../../desk_ui/widget_detail/link_widget_buttons.dart';
import 'widget_node_panel.dart';
import 'package:widget_module/blocs/blocs.dart';

import 'package:widgets/widgets.dart';

import 'category_end_drawer.dart';
import 'widget_detail_bar.dart';
import 'widget_detail_panel.dart';


// 用于组件详情不需要在一开始就加载
// WidgetDetailBloc 可以在稍后提供
class WidgetDetailPageScope extends StatelessWidget {
  final WidgetModel model;

  const WidgetDetailPageScope({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WidgetDetailBloc>(
      create: (_) => WidgetDetailBloc(
          widgetRepository: const WidgetDbRepository(),
          nodeRepository: const NodeDbRepository())
        ..push(model),
      child: WidgetDetailPage(
        model: model,
      ),
    );
  }
}

class WidgetDetailPage extends StatelessWidget {
  final WidgetModel model;

  const WidgetDetailPage({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetDetailBloc bloc = context.watch<WidgetDetailBloc>();
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark?Colors.black:Colors.white,
      endDrawer: CategoryEndDrawer(widget: bloc.currentWidget),
      body: Builder(builder: (ctx) => _buildContent(ctx, bloc)),
    );
  }

  Widget linkText(BuildContext  context) => Row(
    children:  [
      const Padding(
        padding: EdgeInsets.only(left: 15, right: 5),
        child: Icon(Icons.link, color: Colors.blue),
      ),
      Text(context.l10n.relatedComponents, style: UnitTextStyle.labelBold),
    ],
  );


  Widget _buildContent(BuildContext context, WidgetDetailBloc bloc) {
    DetailState state = bloc.state;
    return WillPopScope(
        onWillPop: () => _whenPop(context),
        child: CustomScrollView(
          slivers: [
            SliverWidgetDetailBar(
                model: bloc.currentWidget
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WidgetDetailPanel(model: bloc.currentWidget),
                  linkText(context),
                  if (state is DetailWithData)
                    LinkWidgetButtons(links: state.links, onSelect: bloc.push,),
                  const Divider(),
                ],
              ),
            ),
            if (state is DetailWithData)
              _buildSliverNodeList(context,state.nodes, state.widgetModel)
          ],
        ));
  }

  Future<bool> _whenPop(BuildContext context) async {
    // print("======_whenPop============");
    WidgetDetailBloc detailBloc = context.read<WidgetDetailBloc>();
    if (Scaffold.of(context).isEndDrawerOpen) {
      return true;
    }
    return detailBloc.pop();
  }


  Widget _buildSliverNodeList(BuildContext context,List<NodeModel> nodes, WidgetModel model) {
    AppConfigState globalState = BlocProvider.of<AppConfigBloc>(context).state;
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (_, i) => WidgetNodePanel(
        codeStyle: globalState.codeStyle,
        codeFamily: 'Inconsolata',
        text: nodes[i].name,
        subText: nodes[i].subtitle,
        code: nodes[i].code,
        death: model.death,
        show: WidgetsMap.map(model.name)[i],
      ),
      childCount: nodes.length,
    ));
  }
}