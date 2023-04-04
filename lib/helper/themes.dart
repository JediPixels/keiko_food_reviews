import 'package:flutter/material.dart';

class Themes {
  static ThemeData lightTheme() {
    return ThemeData.light(useMaterial3: true).copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: ThemeColors.m3Baseline,
        brightness: Brightness.light,
      )
    );
  }

  static ThemeData darkTheme() {
    return ThemeData.dark(useMaterial3: true).copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: ThemeColors.m3Baseline,
        brightness: Brightness.dark,
      )
    );
  }
 }

class ThemeColors {
  static const Color m3Baseline = Color(0xff6750a4);
  static const Color locationPin = Colors.lightBlue;
}