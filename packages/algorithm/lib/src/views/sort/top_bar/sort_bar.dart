import 'package:algorithm/algorithm.dart';
import 'package:algorithm/src/algorithm/sort/functions.dart';
import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:toly_ui/toly_ui.dart';
import 'package:tolyui/basic/basic.dart';

import 'sort_button.dart';

class DeskSortBar extends StatelessWidget {
  const DeskSortBar({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    String name = SortStateScope.of(context).config.name;

    return DragToMoveWrapper(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 42,
        color: isDark ? const Color(0xff2C3036) : Colors.white,
        child: Row(
          children: [
            const FindingButton(),
            Spacer(),
            TolyLink(
                href:
                    'https://github.com/toly1994328/FlutterUnit/blob/master/packages/algorithm/lib/src/algorithm/sort/functions/${name}.dart',
                text: '查看排序源码',
                hoverColor: Colors.blue,
                style: TextStyle(fontSize: 12,fontFamily: '宋体'),
                onTap: jumpURL),
            const SizedBox(width: 10),
            TolyAction(
                tooltip: '设置',
                onTap: () {
                  Scaffold.of(context).openEndDrawer();
                },
                child: const Icon(
                  Icons.settings,
                  size: 20,
                )),
          ],
        ),
      ),
    );
  }
}

class SortBar extends StatelessWidget {
  const SortBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const FindingButton(),
        const SizedBox(
          width: 10,
        ),
        const SortSelector(),
        const SizedBox(
          width: 10,
        ),
        GestureDetector(
            onTap: () {
              Scaffold.of(context).openEndDrawer();
            },
            child: const Icon(Icons.settings))
      ],
    );
  }
}

class SortSelector extends StatelessWidget {
  const SortSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return DropSelectableWidget(
      fontSize: 12,
      data: sortNameMap.values.toList(),
      iconSize: 20,
      height: 28,
      width: 200,
      disableColor: const Color(0xff1F425F),
      onDropSelected: (int index) async {
        SortState state = SortStateScope.of(context);
        state.config = state.config.copyWith(name: sortNameMap.keys.toList()[index]);
      },
    );
  }
}
