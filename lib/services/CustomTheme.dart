import 'package:flutter/material.dart';

class CustomTheme {
  CustomTheme({
    required this.isDark,
  });

  final bool isDark;

  Color get textColor {
    return isDark ? Color.fromRGBO(255, 255, 255, 1) : Color.fromRGBO(0, 0, 0, 1);
  }

  Color get paperTextColor {
    return isDark ? Color.fromRGBO(114, 114, 114, 1) : Color.fromRGBO(114, 114, 114, 1);
  }

  ThemeData get themeData {
  
    var theme = ThemeData(
      primarySwatch: Colors.pink,
      primaryColor: Color.fromRGBO(210, 155, 253, 1),
      accentColor: Color.fromRGBO(249, 220, 197, 1),
      backgroundColor: isDark ? Colors.black : Colors.white,
      dialogBackgroundColor: isDark ? Color.fromRGBO(60, 60, 60, 1) : Color.fromRGBO(227, 227, 227, 1),
      brightness: isDark ? Brightness.dark : Brightness.light,
      errorColor: Colors.red.shade400,

      fontFamily: 'SanFrancisco',
    );
    
    return theme;
  }
}