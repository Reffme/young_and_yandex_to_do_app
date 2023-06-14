import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(

  colorScheme: const ColorScheme.light(),
  appBarTheme: const AppBarTheme(color: Color(0xFFF7F6F2)),
  scaffoldBackgroundColor: const Color(0xFFF7F6F2),
  primaryColor: Colors.blue,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.blue,
    elevation: 1,
  ),
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
);
