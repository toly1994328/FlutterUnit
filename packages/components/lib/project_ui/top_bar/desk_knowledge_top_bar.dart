import 'package:app/app.dart';
import 'package:toly_ui/toly_ui.dart';
import 'package:flutter/material.dart';

class DeskKnowledgeTabTopBar extends StatefulWidget {
  final List<String> tabs;
  final ValueChanged<int> onTabPressed;

  const DeskKnowledgeTabTopBar(
      {Key? key, required this.onTabPressed, required this.tabs})
      : super(key: key);

  @override
  State<DeskKnowledgeTabTopBar> createState() => _DeskKnowledgeTabTopBarState();
}

class _DeskKnowledgeTabTopBarState extends State<DeskKnowledgeTabTopBar>
    with TickerProviderStateMixin {
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
  Widget build(BuildContext context) {
    Color themeColor = Theme.of(context).primaryColor;

    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return DragToMoveAreaNoDouble(
      child: Stack(
        children: [
          Container(
            height: 64,
            color: isDark ? Color(0xff2C3036) : Colors.white,
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
          Positioned(child: WindowButtons())
        ],
      ),
    );
  }
}
