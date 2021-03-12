import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/utils/convert.dart';

import 'package:flutter_unit/app/router/unit_router.dart';
import 'package:flutter_unit/blocs/bloc_exp.dart';
import 'package:flutter_unit/views/components/permanent/feedback_widget.dart';
import 'package:flutter_unit/views/components/project/overlay_tool_wrapper.dart';
import 'package:flutter_unit/views/components/project/default/empty_shower.dart';
import 'package:flutter_unit/views/components/project/default/error_shower.dart';
import 'package:flutter_unit/views/components/project/default/loading_shower.dart';
import 'package:flutter_unit/views/components/project/no_more_widget.dart';

import 'package:flutter_unit/model/widget_model.dart';
import 'package:flutter_unit/views/components/project/items/widget/home_item_support.dart';
import 'package:flutter_unit/views/pages/widget_home/toly_app_bar.dart';

import 'background.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => OverlayToolWrapper.of(context).showFloating());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
        body: Stack(
      children: <Widget>[
        BlocBuilder<GlobalBloc, GlobalState>(builder: _buildBackground),
        BlocBuilder<WidgetsBloc, WidgetsState>(
            builder: (_, state) => CustomScrollView(
                  slivers: <Widget>[
                    _buildPersistentHeader(),
                    _buildContent(state),
                    SliverToBoxAdapter(
                      child: NoMoreWidget(),
                    )
                  ],
                ))
      ],
    ));
  }

  Widget _buildPersistentHeader() => SliverPersistentHeader(
      pinned: true,
      delegate: FlexHeaderDelegate(
          minHeight: 35 + 56.0,
          maxHeight: 120.0,
          childBuilder: (offset, max, min) {
            double dy = max - 25 - offset;
            if (dy < min - 25) {
              dy = min - 25;
            }
            return TolyAppBar(
              maxHeight: dy,
              onItemClick: _switchTab,
            );
          }));

  Widget _buildBackground(BuildContext context, GlobalState state) {
    if (state.showBackGround) {
      return BackgroundShower();
    }
    return Container();
  }

  Widget _buildContent(WidgetsState state) {
    if (state is WidgetsLoading) {
      return const SliverFillRemaining(
        child: LoadingShower(),
      );
    }

    if (state is WidgetsLoaded) {
      List<WidgetModel> items = state.widgets;
      if (items.isEmpty)
        return const SliverFillRemaining(
          child: EmptyShower(
            message: "没数据，哥也没办法\n(≡ _ ≡)/~┴┴",
          ),
        );
      return SliverList(
        delegate: SliverChildBuilderDelegate(
            (_, int index) => _buildHomeItem(items[index]),
            childCount: items.length),
      );
    }

    if (state is WidgetsLoadFailed) {
      return SliverFillRemaining(
          child: ErrorShower(
        error: "数据加载异常:\n${state.error}",
      ));
    }
    return Container();
  }

  Widget _buildHomeItem(WidgetModel model) =>
      BlocBuilder<GlobalBloc, GlobalState>(
        buildWhen: (p, c) => (p.itemStyleIndex != c.itemStyleIndex),
        builder: (_, state) {
          return FeedbackWidget(
              a: 0.95,
              duration: const Duration(milliseconds: 200),
              onEnd: () => _toDetailPage(model),
              child: HomeItemSupport.get(model, state.itemStyleIndex));
        },
      );

  _switchTab(int index, Color color) {
    BlocProvider.of<WidgetsBloc>(context)
        .add(EventTabTap(Convert.toFamily(index)));
  }

  _toDetailPage(WidgetModel model) {
    BlocProvider.of<DetailBloc>(context).add(FetchWidgetDetail(model));
    Navigator.pushNamed(context, UnitRouter.widget_detail, arguments: model);
  }

  @override
  bool get wantKeepAlive => true;
}

class FlexHeaderDelegate extends SliverPersistentHeaderDelegate {
  FlexHeaderDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.childBuilder,
  });

  final double minHeight; //最小高度
  final double maxHeight; //最大高度
  final Widget Function(double offset, double max, double min)
      childBuilder; //最大高度

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return childBuilder(shrinkOffset, maxHeight, minHeight);
  }

  @override //是否需要重建
  bool shouldRebuild(FlexHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight;
  }
}
