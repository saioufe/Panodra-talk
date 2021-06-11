import 'package:flutter/cupertino.dart';
import 'package:pandora_talks/routes/home_screen.dart';
import 'package:pandora_talks/routes/search_screen.dart';

class RouteGenerator {
  static const String homePage = "/";
  static const String loadingPage = "/home";
  static const String searchPage = "/search";
  static final key = GlobalKey<NavigatorState>();
  const RouteGenerator();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return CupertinoPageRoute(builder: (_) => const HomeScreen());
      case searchPage:
        return CupertinoPageRoute(builder: (_) => const SearchScreen());

      default:
        throw FormatException();
    }
  }
}

class RouteException implements Exception {
  final String message;

  const RouteException(this.message);
}
