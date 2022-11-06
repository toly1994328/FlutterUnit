import 'package:db_storage/db_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/blocs/color_change_bloc.dart';
import 'package:flutter_unit/app/res/cons.dart';
import 'package:flutter_unit/app/utils/convert.dart';
import 'package:flutter_unit/components/permanent/decorations/round_rect_rab_indicator.dart';
import 'package:flutter_unit/components/permanent/sliver_header/sliver_pinned_header.dart';
import 'package:flutter_unit/components/permanent/sliver_header/sliver_snap_header.dart';
import 'package:flutter_unit/widget_system/blocs/widget_system_bloc.dart';

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

  List<Widget> _buildHeader(BuildContext context, bool innerBoxIsScrolled) {
    Color themeColor = Theme.of(context).primaryColor;

    return [
      const SliverSnapHeader(
        child: StandardHomeSearch(),
      ),
      SliverOverlapAbsorber(
        sliver: SliverPinnedHeader(
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

  void _switchTab(int index) {
    WidgetFamily widgetFamily = Convert.toFamily(index);
    context.read<ColorChangeCubit>()
        .change(Cons.tabColors[index], family: widgetFamily);
    BlocProvider.of<WidgetsBloc>(context).add(EventTabTap(widgetFamily));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final AppBarTheme appBarTheme = AppBarTheme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xffF3F4F6),
      body: Column(
        children: [
          AnnotatedRegion<SystemUiOverlayStyle>(
            value: appBarTheme.systemOverlayStyle!,
            child: Container(
              color: Colors.white,
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
            padding: const EdgeInsets.only(bottom: 20),
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
