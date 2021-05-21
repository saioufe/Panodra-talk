import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:intl/locale.dart';

enum LockKeys { hello }

class AppLocalization {
  static AppLocalization of(BuildContext ctx) {
    return Localizations.of<AppLocalization>(ctx, AppLocalization);
  }

  static Map<String, Map<LockKeys, String>> _db = {
    "en": {
      LockKeys.hello: "Hello!",
    },
    "ar": {
      LockKeys.hello: "اهلا وسهلا",
    },
  };

  String localize(LockKeys value) {
    final code = PlatformDispatcher.instance.locale.languageCode;

    print(code);

    if (_db.containsKey(code)) {
      return _db[code][value] ?? "-";
    } else {
      return _db["ar"][value] ?? "-";
    }
  }
}
