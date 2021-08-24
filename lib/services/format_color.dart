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
          return Color.fromRGBO(215, 177, 227, 1);
        case 'alphaca':
          return Color.fromRGBO(132, 255, 130, 1);
        case 'blossom':
          return Color.fromRGBO(255, 94, 125, 1);
        default:
          return Color.fromRGBO(215, 177, 227, 1);
      } 
    } else {
      switch (primaryString) {
        case 'lila':
          return Color.fromRGBO(182, 149, 192, 1);
        case 'alphaca':
          return Color.fromRGBO(109, 214, 107, 1);
        case 'blossom':
          return Color.fromRGBO(255, 84, 115, 1);
        default:
          return Color.fromRGBO(182, 149, 192, 1);
      }
    }
  }

  Color getAccentColor() {
    String accentString = this.accent;
    if (this.isDark) {
      switch (accentString) {
        case 'peach':
          return Color.fromRGBO(255, 212, 181, 1);
        case 'mango':
          return Color.fromRGBO(255, 224, 112, 1);
        case 'lavanda':
          return Color.fromRGBO(212, 163, 247, 1);
        default:
          return Color.fromRGBO(255, 212, 181, 1);
      } 
    } else {
      switch (accentString) {
        case 'peach':
          return Color.fromRGBO(255, 203, 165, 1);
        case 'mango':
          return Color.fromRGBO(255, 217, 79, 1);
        case 'lavanda':
          return Color.fromRGBO(203, 141, 247, 1);
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
    return Color.fromRGBO(50, 50, 50, 1);
  return Color.fromRGBO(255, 255, 255, 1);
}