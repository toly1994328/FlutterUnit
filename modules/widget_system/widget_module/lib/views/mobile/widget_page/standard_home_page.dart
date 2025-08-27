import 'package:l10n/ext.dart';
import 'package:widget_module/blocs/action/widget_action.dart';
import 'package:widget_repository/widget_repository.dart';

import 'package:toly_ui/toly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_module/blocs/blocs.dart';
import 'home_drawer.dart';
import 'standard_home_search.dart';
import 'widget_page.dart';

class StandardHomePage extends StatefulWidget {
  final Widget? heard;

  const StandardHomePage({super.key, this.heard});

  @override
  State<StandardHomePage> createState() => _StandardHomePageState();
}

class _StandardHomePageState extends State<StandardHomePage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  List<String> get _tabs {
    final provider = WidgetStatisticsProvider();
    final stats = provider.statistics;

    if (stats == null) {
      return [
        context.l10n.stateless,
        context.l10n.stateful,
        context.l10n.single,
        context.l10n.multi,
        context.l10n.sliver,
        context.l10n.proxy,
        context.l10n.other,
      ];
    }

    return [
      context.l10n.stateless,
      context.l10n.stateful,
      context.l10n.single,
      context.l10n.multi,
      context.l10n.sliver,
      context.l10n.proxy,
      context.l10n.other,
    ];
  }

  ValueNotifier<int> indexValue = ValueNotifier(0);

  List<Widget> _buildTabWidgets() {
    final provider = WidgetStatisticsProvider();
    final stats = provider.statistics;
    final counts = [
      stats?.familyCount[WidgetFamily.stateless] ?? 0,
      stats?.familyCount[WidgetFamily.stateful] ?? 0,
      stats?.familyCount[WidgetFamily.singleChildRender] ?? 0,
      stats?.familyCount[WidgetFamily.multiChildRender] ?? 0,
      stats?.familyCount[WidgetFamily.sliver] ?? 0,
      stats?.familyCount[WidgetFamily.proxy] ?? 0,
      stats?.familyCount[WidgetFamily.other] ?? 0,
    ];

    return List.generate(
        _tabs.length,
        (index) => ValueListenableBuilder<int>(
            valueListenable: indexValue,
            builder: (context, value, __) {
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  Text(_tabs[index]),
                  if (value == index)
                    Positioned(
                      right: -10,
                      top: -6,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .primaryColor
                              .withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text('${counts[index]}',
                            style: const TextStyle(
                                fontFamily: '黑体',
                                height: 1,
                                fontSize: 9,
                                color: Colors.white)),
                      ),
                    ),
                ],
              );
            }));
  }

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 7, vsync: this);
    tabController.addListener(_onChange);
  }

  int maxCount = 60;

  @override
  void dispose() {
    tabController.removeListener(_onChange);

    tabController.dispose();
    super.dispose();
  }

  void _switchTab(int index) {
    WidgetFamily widgetFamily = WidgetFamily.values[index];
    WidgetsBloc bloc = context.read<WidgetsBloc>();
    if (bloc.state.filter.family == widgetFamily) return;
    PrimaryScrollController.of(context).jumpTo(0);
    context.switchWidgetFamily(widgetFamily);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final AppBarTheme appBarTheme = AppBarTheme.of(context);
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    double bottom = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      extendBody: true,
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
                body: const WidgetPage()),
          ),
          SizedBox(height: bottom)
        ],
      ),
    );
  }

  List<Widget> _buildHeader(BuildContext context, bool innerBoxIsScrolled) {
    Color themeColor = Theme.of(context).primaryColor;
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return [
      // const SliverSnapHeader(child: StandardHomeSearch()),
      const SliverFloatingHeader(
        snapMode: FloatingHeaderSnapMode.scroll,
        child: StandardHomeSearch(),
      ),
      if (widget.heard != null)
        SliverToBoxAdapter(
          child: Container(
            height: 168,
            color: isDark ? Colors.black : Colors.white,
            child: widget.heard,
          ),
        ),
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
            tabs: _buildTabWidgets()
                .map((Widget widget) => Tab(child: widget))
                .toList(),
          )),
      // handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
      // ),
    ];
  }

  @override
  bool get wantKeepAlive => true;

  void _onChange() {
    indexValue.value = tabController.index;
  }
}
