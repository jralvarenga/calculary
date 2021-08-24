import 'package:flutter/material.dart';

class FormatColor {
  String primary;
  String accent;
  bool isDark;

  FormatColor({
    required this.primary,
    required this.accent,
    required this.isDark
  });

  Color getPrimaryColor() {
    String primaryString = this.primary;
    if (this.isDark) {
      switch (primaryString) {
        case 'lila':
          return Color.fromRGBO(198, 112, 255, 1);
        case 'alphaca':
          return Color.fromRGBO(86, 178, 84, 1);
        case 'blossom':
          return Color.fromRGBO(255, 94, 125, 1);
        default:
          return Color.fromRGBO(198, 112, 255, 1);
      } 
    } else {
      switch (primaryString) {
        case 'lila':
          return Color.fromRGBO(188, 102, 255, 1);
        case 'alphaca':
          return Color.fromRGBO(76, 168, 74, 1);
        case 'blossom':
          return Color.fromRGBO(255, 84, 115, 1);
        default:
          return Color.fromRGBO(188, 102, 255, 1);
      }
    }
  }

  Color getAccentColor() {
    String accentString = this.accent;
    if (this.isDark) {
      switch (accentString) {
        case 'peach':
          return Color.fromRGBO(255, 213, 175, 1);
        case 'mango':
          return Color.fromRGBO(255, 176, 53, 1);
        case 'lavanda':
          return Color.fromRGBO(218, 166, 255, 1);
        default:
          return Color.fromRGBO(255, 213, 175, 1);
      } 
    } else {
      switch (accentString) {
        case 'peach':
          return Color.fromRGBO(255, 203, 165, 1);
        case 'mango':
          return Color.fromRGBO(255, 166, 43, 1);
        case 'lavanda':
          return Color.fromRGBO(181, 126, 220, 1);
        default:
          return Color.fromRGBO(255, 203, 165, 1);
      }
    }
  }
}

Color estimateBrightnessForColorForText(Color color) {
  final double relativeLuminance = color.computeLuminance();

  const double kThreshold = 0.15;
  if ((relativeLuminance + 0.05) * (relativeLuminance + 0.05) > kThreshold)
    return Color.fromRGBO(0, 0, 0, 1);
  return Color.fromRGBO(255, 255, 255, 1);
}