import 'package:calculary/pages/MainCalculator.dart';
import 'package:calculary/services/CustomTheme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculary',
      theme: CustomTheme.lightTheme,
      home: MainCalculator(title: 'Main Calculator',),
    );
  }
}