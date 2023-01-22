import 'package:flutter/material.dart';

import 'colors.dart';

class MyThemeData {
  static ThemeData lightTheme = ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: greenBackground,
      colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: primaryColor,
          onPrimary: Colors.white,
          secondary: greenBackground,
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          background: greenBackground,
          onBackground: primaryColor,
          surface: Colors.grey,
          onSurface: colorBlack),
      appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
          iconTheme: IconThemeData(color: Colors.white)),
      textTheme: TextTheme(
        headline1: TextStyle(
            fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        subtitle1: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: primaryColor),
        subtitle2: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: colorGreen),
      ),
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: primaryColor),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.grey));

  static ThemeData darkTheme = ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: greenBackground,
      colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: primaryColor,
          onPrimary: Colors.white,
          secondary: greenBackground,
          onSecondary: colorBlack,
          error: Colors.red,
          onError: Colors.white,
          background: greenBackground,
          onBackground: primaryColor,
          surface: colorBlack,
          onSurface: colorBlack),
      appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
          iconTheme: IconThemeData(color: Colors.white)),
      textTheme: TextTheme(
        headline1: TextStyle(
            fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        subtitle1: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: primaryColor),
        subtitle2: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: colorGreen),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.grey));
}
