import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:young_and_yandex_to_do_app/logger/base_logger.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(darkTheme));

  void switchTheme() {
    final newTheme = state.themeData == lightTheme ? darkTheme : lightTheme;
    emit(ThemeState(newTheme));

    BaseLogger.log('Theme switched: $newTheme');
  }
}

final ThemeData lightTheme = ThemeData(
  appBarTheme:  const AppBarTheme(color: Color.fromRGBO(247, 246, 242, 1)),
  scaffoldBackgroundColor: const Color.fromRGBO(247, 246, 242, 1),
  colorScheme:  const ColorScheme.light(),
  useMaterial3: true,
);

final ThemeData darkTheme = ThemeData.dark(
  useMaterial3: true,
);
