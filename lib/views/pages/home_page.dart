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
import 'package:flutter_unit/views/items/widget_list_item.dart';
import 'package:flutter_unit/views/widgets/StatelessWidget/stateless_unit.dart';
import '../home/home_left_drawer.dart';
import '../home/home_light_drawer.dart';
import '../../app/res/cons.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _ctrl;
  double _y = 0;
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
    return DefaultTabController(
        //标签控制器
        length: Cons.TABS.length, //标签个数
        child: BlocBuilder<GlobalBloc, GlobalState>(
            builder: (_, state) => Scaffold(
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerFloat,
                  floatingActionButton: FloatingActionButton(
                    backgroundColor:
                        state is GlobalColorState ? state.color : Colors.blue,
                    shape: StarBorder(),
                    child: Icon(Icons.search),
                    onPressed: () {},
                  ),
                  appBar: TolyAppBar(
                    preferredSize: Size.fromHeight(state is AppBarHeightState
                        ? state.height
                        : kToolbarHeight * 2 - 20),
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
                  drawer: HomeLeftDrawer(),
                  //左滑页
                  endDrawer: HomeRightDrawer(), //右滑页
                )));
  }

  Widget _buildContent(BuildContext context) =>
      BlocBuilder<WidgetBloc, WidgetState>(builder: (_, state) {
        if (state is WidgetsLoaded) {
          var items = state.widgets.reversed.toList();
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
                        child: WidgetListItem(
                          data: items[index],
                        )),
                  ),
              separatorBuilder: (_, index) => Container(),
              itemCount: items.length);
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
