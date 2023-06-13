import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.light(),
  appBarTheme: AppBarTheme(color: Color(0xFFF7F6F2)),
  scaffoldBackgroundColor: Color(0xFFF7F6F2),
  primaryColor: Colors.blue,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.blue,
    elevation: 1,
  ),
  iconTheme: IconThemeData(
    color: Colors.white,
  ),
);
