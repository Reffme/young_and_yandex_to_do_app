import 'package:flutter/material.dart';
import 'package:young_and_yandex_to_do_app/themes/color_theme.dart';

import 'text_theme.dart';

abstract interface class AppTheme {
  ColorTheme get color;

  StyleTextTheme get text;

  ThemeData get material;
}

abstract base class BaseAppTheme implements AppTheme {
  final ColorTheme color;
  final StyleTextTheme text;

 const BaseAppTheme({required this.color, required this.text});
}
final class AppThemeRealese extends BaseAppTheme{
  AppThemeRealese({required super.color, required super.text});

  @override
  // TODO: implement material
  ThemeData get material => throw UnimplementedError();

}
