// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_l10n.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppL10nDe extends AppL10n {
  AppL10nDe([String locale = 'de']) : super(locale);

  @override
  String get deskTabWidgets => 'Widget-Sammlung';

  @override
  String get deskTabPainter => 'Zeichnungssammlung';

  @override
  String get deskTabKnowledge => 'Wissensdatenbank';

  @override
  String get deskTabTools => 'Werkzeugkasten';

  @override
  String get deskTabMine => 'App-Info';

  @override
  String get messageBoard => 'Pinnwand';

  @override
  String get mobileTabWidgets => 'Widgets';

  @override
  String get mobileTabPainter => 'Malen';

  @override
  String get mobileTabKnowledge => 'Wissen';

  @override
  String get mobileTabTools => 'Werkzeuge';

  @override
  String get mobileTabMine => 'Mein';
}
