import 'package:app/app.dart';
import 'package:l10n/l10n.dart';
import 'package:toly_ui/toly_ui.dart';
import 'package:flutter/material.dart';

import 'desk_search_bar.dart';

class DeskWidgetTopBar extends StatefulWidget {
  final ValueChanged<int> onTabPressed;

  const DeskWidgetTopBar({Key? key,required this.onTabPressed}) : super(key: key);

  @override
  State<DeskWidgetTopBar> createState() => _DeskWidgetTopBarState();
}

class _DeskWidgetTopBarState extends State<DeskWidgetTopBar>  with SingleTickerProviderStateMixin {
  late TabController tabController;


  List<String> get _tabs =>[
    context.l10n.stateless,
    context.l10n.stateful,
    context.l10n.single,
    context.l10n.multi,
    context.l10n.sliver,
    context.l10n.proxy,
    context.l10n.other,
  ];


  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 7, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    Color themeColor = Theme.of(context).primaryColor;
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return DragToMoveAreaNoDouble(
      child: Container(
        padding: const EdgeInsets.only(left: 20),
        height: 64,
        color: isDark?Color(0xff2C3036):Colors.white,
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
                tabs:
                _tabs.map((String name) => Tab(text: name)).toList(),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                  width: 250, height: 30, child: DeskSearchBar(
              )),
            ),
            // const SizedBox(width: 20,),
            const WindowButtons(),
          ],
        ),
      ),
    );
  }
}
