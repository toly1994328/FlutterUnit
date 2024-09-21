import 'package:flutter/material.dart';

import '../../../l10n/gen/app_l10n.dart';
import '../../model/app_tab.dart';

class PureBottomBar extends StatelessWidget {
  final ValueChanged<int>? onTap;
  final AppTab activeTab;


  const PureBottomBar({
    super.key,
    this.onTap,
    required this.activeTab,
    // required this.labels,
    // required this.icons,
  });

  @override
  Widget build(BuildContext context) {
    AppL10n l10n = AppL10n.of(context);
    return BottomNavigationBar(
        onTap: onTap,
        currentIndex: activeTab.index,
        elevation: 3,
        // fixedColor: themeColor.activeColor,
        type: BottomNavigationBarType.fixed,
        iconSize: 22,
        selectedItemColor: Theme.of(context).primaryColor,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        showUnselectedLabels: true,
        showSelectedLabels: true,
        // backgroundColor: themeColor.itemColor,
        items: AppTab.values
            .map((AppTab tab) => BottomNavigationBarItem(
                  label: tab.label(l10n),
                  icon: Icon(tab.icon),
                ))
            .toList()

        // labels
        //     .asMap()
        //     .keys
        //     .map((index) =>
        //
        //     .toList(),
        );
  }
}
