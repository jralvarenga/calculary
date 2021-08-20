import 'package:calculary/pages/counter_calculator.dart';
import 'package:calculary/pages/function_calculator.dart';
import 'package:calculary/pages/main_calculator.dart';
import 'package:calculary/services/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var brightness = SchedulerBinding.instance!.window.platformBrightness;
    bool darkModeOn = brightness == Brightness.dark;
    
    CustomTheme appTheme = CustomTheme(isDark: darkModeOn);
    var themeData = appTheme.themeData;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: themeData.backgroundColor,
      statusBarColor: Colors.transparent,
      statusBarBrightness: appTheme.isDark ? Brightness.light : Brightness.dark,
      statusBarIconBrightness: appTheme.isDark ? Brightness.light : Brightness.dark,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: appTheme.isDark ? Brightness.light : Brightness.dark, //navigation bar icon 
    ));

    return Provider.value(
      value: appTheme,
      child: MaterialApp(
        title: 'Calculary',
        theme: appTheme.themeData,
        home: MainCalculator(),
        routes: {
          '/counter': (context) => CounterCalculator(),
          '/function': (context) => FunctionCalculator()
        },
      ),
    );
  }
}