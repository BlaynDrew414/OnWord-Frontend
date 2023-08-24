import 'package:flutter/material.dart';


class LightTheme {
  static final ThemeData themeData = ThemeData.light().copyWith(
    primaryColor: Color.fromARGB(255, 200, 241, 238),
    colorScheme: ColorScheme.light(
      background: Colors.white,
      secondary: Colors.grey,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: Color.fromARGB(255, 33, 33, 33),
      ),
    ),
  );
  static const Color textColorLight = Color.fromARGB(255, 33, 33, 33);
}

class DarkTheme {
  static final ThemeData themeData = ThemeData.dark().copyWith(
    primaryColor: Color.fromARGB(237, 30, 40, 62),
    colorScheme: ColorScheme.dark(
      background: Color.fromARGB(235, 25, 32, 46),
      secondary: Color.fromARGB(237, 30, 40, 62),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: Color.fromARGB(255, 160, 161, 162),
      ),
    ),
  );
  static const Color textColorDark = Color.fromARGB(255, 160, 161, 162);
}


