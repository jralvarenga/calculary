import 'package:flutter/material.dart';


class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: Color.fromRGBO(249, 220, 197, 1),
      accentColor: Color.fromRGBO(210, 155, 253, 1),
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Montserrat',
    );
  }
}