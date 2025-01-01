import 'package:flutter/material.dart';

import 'gen_l10n/app_localizations.dart';
export 'gen_l10n/app_localizations.dart' show AppLocalizations;
const l10nDelegates = AppLocalizations.localizationsDelegates;
const l10nLocales = AppLocalizations.supportedLocales;

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
