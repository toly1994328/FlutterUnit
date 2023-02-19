import 'package:components/toly_ui/toly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unit/app/plateform_adapter/window/windows_adapter.dart';

import '../widget_ui/desk_ui/widget_panel/window_buttons.dart';



class DeskCodeGenTopBar extends StatefulWidget {
  final ValueChanged<int> onTabPressed;
  final VoidCallback onTapGen;

  const DeskCodeGenTopBar({Key? key,required this.onTabPressed, required this.onTapGen}) : super(key: key);

  @override
  State<DeskCodeGenTopBar> createState() => _DeskCodeGenTopBarState();
}

class _DeskCodeGenTopBarState extends State<DeskCodeGenTopBar>  with SingleTickerProviderStateMixin {
  late TabController tabController;

  static const List<String> _tabs = ['数据类', 'IconFont', '状态管理', 'Json 解析',];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    Color themeColor = Theme.of(context).primaryColor;

    return DragToMoveAreaNoDouble(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 64,
        color: Colors.white,
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
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: StadiumBorder()
                ),
                onPressed: widget.onTapGen, child: Text('生成代码')),
            const SizedBox(width: 20,),
            WindowButtons(),
          ],
        ),
      ),
    );
  }
}
