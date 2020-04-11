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
import 'package:flutter_unit/blocs/widgets/widget_bloc.dart';
import 'package:flutter_unit/blocs/widgets/widget_event.dart';
import 'package:flutter_unit/blocs/widgets/widget_state.dart';
import 'package:flutter_unit/components/toly_app_bar.dart';
import 'package:flutter_unit/model/widget_model.dart';
import 'package:flutter_unit/views/empty_page.dart';
import 'package:flutter_unit/views/items/coupon_widget_list_item.dart';
import 'package:flutter_unit/views/items/techno_widget_list_item.dart';
import '../home/home_light_drawer.dart';
import 'setting/home_drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _ctrl;
  double _limitY = 35;

  @override
  void initState() {
    _ctrl = ScrollController()..addListener(_updateAppBarHeight);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<GlobalBloc, GlobalState>(
      builder: (_, state) => Scaffold(
            appBar: TolyAppBar(
              preferredSize: Size.fromHeight(state.height),
              onItemClick: _switchTab,
            ),
            body: Stack(
              children: <Widget>[
                if (state.showBackGround) BackGround(),
                _buildContent(context)
              ],
            ),
          ));

  Widget _buildContent(BuildContext context) =>
      BlocBuilder<WidgetBloc, WidgetState>(builder: (_, state) {
        if (state is WidgetsLoaded) {
          var items = state.widgets;
          if (items.isEmpty) return EmptyPage();
          return ListView.separated(
              controller: _ctrl,
              itemBuilder: (_, index) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: GestureDetector(
                        onTap: () => _toDetailPage(items[index]),
                        child: _mapItemByType(items[index])),
                  ),
              separatorBuilder: (_, index) => Container(),
              itemCount: items.length);
        }
        if (state is WidgetsLoadFailed) {
          return Container(
            child: Text('加载数据异常'),
          );
        }
        return Container();
      });

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
    }
    return TechnoWidgetListItem(
      data: model,
    );
  }

  _updateAppBarHeight() {
    if (_ctrl.offset < _limitY * 4) {
      var offsetY = kToolbarHeight * 2 - 20 - _ctrl.offset / 4;
      BlocProvider.of<GlobalBloc>(context).add(UpdateAppBarHeight(offsetY));
    }
  }

  _switchTab(int index, Color color) {
    if (_ctrl.hasClients) _ctrl.jumpTo(0);
    BlocProvider.of<GlobalBloc>(context).add(EventSwitchHomeColor(color));
    BlocProvider.of<WidgetBloc>(context)
        .add(LoadWidget(Convert.toFamily(index)));
  }

  _toDetailPage(WidgetModel model) {
    BlocProvider.of<DetailBloc>(context).add(FetchWidgetDetail(model));
    Navigator.pushNamed(context, Router.widget_detail);
  }
}

class BackGround extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.05,
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/sabar.jpg'),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(400),
                topLeft: Radius.circular(400))),
      ),
    );
  }
}
