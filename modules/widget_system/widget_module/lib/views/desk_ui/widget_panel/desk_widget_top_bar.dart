import 'package:app/app.dart';
import 'package:l10n/l10n.dart';
import 'package:toly_ui/toly_ui.dart';
import 'package:flutter/material.dart';
import 'package:widget_repository/widget_repository.dart';

import 'desk_search_bar.dart';

class DeskWidgetTopBar extends StatefulWidget {
  final ValueChanged<int> onTabPressed;

  const DeskWidgetTopBar({Key? key, required this.onTabPressed})
      : super(key: key);

  @override
  State<DeskWidgetTopBar> createState() => _DeskWidgetTopBarState();
}

class _DeskWidgetTopBarState extends State<DeskWidgetTopBar>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

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
        (index) => Stack(
              clipBehavior: Clip.none,
              children: [
                Text(_tabs[index]),
                if (tabController.index == index)
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
            ));
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 7, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    Color themeColor = Theme.of(context).primaryColor;
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return DragToMoveWrapper(
      child: Container(
        padding: const EdgeInsets.only(left: 20),
        height: 64,
        color: isDark ? Color(0xff2C3036) : Colors.white,
        child: Row(
          children: [
            SizedBox(
              width: 380,
              child: TabBar(
                onTap: widget.onTabPressed,
                tabAlignment: TabAlignment.start,
                indicatorSize: TabBarIndicatorSize.label,
                labelPadding: const EdgeInsets.symmetric(horizontal: 6),
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
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(width: 250, height: 30, child: DeskSearchBar()),
            ),
            // const SizedBox(width: 20,),
            const WindowButtons(),
          ],
        ),
      ),
    );
  }
}
