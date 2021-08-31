import 'dart:convert';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:calculary/l10n/l10n.dart';
import 'package:calculary/pages/counter_calculator.dart';
import 'package:calculary/pages/function_calculator.dart';
import 'package:calculary/pages/main_calculator.dart';
import 'package:calculary/pages/numeric_methods_menu.dart';
import 'package:calculary/pages/settings_page.dart';
import 'package:calculary/services/custom_theme.dart';
import 'package:calculary/services/format_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';

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
  bool _mathAPIAvailable = true;
  String _primaryColor = 'lila';
  String _accentColor = 'peach';

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

    String primaryColorConfig = (prefs.getString('primary_color') ?? 'lila');
    String accentColorConfig = (prefs.getString('accent_color') ?? 'peach');
    setState(() {
      _primaryColor = primaryColorConfig;
      _accentColor = accentColorConfig;
    });
  }

  void setGlobalColors(String primary, String accent) {
    setState(() {
      _primaryColor = primary;
      _accentColor = accent;
    });
  }
  
  void showToastMessage(String text) {
    Fluttertoast.showToast(
      msg: text,
    );
  }

  void initMathAPIServer() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
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
        return;
      } else {
        setState(() {
          _mathAPIAvailable = false;
        });
        showToastMessage('MathAPI Server Not Available');
      }
    } else {
      setState(() {
        _mathAPIAvailable = false;
      });
      showToastMessage('MathAPI Server Not Available');
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
    final FormatColor formatColor = FormatColor(primary: _primaryColor, accent: _accentColor, isDark: _darkModeOn);
    Color primaryColor = formatColor.getPrimaryColor();
    Color accentColor = formatColor.getAccentColor();
    CustomTheme appTheme = CustomTheme(isDark: _darkModeOn, primary: primaryColor, accent: accentColor);
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
        home: MainCalculator(
          mathAPIAvaliable: _mathAPIAvailable,
        ),
        supportedLocales: L10n.all,
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        /*routes: {
          '/counter': (context) => CounterCalculator(
            mathAPIAvaliable: _mathAPIAvailable,
          ),
          '/function': (context) => FunctionCalculator(
            mathAPIAvaliable: _mathAPIAvailable,
          ),
          '/settings': (context) => SettingsPage(
            setGlobalThemeConfig: setThemeConfig,
            mathAPIAvaliable: _mathAPIAvailable,
            retryMathAPIServer: initMathAPIServer,
            setGlobalColors: setGlobalColors,
          ),
          '/numeric-methods-menu': (context) => NumericMethodsMenu(),
        },*/
        onGenerateRoute: (route) {
          switch (route.name) {
            case '/counter':
              return PageTransition(
                child: CounterCalculator(
                  mathAPIAvaliable: _mathAPIAvailable,
                ),
                type: PageTransitionType.fade
              );
            case '/function':
              return PageTransition(
                child: FunctionCalculator(
                  mathAPIAvaliable: _mathAPIAvailable,
                ),
                type: PageTransitionType.fade
              );
            case '/settings':
              return PageTransition(
                child: SettingsPage(
                  setGlobalThemeConfig: setThemeConfig,
                  mathAPIAvaliable: _mathAPIAvailable,
                  retryMathAPIServer: initMathAPIServer,
                  setGlobalColors: setGlobalColors,
                ),
                type: PageTransitionType.rightToLeftWithFade
              );
            case '/numeric-methods-menu':
              return PageTransition(
                child: NumericMethodsMenu(),
                type: PageTransitionType.rightToLeftWithFade
              );
            default:
              return PageTransition(
                child: MainCalculator(
                  mathAPIAvaliable: _mathAPIAvailable,
                ),
                type: PageTransitionType.fade
              );
          }
        },
      ),
    );
  }

  void showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('MathAPI Server Error')
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}