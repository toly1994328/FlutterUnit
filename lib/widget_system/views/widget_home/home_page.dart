import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/blocs/color_change_bloc.dart';
import 'package:flutter_unit/app/blocs/global/global_bloc.dart';
import 'package:flutter_unit/app/blocs/global/global_state.dart';
import 'package:flutter_unit/app/res/cons/cons.dart';
import 'package:flutter_unit/app/utils/convert.dart';
import 'package:flutter_unit/components/project/default/empty_shower.dart';
import 'package:flutter_unit/components/project/default/error_shower.dart';
import 'package:flutter_unit/components/project/default/loading_shower.dart';
import 'package:flutter_unit/components/project/no_more_widget.dart';
import 'package:flutter_unit/widget_system/blocs/widget_system_bloc.dart';
import 'package:widget_repository/widget_repository.dart';

import 'background.dart';
import 'content/desk_widget_content.dart';
import 'content/phone_widget_content.dart';
import 'toly_app_bar.dart';
import 'package:db_storage/db_storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: Stack(
      children: <Widget>[
        BlocBuilder<AppBloc, AppState>(builder: _buildBackground),
        BlocBuilder<WidgetsBloc, WidgetsState>(
            builder: (_, state) => CustomScrollView(
                  slivers: <Widget>[
                    _buildPersistentHeader(),
                    _buildContent(state),
                    const SliverToBoxAdapter(
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

  Widget _buildBackground(BuildContext context, AppState state) {
    if (state.showBackGround) {
      return const BackgroundShower();
    }
    return const SizedBox.shrink();
  }

  Widget _buildContent(WidgetsState state) {
    if (state is WidgetsLoading) {
      return const SliverFillRemaining(
        child: LoadingShower(),
      );
    }

    if (state is WidgetsLoaded) {
      List<WidgetModel> items = state.widgets;
      if (items.isEmpty) {
        return const SliverFillRemaining(
          child: EmptyShower(
            message: "没数据，哥也没办法\n(≡ _ ≡)/~┴┴",
          ),
        );
      }
      return SliverLayoutBuilder(builder: (_,c){
        if(c.crossAxisExtent>500){
          return DeskWidgetContent(
            items: items,
            width: c.crossAxisExtent,
          );
        }
        return PhoneWidgetContent(
          items: items,
        );
      });
    }

    if (state is WidgetsLoadFailed) {
      return SliverFillRemaining(
          child: ErrorShower(
        error: "数据加载异常:\n${state.error}",
      ));
    }
    return Container();
  }

  void _switchTab(int index) {
    WidgetFamily widgetFamily = Convert.toFamily(index);
    context.read<ColorChangeCubit>().change(Cons.tabColors[index],family: widgetFamily);
    BlocProvider.of<WidgetsBloc>(context).add(EventTabTap(widgetFamily));
  }

  @override
  bool get wantKeepAlive => true;
}

class FlexHeaderDelegate extends SliverPersistentHeaderDelegate {
  FlexHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.childBuilder,
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
