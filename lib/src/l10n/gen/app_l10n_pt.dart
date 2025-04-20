// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_l10n.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppL10nPt extends AppL10n {
  AppL10nPt([String locale = 'pt']) : super(locale);

  @override
  String get deskTabWidgets => 'Coleção de widgets';

  @override
  String get deskTabPainter => 'Coleção de desenhos';

  @override
  String get deskTabKnowledge => 'Hub de conhecimento';

  @override
  String get deskTabTools => 'Caixa de ferramentas';

  @override
  String get deskTabMine => 'Info App';

  @override
  String get messageBoard => 'Quadro de Mensagens';

  @override
  String get mobileTabWidgets => 'Widgets';

  @override
  String get mobileTabPainter => 'Desenho';

  @override
  String get mobileTabKnowledge => 'Conhecimento';

  @override
  String get mobileTabTools => 'Ferramentas';

  @override
  String get mobileTabMine => 'Meu';
}
