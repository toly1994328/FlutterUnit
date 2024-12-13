import 'package:flutter/material.dart';

class LocalizationsDemo1 extends StatelessWidget {
  const LocalizationsDemo1({super.key});

  @override
  Widget build(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    return Text('Locale: ${locale.toString()}');
  }
}
