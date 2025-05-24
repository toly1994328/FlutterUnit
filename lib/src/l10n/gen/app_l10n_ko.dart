// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_l10n.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppL10nKo extends AppL10n {
  AppL10nKo([String locale = 'ko']) : super(locale);

  @override
  String get deskTabWidgets => '위젯 모음집';

  @override
  String get deskTabPainter => '그림 모음집';

  @override
  String get deskTabKnowledge => '지식 허브';

  @override
  String get deskTabTools => '도구 상자';

  @override
  String get deskTabMine => '앱 정보';

  @override
  String get messageBoard => '게시판';

  @override
  String get mobileTabWidgets => '위젯';

  @override
  String get mobileTabPainter => '그리기';

  @override
  String get mobileTabKnowledge => '지식';

  @override
  String get mobileTabTools => '도구';

  @override
  String get mobileTabMine => '내 정보';

  @override
  String get newBoard => '새 글';

  @override
  String get news => '최신 소식';

  @override
  String get moreNews => '더 보기';
}
