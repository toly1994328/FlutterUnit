import 'app_l10n.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppL10nZh extends AppL10n {
  AppL10nZh([String locale = 'zh']) : super(locale);

  @override
  String get deskTabWidgets => '组件集录';

  @override
  String get deskTabPainter => '绘制集录';

  @override
  String get deskTabKnowledge => '知识集锦';

  @override
  String get deskTabTools => '工具宝箱';

  @override
  String get deskTabMine => '应用信息';

  @override
  String get messageBoard => '留言板';

  @override
  String get mobileTabWidgets => '组件';

  @override
  String get mobileTabPainter => '绘制';

  @override
  String get mobileTabKnowledge => '知识';

  @override
  String get mobileTabTools => '工具';

  @override
  String get mobileTabMine => '我的';
}
