import 'package:app/app.dart';
import 'package:toly_ui/toly_ui.dart';
import 'package:flutter/material.dart';

class DeskKnowledgeTabTopBar extends StatefulWidget {
  /// 知识库各入口的标题。
  final List<String> tabs;

  /// 主页面同步切换入口。
  final ValueChanged<int> onTabPressed;

  const DeskKnowledgeTabTopBar(
      {super.key, required this.onTabPressed, required this.tabs});

  @override
  State<DeskKnowledgeTabTopBar> createState() => _DeskKnowledgeTabTopBarState();
}

class _DeskKnowledgeTabTopBarState extends State<DeskKnowledgeTabTopBar>
    with TickerProviderStateMixin {
  /// 顶部标签的选中状态与动画。
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: widget.tabs.length, vsync: this);
  }

  @override
  void didUpdateWidget(covariant DeskKnowledgeTabTopBar oldWidget) {
    if (oldWidget.tabs.length != widget.tabs.length) {
      tabController.dispose();
      tabController = TabController(length: widget.tabs.length, vsync: this);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color themeColor = Theme.of(context).primaryColor;

    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return DragToMoveWrapper(
      child: Stack(
        children: [
          Container(
            height: 56,
            color: isDark ? const Color(0xff2C3036) : Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: Center(
                    child: SizedBox(
                      width: 400,
                      child: TabBar(
                        onTap: widget.onTabPressed,
                        indicatorSize: TabBarIndicatorSize.label,
                        labelPadding: const EdgeInsets.symmetric(horizontal: 6),
                        isScrollable: false,
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
                        tabs: widget.tabs
                            .map((String name) => Tab(text: name))
                            .toList(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                // WindowButtons(),
              ],
            ),
          ),
          const Positioned(child: WindowButtons())
        ],
      ),
    );
  }
}
