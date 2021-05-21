import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:pandora_talks/localization/app_localization.dart';
import 'package:intl/intl.dart';

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  const AppLocalizationDelegate();
  @override
  bool isSupported(Locale locale) {
    return ['en', "ar"].contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) =>
      SynchronousFuture<AppLocalization>(AppLocalization());

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalization> old) {
    return false;
  }
}
