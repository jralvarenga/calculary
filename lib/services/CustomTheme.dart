import 'package:flutter/material.dart';

class CustomTheme {
  CustomTheme({
    required this.isDark,
  });

  final bool isDark;

  ThemeData get themeData {

    TextTheme textTheme = (isDark ? ThemeData.dark() : ThemeData.light()).textTheme;
    Color txtColor = isDark ? Color.fromRGBO(255, 255, 255, 1) : Color.fromRGBO(0, 0, 0, 1);
    ColorScheme colorScheme = ColorScheme(
      primary: Color.fromRGBO(249, 220, 197, 1),
      primaryVariant: Color.fromRGBO(249, 220, 197, 1),
      secondary: Color.fromRGBO(210, 155, 253, 1),
      secondaryVariant: Color.fromRGBO(210, 155, 253, 1),
      surface: Color.fromRGBO(227, 227, 227, 1),
      background: isDark ? Colors.black : Colors.white,
      onBackground: txtColor,
      onSurface: txtColor,
      onError: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      error: Colors.red.shade400,
      brightness: isDark ? Brightness.dark : Brightness.light,
    );

    var theme = ThemeData(
      colorScheme: colorScheme,
      textTheme: textTheme,

      fontFamily: 'SanFrancisco',
    );
    
    return theme;
  }
}