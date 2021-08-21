import 'package:calculary/services/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({
    Key? key,
    required this.setGlobalThemeConfig
  }) : super(key: key);

  final setGlobalThemeConfig;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

enum ThemeConfig { light, dark, system }

class _SettingsPageState extends State<SettingsPage> {
  ThemeConfig _themeConfig = ThemeConfig.system;

  void setThemeConfig(String config) {
    switch (config) {
      case 'ThemeConfig.system':
        setState(() {
          _themeConfig = ThemeConfig.system;
        });
      break;
      case 'ThemeConfig.dark':
        setState(() {
          _themeConfig = ThemeConfig.dark;
        });
      break;
      case 'ThemeConfig.light':
        setState(() {
          _themeConfig = ThemeConfig.light;
        });
      break;
    }
  }

  void getSettings() async {
    final prefs = await SharedPreferences.getInstance();
    String themeConfig = (prefs.getString('theme_config') ?? 'ThemeConfig.system');
    print(themeConfig);
    setThemeConfig(themeConfig);
  }

  @override
  void initState() {
    super.initState();
    getSettings();
  }

  void changeThemeConfig(ThemeConfig config) async {
    final prefs = await SharedPreferences.getInstance();
    String saveConfig = config.toString();
    prefs.setString('theme_config', saveConfig);
    widget.setGlobalThemeConfig(saveConfig);

    setState(() {
      _themeConfig = config;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    CustomTheme theme = Provider.of(context);
    var themeData = theme.themeData;

    void openThemeDialog() {
      showDialog(
        context: context,
        builder: (context) => buildThemeDialog()
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: theme.textColor
        ),
        title: Text(
          'Settings',
          style: TextStyle(
            color: theme.textColor,
            fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: themeData.dialogBackgroundColor,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 15),
          child: Column(
            children: [
              Material(
                child: InkWell(
                  onTap: openThemeDialog,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Icon(
                          Icons.dark_mode,
                          size: 25,
                        ),
                        SizedBox(width: 20),
                        Text(
                          'Theme',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                  )
                ),
              ),
              Material(
                child: InkWell(
                  onTap: () => print('object'),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Icon(
                          Icons.category,
                          size: 25,
                        ),
                        SizedBox(width: 20),
                        Text(
                          'Angular units: Radians',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                  )
                ),
              ),
              Material(
                child: InkWell(
                  onTap: () => print('object'),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Icon(
                          Icons.category,
                          size: 25,
                        ),
                        SizedBox(width: 20),
                        Text(
                          'Tip percentage: 10%',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                  )
                ),
              )
            ],
          ),
        )
      ),
    );
  }

  Widget buildThemeDialog () => AlertDialog(
    title: Text(
      'Theme',
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold
      )
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20)
    ),
    content: Container(
      height: 200,
      child: Column(
        children: [
          ListTile(
            title: Text(
              'Light theme',
              style: TextStyle(
                fontSize: 18
              ),
            ),
            leading: Radio<ThemeConfig>(
              value: ThemeConfig.light,
              groupValue: _themeConfig,
              onChanged: (ThemeConfig? value) => changeThemeConfig(value!)
            ),
          ),
          ListTile(
            title: Text(
              'Dark theme',
              style: TextStyle(
                fontSize: 18
              ),
            ),
            leading: Radio<ThemeConfig>(
              value: ThemeConfig.dark,
              groupValue: _themeConfig,
              onChanged: (ThemeConfig? value) => changeThemeConfig(value!)
            ),
          ),
          ListTile(
            title: Text(
              'System default',
              style: TextStyle(
                fontSize: 18
              ),
            ),
            leading: Radio<ThemeConfig>(
              value: ThemeConfig.system,
              groupValue: _themeConfig,
              onChanged: (ThemeConfig? value) => changeThemeConfig(value!)
            ),
          )
        ],
      ),
    ),
  );
}