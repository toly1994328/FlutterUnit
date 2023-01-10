import 'package:app_config/app_config.dart';
import 'package:components/toly_ui/toly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/plateform_adapter/window/windows_adapter.dart';

import 'package:flutter_unit/components/project/widget_node_panel.dart';
import 'package:widget_module/blocs/blocs.dart';

import 'package:widget_repository/widget_repository.dart';

import '../../../widgets/widgets_map.dart';
import '../category_end_drawer.dart';
import 'widget_detail_bar.dart';
import 'widget_detail_panel.dart';
import 'widget_node_panel.dart';

// 用于组件详情不需要在一开始就加载
// WidgetDetailBloc 可以在稍后提供
class DeskWidgetDetailPageScope extends StatelessWidget {
  final WidgetModel model;

  const DeskWidgetDetailPageScope({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WidgetDetailBloc>(
      create: (_) => WidgetDetailBloc(
          widgetRepository: const WidgetDbRepository(),
          nodeRepository: const NodeDbRepository())
        ..add(FetchWidgetDetail(model)),
      child: DeskWidgetDetailPage(
        model: model,
      ),
    );
  }
}

class DeskWidgetDetailPage extends StatefulWidget {
  final WidgetModel model;

  const DeskWidgetDetailPage({Key? key, required this.model}) : super(key: key);

  @override
  _DeskWidgetDetailPageState createState() => _DeskWidgetDetailPageState();
}

class _DeskWidgetDetailPageState extends State<DeskWidgetDetailPage> {
  final List<WidgetModel> _modelStack = [];

  bool get isDark => Theme.of(context).brightness == Brightness.dark;

  @override
  void initState() {
    _modelStack.add(widget.model);
    super.initState();
  }

  // 获取当前的 组件数据模型
  WidgetModel get currentWidgetModel => _modelStack.last;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WidgetDetailBloc, DetailState>(
      builder: (_, state) => Scaffold(
        endDrawer: CategoryEndDrawer(widget: currentWidgetModel),
        body: Builder(builder: (ctx) {
          return _buildContent(ctx, state);
        }),
      ),
    );
  }

  Widget get linkText => Row(
        children: const [
          Padding(
            padding: EdgeInsets.only(left: 15, right: 5),
            child: Icon(Icons.link, color: Colors.blue),
          ),
          Text('相关组件', style: UnitTextStyle.labelBold),
        ],
      );

  Widget _buildContent(BuildContext context, DetailState state) {
    return WillPopScope(
        onWillPop: () => _whenPop(context),
        child: CustomScrollView(
          slivers: [
            DeskSliverWidgetDetailBar(model: _modelStack.last),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: DeskWidgetDetailPanel(model: _modelStack.last),
                      ),
                      const SizedBox(width: 20,),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          linkText,
                          if (state is DetailWithData)
                            _buildLinkTo(context, state.links),
                          // const Divider(),
                        ],
                      ))
                    ],
                  ),
                  Divider()
                ],
              ),
            ),
            if (state is DetailWithData)
              _buildSliverNodeList(state.nodes, state.widgetModel.name)
          ],
        ));
  }

  Future<bool> _whenPop(BuildContext context) async {
    if (Scaffold.of(context).isEndDrawerOpen || _modelStack.isEmpty) {
      return true;
    }
    _modelStack.removeLast();
    if (_modelStack.isNotEmpty) {
      BlocProvider.of<WidgetDetailBloc>(context).add(
        FetchWidgetDetail(currentWidgetModel),
      );
      return false;
    } else {
      return true;
    }
  }

  Color? get chipColor => isDark
      ? Theme.of(context).floatingActionButtonTheme.backgroundColor
      : Theme.of(context).primaryColor;

  Widget _buildLinkTo(BuildContext context, List<WidgetModel> links) {
    if (links.isEmpty) {
      return Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Chip(
            backgroundColor: Colors.grey.withAlpha(120),
            labelStyle: const TextStyle(fontSize: 12, color: Colors.white),
            label: const Text('暂无链接组件'),
          ));
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 10),
        child: Wrap(
          spacing: 5,
          runSpacing: 5,
          children: links
              .map((WidgetModel model) => ActionChip(
                    labelPadding: EdgeInsets.zero,
                    side: BorderSide.none,
                    onPressed: () => _toLinkWidget(model),
                    elevation: 1,
                    // shadowColor: chipColor,
                    backgroundColor: chipColor,
                    labelStyle: model.deprecated
                        ? UnitTextStyle.deprecatedChip
                        : UnitTextStyle.commonChip,
                    label: Text(model.name),
                  ))
              .toList(),
        ),
      );
    }
  }

  void _toLinkWidget(WidgetModel model) {
    BlocProvider.of<WidgetDetailBloc>(context).add(FetchWidgetDetail(model));
    _modelStack.add(model);
  }

  Widget _buildSliverNodeList(List<NodeModel> nodes, String name) {
    AppState globalState = BlocProvider.of<AppBloc>(context).state;
    HighlighterStyle codeStyle =
        Cons.codeThemeSupport.keys.toList()[globalState.codeStyleIndex];
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (_, i) => DeskWidgetNodePanel(
        codeStyle: codeStyle,
        codeFamily: 'Inconsolata',
        text: nodes[i].name,
        subText: nodes[i].subtitle,
        code: nodes[i].code,
        death: _modelStack.last.death,
        show: WidgetsMap.map(name)[i],
      ),
      childCount: nodes.length,
    ));
  }
}
