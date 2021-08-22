import 'dart:convert';

import 'package:calculary/pages/counter_calculator.dart';
import 'package:calculary/pages/function_calculator.dart';
import 'package:calculary/pages/main_calculator.dart';
import 'package:calculary/pages/numeric_methods_menu.dart';
import 'package:calculary/pages/settings_page.dart';
import 'package:calculary/services/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({
    Key? key
  }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _darkModeOn = true;

  void setThemeConfig(String config) {
    switch (config) {
      case 'ThemeConfig.system':
        var brightness = SchedulerBinding.instance!.window.platformBrightness;
        bool darkModeOn = brightness == Brightness.dark;
        setState(() {
          darkModeOn = darkModeOn;
        });
      break;
      case 'ThemeConfig.dark':
        setState(() {
          _darkModeOn = true;
        });
      break;
      case 'ThemeConfig.light':
        setState(() {
          _darkModeOn = false;
        });
      break;
    }
  }

  void getConfig() async {
    final prefs = await SharedPreferences.getInstance();
    String themeConfig = (prefs.getString('theme_config') ?? 'ThemeConfig.system');
    setThemeConfig(themeConfig);
  }

  void initMathAPIServer() async {
    final response = await http.post(
      Uri.parse('https://mathapi.vercel.app/api/function/solve/'),
      headers: <String, String> {
        'Content-Type': 'application/json'
      },
      body: jsonEncode({
        "fx": "3*x + 1",
        "value": 3
      })
    );

    if (response.statusCode == 200) {
      print('mathapi ready');
    } else {
      print('MathAPI Server Error');
    }
  }

  @override
  void initState() {
    super.initState();

    getConfig();
    initMathAPIServer();
  }

  @override
  Widget build(BuildContext context) {
    
    CustomTheme appTheme = CustomTheme(isDark: _darkModeOn);
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
          '/function': (context) => FunctionCalculator(),
          '/settings': (context) => SettingsPage(setGlobalThemeConfig: setThemeConfig),
          '/numeric-methods-menu': (context) => NumericMethodsMenu(),
        },
      ),
    );
  }
}