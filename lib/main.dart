import 'package:calculary/pages/MainCalculator.dart';
import 'package:calculary/services/CustomTheme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CustomTheme appTheme = CustomTheme(isDark: false);
    return Provider.value(
      value: appTheme,
      child: MaterialApp(
        title: 'Calculary',
        theme: appTheme.themeData,
        home: MainCalculator(
          title: 'Main Calculator'
        ),
      ),
    );
  }
}