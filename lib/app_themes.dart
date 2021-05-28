import 'package:flutter/material.dart';

enum AppTheme { White, Dark }

/// Returns enum value name without enum class name.
String enumName(AppTheme anyEnum) {
  return anyEnum.toString().split('.')[1];
}

final appThemeData = {
  AppTheme.White: ThemeData(
    fontFamily: 'tajawal',
    canvasColor: Colors.white,
    primaryColor: Color(0xff09ce4a),
    textTheme: TextTheme(
      bodyText1: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
      bodyText2: TextStyle(color: Colors.grey.shade600),
    ),
    //accentColor: Color.fromRGBO(255, 189, 67, 1),
    // accentColor: Color(0xff215a7d),
    //bottomAppBarColor: Color(0xff313e4b),
    appBarTheme: AppBarTheme(
      color: Color(0xff0ead3f),
      elevation: 0,
      centerTitle: false,
      iconTheme: IconThemeData(color: Colors.white),
      textTheme: TextTheme(
        title: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ),
  AppTheme.Dark: ThemeData(
    fontFamily: 'tajawal',
    canvasColor: Colors.white,
    primaryColor: Color(0xff09ce4a),
    //accentColor: Color.fromRGBO(255, 189, 67, 1),
    // accentColor: Color(0xff215a7d),
    //bottomAppBarColor: Color(0xff313e4b),
    appBarTheme: AppBarTheme(
      color: Color(0xff0ead3f),
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      centerTitle: false,
      textTheme: TextTheme(
        title: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ),
};
