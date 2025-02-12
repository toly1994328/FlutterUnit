import 'app_l10n.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppL10nEs extends AppL10n {
  AppL10nEs([String locale = 'es']) : super(locale);

  @override
  String get deskTabWidgets => 'Colección de widgets';

  @override
  String get deskTabPainter => 'Colección de dibujos';

  @override
  String get deskTabKnowledge => 'Centro de conocimiento';

  @override
  String get deskTabTools => 'Caja de herramientas';

  @override
  String get deskTabMine => 'Info App';

  @override
  String get mobileTabWidgets => 'Widgets';

  @override
  String get mobileTabPainter => 'Dibujo';

  @override
  String get mobileTabKnowledge => 'Conocimiento';

  @override
  String get mobileTabTools => 'Herramientas';

  @override
  String get mobileTabMine => 'Mi';
}
