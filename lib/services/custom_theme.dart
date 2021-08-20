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
    return isDark ? Color.fromRGBO(150, 150, 150, 1) : Color.fromRGBO(120, 120, 120, 1);
  }

  ThemeData get themeData {
  
    var theme = ThemeData(
      primarySwatch: Colors.pink,
      primaryColor: isDark ? Color.fromRGBO(198, 125, 255, 1) : Color.fromRGBO(188, 102, 255, 1),
      accentColor: isDark ? Color.fromRGBO(255, 214, 181, 1) : Color.fromRGBO(255, 203, 165, 1),
      backgroundColor: isDark ? Colors.grey[850] : Colors.white,
      dialogBackgroundColor: isDark ? Color.fromRGBO(70, 70, 70, 1) : Color.fromRGBO(227, 227, 227, 1),
      brightness: isDark ? Brightness.dark : Brightness.light,
      errorColor: Colors.red.shade400,

      fontFamily: 'SanFrancisco',
    );
    
    return theme;
  }
}