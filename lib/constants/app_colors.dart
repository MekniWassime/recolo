import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static final MaterialColor primaryColor = _materialColorFromHex(0xff1c2754);

  static const backgroundColor = Color(0xff131c3c);

  static final interactableColor = _materialColorFromHex(0xff3658d8);

  static const fadedText = Colors.white38;

  static const outlineColor = Colors.white;

  static MaterialColor _materialColorFromHex(int primary) {
    Color color = Color(primary);
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}
