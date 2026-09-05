import 'package:authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        currentIndex: AppTab.mobileTabs.indexOf(activeTab),
        elevation: 3,
        // fixedColor: themeColor.activeColor,
        type: BottomNavigationBarType.fixed,
        iconSize: 22,
        selectedItemColor: Theme.of(context).primaryColor,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        showUnselectedLabels: true,
        showSelectedLabels: true,
        // backgroundColor: themeColor.itemColor,
        items: AppTab.mobileTabs
            .map((AppTab tab) => BottomNavigationBarItem(
                  label: tab.label(l10n),
                  icon: _buildIcon(tab),
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

  Widget _buildIcon(AppTab tab) {
    final Widget icon = Icon(tab.icon);
    if (tab != AppTab.mine) return icon;
    return BlocSelector<ProgressionCubit, ProgressionState, int>(
      selector: (ProgressionState state) => state.claimableTaskCount,
      builder: (BuildContext context, int count) {
        if (count == 0) return icon;
        return Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            icon,
            Positioned(
              top: -7,
              right: -12,
              child: Container(
                constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                padding: const EdgeInsets.symmetric(horizontal: 4),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  count > 99 ? '99+' : '$count',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    height: 1,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
