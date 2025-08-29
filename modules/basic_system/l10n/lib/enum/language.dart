import 'dart:ui';

enum Language {
  zh_CN(locale: Locale('zh', 'CN'), label: '简体中文'),
  en_US(locale: Locale('en', 'US'), label: 'English'),
  // ru_RU(locale: Locale('ru','RU'), label: 'Русский'),
  // fr_FR(locale: Locale('fr','FR'), label: 'Français'),
  // ko_KR(locale: Locale('ko','KR'), label: '한국어'),
  // de_DE(locale: Locale('de','DE'), label: 'Deutsch'),
  // ja_JP(locale: Locale('ja','JP'), label: '日本語'),
  // it_IT(locale: Locale('it','IT'), label: 'Italiano'),
  // pt_PT(locale: Locale('pt','PT'), label: 'Português'),
  // es_ES(locale: Locale('es','ES'), label: 'Español'),
  ;

  String get code =>
      '${locale.languageCode}-${locale.countryCode}'.toLowerCase();

  final Locale locale;
  final String label;

  const Language({
    required this.locale,
    required this.label,
  });
}
