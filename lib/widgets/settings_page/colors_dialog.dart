import 'package:calculary/services/custom_theme.dart';
import 'package:calculary/services/format_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ColorItem {
  String primary;
  String accent;

  ColorItem({
    required this.primary,
    required this.accent
  });
}

class ColorsDialog extends StatelessWidget {
  ColorsDialog({
    Key? key,
    required this.primaryColorConfig,
    required this.accentColorConfig,
    required this.changeColorConfig
  }) : super(key: key);

  final String primaryColorConfig;
  final String accentColorConfig;
  final changeColorConfig;

  final List<ColorItem> colors = [
    ColorItem(primary: "lila", accent: "peach"),
    ColorItem(primary: "alphaca", accent: "mango"),
    ColorItem(primary: "blossom", accent: "lavanda"),
  ];

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: Text(
        'Colors',
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
          children: <Widget>[
            for (var i = 0; i < colors.length; i++)
              ColorContainer(
                primary: colors[i].primary,
                accent: colors[i].accent,
                accentConfig: accentColorConfig,
                primaryConfig: primaryColorConfig,
                changeColorConfig: () => changeColorConfig(colors[i].primary, colors[i].accent),
              ),
          ],
        ),
      ),
    );
  }
}

class ColorContainer extends StatelessWidget {
  ColorContainer({
    Key? key,
    required this.primary,
    required this.accent,
    required this.primaryConfig,
    required this.accentConfig,
    required this.changeColorConfig
  }) : super(key: key);

  final String primary;
  final String accent;
  final String primaryConfig;
  final String accentConfig;
  final changeColorConfig;

  String capitalize(String string) {
    return "${string[0].toUpperCase()}${string.substring(1)}";
  }

  @override
  Widget build(BuildContext context) {
    CustomTheme theme = Provider.of(context);
    var themeData = theme.themeData;
    final FormatColor formatColor = FormatColor(primary: primary, accent: accent, isDark: theme.isDark);
    final bool isSelected = primary == primaryConfig && accent == accentConfig ? true : false;

    return Column(
      children: [
        Material(
          color: isSelected ? themeData.backgroundColor : themeData.dialogBackgroundColor,
          borderRadius: BorderRadius.circular(20),
          child: InkWell(
            onTap: changeColorConfig,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: isSelected ? themeData.backgroundColor : themeData.dialogBackgroundColor,
                borderRadius: BorderRadius.circular(20)
              ),
              child: Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          formatColor.getAccentColor(),
                          formatColor.getPrimaryColor(),
                        ],
                      )
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "${capitalize(primary)} & ${capitalize(accent)}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        
        SizedBox(height: 15)
      ],
    );
  }
}