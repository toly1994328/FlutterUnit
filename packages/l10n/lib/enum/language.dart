import 'dart:ui';

enum Language {
  zh_CN(locale: Locale('zh','CN'), label: '简体中文'),
  en_US(locale: Locale('en','US'), label: 'English');

  final Locale locale;
  final String label;

  const Language({
    required this.locale,
    required this.label,
  });
}
