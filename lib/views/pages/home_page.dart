import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/Convert.dart';
import 'package:flutter_unit/blocs/widgets/widget_bloc.dart';
import 'package:flutter_unit/blocs/widgets/widget_state.dart';
import 'package:flutter_unit/components/flutter/no_shadow_tab_bar.dart';
import 'package:flutter_unit/views/empty_page.dart';
import 'package:flutter_unit/views/widgets/StatefulWidget/PopupMenuButton.dart';
import '../home/home_left_drawer.dart';
import '../home/home_light_drawer.dart';
import '../../app/res/cons.dart';
import 'stateless/stateless_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        //标签控制器
        length: Cons.TABS.length, //标签个数
        child: Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(height: 100,),
              title: Text("Flutter 联盟"),
              actions: <Widget>[Icon(Icons.search), CustomPopupMenuButton()],
              //标题栏右侧按钮
              bottom: _buildHomeBar()),
          body: Stack(
            children: <Widget>[
              BackGround(),
              TabBarView(children: _buildContent())
            ],
          ),
          drawer: HomeLeftDrawer(), //左滑页
          endDrawer: HomeRightDrawer(), //右滑页
        ));
  }

  List<Widget> _buildContent() => Cons.TABS
      .map((text) => BlocBuilder<WidgetBloc, WidgetState>(builder: (_, state) {
            var index = Cons.TABS.indexOf(text);
            if (state is WidgetsLoaded) {
              var items = state.widgets.reversed
                  .where((e) => e.family == Convert.toFamily(index))
                  .toList();
              if (items.isEmpty) return EmptyPage();
              var widgetPage = WidgetPage(items);
              return widgetPage;
            }
            return Container();
          }))
      .toList();

  PreferredSizeWidget _buildHomeBar() => NoShadowTabBar(
        labelStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontSize: 14),
        labelColor: Color(0xffffffff),
        unselectedLabelColor: Color(0xffeeeeee),
        tabs: Cons.TABS
            .map((tab) => Container(
                  height: 40,
                  alignment: Alignment.center,
                  child: Text(tab),
                ))
            .toList(),
      );
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
