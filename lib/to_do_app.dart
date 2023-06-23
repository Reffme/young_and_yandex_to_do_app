import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/data/source/repositories/task_repository.dart';
import 'features/task_feature/presentation/screens/task_screen.dart';
import 'core/blocs/localization_cubit/localization_cubit.dart';
import 'core/data/source/models/task_model.dart';
import 'core/localization/app_localization.dart';
import 'core/logs/observers/route_logger.dart';
import 'features/list_tasks_feature/presentation/screens/list_tasks_screen.dart';
import 'features/task_feature/presentation/task_cubit/task_cubit.dart';

import 'core/blocs/theme_cubit/theme_cubit.dart';
import 'features/list_tasks_feature/presentation/todo_cubit/todo_cubit.dart';

class MyApp extends StatefulWidget {
  MyApp({super.key, required this.taskRepository});

  @override
  State<MyApp> createState() => _MyAppState();
  final TaskRepository taskRepository;
}

class _MyAppState extends State<MyApp> {
  final RouteLogger routeLogger = RouteLogger();



  @override
  Widget build(final BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider<LocalizationCubit>(
            create: (final context) => LocalizationCubit(),
          ),
          BlocProvider<TodoCubit>(
            create: (final context) => TodoCubit(widget.taskRepository),
          ),
          BlocProvider<TaskCubit>(
            create: (final context) => TaskCubit(
                TaskModel(text: '', status: false, importance: 'Нет', date: DateTime.now(), id: '-1')),
          ),
          BlocProvider<ThemeCubit>(
            create: (context) => ThemeCubit(),
          ),
        ],
        child: BlocBuilder<LocalizationCubit, Locale>(
  builder: (context, locale) => BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, themeState) => MaterialApp(
            locale: locale,
            localizationsDelegates: const [
              AppLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''), // Английский язык
              Locale('ru', ''), // Русский язык
            ],
            debugShowCheckedModeBanner: false,
            title: 'TO-DO',
            initialRoute: '/',
            theme: themeState.themeData,
            routes: {
              '/': (context) => const ListTasks(),
              '/task': (context) => TaskScreen(),
            },
            navigatorObservers: [routeLogger],
          ),
        ),
),
      );
}
