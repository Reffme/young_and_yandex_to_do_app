import 'package:flutter/material.dart';

abstract interface class ColorTheme {
  Color get support;

}
final class LightColorTheme implements ColorTheme{
  @override
  // TODO: implement support
  Color get support => throw UnimplementedError();

}

final class DarkColorTheme implements ColorTheme{
  @override
  // TODO: implement support
  Color get support => throw UnimplementedError();

}