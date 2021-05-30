import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pandora_talks/blocs/authentication_bloc/bloc.dart';
import 'package:pandora_talks/blocs/theme_provider/theme_manager.dart';
import 'package:pandora_talks/repository/user_repository.dart';
import 'package:pandora_talks/repository/user_repository/phone_repository.dart';
import 'package:pandora_talks/routes/home_screen.dart';
import 'package:provider/provider.dart';

import 'localization/localization_delegate.dart';
import 'routes.dart';

void main() {
  runApp(
    Provider<PhoneUserRepository>(
      create: (_) => PhoneUserRepository(),
      builder: (context, child) {
        return MyApp();
      },
    ),
  );
}

// {
//     @Override
//     public void onAuthStateChanged(@NonNull FirebaseAuth auth) {
//         FirebaseUser firebaseUser = auth.getCurrentUser();
//         if (firebaseUser != null) {
//             //Do what you need to do
//         }
//     }
// };
class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  const MyApp();
  @override
  Widget build(BuildContext context) {
    final repository = context.select((PhoneUserRepository r) => r);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ThemeManager(),
        ),
      ],
      child: BlocProvider<AuthenticationBloc>(
          create: (_) => AuthenticationBloc(repository),
          child: Consumer<ThemeManager>(
            builder: (ctx, theme, _) {
              return MaterialApp(
                title: 'PandoraTalk',
                theme: theme.themeData,
                debugShowCheckedModeBanner: false,
                onGenerateTitle: (context) => "Pandora Talk",
                initialRoute: RouteGenerator.homePage,
                onGenerateRoute: RouteGenerator.generateRoute,
                navigatorKey: RouteGenerator.key,
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
              );
            },
          )),
    );
  }
}
