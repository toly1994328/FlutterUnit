// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_l10n.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppL10nEn extends AppL10n {
  AppL10nEn([String locale = 'en']) : super(locale);

  @override
  String get deskTabWidgets => 'Widgets';

  @override
  String get deskTabPainter => 'Painter';

  @override
  String get deskTabKnowledge => 'Knowledge';

  @override
  String get deskTabTools => 'Treasure';

  @override
  String get deskTabMine => 'About';

  @override
  String get messageBoard => 'Message Board';

  @override
  String get mobileTabWidgets => 'Widgets';

  @override
  String get mobileTabPainter => 'Painter';

  @override
  String get mobileTabKnowledge => 'Knowledge';

  @override
  String get mobileTabTools => 'Treasure';

  @override
  String get mobileTabMine => 'Mine';

  @override
  String get newBoard => 'New';

  @override
  String get news => 'News';

  @override
  String get moreNews => 'More News';
}
