import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.blue,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.blue,
  ),
  // Define other properties for light theme
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.black,
  scaffoldBackgroundColor: Color(0xFF1C2029),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF1C2029),
  ),
  // Define other properties for dark theme
);
