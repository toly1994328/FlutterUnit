import 'app_l10n.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppL10nJa extends AppL10n {
  AppL10nJa([String locale = 'ja']) : super(locale);

  @override
  String get deskTabWidgets => 'ウィジェット集';

  @override
  String get deskTabPainter => '描画集';

  @override
  String get deskTabKnowledge => 'ナレッジハブ';

  @override
  String get deskTabTools => 'ツールボックス';

  @override
  String get deskTabMine => 'アプリ情報';

  @override
  String get messageBoard => '掲示板';

  @override
  String get mobileTabWidgets => 'ウィジェット';

  @override
  String get mobileTabPainter => '描画';

  @override
  String get mobileTabKnowledge => '知識';

  @override
  String get mobileTabTools => 'ツール';

  @override
  String get mobileTabMine => 'マイ';
}
