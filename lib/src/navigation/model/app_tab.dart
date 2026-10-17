import 'package:app/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unit/src/l10n/gen/app_l10n.dart';
import 'package:tolyui/tolyui.dart';

enum AppTab {
  widgets('/widget', TolyIcon.icon_layout),
  packages('/packages', Icons.batch_prediction_rounded),
  knowledge('/knowledge', TolyIcon.icon_artifact),
  tools('/tools', TolyIcon.icon_fast),
  mine('/account', TolyIcon.yonghu);

  final IconData icon;
  final String path;

  /// 手机端知识入口紧随组件，页面顺序与底部导航保持一致。
  static List<AppTab> get mobileTabs =>
      const <AppTab>[widgets, knowledge, packages, tools, mine];

  /// 桌面端导航顺序，知识集锦紧随组件集录。
  static const List<AppTab> desktopTabs = <AppTab>[
    widgets,
    knowledge,
    packages,
    tools,
    mine,
  ];

  const AppTab(this.path, this.icon);

  String label(AppL10n l10n) {
    if (kAppEnv.isDesktopUI) {
      return switch (this) {
        AppTab.widgets => l10n.deskTabWidgets,
        AppTab.knowledge => l10n.deskTabKnowledge,
        AppTab.tools => l10n.deskTabTools,
        AppTab.mine => l10n.deskTabMine,
        AppTab.packages => l10n.package,
      };
    }
    return switch (this) {
      AppTab.widgets => l10n.mobileTabWidgets,
      AppTab.knowledge => l10n.mobileTabKnowledge,
      AppTab.tools => l10n.mobileTabTools,
      AppTab.mine => l10n.mobileTabMine,
      AppTab.packages => l10n.package,
    };
  }

  IconMenu menu(AppL10n l10n) => IconMenu(
        icon,
        label: label(l10n),
        route: path,
      );
}
