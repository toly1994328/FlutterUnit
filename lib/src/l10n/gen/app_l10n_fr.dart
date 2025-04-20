// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_l10n.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppL10nFr extends AppL10n {
  AppL10nFr([String locale = 'fr']) : super(locale);

  @override
  String get deskTabWidgets => 'Collection de widgets';

  @override
  String get deskTabPainter => 'Collection de dessins';

  @override
  String get deskTabKnowledge => 'Base de connaissances';

  @override
  String get deskTabTools => 'Boîte à outils';

  @override
  String get deskTabMine => 'Infos App';

  @override
  String get messageBoard => 'Tableau de messages';

  @override
  String get mobileTabWidgets => 'Widgets';

  @override
  String get mobileTabPainter => 'Dessin';

  @override
  String get mobileTabKnowledge => 'Connaissances';

  @override
  String get mobileTabTools => 'Outils';

  @override
  String get mobileTabMine => 'Moi';
}
