import 'package:flutter/cupertino.dart';
import 'package:pandora_talks/routes/login_screen.dart';

class RouteGenerator {
  static const String homePage = "/";
  static const String loadingPage = "/loading";
  static final key = GlobalKey<NavigatorState>();
  const RouteGenerator();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return CupertinoPageRoute(builder: (_) => const LoginScreen());

      default:
        throw FormatException();
    }
  }
}

class RouteException implements Exception {
  final String message;

  const RouteException(this.message);
}
