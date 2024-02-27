import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData customTheme = ThemeData(
    //  primary and accent colors
    primaryColor: Colors.blue,

    // app's typography
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
      displaySmall: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(fontSize: 16.0),
      bodyMedium: TextStyle(fontSize: 14.0),
    ),

  );
}
