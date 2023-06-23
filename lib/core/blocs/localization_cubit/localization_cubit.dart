  import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';

  import '../../logs/logger/base_logger.dart';

  enum LocalizationEvent {
    changeLanguage,
  }

  class LocalizationCubit extends Cubit<Locale> {
    LocalizationCubit() : super(const Locale('ru', ''));

    void changeLanguage() {
      final currentLocale = state;
      final newLocale = currentLocale.languageCode == 'en'
          ? const Locale(
              'ru', '') // Если текущий язык - английский, меняем на русский
          : const Locale(
              'en', ''); // Если текущий язык - русский, меняем на английский
      BaseLogger.log(
          'Changing language from ${currentLocale.languageCode} to ${newLocale.languageCode}');
      emit(newLocale);
    }
  }
