import 'package:flutter/widgets.dart';

import 'package:portfolio/l10n/app_localizations.dart';
import 'package:portfolio/l10n/app_localizations_en.dart';

extension L10nX on BuildContext {
  AppLocalizations get l10n {
    final loc = AppLocalizations.of(this);
    assert(loc != null, 'No AppLocalizations found in context');
    return loc ?? AppLocalizationsEn();
  }

  String get languageCode {
    final locale = Localizations.localeOf(this);
    return locale.languageCode;
  }
}
