import 'package:flutter/material.dart';

mixin LocalProvider {
  Iterable<LocalizationsDelegate<dynamic>>? get localizationsDelegates;

  List<Locale> get supportedLocales;
}
