import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:l10n/l10n.dart';
import 'package:toly_ui/toly_ui.dart';

import 'package:authentication/views/authentic_widget.dart';
import '../../desk_ui/category_panel/desk_category_page.dart';
import 'category_page.dart';
import 'like_widget_page.dart';
import 'sync/async_button.dart';
import 'sync/upload_button.dart';


class CollectPageAdapter extends StatelessWidget {
  final bool canPop;
  const CollectPageAdapter({Key? key, this.canPop=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDesk = Platform.isMacOS||Platform.isWindows||Platform.isLinux;
    if(isDesk){
      return DeskCategoryPage();
    }else{
      return CollectPage(canPop:canPop);
    }
  }
}



class CollectPage extends StatefulWidget {
  final bool canPop;
  const CollectPage({Key? key, this.canPop=false}) : super(key: key);

  @override
  _CollectPageState createState() => _CollectPageState();
}

class _CollectPageState extends State<CollectPage>
    with AutomaticKeepAliveClientMixin {
 late final List<String> _tabs =  [
    context.l10n.widgetsInn,
    context.l10n.likedWidgets,
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    BuildContext _topContext = context;
    final Color color = Colors.blue.withAlpha(11);

    return Scaffold(
        // backgroundColor: Colors.white,
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
              body: const TabBarView(
                children: [
                  CategoryPage(),
                  LikeWidgetPage(),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildAppBar(BuildContext context, bool index) {
    // final Color color = Colors.blue;
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    String image = isDark?'draw_bg3.webp':'caver.webp';
    return SliverAppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light
      ),
      leading: widget.canPop?BackButton(color: Colors.white,):Container(
          margin: const EdgeInsets.all(10),
          child: FeedbackWidget(
            onPressed: () {
              // Navigator.of(context).pushNamed(UnitRouter.login);
            },
            child: const CircleImage(
              image: AssetImage('assets/images/icon_head.webp'),
              borderSize: 1.5,
            ),
          )),
      backgroundColor: Theme.of(context).primaryColor,
      actionsIconTheme: IconThemeData(color: Colors.white),
      actions: <Widget>[
        SizedBox(
            width: 32,
            child: AuthenticWidget.just(const UploadCategoryButton())),
        // SizedBox(width: 5,),

        SizedBox(
            width: 32,
            child: AuthenticWidget.just(const SyncCategoryButton())),
        if(!widget.canPop)
        SizedBox(child: _buildAddAction(context))
      ],
      title:  Text(
        context.l10n.collectCollection,
        style: TextStyle(
            color: Colors.white, //标题
            fontSize: 18,
            shadows: [
              Shadow(color: Colors.blue, offset:Offset(1, 1), blurRadius: 2)
            ]),
      ),
      pinned: true,
      expandedHeight: 150.0,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax, //视差效果
        background: Image.asset(
          "assets/images/$image",
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

  Widget _buildAddAction(BuildContext context) => GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap:  () => Scaffold.of(context).openEndDrawer(),
    child: SizedBox(
      width: 32,
        child: const Icon(
          Icons.add,
          size: 24,
        ),
      ),
  );

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




