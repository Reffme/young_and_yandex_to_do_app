import 'package:flutter/material.dart';
import 'color_theme.dart';

import 'text_theme.dart';

abstract interface class AppTheme {
  ColorTheme get color;

  StyleTextTheme get text;

  ThemeData get material;
}

abstract base class BaseAppTheme implements AppTheme {
  const BaseAppTheme({required this.color, required this.text});

  @override
  final ColorTheme color;
  @override
  final StyleTextTheme text;
}

final class AppThemeRealese extends BaseAppTheme {
  AppThemeRealese({required super.color, required super.text});

  @override
  // TODO: implement material
  ThemeData get material => throw UnimplementedError();
}
