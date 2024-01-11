import 'package:app/app.dart';
import 'package:toly_ui/toly_ui.dart';
import 'package:flutter/material.dart';



class DeskCodeGenTopBar extends StatefulWidget {
  final ValueChanged<int> onTabPressed;
  final VoidCallback onTapGen;

  const DeskCodeGenTopBar({Key? key,required this.onTabPressed, required this.onTapGen}) : super(key: key);

  @override
  State<DeskCodeGenTopBar> createState() => _DeskCodeGenTopBarState();
}

class _DeskCodeGenTopBarState extends State<DeskCodeGenTopBar>  with SingleTickerProviderStateMixin {
  late TabController tabController;

  static const List<String> _tabs = ['IconFont', '数据类' , '状态管理', 'Json 解析',];

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
        height: 64,
      color: isDark?Color(0xff2C3036):Colors.white,
        child: Row(
          children: [
            const SizedBox(width: 12,),
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

            const SizedBox(width: 20,),
            WindowButtons(),
          ],
        ),
      ),
    );
  }
}
