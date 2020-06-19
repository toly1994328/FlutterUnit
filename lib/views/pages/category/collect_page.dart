import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/router.dart';
import 'package:flutter_unit/blocs/bloc_exp.dart';
import 'package:flutter_unit/components/permanent/circle_image.dart';
import 'package:flutter_unit/components/permanent/feedback_widget.dart';

import 'category_page.dart';
import 'default_collect_page.dart';

class CollectPage extends StatefulWidget {
  @override
  _CollectPageState createState() => _CollectPageState();
}

class _CollectPageState extends State<CollectPage>
    with AutomaticKeepAliveClientMixin {

  final _tabs = [
    '收藏集录',
    '默认收藏',
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var _topContext = context;
    return Scaffold(
        backgroundColor:
            BlocProvider.of<HomeBloc>(context).state.homeColor.withAlpha(11),
        body: DefaultTabController(
          length: _tabs.length, // This is the number of tabs.
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                    sliver: _buildAppBar(_topContext, innerBoxIsScrolled)),
              ];
            },
            body:  TabBarView(
              children: <Widget>[
                CategoryPage(),
                DefaultCollectPage(),
              ],
            ),
          ),
        ));
  }

  Widget _buildAppBar(BuildContext context, bool index) {
    return SliverAppBar(
      leading: Container(
          margin: EdgeInsets.all(10),
          child: FeedbackWidget(
            onPressed: (){
              Navigator.of(context).pushNamed(Router.login);
            },
            child: CircleImage(
              image: AssetImage('assets/images/icon_head.png'),
              borderSize: 1.5,
            ),
          )),
      backgroundColor: BlocProvider.of<HomeBloc>(context).state.homeColor,
      actions: <Widget>[_buildAddActionBuilder(context)],
      title: Text(
        '收藏集 CollectUnit',
        style: TextStyle(
            color: Colors.white, //标题
            fontSize: 18,
            shadows: [
              Shadow(color: Colors.blue, offset: Offset(1, 1), blurRadius: 2)
            ]),
      ),
      pinned: true,
      expandedHeight: 150.0,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax, //视差效果
        background: Image.asset(
          "assets/images/caver.jpeg",
          fit: BoxFit.cover,
        ),
      ),
      forceElevated: index,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(30),
        child: TabBar(
          indicatorColor: Colors.transparent,
          unselectedLabelColor: Colors.white,
          labelColor: Colors.black,
          labelStyle: TextStyle(fontSize: 16, shadows: [
            Shadow(
                color: Theme.of(context).primaryColor,
                offset: Offset(1, 1),
                blurRadius: 10)
          ]),
          tabs: _tabs
              .map((String name) => Container(
                  margin: EdgeInsets.only(bottom: 5),
                  alignment: Alignment.center,
                  child: Text(name)))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildAddActionBuilder(BuildContext context) => IconButton(
      icon: Icon(
        Icons.add,
        size: 30,
      ),
      onPressed: () => Scaffold.of(context).openEndDrawer());

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
