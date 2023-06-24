import 'package:app/app.dart';
import 'package:components/toly_ui/toly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/navigation/home_drawer.dart';
import 'package:flutter_unit/app/utils/convert.dart';
import 'package:widget_module/blocs/blocs.dart';
import 'package:widget_repository/widget_repository.dart';

import 'standard_home_search.dart';
import 'widget_list_panel.dart';

class StandardHomePage extends StatefulWidget {
  const StandardHomePage({Key? key}) : super(key: key);

  @override
  State<StandardHomePage> createState() => _StandardHomePageState();
}

class _StandardHomePageState extends State<StandardHomePage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  static const List<String> _tabs = ['无态', '有态', '单渲', '多渲', '滑片', '代理', '其它'];
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void _switchTab(int index) {
    WidgetFamily widgetFamily = Convert.toFamily(index);
    WidgetsBloc bloc = BlocProvider.of<WidgetsBloc>(context);
    if(bloc.state.filter.family==widgetFamily) return;
    BlocProvider.of<WidgetsBloc>(context).add(EventTabTap(widgetFamily));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final AppBarTheme appBarTheme = AppBarTheme.of(context);
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      // backgroundColor: const Color(0xffF3F4F6),
      drawer: const HomeDrawer(),
      body: Column(
        children: [
          AnnotatedRegion<SystemUiOverlayStyle>(
            value: appBarTheme.systemOverlayStyle!,
            child: Container(
              color: isDark?Colors.black:Colors.white,
              height: MediaQuery.of(context).padding.top,
            ),
          ),
          Expanded(
            child: NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder: _buildHeader,
              body: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: tabController,
                children: _tabs.map(buildScrollPage).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildHeader(BuildContext context, bool innerBoxIsScrolled) {
    Color themeColor = Theme.of(context).primaryColor;
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return [
      const SliverSnapHeader(child: StandardHomeSearch()),
      SliverOverlapAbsorber(
        sliver: SliverPinnedHeader(
          color: isDark?Colors.black:Colors.white,
          child: TabBar(
            onTap: _switchTab,
            indicatorSize: TabBarIndicatorSize.label,
            isScrollable: true,
            indicator: RoundRectTabIndicator(
              borderSide: BorderSide(color: themeColor, width: 3),
            ),
            labelStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            controller: tabController,
            labelColor: themeColor,
            indicatorWeight: 3,
            unselectedLabelColor: Colors.grey,
            indicatorColor: themeColor,
            tabs: _tabs.map((String name) => Tab(text: name)).toList(),
          ),
        ),
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
      ),
    ];
  }

  Widget buildScrollPage(String name) {
    return Builder(
      builder: (BuildContext context) => CustomScrollView(
        key: PageStorageKey<String>(name),
        slivers: <Widget>[
          SliverOverlapInjector(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          ),
          const WidgetListPanel(),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 30),
            sliver: SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
