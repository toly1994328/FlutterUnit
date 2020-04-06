import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/Convert.dart';
import 'package:flutter_unit/app/router.dart';
import 'package:flutter_unit/blocs/detail/detail_bloc.dart';
import 'package:flutter_unit/blocs/detail/detail_event.dart';
import 'package:flutter_unit/blocs/global/global_bloc.dart';
import 'package:flutter_unit/blocs/widgets/widget_bloc.dart';
import 'package:flutter_unit/blocs/widgets/widget_event.dart';
import 'package:flutter_unit/blocs/widgets/widget_state.dart';
import 'package:flutter_unit/components/toly_app_bar.dart';
import 'package:flutter_unit/views/empty_page.dart';
import 'package:flutter_unit/views/items/coupon_widget_list_item.dart';
import 'package:flutter_unit/views/items/techno_widget_list_item.dart';
import '../home/home_light_drawer.dart';
import 'home_drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _ctrl;
  double limitY = 35;

  @override
  void initState() {
    _ctrl = ScrollController()
      ..addListener(() {
        if (_ctrl.offset < limitY * 4) {
          var offsetY = kToolbarHeight * 2 - 20 - _ctrl.offset / 4;
          BlocProvider.of<GlobalBloc>(context).add(UpdateAppBarHeight(offsetY));
        }
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalBloc, GlobalState>(
            builder: (_, state) => Scaffold(
                  appBar: TolyAppBar(
                    preferredSize: Size.fromHeight(state.height),
                    onItemClick: (index, e) {
                      if (_ctrl.hasClients) _ctrl.jumpTo(0);
                      BlocProvider.of<GlobalBloc>(context)
                          .add(EventSwitchColor(e));
                      BlocProvider.of<WidgetBloc>(context)
                          .add(LoadWidget(Convert.toFamily(index)));
                    },
                  ),
                  body: Stack(
                    children: <Widget>[BackGround(), _buildContent(context)],
                  ),
                  drawer: HomeDrawer(),
                  //左滑页
                  endDrawer: HomeRightDrawer(), //右滑页
                ));
  }

  Widget _buildContent(BuildContext context) =>
      BlocBuilder<WidgetBloc, WidgetState>(builder: (_, state) {
        if (state is WidgetsLoaded) {
          var items = state.widgets;
          if (items.isEmpty) return EmptyPage();
          return ListView.separated(
              controller: _ctrl,
              itemBuilder: (_, index) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: InkWell(
                        onTap: () {
                          BlocProvider.of<DetailBloc>(context)
                              .add(ToWidgetDetail(items[index]));
                          Navigator.pushNamed(context, Router.widget_detail);
                        },
                        child: TechnoWidgetListItem(
                          data: items[index],
                        )),
                  ),
              separatorBuilder: (_, index) => Container(),
              itemCount: items.length);
        }
        if(state is WidgetsLoadFailed){
          return Container(child: Text('加载数据异常'),);
        }
        return Container();
      });
}

class BackGround extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.1,
      child: Container(
        decoration: BoxDecoration(
//          color: Colors.orangeAccent.withAlpha(44),
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
