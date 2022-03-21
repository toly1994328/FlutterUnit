import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/blocs/color_change_bloc.dart';
import 'package:flutter_unit/components/permanent/circle_image.dart';
import 'package:flutter_unit/components/permanent/feedback_widget.dart';
import 'package:flutter_unit/user_system/component/authentic_widget.dart';

import 'category_page.dart';
import 'like_widget_page.dart';
import 'sync/async_button.dart';
import 'sync/upload_button.dart';

class CollectPage extends StatefulWidget {
  @override
  _CollectPageState createState() => _CollectPageState();
}

class _CollectPageState extends State<CollectPage>
    with AutomaticKeepAliveClientMixin {
  final List<String> _tabs = const [
    '收藏集录',
    '珍藏组件',
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    BuildContext _topContext = context;
    final Color color = BlocProvider.of<ColorChangeCubit>(context).state.tabColor.withAlpha(11);

    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          color: color,
          child: DefaultTabController(
            length: _tabs.length,
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => <Widget>[
                SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                    sliver: _buildAppBar(_topContext, innerBoxIsScrolled)),
              ],
              body: TabBarView(
                children: <Widget>[
                  CategoryPage(),
                  LikeWidgetPage(),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildAppBar(BuildContext context, bool index) {
    final Color color = BlocProvider.of<ColorChangeCubit>(context).state.color;

    return SliverAppBar(
      leading: Container(
          margin: EdgeInsets.all(10),
          child: FeedbackWidget(
            onPressed: () {
              // Navigator.of(context).pushNamed(UnitRouter.login);
            },
            child: const CircleImage(
              image: AssetImage('assets/images/icon_head.webp'),
              borderSize: 1.5,
            ),
          )),
      backgroundColor: color,
      actions: <Widget>[
        SizedBox(
            width: 32,
            child: AuthenticWidget.just(UploadCategoryButton())),
        // SizedBox(width: 5,),
        SizedBox(
            width: 32,
            child: AuthenticWidget.just(SyncCategoryButton())),
        _buildAddAction(context)
      ],
      title: const Text(
        '收藏集 CollectUnit',
        style: TextStyle(
            color: Colors.white, //标题
            fontSize: 18,
            shadows: [
              Shadow(color: Colors.blue, offset:const Offset(1, 1), blurRadius: 2)
            ]),
      ),
      pinned: true,
      expandedHeight: 150.0,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax, //视差效果
        background: Image.asset(
          "assets/images/caver.webp",
          fit: BoxFit.cover,
        ),
      ),
      forceElevated: index,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(30),
        child: TabBar(
          indicatorColor: Colors.transparent,
          unselectedLabelColor: Colors.white,
          labelColor: Colors.black,
          labelStyle: TextStyle(fontSize: 16, shadows: [
            Shadow(
                color: Theme.of(context).primaryColor,
                offset: const Offset(1, 1),
                blurRadius: 10)
          ]),
          tabs: _buildTabs(),
        ),
      ),
    );
  }

  Widget _buildAddAction(BuildContext context) => IconButton(
      icon: const Icon(
        Icons.add,
        size: 30,
      ),
      onPressed: () => Scaffold.of(context).openEndDrawer());

  List<Widget> _buildTabs() => _tabs
      .map(
        (String name) => Container(
          margin: const EdgeInsets.only(bottom: 5),
          alignment: Alignment.center,
          child: Text(name),
        ),
      )
      .toList();

  @override
  bool get wantKeepAlive => true;
}




