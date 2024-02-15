import 'package:l10n/ext.dart';
import 'package:toly_ui/toly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_module/blocs/blocs.dart';

import '../../../data/exp.dart';
import 'home_drawer.dart';
import 'standard_home_search.dart';
import 'widget_page.dart';

class StandardHomePage extends StatefulWidget {
  const StandardHomePage({Key? key}) : super(key: key);

  @override
  State<StandardHomePage> createState() => _StandardHomePageState();
}

class _StandardHomePageState extends State<StandardHomePage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {

  List<String> get _tabs =>[
    context.l10n.stateless,
    context.l10n.stateful,
    context.l10n.single,
    context.l10n.multi,
    context.l10n.sliver,
    context.l10n.proxy,
    context.l10n.other,
  ];

  late TabController tabController;



  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 7, vsync: this);
  }

  int maxCount = 60;

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void _switchTab(int index) {
    WidgetFamily widgetFamily = WidgetFamily.values[index];
    WidgetsBloc bloc = BlocProvider.of<WidgetsBloc>(context);
    if (bloc.state.filter.family == widgetFamily) return;
    PrimaryScrollController.of(context).jumpTo(0);
    BlocProvider.of<WidgetsBloc>(context).add(EventTabTap(widgetFamily));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final AppBarTheme appBarTheme = AppBarTheme.of(context);
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    double bottom = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      extendBody: true,
      // backgroundColor: const Color(0xffF3F4F6),
      drawer: const HomeDrawer(),
      body: Column(
        children: [
          AnnotatedRegion<SystemUiOverlayStyle>(
            value: appBarTheme.systemOverlayStyle!,
            child: Container(
              color: isDark ? Colors.black : Colors.white,
              height: MediaQuery.of(context).padding.top,
            ),
          ),
          Expanded(
            child: NestedScrollView(
                floatHeaderSlivers: true,
                headerSliverBuilder: _buildHeader,
                body: WidgetPage()),
          ),
          SizedBox(
            height: bottom,
          )
        ],
      ),
    );
  }

  List<Widget> _buildHeader(BuildContext context, bool innerBoxIsScrolled) {
    Color themeColor = Theme.of(context).primaryColor;
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return [
      const SliverSnapHeader(child: StandardHomeSearch()),
      // SliverOverlapAbsorber(
      //   sliver:
      SliverPinnedHeader(
          color: isDark ? Colors.black : Colors.white,
          child: TabBar(
            onTap: _switchTab,
            tabAlignment: TabAlignment.start,
            indicatorSize: TabBarIndicatorSize.label,
            isScrollable: true,
            indicator: RoundRectTabIndicator(
              borderSide: BorderSide(color: themeColor, width: 3),
            ),
            labelStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            controller: tabController,
            labelColor: themeColor,
            indicatorWeight: 3,
            unselectedLabelColor: Colors.grey,
            indicatorColor: themeColor,
            tabs: _tabs.map((String name) => Tab(text: name)).toList(),
          )),
      // handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
      // ),
    ];
  }

  @override
  bool get wantKeepAlive => true;
}
