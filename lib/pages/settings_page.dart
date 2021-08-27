import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:calculary/services/custom_theme.dart';
import 'package:calculary/widgets/settings_page/colors_dialog.dart';
import 'package:calculary/widgets/settings_page/tip_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({
    Key? key,
    required this.setGlobalThemeConfig,
    required this.mathAPIAvaliable,
    required this.retryMathAPIServer,
    required this.setGlobalColors
  }) : super(key: key);

  final setGlobalThemeConfig;
  final setGlobalColors;
  final bool mathAPIAvaliable;
  final retryMathAPIServer;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

enum ThemeConfig { light, dark, system }

class _SettingsPageState extends State<SettingsPage> {
  ThemeConfig _themeConfig = ThemeConfig.system;
  String _primaryColor = 'lila';
  String _accentColor = 'peach';
  TextEditingController _tipInputControler = TextEditingController(text: '10');

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
    setThemeConfig(themeConfig);

    String primaryColorConfig = (prefs.getString('primary_color') ?? 'lila');
    String accentColorConfig = (prefs.getString('accent_color') ?? 'peach');
    String tipValueConfig = (prefs.getString('tip_value') ?? '10');
    setState(() {
      _primaryColor = primaryColorConfig;
      _accentColor = accentColorConfig;
      _tipInputControler = TextEditingController(text: tipValueConfig);
    });
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

  void changeColorsConfig(String primary, String accent) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('primary_color', primary);
    prefs.setString('accent_color', accent);

    setState(() {
      _primaryColor = primary;
      _accentColor = accent;
      widget.setGlobalColors(primary, accent);
    });
    Navigator.of(context).pop();
  }

  void changeTipValue(String tip) async {
    tip =  tip.replaceAll(',', '.');
    tip =  tip.replaceAll(' ', '');
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('tip_value', tip);
    setState(() {
      _tipInputControler = TextEditingController(text: tip);
    });
  }

  @override
  Widget build(BuildContext context) {
    CustomTheme theme = Provider.of(context);
    var themeData = theme.themeData;

    void retryMathAPIServer() {
      final snackBar = SnackBar(
        content: Text('Retrying MathAPI availability')
      );
      
      widget.retryMathAPIServer();
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    void openThemeDialog() {
      showDialog(
        context: context,
        builder: (context) => buildThemeDialog()
      );
    }

    void openColorsDialog() {
      showDialog(
        context: context,
        builder: (context) => buildColorDialog()
      );
    }

    void openTipDialog() {
      showDialog(
        context: context,
        builder: (context) => buildTipDialog()
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: theme.textColor
        ),
        title: Text(
          AppLocalizations.of(context)!.settings_title,
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
                  onTap: retryMathAPIServer,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: widget.mathAPIAvaliable ? Colors.green[400] : Colors.red[400],
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(
                          AppLocalizations.of(context)!.mathapi_server_status,
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
                          AppLocalizations.of(context)!.theme,
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
                  onTap: openColorsDialog,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Icon(
                          Icons.color_lens,
                          size: 25,
                        ),
                        SizedBox(width: 20),
                        Text(
                          AppLocalizations.of(context)!.colors,
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
                  onTap: openTipDialog,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        SizedBox(width: 5),
                        Text(
                          '%',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(
                          AppLocalizations.of(context)!.tip_percentage + " ${_tipInputControler.text}%",
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
                          AppLocalizations.of(context)!.angular_units + ': ' + AppLocalizations.of(context)!.radians,
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
            ],
          ),
        )
      ),
    );
  }

  Widget buildThemeDialog () => AlertDialog(
    title: Text(
      AppLocalizations.of(context)!.theme,
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
              AppLocalizations.of(context)!.light_theme,
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
              AppLocalizations.of(context)!.dark_theme,
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
              AppLocalizations.of(context)!.system_theme,
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

  Widget buildColorDialog() => ColorsDialog(
    primaryColorConfig: _primaryColor,
    accentColorConfig: _accentColor,
    changeColorConfig: changeColorsConfig,
  );

  Widget buildTipDialog() => TipDialog(
    tipInputController: _tipInputControler,
    changeTipValue: changeTipValue
  );
}