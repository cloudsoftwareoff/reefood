import 'package:flutter/material.dart';
import 'package:reefood/constant/colors.dart';

final MaterialColor primarySwatchColor =
    MaterialColor(scheme.primary.value, const <int, Color>{
  50: Color(0xFFE6F1ED), // Lighter shade
  100: Color(0xFFCCE5D9), // Slightly lighter
  200: Color(0xFFB2D9C5),
  300: Color(0xFF98CDC1),
  400: Color(0xFF7EC1AD), // Closer to primary
  500: Color(0xFF218644), // Your primary color
  600: Color(0xFF1C793D), // Slightly darker
  700: Color(0xFF176C37),
  800: Color(0xFF125F30),
  900: Color(0xFF0D522A), // Darker shade
});

ThemeData myAppTheme = ThemeData(
  // brightness: Brightness.dark,
  primarySwatch: primarySwatchColor,

  colorScheme: ColorScheme.fromSwatch()
      .copyWith(secondary: scheme.secondary, primary: scheme.primary),
  fontFamily: 'Plus Jakarta Sans',
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    backgroundColor: scheme.primary,
  )),
  textTheme: TextTheme(
    displayLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(fontSize: 16.0),
  ),
);
