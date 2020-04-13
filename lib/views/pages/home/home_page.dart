import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/Convert.dart';
import 'package:flutter_unit/app/router.dart';
import 'package:flutter_unit/blocs/detail/detail_bloc.dart';
import 'package:flutter_unit/blocs/detail/detail_event.dart';
import 'package:flutter_unit/blocs/global/global_bloc.dart';
import 'package:flutter_unit/blocs/global/global_event.dart';
import 'package:flutter_unit/blocs/global/global_state.dart';
import 'package:flutter_unit/blocs/widgets/home_bloc.dart';
import 'package:flutter_unit/blocs/widgets/home_event.dart';
import 'package:flutter_unit/blocs/widgets/home_state.dart';
import 'package:flutter_unit/model/widget_model.dart';
import 'package:flutter_unit/views/pages/common/empty_page.dart';
import 'package:flutter_unit/views/items/coupon_widget_list_item.dart';
import 'package:flutter_unit/views/items/techno_widget_list_item.dart';
import 'package:flutter_unit/views/pages/home/toly_app_bar.dart';

import 'background.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _ctrl;
  double _limitY = 35;
  double _height = kToolbarHeight * 2 - 20;

  @override
  void initState() {
    _ctrl = ScrollController()..addListener(_updateAppBarHeight);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TolyAppBar(
          preferredSize: Size.fromHeight(_height),
          onItemClick: _switchTab,
        ),
        body: Stack(
          children: <Widget>[
            if (BlocProvider.of<GlobalBloc>(context).state.showBackGround)
              Background(),
            BlocBuilder<HomeBloc, HomeState>(
                builder: (_, state) => _buildContent(state))
          ],
        ),
      );
  }

  Widget _buildContent(HomeState state) {
    if (state is WidgetsLoaded) {
      var items = state.widgets;
      if (items.isEmpty) return EmptyPage();
      return ListView.builder(
          controller: _ctrl,
          itemBuilder: (_, index) => Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: GestureDetector(
                    onTap: () => _toDetailPage(items[index]),
                    child: _mapItemByType(items[index])),
              ),
          itemCount: items.length);
    }
    if (state is WidgetsLoadFailed) {
      return Container(
        child: Text('加载数据异常'),
      );
    }
    return Container();
  }

  Widget _mapItemByType(WidgetModel model) {
    var index = BlocProvider.of<GlobalBloc>(context).state.itemStyleIndex;
    switch (index) {
      case 0:
        return TechnoWidgetListItem(
          data: model,
        );
      case 1:
        return CouponWidgetListItem(
          data: model,
        );
      case 2:
        return CouponWidgetListItem(
          hasTopHole:false,
          data: model,
        );
      case 3:
        return CouponWidgetListItem(
          hasTopHole:true,hasBottomHole:true,
          data: model,
        );

    }
    return TechnoWidgetListItem(
      data: model,
    );
  }

  _updateAppBarHeight() {
    if (_ctrl.offset < _limitY * 4) {
      setState(() {
        _height = kToolbarHeight * 2 - 20 - _ctrl.offset / 4;
      });
    }
  }

  _switchTab(int index, Color color) {
    if (_ctrl.hasClients) _ctrl.jumpTo(0);
    BlocProvider.of<HomeBloc>(context)
        .add(EventTabTap(Convert.toFamily(index)));
  }

  _toDetailPage(WidgetModel model) {
    BlocProvider.of<DetailBloc>(context).add(FetchWidgetDetail(model));
    Navigator.pushNamed(context, Router.widget_detail);
  }
}
