import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pandora_talks/blocs/authentication_bloc/bloc.dart';
import 'package:pandora_talks/repository/user_repository.dart';
import 'package:pandora_talks/repository/user_repository/phone_repository.dart';
import 'package:pandora_talks/routes/home_screen.dart';
import 'package:provider/provider.dart';

import 'localization/localization_delegate.dart';
import 'routes.dart';

void main() {
  runApp(
    Provider<UserRepository>(
      create: (_) => PhoneUserRepository(),
      builder: (context, child) {
        return MyApp();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  const MyApp();
  @override
  Widget build(BuildContext context) {
    final repository = context.select((UserRepository r) => r);

    return BlocProvider<AuthenticationBloc>(
      create: (_) => AuthenticationBloc(repository),
      child: MaterialApp(
        title: 'PandoraTalk',
        debugShowCheckedModeBanner: false,
        onGenerateTitle: (context) => "Pandora Talk",
        initialRoute: RouteGenerator.homePage,
        onGenerateRoute: RouteGenerator.generateRoute,
        navigatorKey: RouteGenerator.key,
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
        home: HomeScreen(),
      ),
    );
  }
}
