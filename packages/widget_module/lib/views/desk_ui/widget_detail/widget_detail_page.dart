import 'package:app/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l10n/l10n.dart';
import 'package:widget_module/blocs/blocs.dart';

import '../../../../data/exp.dart';
import 'package:widgets/widgets.dart';

import '../../mobile/widget_detail/category_end_drawer.dart';
import 'link_widget_buttons.dart';
import 'widget_detail_bar.dart';
import 'widget_detail_panel.dart';
import 'widget_node_panel.dart';

// 用于组件详情不需要在一开始就加载
// WidgetDetailBloc 可以在稍后提供
class DeskWidgetDetailPageScope extends StatefulWidget {
  final WidgetModel? model;
  final String? widgetName;
  const DeskWidgetDetailPageScope({super.key, required this.model, this.widgetName});

  @override
  State<DeskWidgetDetailPageScope> createState() => _DeskWidgetDetailPageScopeState();
}

class _DeskWidgetDetailPageScopeState extends State<DeskWidgetDetailPageScope> {
  WidgetModel? _model;

  @override
  void initState() {
    super.initState();
    _model = widget.model;
    if (_model == null) {
      _loadModelByName();
    }
  }

  void _loadModelByName() async {
    _model = await context
        .read<WidgetsBloc>()
        .repository
        .queryWidgetByName(widget.widgetName);
  }

  @override
  Widget build(BuildContext context) {
    if (_model == null)
      return Center(
        child: CupertinoActivityIndicator(),
      );

    return BlocProvider<WidgetDetailBloc>(
      create: (_) => WidgetDetailBloc(
          widgetRepository: const WidgetDbRepository(),
          nodeRepository: const NodeDbRepository())
        ..push(_model!),
      child: DeskWidgetDetailPage(
        model: widget.model,
      ),
    );
  }
}

class DeskWidgetDetailPage extends StatelessWidget{
  final WidgetModel? model;

  const DeskWidgetDetailPage({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    WidgetDetailBloc bloc = context.watch<WidgetDetailBloc>();

    return BlocBuilder<WidgetDetailBloc, DetailState>(
      builder: (_, state) => Scaffold(
        endDrawer: CategoryEndDrawer(widget: bloc.currentWidget),
        body: Builder(builder: (ctx) {
          return _buildContent(ctx, bloc);
        }),
      ),
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
            DeskSliverWidgetDetailBar(model: bloc.currentWidget),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: DeskWidgetDetailPanel(
                            model: bloc.currentWidget,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16,),
                          linkText(context),
                          if (state is DetailWithData)
                            LinkWidgetButtons(
                              links: state.links,
                              onSelect: bloc.push,
                            )
                        ],
                      ))
                    ],
                  ),
                  const Divider()
                ],
              ),
            ),
            if (state is DetailWithData)
              _buildSliverNodeList(context, state.nodes, state.widgetModel)
          ],
        ));
  }

  Future<bool> _whenPop(BuildContext context) async {
    WidgetDetailBloc detailBloc = context.read<WidgetDetailBloc>();
    if (Scaffold.of(context).isEndDrawerOpen) {
      return true;
    }
    return detailBloc.pop();
  }

  Widget _buildSliverNodeList(
      BuildContext context, List<NodeModel> nodes, WidgetModel model) {
    AppConfigState globalState = BlocProvider.of<AppConfigBloc>(context).state;

    return SliverList(

        delegate: SliverChildBuilderDelegate(
      (_, i) => DeskWidgetNodePanel(
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
