import 'package:algorithm/algorithm.dart';
import 'package:algorithm/src/algorithm/sort/functions.dart';
import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:toly_ui/toly_ui.dart';
import 'package:tolyui/basic/basic.dart';
import 'package:tolyui/tolyui.dart';

import '../data_scope/finding_state.dart';


class FindingToolBar extends StatelessWidget implements PreferredSizeWidget{
  const FindingToolBar({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    FindingState state = FindingStateScope.of(context);
    String  name = state.config.algo.name;


    return DragToMoveWrapper(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 42,
        color: isDark ? const Color(0xff2C3036) : Colors.white,
        child: Row(
          children: [
            const FindingButton(),
            TolyAction(
                tooltip: '更新地图',
                onTap: () {
                  if(state.status==FindingStatus.finding){
                    $message.warning(message: '正在寻路中,请稍后');
                    return;
                  }
                  state.reset();
                  // Scaffold.of(context).openEndDrawer();
                },
                child: const Icon(
                  Icons.refresh,
                  color: Colors.orange,
                  size: 20,
                )),
            TolyAction(
                selected: state.lockMap,
                tooltip:  state.lockMap?'解除锁定':'锁定地图',
                onTap: () {
                  if(state.status==FindingStatus.finding){
                    $message.warning(message: '正在寻路中,请稍后');
                    return;
                  }
                  if(state.lockMap){
                    state.unlock();

                  }else{
                    state.lock();

                  }
                  // Scaffold.of(context).openEndDrawer();
                },
                child: const Icon(
                  Icons.lock,
                  color: Colors.blue,
                  size: 20,
                )),
            Spacer(),
            TolyLink(
                href:
                    'https://github.com/toly1994328/FlutterUnit/blob/master/packages/algorithm/lib/src/algorithm/finding/functions/${name}.dart',
                text: '查看[$name 寻路]源码',
                hoverColor: Colors.blue,
                style: TextStyle(fontSize: 12,fontFamily: '宋体'),
                onTap: jumpURL),
            const SizedBox(width: 10),
            // TolyAction(
            //     tooltip: '设置',
            //     onTap: () {
            //       Scaffold.of(context).openEndDrawer();
            //     },
            //     child: const Icon(
            //       Icons.settings,
            //       size: 20,
            //     )),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(42);
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
