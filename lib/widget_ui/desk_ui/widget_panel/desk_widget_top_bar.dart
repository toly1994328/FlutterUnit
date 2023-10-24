import 'package:app/app.dart';
import 'package:components/toly_ui/toly_ui.dart';
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

  static const List<String> _tabs = ['无态', '有态', '单渲', '多渲', '滑片', '代理', '其它'];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: _tabs.length, vsync: this);
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
              width: 350,
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
