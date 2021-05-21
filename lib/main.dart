import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pandora_talks/routes/login_screen.dart';

import 'localization/localization_delegate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  const MyApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PandoraTalk',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: [
        const AppLocalizationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale.fromSubtags(languageCode: "ar"),
        Locale.fromSubtags(languageCode: "en"),
      ],
      home: LoginScreen(),
    );
  }
}
