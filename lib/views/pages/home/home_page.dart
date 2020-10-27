import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/utils/convert.dart';

import 'package:flutter_unit/app/router.dart';
import 'package:flutter_unit/blocs/bloc_exp.dart';
import 'package:flutter_unit/components/permanent/feedback_widget.dart';
import 'package:flutter_unit/components/permanent/overlay_tool_wrapper.dart';

import 'package:flutter_unit/model/widget_model.dart';
import 'package:flutter_unit/views/common/empty_page.dart';
import 'package:flutter_unit/views/items/home_item_support.dart';
import 'package:flutter_unit/views/pages/home/toly_app_bar.dart';

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

    WidgetsBinding.instance.addPostFrameCallback((callback) {
      OverlayToolWrapper.of(context).showFloating();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
        body: BlocBuilder<HomeBloc, HomeState>(builder: (ctx, state) {
      return Stack(
        children: <Widget>[
          BlocBuilder<GlobalBloc, GlobalState>(builder: _buildBackground),
          CustomScrollView(
            slivers: <Widget>[
              _buildPersistentHeader(),
              _buildContent(ctx, state),
            ],
          ),
        ],
      );
    }));
  }

  Widget _buildPersistentHeader() => SliverPersistentHeader(
      pinned: true,
      delegate: FlexHeaderDelegate(
          minHeight: 25 + 56.0,
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

  Widget _buildContent(BuildContext context, HomeState state) {
    if (state is WidgetsLoading) {
      // return SliverToBoxAdapter(
      //   child: Center(
      //     child: PlateLoading(),
      //   ),
      // );
      //
      return SliverToBoxAdapter(
        child: Container(),
      );
    }

    if (state is WidgetsLoaded) {
      List<WidgetModel> items = state.widgets;
      if (items.isEmpty) return EmptyPage();
      return SliverList(
        delegate: SliverChildBuilderDelegate(
            (_, int index) => _buildHomeItem(items[index]),
            childCount: items.length),
      );
    }

    if (state is WidgetsLoadFailed) {
      return SliverToBoxAdapter(
        child: Container(
          child: Text('加载数据异常'),
        ),
      );
    }
    return Container();
  }

  Widget _buildHomeItem(WidgetModel model) =>
      BlocBuilder<GlobalBloc, GlobalState>(
        condition: (p, c) => (p.itemStyleIndex != c.itemStyleIndex),
        builder: (_, state) {
          return FeedbackWidget(
              duration: const Duration(milliseconds: 200),
              onPressed: () => _toDetailPage(model),
              child: HomeItemSupport.get(model, state.itemStyleIndex));
        },
      );

  _switchTab(int index, Color color) {
    BlocProvider.of<HomeBloc>(context)
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
