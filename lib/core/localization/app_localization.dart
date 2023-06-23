import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart' show SynchronousFuture;

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations? of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations);

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'title': 'My Tasks',
      'completed': 'Completed',
      'new': 'New',
      'save': 'Save',
      'task': 'What needs to be done?',
      'dueDate': 'Due Date',
      'notSelected': 'Not Selected',
      'no': 'No',
      'low': 'Low',
      'high': 'High',
      'delete': 'Delete',
      'importance' : 'importance'

    },
    'ru': {
      'title': 'Мои дела',
      'completed': 'Выполнено',
      'new': 'Новое',
      'save': 'Сохранить',
      'task': 'Что надо сделать?',
      'dueDate': 'Сделать до',
      'notSelected': 'Не выбрано',
      'no': 'Нет',
      'low': 'Низкий',
      'high': 'Высокий',
      'delete': 'Удалить',
      'importance' : 'Важность'
    },
  };

  String? get title => _localizedValues[locale.languageCode]?['title'];

  String? get newTask => _localizedValues[locale.languageCode]?['new'];

  String? get save => _localizedValues[locale.languageCode]?['save'];

  String? get task => _localizedValues[locale.languageCode]?['task'];

  String? get dueDate => _localizedValues[locale.languageCode]?['dueDate'];

  String? get notSelected =>
      _localizedValues[locale.languageCode]?['notSelected'];

  String? get no => _localizedValues[locale.languageCode]?['no'];

  String? get low => _localizedValues[locale.languageCode]?['low'];

  String? get high => _localizedValues[locale.languageCode]?['high'];

  String? get delete => _localizedValues[locale.languageCode]?['delete'];

  String? get completed => _localizedValues[locale.languageCode]?['completed'];
  String? get importance => _localizedValues[locale.languageCode]?['importance'];
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ru'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) =>
      SynchronousFuture<AppLocalizations>(AppLocalizations(locale));

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
