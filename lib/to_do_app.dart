import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/theme_cubit/theme_cubit.dart';
import 'Screens/main_screen.dart';
import 'Screens/task_screen.dart';
import 'blocs/task_cubit/task_cubit.dart';
import 'blocs/todo_cubit/todo_cubit.dart';
import 'models/TaskModel.dart';
import 'observers/route_logger.dart';
import 'repositories/TaskRepository.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final RouteLogger routeLogger = RouteLogger();

  @override
  Widget build(final BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider<TodoCubit>(
            create: (final context) => TodoCubit(),
          ),
          BlocProvider<TaskCubit>(
            create: (final context) => TaskCubit(
                TaskModel(text: '', status: false, importance: 'Нет')),
          ),
          BlocProvider<ThemeCubit>(
            create: (context) => ThemeCubit(),
          ),
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, themeState) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'TO-DO',
            initialRoute: '/',
            theme: themeState.themeData,
            routes: {
              '/': (context) => const MainScreen(),
              '/task': (context) => TaskScreen(),
            },
            navigatorObservers: [routeLogger],
          ),
        ),
      );
}
