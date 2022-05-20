import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/blocs/global/global_bloc.dart';
import 'package:flutter_unit/app/blocs/global/global_state.dart';
import 'package:flutter_unit/app/res/cons.dart';
import 'package:flutter_unit/app/res/style/unit_text_style.dart';
import 'package:flutter_unit/app/res/toly_icon.dart';
import 'package:flutter_unit/app/utils/Toast.dart';
import 'package:flutter_unit/components/permanent/code/highlighter_style.dart';
import 'package:flutter_unit/components/permanent/feedback_widget.dart';
import 'package:flutter_unit/components/project/widget_node_panel.dart';
import 'package:flutter_unit/widget_system/blocs/widget_system_bloc.dart';
import 'package:flutter_unit/widget_system/repositories/model/node_model.dart';
import 'package:flutter_unit/widget_system/repositories/model/widget_model.dart';

import '../../widgets/widgets_map.dart';
import 'category_end_drawer.dart';
import 'widget_detail_panel.dart';

class WidgetDetailPage extends StatefulWidget {
  final WidgetModel model;

  const WidgetDetailPage({Key? key, required this.model}) : super(key: key);

  @override
  _WidgetDetailPageState createState() => _WidgetDetailPageState();
}

class _WidgetDetailPageState extends State<WidgetDetailPage> {
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
        appBar: AppBar(
          title: Text(currentWidgetModel.name),
          leading: const BackButton(),
          actions: <Widget>[
            _buildToHome(),
            FeedbackWidget(
              onPressed: () => _toggleLikeState(context),
              child: BlocConsumer<LikeWidgetBloc, LikeWidgetState>(
                listener: _listenLikeStateChange,
                builder: _buildByLikeState,
              ),
            )
          ],
        ),
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
          Text('相关组件', style: TStyleUnit.labelBold),
        ],
      );

  Widget _buildContent(BuildContext context, DetailState state) {
    return WillPopScope(
        onWillPop: () => _whenPop(context),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WidgetDetailPanel(model: _modelStack.last),
                  linkText,
                  if (state is DetailWithData)
                    _buildLinkTo(context, state.links),
                  const Divider(),
                ],
              ),
            ),
            if (state is DetailWithData)
              _buildSliverNodeList(state.nodes, state.widgetModel.name)
          ],
        ));
  }

  Widget _buildToHome() => Builder(
      builder: (ctx) => GestureDetector(
          onLongPress: () => Scaffold.of(ctx).openEndDrawer(),
          child: const Padding(
            padding: EdgeInsets.all(15.0),
            child: Icon(Icons.home),
          ),
          onTap: () => Navigator.of(ctx).pop()));

  // 监听 LikeWidgetBloc 伺机弹出 toast
  void _listenLikeStateChange(BuildContext context, LikeWidgetState state) {
    bool collected = state.widgets.contains(currentWidgetModel);
    String msg = collected
        ? "收藏【${currentWidgetModel.name}】组件成功!"
        : "已取消【${currentWidgetModel.name}】组件收藏!";

    Toast.toast(
      context,
      msg,
      duration: Duration(milliseconds: collected ? 1500 : 600),
      action: collected
          ? SnackBarAction(
              textColor: Colors.white,
              label: '收藏夹管理',
              onPressed: () => Scaffold.of(context).openEndDrawer())
          : null,
    );
  }

  // 根据 [LikeWidgetState ] 构建图标
  Widget _buildByLikeState(BuildContext context, LikeWidgetState state) {
    bool liked = state.widgets.contains(currentWidgetModel);
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: Icon(
        liked ? TolyIcon.icon_star_ok : TolyIcon.icon_star_add,
        size: 25,
      ),
    );
  }


  void _toggleLikeState(BuildContext context) {
    BlocProvider.of<LikeWidgetBloc>(context).add(
      ToggleLikeWidgetEvent(id: currentWidgetModel.id),
    );
  }

  Future<bool> _whenPop(BuildContext context) async {
    if (Scaffold.of(context).isEndDrawerOpen||_modelStack.isEmpty) return true;
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
          children: links
              .map((WidgetModel model) => ActionChip(
                    onPressed: () => _toLinkWidget(model),
                    elevation: 2,
                    shadowColor: chipColor,
                    backgroundColor: chipColor,
                    labelStyle: model.deprecated
                        ? TStyleUnit.deprecatedChip
                        : TStyleUnit.commonChip,
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
    GlobalState globalState = BlocProvider.of<GlobalBloc>(context).state;
    HighlighterStyle codeStyle =
        Cons.codeThemeSupport.keys.toList()[globalState.codeStyleIndex];
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (_, i) => WidgetNodePanel(
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

