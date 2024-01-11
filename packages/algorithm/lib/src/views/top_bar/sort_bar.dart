import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:toly_ui/toly_ui.dart';


import '../../data_scope/state.dart';
import '../../algorithm/sort/functions.dart';
import 'sort_button.dart';

class DeskSortBar extends StatelessWidget {
  const DeskSortBar({super.key});

  @override
  Widget build(BuildContext context) {

    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return DragToMoveAreaNoDouble(
      child: Container(
        height: 64,
        color: isDark? const Color(0xff2C3036):Colors.white,
        child: const Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text('可视化排序',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
            ),
            Spacer(),
            SizedBox(
              width: 20,
            ),
            SortBar(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 18.0),
              child: VerticalDivider(
                width: 32,
              ),
            ),
            WindowButtons(),
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
        const SortButton(),
        const SizedBox(width: 10,),
        const SortSelector(),
        const SizedBox(width: 10,),
        GestureDetector(
            onTap: (){
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
        state.config =state.config.copyWith(
            name: sortNameMap.keys.toList()[index]
        );
      },
    );
  }
}
